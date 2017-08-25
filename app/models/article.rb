class Article < ActiveRecord::Base
  has_and_belongs_to_many :contributors
  belongs_to :periodical
  belongs_to :month

  scope :contents_order, -> { order(:issue_number).order(:page_start).order(:page_end)}
  scope :periodical_order, -> { joins(:periodical).merge(Periodical.order(title: :asc)).order(volume: :asc)}

  #concatenate date information for display
  def date
    if self.day
      day = "#{self.day}, "
    else
      day = self.day
    end

    date = [self.month.publication_month, day, self.article_year].reject(&:blank?).join(" ").to_s
  end

  #concatenate page numbers unless blank
  def pages
    if self.page_start && self.page_end
      pages = "#{self.page_start} - #{self.page_end}"
    elsif self.page_start && !self.page_end
      pages = self.page_start
    else
      pages = nil
    end
    return pages
  end

#create string of article information for periodical citation
  def periodical_citation
    all_contributors = self.contributors.map{|contributor| "<b>#{contributor.first_last_name}</b>"}

    if self.code == "none"
      code = ""
    else
      code = self.code
    end

    array = ["<b>#{self.periodical.abbreviation}</b>", code, self.title, self.pages, self.date, all_contributors, self.attribution_confidence, self.attribution]
    citation = array.reject(&:blank?).join(", ").to_s

    unless self.article_type == "prose"
      citation = citation + " [#{self.article_type}]"
    end
    citation = citation + " #{self.entry_month}"
    unless self.payment.nil?
      citation = citation + " #{self.payment}"
    end
    return citation
  end

end