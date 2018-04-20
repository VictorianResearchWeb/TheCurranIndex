class ArticlesController < ApplicationController
  def index
    @search = ArticleSearch.new(params)
    @list = @search.result.includes(:contributors, :periodical, :month).periodical_order.contents_order.paginate(page: params[:page], :per_page => 20)
    @contents = PageContent.where(:page_key => 'home').first
  end

  def test
    @search = ArticleSearch.new(params)
    @list = @search.result.includes(:contributors, :periodical, :month).periodical_order.contents_order.paginate(page: params[:page], :per_page => 20)
  end

  def date_range
    #get date and previous search params
    date_range = params["date_range"]
    string = Rack::Utils.parse_nested_query(params["search_params"])
    #remove previous date range - can only search one at a time
    if string.key?("article_year")
      string.delete("article_year")
    end
    search_params = { "search" => string}
    #create a new search to get the article_year filter
    @search = ArticleSearch.new(search_params)
    year_filter = @search.filter(:article_year)
    #get the params for the article year filter, then add to previous params and redirect
    new_params = year_filter.add(date_range).path
    path = root_path + new_params
    render js: "window.location = '#{path}'"
  end

  def title_search
    #get title search and previous params
    title = params["title_search"]
    string = Rack::Utils.parse_nested_query(params["search_params"])
    #remove previous title search - only capable of one search at a time
    if string.key?("title")
      string.delete("title")
    end
    search_params = { "search" => string}
    #create a new search to get the title search filter
    @search = ArticleSearch.new(search_params)
    title_filter = @search.filter(:title)    
    #get the params for the title search filter, then add to previous params and redirect
    new_params = title_filter.add(title).path
    path = root_path + new_params
    render js: "window.location = '#{path}'"
  end

end
