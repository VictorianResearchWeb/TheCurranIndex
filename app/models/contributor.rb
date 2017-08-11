class Contributor < ActiveRecord::Base
#  has_many :article_contributor_links
#  has_many :articles, through: :article_contributor_links
  has_and_belongs_to_many :articles

  scope :by_periodical, ->(periodical) { joins(articles: :periodical).where(articles: {periodical_id: periodical})}

  #scope :names_by_article, ->(articles) {joins(:articles).where(articles: {id: articles.ids}).pluck(:full_name)}

  scope :names_by_article, -> {pluck(:full_name) }


  def birthdate
    if self.birth
      birthdate = self.birth.strftime('%m/%d/%Y')
    else
      birthdate = self.birth_year
    end
    return birthdate
  end

  def deathdate
    if self.death
      deathdate = self.death.strftime('%m/%d/%Y')
    else
      deathdate = self.death_year
    end
    return deathdate
  end

  def first_last_name
    self.full_name.split(",").reverse.join(" ").strip
  end

end