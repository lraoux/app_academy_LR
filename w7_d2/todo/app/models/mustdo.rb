# == Schema Information
#
# Table name: mustdos
#
#  id         :integer          not null, primary key
#  title      :text
#  body       :text
#  done       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Mustdo < ActiveRecord::Base
  validates :title, :body, presence: true
  validates :done, :inclusion => {:in => [true, false]}
  
end
