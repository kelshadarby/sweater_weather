class User < ApplicationRecord
  before_validation :generate_unique_api_key, on: :create

  validates :email, uniqueness: true, presence: true
  validates :api_key, uniqueness: true
  has_secure_password

  def generate_unique_api_key
    self.api_key = SecureRandom.hex
  end
end
