class TetrisController < ApplicationController

  def index
    redirect_to dashboard_path, :flash => { :error => "Your game is not ready"} if !current_user.can_play?
    current_user.update_attributes(:status => "in_game")
  end


end
