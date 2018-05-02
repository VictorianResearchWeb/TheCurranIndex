class ArticlesController < ApplicationController
  def index
    @search = ArticleSearch.new(params)
    @per_page = params[:per_page] || 20
    @list = @search.result.includes(:contributors, :periodical, :month).periodical_order.contents_order.paginate(page: params[:page], :per_page => @per_page)
    page_contents = PageContent.where(:page_key => 'home').first
    @contents = page_contents ? page_contents.html : nil
  end

  def advanced_search
    @search = AdvancedSearch.new(params)
    @per_page = params[:per_page] || 20
    @list = @search.result.includes(:contributors, :periodical, :month)
    page_contents = PageContent.where(:page_key => 'home').first
    @contents = page_contents ? page_contents.html : nil
    @group_by_attribute=params[:aggregate_by]||'article_type'
        
    @aggregation = @search.aggregate(@list, @group_by_attribute)
  end

  PERIODICAL_HEADERS = 
  [
    :abbreviation,
    :title,
    :frequency
  ]
  ARTICLE_HEADERS =
  [
    :title,
    :article_year,
    :month_id,
    :day,
    :page_start,
    :page_end,
    :volume,
    :article_type,
    :entry_month,
    :issue_number
  ]
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
    :wellesley
  ]

  def download
    search = ArticleSearch.new(params)
    list = search.result.includes(:contributors, :periodical, :month).periodical_order.contents_order

    csv = CSV.generate(:headers => true) do |records|
      # create headers
      headers = PERIODICAL_HEADERS+ARTICLE_HEADERS
      0.upto(3) { |i| headers += CONTRIBUTOR_HEADERS.map {|k| "Contributor__#{i+1}_#{k}" }}
      records << headers.map{|k| k.to_s.titleize}
      
      # fill cells
      list.each do |article|
        record = []
        PERIODICAL_HEADERS.each do |k|
          record << article.periodical[k]
        end
        
        ARTICLE_HEADERS.each do |k|
          record << article[k]
        end
        
        # max of four contributors
        0.upto(3) do |i|
          if article.contributors[i]
            # contributor i info
            CONTRIBUTOR_HEADERS.each do |k|
              record << article.contributors[i][k]
            end
          else
            CONTRIBUTOR_HEADERS.each { record << "" }
          end
        end        
        records << record
      end
    end
    
    send_data csv, filename: "curran_search_#{Date.today}.csv"
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
