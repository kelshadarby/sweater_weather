require 'rails_helper'

RSpec.describe "User Creation" do
  it "User Registration", :vcr do
    user_params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post "/api/v1/users", params: {user: user_params}

    expect(response).to be_successful

    parsed_user_registration = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_user_registration).to have_key(:data)
    expect(parsed_user_registration[:data]).to have_key(:type)
    expect(parsed_user_registration[:data]).to have_key(:id)
    expect(parsed_user_registration[:data]).to have_key(:attributes)

    expect(parsed_user_registration[:data]).to_not eq(nil)
    expect(parsed_user_registration[:data][:type]).to eq("users")
    expect(parsed_user_registration[:data][:id]).to_not eq(nil)
    expect(parsed_user_registration[:data][:attributes]).to_not eq(nil)
    expect(parsed_user_registration[:data][:attributes][:email]).to_not eq(nil)
    expect(parsed_user_registration[:data][:attributes][:api_key]).to_not eq(nil)
  end
  it "User Registration - Email Taken", :vcr do
    user_params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post "/api/v1/users", params: {user: user_params}

    expect(response).to be_successful

    user_params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post "/api/v1/users", params: {user: user_params}

    expect(response).to_not be_successful

    parsed_user_registration_2 = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_user_registration_2[:errors][0]).to eq("Email has already been taken")
  end
  it "User Registration - Passwords Don't Match", :vcr do
    user_params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password_2"
    }
    post "/api/v1/users", params: {user: user_params}

    expect(response).to_not be_successful

    parsed_user_registration_2 = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_user_registration_2[:errors][0]).to eq("Password confirmation doesn't match Password")
  end
  it "User Registration - Missing Field", :vcr do
    user_params = {
      "email": nil,
      "password": "password",
      "password_confirmation": "password"
    }
    post "/api/v1/users", params: {user: user_params}

    expect(response).to_not be_successful

    parsed_user_registration_2 = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_user_registration_2[:errors][0]).to eq("Email can't be blank")
  end
end
