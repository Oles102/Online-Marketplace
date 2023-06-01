class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :reviews

  validates :name, presence: true, length: { minimum: 5 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :category, presence: true

end
