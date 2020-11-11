class Api::V1::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]
  before_action :fetch_articles, only: [:index]

  # GET /articles
  def index; end

  # GET /articles/1
  def show; end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      render :show
    else
      render json: @article.errors
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors
    end
  end

  # DELETE /articles/1
  def destroy
    if @article.destroy
      render json: "Deleted Successfully"
    else
      render json: "Something went wrong"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:name, :author)
    end

    def fetch_articles
      @articles = Article.includes(:comments).all
    end
end
