class EssaysController < ApplicationController
  def index
    @essays = Essay.all.date_order
  end
end
