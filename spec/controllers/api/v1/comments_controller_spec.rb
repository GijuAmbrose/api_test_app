require 'rails_helper'

RSpec.describe Api::V1::CommentsController, :type => :controller do

  describe "Comments API" do
    render_views

    describe "GET /comments" do 

      before do
      	FactoryBot.create(:article, name: "1984", author: "George Orwell")
        FactoryBot.create(:article, name: "The Time Machine", author: "H.G Wells")
        FactoryBot.create(:comment, comment: "The Book is good", article_id: 1)
        FactoryBot.create(:comment, comment: "The Author is good", article_id: 2)
      end 

      it "returns all comments" do

        get :index, params: { article_id: 1 }, format: :json
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(1)
      end
    end

    describe 'POST /comment' do

    	before do
	    	@article = FactoryBot.create(:article, name: "1984", author: "George Orwell")
	    end

      it 'creates new comment' do
        expect {   
        post :create,format: :json, params: {article_id: @article.id, comment: {comment: 'The book is good', article_id: @article.id}}
        }.to change {Comment.count}.from(0).to(1)
        expect(response).to have_http_status(200)

      end
    end

    describe 'DELETE /comments/:id' do
    	before do
    		@article = FactoryBot.create(:article, name: "1984", author: "George Orwell")
    	end

      let!(:comment) {FactoryBot.create(:comment, comment: 'The Author is good', article_id: 1)}
      it 'deletes a comment' do

        expect{
          delete :destroy, format: :json, params: {article_id: @article.id, id: comment.id}
        }.to change{Comment.count}.from(1).to(0)

        expect(response).to have_http_status(204)
      end
    end
  end  
end

