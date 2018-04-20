class StaticPagesController < ApplicationController
  before_action :load_contents
  def history
    load_contents('history')
  end

  def sites
    load_contents('sites')
  end

  def scholarship
    load_contents('scholarship')
  end

  def contact
    load_contents('contact')
    @contact = Contact.first
  end
  
 
  def load_contents(page_key = nil)
    @contents = nil
    @page_key = page_key || params[:page_key]
    if @page_key
      @contents = PageContent.where(:page_key => @page_key).first
    end    
  end
end
