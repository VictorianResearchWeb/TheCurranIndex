module ContributorsHelper

  def selected(filter_name)
    #determine which search filter, then return the correct descriptor and object
    filter = @search.filter(filter_name)
    if filter_name == :gender
      @link = {}
      filter.selected.each do |entity|
        @entity_name = entity
        @link.store(@entity_name, entity)
      end   
    elsif filter_name == :nationality
      @link = {}
      filter.selected.each do |entity|
        @entity_name = entity
        @link.store(@entity_name, entity)
      end   
    #article type is prose or verse
    elsif filter_name == [:articles, :article_type]
      @link = {}
      filter.selected.each do |entity|
        @link.store(entity, entity)
      end
    elsif filter_name == :full_name
      @link = {}
      unless filter.value.nil?
        @link.store(filter.value[0], filter.value)
      end
    end

    #contributors are described by first and last name
    if filter_name == :contributors
      @link = {}
      filter.selected.each do |entity|
        @entity_name = entity.first_last_name
        @link.store(@entity_name, entity)
      end
    #periodicals are described by title
    elsif filter_name == :periodical
      @link = {}
      filter.selected.each do |entity|
        @entity_name = entity.title
        @link.store(@entity_name, entity)
      end
    #article type is prose or verse
    elsif filter_name == :article_type
      @link = {}
      filter.selected.each do |entity|
        @link.store(entity, entity)
      end
    #date range is the date range
    elsif filter_name == :article_year
      @link = {}
      unless filter.value.nil?
        @link.store(filter.value[0], filter.value)
      end
    #title search is the search word
    elsif filter_name == :title
      @link = {}
      unless filter.value.nil?
        @link.store(filter.value[0], filter.value)
      end
    end
    return @link
  end

  def comment(filter_name)
    filter = @search.filter(filter_name)
    if filter_name == :periodical
      @comment = {}
      filter.selected.each do |entity|
        @comment.store(entity.title, entity.comment)
      end
    else
      @comment = nil
    end
    return @comment
  end

  #This concatenates the information for a particular contributor. Items shouldn't be displayed under certain circumstances (blank/nil/certain entries).
  def bio(contrib)

    #this provides the html for the popover, redirecting to a partial with the periodical information
    comment = "<b><a tabindex='0' class='popover-periodical' data-toggle='popover' data-trigger='focus' title='#{art.periodical.title}' data-content='#{render :partial => 'periodical', :locals => {periodical: art.periodical}}'> #{art.periodical.abbreviation}</a></b>"



    #put the citation in order and drop any items that are nil/blank, joining with a comma
    array = [comment, code, art.title, art.pages, art.date, all_contributors, art.attribution_confidence, art.attribution]
    citation = array.reject(&:blank?).join(", ").to_s

    #the following items are joined with spaces, not comma
    #only show article type if it's anything other than prose
    unless art.article_type == "prose"
      citation = citation + " [#{art.article_type}]"
    end
    citation = citation + " #{art.entry_month}"
    #show payments if they exist
    unless art.payment.nil?
      citation = citation + " #{art.payments}"
    end
    return bio
  end

end
