class Game < ActiveRecord::Base
  attr_accessible :status,:secret_key,:user_id,:message
  has_many :users

  validates :message, :presence => true

  IN_GAME_STATUS = "in_game"
  WAITING_STATUS = "waiting"

  def is_waiting?
    status == WAITING_STATUS
  end

  def in_game?
    status == IN_GAME_STATUS
  end

end
