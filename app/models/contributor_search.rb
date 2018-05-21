class ContributorSearch < FortyFacets::FacetSearch
  model 'Contributor'

  #range :article_year, name: 'Article Year'

  facet :full_name, name: 'Contributor', order: :downcase
  facet :gender, name: 'Gender'
  facet :nationality, name: 'Nationality', order: :to_s
  #facet :articles, name: 'Articles'
  facet [:articles, :article_type], name: 'Article Type'
  facet [:articles, :periodical], name: 'Periodical', order: :title
  facet :schools, name: 'Education'
  
  #text :full_name, name: 'Name Search'
  text :comment, name: 'Comments Search'

end