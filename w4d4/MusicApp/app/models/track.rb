class Track < ActiveRecord::Base
  TYPES = %w(Regular Bonus)

  validates :name, :album_id, :track_type, :lyrics, presence: true

  belongs_to :album
  has_many :notes
end
