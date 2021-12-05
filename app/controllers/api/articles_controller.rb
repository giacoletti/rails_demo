class Api::ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
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
      render_error("Unfortunately we cannot find the article you are looking for.", 404)
    end
  end

  def create
    article = Article.create(article_params)
    if article.persisted?
      render json: { article: article }, status: 201
    else
      render_error(article.errors.full_messages.to_sentence, 422)
    end
  end

  def edit
    begin
      article = Article.find(params["id"])
      render json: { article: article }
    rescue ActiveRecord::RecordNotFound => e
      render_error("Unfortunately we cannot find the article you are looking for.", 404)
    end
  end

  private

  def render_error(message, status)
    render json: { message: message }, status: status
  end

  def validate_params_presence
    render json: { message: "Missing params" }, status: 422 if params[:article].nil?
  end

  def article_params
    params[:article].permit(:title, :content)
  end
end
