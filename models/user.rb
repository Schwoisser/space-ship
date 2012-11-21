class User < ActiveRecord::Base
  attr_accessible :name, :password, :cash
  #validates :name, presence: true, uniqueness: tru
end