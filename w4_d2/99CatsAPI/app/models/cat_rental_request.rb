# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  STATUSES = ['PENDING', 'APPROVED', 'DENIED']

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: STATUSES, message: "Not a valid status"}

  belongs_to(
    :cat,
    class_name: "Cat",
    primary_key: :id,
    foreign_key: :cat_id
  )

  def overlapping_requests
     cat.cat_rental_requests.where(<<-SQL,self.id, self.start_date, self.end_date)
      (? != id)
      AND
      ((? BETWEEN start_date AND end_date)
      OR
      (? BETWEEN start_date AND end_date))
    SQL

  end

  def overlapping_approved_requests
    overlapping_requests.where("status = ?", "APPROVED")
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = ?", "PENDING")
  end

  def approve!
    raise "Overlapping request!" unless overlapping_approved_requests.empty?
    self.status = "APPROVED"
    self.save!
    overlapping_pending_requests.each { |request| request.deny! }
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  def pending?
    self.status == "PENDING"
  end

end
