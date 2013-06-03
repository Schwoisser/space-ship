class User < ActiveRecord::Base
  attr_accessible :name, :password
  #attr_accessible :cash ,:salt, :hashed_password, :last_login_time
  #attr_accessible :last_login_ip, :current_login_time, :current_login_ip
  validates :name, presence: true, uniqueness: true
  
    def authenticate(pw)
      if (self.password == pw)
        true
      else
        false
      end
    end
end