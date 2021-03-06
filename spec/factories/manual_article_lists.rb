Factory.define :manual_article_list, :default_strategy => :build do |f|
  f.name "Manual article list"
  f.position 0
end

Factory.define :todays_articles, :parent => :manual_article_list do |f|
  f.after_build do |list|
    4.times do |i|
      a = Factory :article
      Factory.build(:list_article, headword: a.headword, published_on: Date.today - i, listable: list)
    end
    4.times do |i|
      a = Factory :article
      Factory.build(:list_article, headword: a.headword, published_on: Date.today + i + 1, listable: list)
    end
  end
end
