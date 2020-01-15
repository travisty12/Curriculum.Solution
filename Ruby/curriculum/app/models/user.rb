class User < ApplicationRecord
  attr_accessor :password
  validates :password, :confirmation => true, :format => { :with => /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[-+_!@#$%^&*.,?]).{6,}\z/, :message => "Must have an uppercase letter, a lowercase letter, a number, and a symbol"}
  validates :email, :presence => true, :uniqueness => true
  before_save :encrypt_password

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
  end

  def self.authenticate(email, password)
    user = User.find_by "email = ?", email
    if user && user.password_has == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end