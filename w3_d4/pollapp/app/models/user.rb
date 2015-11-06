# == Schema Information
#
# Table name: users
#
#  id        :integer          not null, primary key
#  user_name :string           not null
#

class User < ActiveRecord::Base
  validates :user_name, presence: true

  has_many(
    :polls,
    class_name: "Poll",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :user_id,
    primary_key: :id
  )


end
