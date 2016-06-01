class Cat < ActiveRecord::Base
  COLORS = ["black", "white", "orange", "grey", "brown"]
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: %w(F M) }

  has_many :cat_rental_requests, dependent: :destroy

  def age
    current_date = Time.now.to_date
    ((current_date - birth_date).to_i) / 365
  end
end
