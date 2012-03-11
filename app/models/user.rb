class User < ActiveRecord::Base
	attr_accessible :name, :email
	
	  validates :name,  :presence => true, :length   => { :maximum => 50 }, :uniqueness => true
	  validates :email, :presence => true, :uniqueness => true
end
