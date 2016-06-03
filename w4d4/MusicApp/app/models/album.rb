class Album < ActiveRecord::Base
  TYPES = %w(Live Studio)
  validates :name, :band_id, :album_type, presence: true

  belongs_to :band
  has_many :tracks, dependent: :destroy
end
