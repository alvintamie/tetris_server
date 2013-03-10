class LandingsController < ApplicationController
  skip_before_filter :current_user
  before_filter :redirect_if_logged_in!

  def show
    
  end
end
