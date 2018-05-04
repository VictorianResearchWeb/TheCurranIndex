class Contributor < ActiveRecord::Base
  has_and_belongs_to_many :articles
  has_and_belongs_to_many :schools


  def education
    schools.to_a.map{|school| school.name}.join("; ")
  end

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
    name = self.full_name.split(",").reverse.join(" ").strip
    unless self.identifier.nil?
      name = name + " #{self.identifier}"
    end
    return name
  end

  def lifespan
    if self.birthdate && self.deathdate
      lifespan = "#{self.birthdate} - #{self.deathdate}"
    elsif self.birthdate && !self.deathdate
      lifespan = self.birthdate
    elsif !self.birthdate && self.deathdate
      lifespan = "? - #{self.deathdate}"
    else
      lifespan = nil
    end
    return lifespan
  end
  
  #concatenate biographical information on a contributor
  def biography
    array = [self.birthdate, "- #{self.deathdate}", "<br>", self.nationality, "<br>", self.education, "<br>", self.comment]
    biography = array.reject(&:blank?).join(" ").to_s
    return biography
  end

end