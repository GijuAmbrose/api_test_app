require 'rails_helper'

RSpec.describe 'Api::V1::ArticlesController', :type => :request do

  let(:user) {FactoryBot.create_list(:user, 1)}
  let(:params) do
    {
      user: {
        email: user.first.email,
        password: user.first.password
      }
    }
  end

  describe "Articles API" do
    before do
      #post "/signup", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      post "/login", params: {user: {email: user.first.email, password: user.first.password}}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      @token_from_request = response.headers['Authorization'].split(' ').last
      
    end 

    describe "GET /articles" do 

      before do
        FactoryBot.create(:article, name: "1984", author: "George Orwell")
        FactoryBot.create(:article, name: "The Time Machine", author: "H.G Wells")
      end

      it "returns all articles" do

        get '/api/v1/articles', headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{@token_from_request}"}
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["articles"].size).to eq(2)
      end
    end

    describe 'POST /articles' do
      it 'creates new article' do
        expect {   
        post "/api/v1/articles", params: {article: {name: 'The New Test', author: 'Ambrose'}}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{@token_from_request}"}
        }.to change {Article.count}.from(0).to(1)

        expect(response).to have_http_status(200)

      end
    end

    describe 'PATCH /articles/:id' do
      let!(:article) {FactoryBot.create(:article, name: '1974', author: "Giju Ambrose")}
      it 'updates an article' do
        patch "/api/v1/articles/#{article.id}", params: {article: {name: 'The New Test', author: 'Ambrose'}}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{@token_from_request}"}
        expect(response).to have_http_status(200)
      end
    end

    describe 'DELETE /articles/:id' do
      let!(:article) {FactoryBot.create(:article, name: "1984", author: "George Orwell")}
      it 'deletes an article' do

        expect{
          delete "/api/v1/articles/#{article.id}", headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{@token_from_request}"}
        }.to change{Article.count}.from(1).to(0)

        expect(response).to have_http_status(200)
      end
    end
  end  
end
