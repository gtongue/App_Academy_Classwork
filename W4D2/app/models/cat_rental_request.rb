# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
  # validates :does_not_overlap_approved_request

  belongs_to :cat,
    class_name: 'Cat',
    foreign_key: :cat_id,
    primary_key: :id

  def overlapping_requests
    # debugger
    overlapping = CatRentalRequest
      .where(cat_id: self.cat_id)
      .where('id != ?', self.id)
    overlapping.select do |req|
      (self.start_date.mjd..self.end_date.mjd).overlaps?(req.start_date.mjd..req.end_date.mjd)
    end
  end

  def overlapping_pending_requests
    overlapping_requests.select { |req| req.status == 'PENDING'}
  end

  def overlapping_approved_requests
    overlapping_requests.select { |req| req.status == 'APPROVED' }
  end

  def does_not_overlap_approved_request
    !overlapping_approved_requests.exists?
  end

  def approve!
    pending_requests = overlapping_pending_requests
    CatRentalRequest.transaction do
      self.status = 'APPROVED'
      self.save
      pending_requests.update_all(status: 'DENIED')
    end
  end

end
