class StaticPagesController < ApplicationController
  def history
  end

  def sites
  end

  def scholarship
  end

  def contact
    @contact = Contact.first
  end
end
