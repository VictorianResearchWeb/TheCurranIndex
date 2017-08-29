class Essay < ActiveRecord::Base
  belongs_to :month

  scope :date_order, -> { order(pub_year: :desc).order(pub_month: :desc)}
end