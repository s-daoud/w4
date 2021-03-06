

class User < ActiveRecord::Base
  attr_reader :password

  after_initialize :ensure_session_token

  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  has_many :subreddits,
    primary_key: :id,
    foreign_key: :mod_id,
    class_name: :SubReddit

  has_many :posts,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Post



  def self.find_by_creds(username, password)
    user = find_by(username: username)
    return nil if user.nil?
    if user.is_password?(password)
      user
    else
      nil
    end
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    pass = BCrypt::Password.new(self.password_digest)
    return true if pass.is_password?(password)
    false
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64(16)
  end

end
