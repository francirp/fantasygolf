class MarketingController < ApplicationController

  def home
    raise SportsDataApiWrapper::Season.new(year: 2015).pull.inspect
  end

end
