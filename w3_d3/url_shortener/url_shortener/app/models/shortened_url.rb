# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  short_url    :string
#  submitter_id :integer
#

require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :submitter_id, :presence => true
  validates :short_url, :uniqueness => true

  include SecureRandom

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  # Should return user objects
  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  has_many :visitors, Proc.new { distinct }, through: :visits, source: :visitors


  def self.random_code
      short_url = SecureRandom.urlsafe_base64
      while ShortenedUrl.exists?(short_url: short_url)
        short_url = SecureRandom.urlsafe_base64
      end
      short_url
  end

  def self.create_for_user_and_long_url!(user,long_url)
     short_url = ShortenedUrl.random_code
     ShortenedUrl.create!({long_url: long_url, short_url: short_url, submitter_id: user.id})
     short_url
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visits.select(:user_id).count
  end

  def num_recent_uniques
    self.visits.select(:user_id).where("created_at >= ? ",10.minutes.ago).count
  end

end
