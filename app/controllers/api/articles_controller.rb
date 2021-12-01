class Api::ArticlesController < ApplicationController
  before_action :validate_params_presence, only: [:create]

  def index
    articles = Article.all
    render json: { articles: articles }
  end

  def show
    begin
      article = Article.find(params["id"])
      render json: { article: article }
    rescue ActiveRecord::RecordNotFound => e
      render json: { 
        message: "Unfortunately we cannot find the article you are looking for." 
      }, status: 404
    end
  end

  def create
    article = Article.create(article_params)
    if article.persisted?
      render json: { article: article }, status: 201
    else
      render json: { message: article.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

  def validate_params_presence
    render json: { message: "Missing params" }, status: 422 if params[:article].nil?
  end

  def article_params
    params[:article].permit(:title, :content)
  end
end
