class SubReddit < ActiveRecord::Base
  validates :title, :mod_id, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :mod_id,
    class_name: :User

  has_many :posts,
    through: :crossposts,
    source: :post

  has_many :crossposts,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :CrossPost,
    inverse_of: :subreddit

end
