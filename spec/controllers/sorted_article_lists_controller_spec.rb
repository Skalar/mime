require 'spec_helper'

describe SortedArticleListsController do

  context "as an editor" do
    login_editor
    let(:page) { Factory :page }

    describe "#new" do
      it "shows the new/edit form" do
        get :new, page_id: page.id
        response.should render_template("new")
      end
    end

    describe "#create" do
      
      context "with valid list" do
        before do
          post :create, sorted_article_list: Factory.attributes_for(:sorted_article_list), page_id: page.id
        end

        it "redirects to page" do
          response.should redirect_to(edit_page_path(page))
        end
        
        it "saves the list to the page" do
          assigns(:page).sorted_article_lists.should_not be_empty
        end
      end
      
      context "with validation errors" do
        before do
          post :create, sorted_article_list: Factory.attributes_for(:sorted_article_list, name: nil), page_id: page.id
        end
        
        it "renders the new template" do
          response.should render_template("new")
        end
        
        it "has errors on the list object" do
          assigns(:article_list).should have(1).error
        end
      end
    end
  end
end
