class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid, :game, :status
  belongs_to :game

  IN_GAME_STATUS = "in_game"
  WAITING_STATUS = "waiting"
  READY_STATUS = "ready"
  OPEN_STATUS = "open"
  NUMBER_PLAYER = 2
  def in_game?
    status == IN_GAME_STATUS
  end

  def is_waiting?
    status == WAITING_STATUS
  end

  def is_ready?
    status == READY_STATUS
  end

  def is_open?
    status == OPEN_STATUS
  end
  
  def can_play?
    game = self.game
    return false if game.nil? || game.users.length != NUMBER_PLAYER
    users = game.users
    users.each do |u|
      return false if u.status != READY_STATUS && u.status != IN_GAME_STATUS
    end
    return true
  end

  def set_status_open
    g = self.game
    g.destroy if g.present? && g.users.empty?
    self.update_attributes(:status => OPEN_STATUS, :game => nil)
  end

  def set_status_waiting
    self.update_attributes(:status => WAITING_STATUS)
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      #user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def create_survey_from_omniauth(auth)
    self.build_survey.create_survey_from_omniauth auth if self.survey.blank?
  end

end
