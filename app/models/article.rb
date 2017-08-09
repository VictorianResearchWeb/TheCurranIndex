class Article < ActiveRecord::Base
  has_and_belongs_to_many :contributors
  belongs_to :periodical

  def date
    Time.now
  end
end