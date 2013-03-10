class GamesController < ApplicationController

  def index
  
  end

  def new
  	@game = Game.new
    redirect_to dashboard_path, :flash => { :error => "You already have a game"} if current_user.game.present?
  end

  def create
  	@game = Game.new(params[:game])
    @game.users.push(current_user)
  	@game.status =  'waiting'
  	if @game.save
      redirect_to waiting_room_games_path, :flash => { :success => "You have successfully created a game"}  
    else
      render :new
    end
  end

  def edit

  end

  def update
    
  end

  def destroy
    @game = current_user.game
    @game.destroy
    redirect_to dashboard_path
  end

  def waiting_room
    current_user.set_status_waiting
    @game = current_user.game
    @user = current_user
  end

  def opponent
    @game = current_user.game
    render :json => { 'away' => @game.users.select{|u| u!=current_user}, 'home' => current_user}
  end

  def ready
    params[:state] == 'true' ? status = 'ready' : status = 'waiting'
    current_user.update_attributes(:status => status)
    render :json => { :status => 'ready success'}
  end

end
