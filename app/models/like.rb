# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :integer
#  photo_id   :integer
#
class Like < ApplicationRecord
  # Associations
  belongs_to :fan, class_name: "User"
  belongs_to :photo

  # Validations
  validates :fan_id, presence: true
  validates :photo_id, presence: true
end
