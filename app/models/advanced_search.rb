class AdvancedSearch < FortyFacets::FacetSearch
  model 'Article'

  range :article_year, name: 'Article Year'

  facet :contributors, name: 'Contributor', order: :full_name
  facet :periodical, name: 'Periodical', order: :title
  facet :article_type, name: 'Article Type'
  facet [:contributors, :gender], name: 'Gender'
  facet [:contributors, :nationality], name: 'Nationality'

  text :title, name: 'Search by Title'

  AGGREGATION_ATTRIBUTES = {
    :article_type => [:article_type],
    :article_year => [:article_year],
    :periodical => [:periodical, :title],
    :contributor_nationality => [:contributors, :first, :nationality],
    :article_year => [:article_year]
  }

  def aggregation_options
    AGGREGATION_ATTRIBUTES.map {|k,v| [k.to_s.titleize, k]}
  end

  def aggregate(list, group_by_attribute)
    by_type={}
    list.each do |article|
      method_list = AGGREGATION_ATTRIBUTES[group_by_attribute.to_sym]
      agg_attr_value = aggregation_attribute_value(article, method_list)
      type_entry = by_type[agg_attr_value] || {:count => 0, :page_sum => 0}
      type_entry[:count] += 1
      type_entry[:page_sum] += article.page_end - article.page_start + 1  if article.page_end && article.page_start
      by_type[agg_attr_value] = type_entry
    end
    
    by_type
  end

  def aggregation_attribute_value(item, method_list)
    this_object = item
    method_list.each do |next_method_name|
      this_object = this_object.send(next_method_name)
    end
    this_object
  end

end