class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }

  validate :overlapping?

  belongs_to :cat

  def overlapping_requests
    overlap = []
    requests = CatRentalRequest.where(cat_id: cat_id)
    requests.each do |request|
      if ((start_date.between?(request.start_date, request.end_date) ||
         end_date.between?(request.start_date, request.end_date)) ||
         (start_date < request.start_date && end_date > request.end_date)) &&
         id != request.id
        overlap << request
      end
    end
    overlap
  end

  def overlapping_approved_requests
    overlap = overlapping_requests
    overlap.select do |ol|
      ol.status == "APPROVED"
    end
  end

  def overlapping_pending_requests
    overlap = overlapping_requests
    overlap.select do |ol|
      ol.status == "PENDING"
    end
  end

  def deny!
    self.status = 'DENIED'
    self.save!
  end

  def approve!
    CatRentalRequest.transaction do
      self.status = 'APPROVED'
      self.save!
      overlapping_pending_requests.each do |request|
        request.status = 'DENIED'
        request.save!
      end
    end
  end

  def pending?
    self.status == "PENDING"
  end

  private
  def overlapping?
    unless status == "DENIED"
      if overlapping_approved_requests.length > 0
        errors.add(:status, "Cat already booked")
      end
    end
  end

end
