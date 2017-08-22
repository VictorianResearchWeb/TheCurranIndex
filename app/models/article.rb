class Article < ActiveRecord::Base
  has_and_belongs_to_many :contributors
  belongs_to :periodical
  belongs_to :month

  scope :contents_order, -> { order(:issue_number).order(:page_start).order(:page_end)}
  scope :periodical_order, -> { joins(:periodical).merge(Periodical.order(title: :asc)).order(volume: :asc)}

  scope :order_by_date, -> { order(:article_year).order(:month_id)}
  #scope :range_by_date, -> (first, last) { where("article_year >= ? AND article_year <= ?", first, last )}

  #concatenate date information for display
  def date
    date = [self.month.publication_month, self.day, self.article_year].reject(&:blank?).join(" ").to_s
  end

  def pages
    "#{self.page_start} - #{self.page_end}"
  end

  def author_citation
    array = [self.periodical.abbreviation, self.code, self.attribution_confidence, "Volume #{self.volume}", self.date, self.title, self.pages]
    citation = array.reject(&:blank?).join(", ").to_s

    unless self.article_type == "prose"
      citation = citation + " [#{self.article_type}]"
    end
    return citation
  end

#create string of article information for periodical citation
  def periodical_citation
    all_contributors = self.contributors.map{|contributor| contributor.first_last_name}

    if self.code == "none"
      code = ""
    else
      code = self.code
    end

    array = [self.periodical.abbreviation, code, "<b>#{self.title}</b>", self.pages, self.date, all_contributors, self.attribution_confidence, self.attribution]
    citation = array.reject(&:blank?).join(", ").to_s

    unless self.article_type == "prose"
      citation = citation + " [#{self.article_type}]"
    end
    return citation
  end


end