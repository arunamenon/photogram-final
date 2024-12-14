# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord
  # Associations
  belongs_to :owner, class_name: "User"
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  # Which users liked this photo?
  has_many :fans, through: :likes, source: :fan

  # Validations
  validates :owner_id, presence: true
end
