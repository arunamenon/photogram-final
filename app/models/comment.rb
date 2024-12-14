# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#  photo_id   :integer
#
class Comment < ApplicationRecord
  # Associations
  belongs_to :photo
  belongs_to :author, class_name: "User"

  # Validations
  validates :body, presence: true
  validates :author_id, presence: true
  validates :photo_id, presence: true
end
