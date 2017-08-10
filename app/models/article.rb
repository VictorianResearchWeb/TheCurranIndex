class Article < ActiveRecord::Base
  has_and_belongs_to_many :contributors
  belongs_to :periodical
  belongs_to :month

  #concatenate date information for display
  def date
    date = "#{self.month.name} #{self.day} #{self.year}"
  end

  def pages
    "#{self.page_start} - #{self.page_end}"
  end

  #create string of article information for periodical citation
  def periodical_citation
    
    all_contributors = []
    self.contributors.each do |c|
      all_contributors << c.first_last_name
    end
    
    array = [self.periodical.abbreviation, self.code, self.title, self.pages, all_contributors, self.attribution_confidence, self.attribution]
    citation = array.reject(&:blank?).join(", ").to_s

    unless self.article_type == "prose"
      citation = citation + " [#{self.article_type}]"
    end
    return citation
  end

  def author_citation
    array = [self.periodical.abbreviation, self.code, self.attribution_confidence, "Volume #{self.volume}", self.date, self.title, self.pages]
    citation = array.reject(&:blank?).join(", ").to_s

    unless self.article_type == "prose"
      citation = citation + " [#{self.article_type}]"
    end
    return citation
  end

end