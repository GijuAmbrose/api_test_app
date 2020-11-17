require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, :type => :controller do

  describe "Articles API" do
    render_views

    describe "GET /articles" do 

      before do
        FactoryBot.create(:article, name: "1984", author: "George Orwell")
        FactoryBot.create(:article, name: "The Time Machine", author: "H.G Wells")
      end 

      it "returns all articles" do

        get :index, :format => :json
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["articles"].size).to eq(2)
      end
    end

    describe 'POST /articles' do
      it 'creates new article' do
        expect {   
        post :create, format: :json, params: {article: {name: 'The New Test', author: 'Ambrose'}}
        }.to change {Article.count}.from(0).to(1)

        expect(response).to have_http_status(200)

      end
    end

    describe 'PATCH /articles/:id' do
      let!(:article) {FactoryBot.create(:article, name: '1974', author: "Giju Ambrose")}
      it 'updates an article' do
        patch :update, format: :json, params: {id: article.id, article: {name: 'The New Test', author: 'Ambrose'}}
        expect(response).to have_http_status(200)
      end
    end

    describe 'DELETE /articles/:id' do
      let!(:article) {FactoryBot.create(:article, name: "1984", author: "George Orwell")}
      it 'deletes an article' do

        expect{
          delete :destroy, format: :json, params: {id: article.id}
        }.to change{Article.count}.from(1).to(0)

        expect(response).to have_http_status(200)
      end
    end
  end  
end
