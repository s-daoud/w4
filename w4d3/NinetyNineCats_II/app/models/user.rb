class User < ActiveRecord::Base
  validates :user_name, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  has_many :cats,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: "Cat"

  has_many :requests,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'CatRentalRequest'

  has_many :session_lists

  def self.find_by_credentials(user_name, password)
      user = User.find_by_user_name(user_name)
      return nil if user.nil?
      user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
    self.save!
  end

  def is_password?(password)
    digest = BCrypt::Password.new(self.password_digest)
    digest.is_password?(password)
  end

end
