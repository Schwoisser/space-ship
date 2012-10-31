class User < ActiveRecord::Base
  attr_accessible :name, :password
  #validates :name, presence: true, uniqueness: tru
end