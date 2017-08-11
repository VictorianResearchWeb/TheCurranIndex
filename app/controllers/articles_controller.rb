class ArticlesController < ApplicationController
  def index
    @periodicals = Periodical.order(:name)

    @periodical = Periodical.find_by(id: 1)
    
    @list = @periodical.articles.includes(:periodical, :month).group_by(&:volume)

    @articles = Article.order(:title).paginate(:page => params[:page], :per_page => 30)
  end

  def contributor
    @contributor = Contributor.find_by(id: 1)
    @contributor_articles = @contributor.articles.includes(:periodical, :month)
  end

end
