class PagesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @leagues = current_user.leagues
  end

end
