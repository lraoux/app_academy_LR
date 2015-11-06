class Track < ActiveRecord::Base
  validates :name, :album_id, :track_type, :lyrics,presence: true
  belongs_to(
    :album,
    class_name: "Album",
    foreign_key: :album_id,
    primary_key: :id)

  has_one :band, through: :album, source: :band

  has_many :notes, dependent: :destroy

end
