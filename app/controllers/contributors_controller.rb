class ContributorsController < ApplicationController
  def index
    @per_page = params[:per_page] || 20
    # if no params, then show all contributors
    #if true 
      #@list = Contributor.all.order(:full_name).paginate(page: params[:page], :per_page => @per_page)
    #else 
      @search = ContributorSearch.new(params)
      @list = @search.result.order(:full_name).paginate(page: params[:page], :per_page => @per_page)
    #@list = @search.result.includes(:contributors, :periodical, :month).periodical_order.contents_order.paginate(page: params[:page], :per_page => @per_page)
    #end
    page_contents = PageContent.where(:page_key => 'contributors').first
    @contents = page_contents ? page_contents.html : nil
  end

  CONTRIBUTOR_HEADERS =
  [
    :full_name,
    :birth,
    :death,
    :gender,
    :education,
    :nationality,
    :birth_year,
    :death_year,
    :identifier,
    :wellesley,
    :comment
  ]

  def download
    search = ContributorSearch.new(params)
    list = search.result.order(:full_name)
    csv = CSV.generate(:headers => true) do |records|
      # create headers
      headers = CONTRIBUTOR_HEADERS
      records << headers.map{|k| k.to_s.titleize}
      
      # fill cells
      list.each do |contributor|
        record = []
        CONTRIBUTOR_HEADERS.each do |k|
          datum = contributor[k]
          datum = datum.gsub(/\n/, ' ') if datum.is_a?(String) && datum.blank? 
          record << datum
        end
        records << record
      end
    end
    
    send_data csv, filename: "curran_search_contributors_#{Date.today}.csv"
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

  def birth_range
    #get date and previous search params
    date_range = params["birth_range"]
    string = Rack::Utils.parse_nested_query(params["search_params"])
    #remove previous date range - can only search one at a time
    if string.key?("birth_year")
      string.delete("birth_year")
    end
    search_params = { "search" => string}
    #create a new search to get the article_year filter
    @search = ContributorSearch.new(search_params)
    year_filter = @search.filter(:birth_year)
    #get the params for the birth year filter, then add to previous params and redirect
    new_params = year_filter.add(date_range).path
    path = contributors_path + new_params
    render js: "window.location = '#{path}'"
  end

  def full_name_search
    #get fullname search and previous params
    fullname = params["full_name_search"]
    string = Rack::Utils.parse_nested_query(params["search_params"])
    #remove previous fullname search - only capable of one search at a time
    if string.key?("fullname")
      string.delete("fullname")
    end
    search_params = { "search" => string}
    #create a new search to get the fullname search filter
    @search = ContributorSearch.new(search_params)
    fullname_filter = @search.filter(:full_name)    
    #get the params for the fullname search filter, then add to previous params and redirect
    new_params = fullname_filter.add(fullname).path
    path = contributors_path + new_params
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

  def comments_search
    #get fullname search and previous params
    comments = params["comments_search"]
    string = Rack::Utils.parse_nested_query(params["search_params"])
    #remove previous fullname search - only capable of one search at a time
    if string.key?("comments")
      string.delete("comments")
    end
    search_params = { "search" => string}
    #create a new search to get the fullname search filter
    @search = ContributorSearch.new(search_params)
    comments_filter = @search.filter(:comment)    
    #get the params for the fullname search filter, then add to previous params and redirect
    new_params = comments_filter.add(comments).path
    path = contributors_path + new_params
    render js: "window.location = '#{path}'"
  end

end
