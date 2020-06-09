require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it { should validate_presence_of :email }
  end
  describe "Instance Methods" do
    it "generate_unique_api_key" do
      user = User.create(email: 'email@example.com')
      expect(user.api_key).to_not eq(nil)

      user_2 = User.create(email: 'email2@example.com')
      expect(user_2.api_key).to_not eq(user.api_key)

      user_3 = User.create(email: 'email3@example.com',
                           password: "password",
                           api_key: '08374d9df11ad1baf159d4f63ed80c61')

      expect(User.last).to eq(user_3)
      expect{User.find(user_3.id)}.to_not raise_error(ActiveRecord::RecordNotFound)

      user_4 = User.create(email: 'email4@example.com',
                           password: "password",
                           api_key: '08374d9df11ad1baf159d4f63ed80c61')

      expect{User.find(user_4.id)}.to_not raise_error(ActiveRecord::RecordNotFound)
      expect(user_4.api_key).to_not eq('08374d9df11ad1baf159d4f63ed80c61')
    end
  end
end
