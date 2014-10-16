class RegistrationsController < Devise::RegistrationsController

  def after_sign_in_path_for(resource)
    current_user.leagues.any? ? dashboard_path : new_league_path
  end

end
