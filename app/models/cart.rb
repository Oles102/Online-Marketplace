class Cart < ApplicationRecord
  has_many :orderables
  has_many :products, through: :orderables
  belongs_to :user
  def total
    orderables.to_a.sum { |orderable| orderable.total }
  end
end
