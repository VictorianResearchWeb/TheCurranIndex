class Article < ActiveRecord::Base
  has_and_belongs_to_many :contributors
  belongs_to :periodical
  belongs_to :month

  scope :contents_order, -> { order(:issue_number).order(:page_start).order(:page_end)}
  scope :periodical_order, -> { joins(:periodical).merge(Periodical.order(title: :asc))}

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

  #display payment information as British currency
  def payments
    currency = self.payment.insert(6, "d").insert(4, "s.").insert(2, ".").insert(0, "&pound")
    return currency
  end

end