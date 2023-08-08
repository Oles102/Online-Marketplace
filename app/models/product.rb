class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :orderables
  has_many :carts, through: :orderables
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many_attached :images

  validates :name, presence: true, length: { minimum: 5 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :category, presence: true
  validates :user, presence: true
  validates :images, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[category_id description name price user_id]
  end
end
