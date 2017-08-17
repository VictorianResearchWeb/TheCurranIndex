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
      
    end
    return @link
  end

end
