require 'spec_helper'

describe "Import::ArticleXml" do
  describe "when parsing the xml" do
    before :each do
      xml = %[
        <lex-import>
          <article oldid="oldid **" id_def="id_def **">
            <metadata>
              <field id="epoch_start">1910</field>
              <field id="epoch_end">1940</field>
              <field id="subject">7413-92</field>
              <field id="author">FHvU</field>
              <field id="headword">Headword</field>
              <field id="clarification">Clarification **</field>
            </metadata>
            <html><head><meta http-equiv="content-type" content="text/html; charset=utf-8" /></head><body>
            <p>tidligere husmannsplass på Ostøya i Bærum, lå under <a class="crossref" href="sl14012479">Oust</a>.</p>
            </body></html>
          </article>
          <article>
          </article>
        </lex-import>
      ]
      @import = Import::Main.parse(Nokogiri::XML(xml))
    end

    it "has two article elements" do
      @import.articles.size.should == 2
    end

    it "has some attributes" do
      @import.articles.first.oldid.should == "oldid **"
      @import.articles.first.definition.should == "id_def **"
    end

    it "has metadata" do
      @import.articles.first.headword.should == "Headword"

      @import.articles.first.subject.should == "7413-92"
      @import.articles.first.author.should == "FHvU"

      @import.articles.first.epoch_start.should == "1910"
      @import.articles.first.epoch_end.should == "1940"

      @import.articles.first.clarification == "Clarification **"
    end

    it "has body text" do
      @import.articles.first.text.should =~ /^<p>tidligere husmannsplass på Ostøya/
      @import.articles.first.text.should =~ /under <a class="crossref" href="sl14012479">Oust<\/a>.<\/p>$/
    end

    it "has attributes hash" do
      @import.articles.first.attributes.class.should == Hash
    end
  end
end

describe "Import::Main" do
  before :each do
    xml = <<-EOXML
      <lex-import>
        <article id_def="gård i Asker"><metadata><field id="headword">Foo</field></metadata><html><body>Artikkeltekst **</body></html></article>
        <article id_def="gård i Bærum"><metadata><field id="headword">Foo</field></metadata><html><body>Artikkeltekst **</body></html></article>
        <article id_def="gård i Bærum"><metadata><field id="headword">Foo</field></metadata><html><body>Artikkeltekst **</body></html></article>
      </lex-import>
    EOXML
    @doc = Nokogiri::XML(xml) do |config|
      config.noent
    end
  end

  it "throws no exceptions when importing" do
    lambda {
      Import::Main.run(@doc)
    }.should_not raise_error
  end

  describe "when importing" do
    before :each do
      Import::Main.run(@doc)
    end

    it "saves articles" do
      Article.all.count.should == 4
    end

    it "checks for duplicates" do
      Article.where(:headword => 'Foo').first.text.should be_blank
      Article.where(:headword => 'Foo').first.ambiguous.should be_true
      Article.where(:headword => 'Foo (gård i Asker)').first.ambiguous.should be_true
      Article.where(:headword => 'Foo (gård i Bærum)').first.ambiguous.should be_true
      Article.where(:headword => 'Foo (gård i Bærum - 2)').first.ambiguous.should be_true
    end
  end
end
