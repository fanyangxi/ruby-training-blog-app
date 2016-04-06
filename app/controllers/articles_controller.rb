class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "fan", password: "a", except: [:index, :show]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    # You don't need to pass all attributes to update. For example, if you'd
    # call @article.update(title: 'A new title') Rails would only update the
    # title attribute, leaving all other attributes untouched.
    @article = Article.find(params[:id])
    if@article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :description)
  end

end
