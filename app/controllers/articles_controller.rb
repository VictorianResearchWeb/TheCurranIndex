class ArticlesController < ApplicationController
  def index
    @periodicals = Periodical.order(:name)

    @periodical = Periodical.find_by(id: 1)
    @list = Article.includes(:periodical).where(periodical_id: @periodical.id).group_by(&:volume)
    
    @articles = Article.order(:title).paginate(:page => params[:page], :per_page => 30)
  end

  def contributor
    @contributor = Contributor.find_by(id: 1)
    @contributor_articles = @contributor.articles.includes(:periodical)
  end

end
