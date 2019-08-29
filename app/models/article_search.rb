class ArticleSearch < FortyFacets::FacetSearch
  model 'Article'

  range :article_year, name: 'Article Year'

  #facet :full_name, name: 'Contributor', order: :downcase #how it's done in a related model
  #facet :contributors, name: 'Contributor', order: :full_name 
  facet :contributors, name: 'Contributor', order: Proc.new { |contributor| contributor.full_name.downcase } # change the order here. contributor.fullname.diwncase
  #facet :contributors, name: 'Contributor', order: "lower(contributor) DESC" # change the order here.
  facet :periodical, name: 'Periodical', order: :title
  facet :article_type, name: 'Genre'

  text :title, name: 'Search by Title'

end