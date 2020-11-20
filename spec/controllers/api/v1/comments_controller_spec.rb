require 'rails_helper'

RSpec.describe 'Api::V1::CommentsController', :type => :request do

  let(:user) {FactoryBot.create_list(:user, 1)}
  let(:params) do
    {
      user: {
        email: user.first.email,
        password: user.first.password
      }
    }
  end

  describe "Comments API" do

    before do
      #post "/signup", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      post "/login", params: {user: {email: user.first.email, password: user.first.password}}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      @token_from_request = response.headers['Authorization'].split(' ').last
      
    end 

    describe "GET /comments" do 

      before do
      	FactoryBot.create(:article, name: "1984", author: "George Orwell")
        FactoryBot.create(:article, name: "The Time Machine", author: "H.G Wells")
        FactoryBot.create(:comment, comment: "The Book is good", article_id: 1)
        FactoryBot.create(:comment, comment: "The Author is good", article_id: 2)
      end 

      it "returns all comments" do

        get '/api/v1/articles/1/comments', headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{@token_from_request}"}
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
        post "/api/v1/articles/#{@article.id}/comments", params: {comment: {comment: 'The book is good'}}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{@token_from_request}"}
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
          delete "/api/v1/articles/#{@article.id}/comments/#{comment.id}", headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{@token_from_request}"}
        }.to change{Comment.count}.from(1).to(0)

        expect(response).to have_http_status(204)
      end
    end
  end  
end

