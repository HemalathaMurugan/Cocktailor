class User < ActiveRecord::Base
  validates :username, uniqueness: true
  validates :first_name, presence: true
  
end
