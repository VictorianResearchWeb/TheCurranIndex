class ArticleSearch < FortyFacets::FacetSearch
  model 'Article'

  text :title, name: 'Title'
  range :date, name: 'Date'

  facet :contributors, name: 'Contributor', order: :full_name
  facet :periodical, name: 'Periodical', order: :title
  facet :article_type, name: 'Article Type'

  
end