class User < ApplicationRecord
  before_validation :generate_unique_api_key, on: :create

  validates :email, uniqueness: true, presence: true
  validates :api_key, uniqueness: true
  has_secure_password

  def generate_unique_api_key
    key = generate_api_key
    if User.find_by(api_key: key)
      until !(User.find_by(api_key: key)) do
        new_key = generate_api_key
      end
      self.api_key = new_key
    else
      self.api_key = key
    end
  end

  private

  def generate_api_key
    Array.new(27){[*"A".."Z", *"a".."z", *"0".."9"].sample}.join
  end
end
