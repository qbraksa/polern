class PagesController < ApplicationController
  def index
    @communities = Community.all
  end
end
