class ArticleSearch < FortyFacets::FacetSearch
  model 'Article'

  text :title, name: 'Title'
  range :article_year, name: 'Article Year'

  facet :contributors, name: 'Contributor', order: :full_name
  facet :periodical, name: 'Periodical', order: :title
  facet :article_type, name: 'Article Type'

end