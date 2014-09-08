class Product < ActiveRecord::Base

  VALID_PRICE_REGEX = /\A\d+(?:\.\d{0,2})?\z/

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true,
                    numericality: true,
                    format: { with: VALID_PRICE_REGEX }

  belongs_to :category
  belongs_to :user
  has_many :reviews

  def average_rating
    average = 0.0
    self.reviews.each do |rev|
      average += rev.rating
    end

    average / self.reviews.count
  end
end
