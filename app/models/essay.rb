class Essay < ActiveRecord::Base
  belongs_to :month, foreign_key: "pub_month"

  scope :date_order, -> { order(pub_year: :desc).order(pub_month: :desc)}

  #used to display release note essays
  def pub_date
    "#{self.month.publication_month} #{self.pub_year}"
  end
end