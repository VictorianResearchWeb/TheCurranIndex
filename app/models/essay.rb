class Essay < ActiveRecord::Base
  belongs_to :month, foreign_key: "pub_month"

  scope :date_order, -> { order(pub_year: :desc).order(pub_month: :desc)}

  #used to display truncated release note essays
  def short
    "#{self.contents.truncate_words(30)} </font>"
  end

end