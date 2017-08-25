module ArticlesHelper

  def selected(filter_name)
    filter = @search.filter(filter_name)
    if filter_name == :contributors
      @link = {}
      filter.selected.each do |entity|
        @entity_name = entity.first_last_name
        @link.store(@entity_name, entity)
      end
    elsif filter_name == :periodical
      @link = {}
      filter.selected.each do |entity|
        @entity_name = entity.title
        @link.store(@entity_name, entity)
      end

    elsif filter_name == :article_type
      @link = {}
      filter.selected.each do |entity|
        @link.store(entity, entity)
      end
      
    elsif filter_name == :article_year
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
#    elsif filter_name == :contributors
#      @comment = {}
#      filter.selected.each do |entity|
#        @comment.store(entity.first_last_name, entity.comment)
#      end
    else
      @comment = nil
    end
    return @comment
  end

  def citation(art)
    authors = art.contributors.map{|contributor| contributor.full_name }
    all_contributors = []
    authors.each do |c|
      contributor = Contributor.find_by(full_name: c)
      unless contributor.full_name == "Unknown"
        body = contributor.biography.gsub("'", "")
        string = "<b><a tabindex='0' class='popover-author' data-toggle='popover' data-trigger='focus' title='#{contributor.first_last_name}' data-content='#{render :partial => 'contributor', :locals => {contributor: contributor}}'> #{contributor.first_last_name}</a></b>"
      else
        body = nil
        string = contributor.full_name
      end
      all_contributors << string
    end

    if art.code == "none"
      code = ""
    else
      code = art.code
    end

    comment = "<b><a tabindex='0' class='popover-periodical' data-toggle='popover' data-trigger='focus' title='#{art.periodical.title}' data-content='#{render :partial => 'periodical', :locals => {periodical: art.periodical}}'> #{art.periodical.abbreviation}</a></b>"

    array = [comment, code, art.title, art.pages, art.date, all_contributors, art.attribution_confidence, art.attribution]
    citation = array.reject(&:blank?).join(", ").to_s

    unless art.article_type == "prose"
      citation = citation + " [#{art.article_type}]"
    end
    citation = citation + " #{art.entry_month}"
    unless art.payment.nil?
      citation = citation + " #{art.payment}"
    end
    return citation
  end

end
