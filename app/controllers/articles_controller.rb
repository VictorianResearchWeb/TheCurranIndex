class ArticlesController < ApplicationController
  def index
    @periodicals = Periodical.order(:title)
    @search = ArticleSearch.new(params)
    @list = @search.result.includes(:contributors, :periodical).periodical_order.paginate(page: params[:page], :per_page => 20)
#    @periodical = Periodical.find_by(id: 1)
    
#    @list = @periodical.articles.includes(:periodical, :month).group_by(&:volume)

#    @articles = Article.order(:title).paginate(:page => params[:page], :per_page => 30)
  end

  def contributor
    @contributor = Contributor.find_by(id: 1)
    @contributor_articles = @contributor.articles.includes(:periodical, :month)
  end

  def periodical
    @periodical = Periodical.find_by(id: 1)
    
    @list = @periodical.articles.includes(:periodical, :month).includes(:contributors).order_by_volume.paginate(:page => params[:page], :per_page => 30)

  end

end
