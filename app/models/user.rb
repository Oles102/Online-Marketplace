class User < ApplicationRecord
  rolify
  LANGUAGE_LOCALE = %w[en ru].freeze
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :roles, join_table: :users_roles
  has_many :products
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_one_attached :avatar
  has_one :cart, dependent: :destroy


  validates :email,    presence: true, uniqueness: true
  validates :password, presence: true
  validates :avatar, presence: true, allow_blank: true, blob: { content_type: :web_image }

  after_create :assign_default_role

  private

  def assign_default_role
    add_role(Role::USER) if roles.blank?
  end
end
