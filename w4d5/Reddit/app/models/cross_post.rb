class CrossPost < ActiveRecord::Base
  validates :subreddit, :post, presence: true

  belongs_to :subreddit,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :SubReddit,
    inverse_of: :crossposts

  belongs_to :post,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :Post,
    inverse_of: :crossposts
end
