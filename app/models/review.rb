class Review < ActiveRecord::Base
  validates :content, presence: true
  validates :rating, presence: true
  validates :user_id, presence: true

  belongs_to :product
  belongs_to :user
end
