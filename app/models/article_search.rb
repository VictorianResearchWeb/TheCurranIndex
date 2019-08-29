class ArticleSearch < FortyFacets::FacetSearch
  model 'Article'

  range :article_year, name: 'Article Year'

  facet :contributors, name: 'Contributor', order: :full_name
  facet :periodical, name: 'Periodical', order: :title
  facet :article_type, name: 'Genre'

  text :title, name: 'Search by Title'

end