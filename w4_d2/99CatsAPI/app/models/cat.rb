# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  COLOR = ['red', 'blue', 'green', 'yellow', 'black', 'white', 'brown', 'orange']

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLOR, message: "Not a valid color"}
  validates :sex, inclusion: {in: ['M','F'], message: "Not a valid sex"}

  has_many(
    :cat_rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )

  def age
    (Date.today - birth_date).to_f / 365.25
  end
end
