class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validates :title, uniqueness: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  has_many :crossposts,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: "CrossPost",
    inverse_of: :post

  has_many :subs,
    through: :crossposts,
    source: :subreddit
  # has_many :subs,
  #   through: :crossposts,
  #   source: :subreddit
  #
  # has_many :crossposts,
  #   primary_key: :id,
  #   foreign_key: :post_id,
  #   class_name: :CrossPost,
  #   inverse_of: :post

end
