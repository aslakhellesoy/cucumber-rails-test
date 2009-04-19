class User < ActiveRecord::Base
  require 'digest/sha2'

  attr_accessor :password_confirmation

  def password 
    @password
  end
  
  def password=(pass)
    @password = pass
    unless pass.blank?
      self.salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
      self.hashed_password = Digest::SHA256.hexdigest(pass + salt)
    end
  end

  def self.authenticate(username, password)
    u = self.find_by_username(username)
    if u.blank? || (Digest::SHA256.hexdigest(password + u.salt) != u.hashed_password)
      raise ActiveRecord::RecordNotFound, "Username or password invalid" 
    end
    u
  end
end