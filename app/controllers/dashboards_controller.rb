class DashboardsController < ApplicationController
  before_filter :current_user_status_to_open
  
  def show
  	@name = @current_user.name
  	@games = Game.all
  end

  def join
    @game = Game.find_by_id(params[:game_id])
    if @game.secret_key != params[:secret_key]  
    	redirect_to dashboard_path, :flash => { :error => "Your secret key does not match"} 
	else
		@current_user.update_attributes(:game => @game)
    	redirect_to waiting_room_games_path, :flash => { :success => "Just joined a game"}
	end
  end
end
