class Group < ActiveRecord::Base
	attr_accessor :password
  before_save :encrypt_password

  attr_accessible :name, :topic, :supervisor, :password, :password_confirmation
  has_and_belongs_to_many :users
  validates :name, :presence => true, :uniqueness => true
  validates :password, :presence => true
  validates_confirmation_of :password

  def self.authenticate(name, password)
    group = find_by_name(name)
    if group && group.password_hash == BCrypt::Engine.hash_secret(password, group.password_salt)
      return group
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
