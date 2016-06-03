class Toy < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  belongs_to :toyable, polymorphic: true
end
