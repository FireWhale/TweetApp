class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
	
	  validates :name,  :presence => true, :length   => { :maximum => 50 }, :uniqueness => true
	  validates :email, :presence => true, :uniqueness => true
	  validates :password, :presence => true, :confirmation => true, :length => { :within => 6..40 }
	
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    if user.nil?
      nil
    elsif user.has_password?(submitted_password)
      user
    else
      nil
    end
  end
  
  private

    def encrypt_password
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      string # Only a temporary implementation!
    end	

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
