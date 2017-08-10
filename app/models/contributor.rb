class Contributor < ActiveRecord::Base
  has_and_belongs_to_many :articles

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