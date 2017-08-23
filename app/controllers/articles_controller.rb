class ArticlesController < ApplicationController
  def index
    @periodicals = Periodical.order(:title)
    @search = ArticleSearch.new(params)
    @list = @search.result.includes(:contributors, :periodical, :month).periodical_order.contents_order.paginate(page: params[:page], :per_page => 20)
  end

  def contributor
    @contributor = Contributor.find_by(id: 1)
    @contributor_articles = @contributor.articles.includes(:periodical, :month)

  end

  def periodical
    @periodical = Periodical.find_by(id: 1)
    @list = @periodical.articles.includes(:periodical, :month).includes(:contributors).order_by_volume.paginate(:page => params[:page], :per_page => 30)

  end

  def test
    @periodicals = Periodical.order(:title)
    @search = ArticleSearch.new(params)
    @list = @search.result.includes(:contributors, :periodical, :month).periodical_order.contents_order.paginate(page: params[:page], :per_page => 20)
  end

  def date_range
    date_range = params["date_range"]
    string = Rack::Utils.parse_nested_query(params["search_params"])
    search_params = { "search" => string}
    @search = ArticleSearch.new(search_params)
    year_filter = @search.filter(:article_year)
    new_params = year_filter.add(date_range).path
    path = root_path + new_params
    render js: "window.location = '#{path}'"
  end


end
