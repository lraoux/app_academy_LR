# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base

  validates :email, :uniqueness => true, :presence => true

  has_many(
    :submitted_urls,
    class_name: "ShortenedUrl",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visited_urls,
    class_name: "Visit",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many :viewed_urls, through: :visited_urls, source: :visited_urls

end
