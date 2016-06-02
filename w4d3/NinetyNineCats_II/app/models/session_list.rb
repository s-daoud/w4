class SessionList < ActiveRecord::Base
  validates :user_id, :session_token, presence: true
  validates :session_token, uniqueness: true

  belongs_to :user

  def self.add_session_token(user)
    token = SecureRandom::urlsafe_base64(16)
    SessionList.create(user_id: user.id, session_token: token)
    token
  end

  def self.delete_session_token(token)
    SessionList.destroy(SessionList.find_by(session_token: token))
  end
end
