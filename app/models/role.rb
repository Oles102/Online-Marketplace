class Role < ApplicationRecord
  ADMIN ='admin'.freeze
  USER = 'user'.freeze
  SELLER = 'seller'.freeze
  AVAILABLE_ROLES = [ADMIN, USER, SELLER].freeze

  has_and_belongs_to_many :users, :join_table => :users_roles
  
  belongs_to :resource,
             :polymorphic => true,
             :optional => true
  

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  validates :name,
            :inclusion => { :in => AVAILABLE_ROLES },
            :allow_nil => false
  scopify
end
