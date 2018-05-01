class AdvancedSearch < FortyFacets::FacetSearch
  model 'Article'

  range :article_year, name: 'Article Year'

  facet :contributors, name: 'Contributor', order: :full_name
  facet :periodical, name: 'Periodical', order: :title
  facet :article_type, name: 'Article Type'
  facet [:contributors, :gender], name: 'Gender'
  facet [:contributors, :nationality], name: 'Nationality'

  text :title, name: 'Search by Title'

end