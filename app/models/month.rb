class Month < ActiveRecord::Base
  has_many :articles
  has_many :essays
end