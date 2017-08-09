class ArticlesController < ApplicationController
  def index
    @periodicals = Periodical.order(:name)
    @articles = Article.order(:title).paginate(:page => params[:page], :per_page => 30)
  end
end
