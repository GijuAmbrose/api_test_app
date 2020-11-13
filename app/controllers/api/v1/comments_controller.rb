class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :set_article, only: [:create, :update]
  before_action :fetch_comment, only: [:index]

  # GET /comments
  def index; end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = @article.comments.new(comment_params)

    if @comment.save
      render "/api/v1/articles/show"
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:comment, :article_id)
    end

    def set_article
      @article = Article.find(params["article_id"])
    end

    def fetch_comment
      @comments = Comment.all
    end
end
