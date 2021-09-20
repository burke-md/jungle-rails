require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is valid with valid attibutes" do
      user = User.new(
        first_name: 'Potato',
        last_name: 'Potatoer',
        email: 'Potato@Potato.Potato',
        password: 'Potato',
        password_confirmation: 'Potato'
      )
      expect(user).to be_valid
    end

    it "is not valid without first name" do
      user = User.new(
        first_name: nil,
        last_name: 'Potatoer',
        email: 'Potato@Potato.Potato',
        password: 'Potato',
        password_confirmation: 'Potato'
      )
      expect(user).to_not be_valid
    end

    it "is not valid without last name" do
      user = User.new(
        first_name: 'Potato',
        last_name: nil,
        email: 'Potato@Potato.Potato',
        password: 'Potato',
        password_confirmation: 'Potato'
      )
      expect(user).to_not be_valid
    end

    it "is not valid without email" do
      user = User.new(
        first_name: 'Potato',
        last_name: 'Potatoer',
        email: nil,
        password: 'Potato',
        password_confirmation: 'Potato'
      )
      expect(user).to_not be_valid
    end 

    it "is not valid without password field" do
      user = User.new(
        first_name: 'Potato',
        last_name: 'Potatoer',
        email: 'Potato@Potato.Potato',
        password: nil,
        password_confirmation: 'Potato'
      )
      expect(user).to_not be_valid
    end

    it "is not valid without password_confirmation field" do
      user = User.new(
        first_name: 'Potato',
        last_name: 'Potatoer',
        email: 'Potato@Potato.Potato',
        password: 'Potato',
        password_confirmation: nil
      )
      expect(user).to_not be_valid
    end

    it "is not valid if password and password confirmation fields don't match" do
      user = User.new(
          first_name: 'Potato',
          last_name: 'Potatoer',
          email: 'Potato@Potato.Potato',
          password: 'Potato',
          password_confirmation: 'Potatos111'
        )
        expect(user).to_not be_valid
    end

    before { User.create!(
      first_name: 'Walty',
      last_name: 'Budd',
      email: 'walty@budd.com',
      password: 'Potato',
      password_confirmation: 'Potato'
    ) }

    it "should not be valid if email already exists in database" do
      user = User.new(
        first_name: 'Potato',
        last_name: 'Potatoer',
        email: 'walty@budd.com',
        password: 'Potato',
        password_confirmation: 'Potato'
      )
      expect(user).to_not be_valid
    end

    it "should not be valid if email already exists in database, not case sensitive" do
      user = User.new(
        first_name: 'Potato',
        last_name: 'Potatoer',
        email: 'walty@BUDD.COM',
        password: 'Potato',
        password_confirmation: 'Potato'
      )
      expect(user).to_not be_valid
    end

    it "should have a password at least three characters long" do
      user = User.new(
        first_name: 'Potato',
        last_name: 'Potatoer',
        email: 'Potato@Potato.Potato',
        password: 'as',
        password_confirmation: 'as'
      )
      expect(user).to_not be_valid
    end
  end

  before { User.create!(
    first_name: 'MPotato',
    last_name: 'carrots',
    email: 'Potato@carrots.com',
    password: 'Potato',
    password_confirmation: 'Potato'
  ) }

  describe '.authenticate_with_credentials' do
    it "should return user if info is valid" do
      user = User.find_by_email('Potato@carrots.com')
      authenticate = User.authenticate_with_credentials('Potato@carrots.com', 'Potato')

      expect(authenticate).to eq user
    end

    it "should return nil if email does not match" do
      user = User.find_by_email('Potato@carrots.com')
      authenticate = User.authenticate_with_credentials('Potato@Potato.com', 'Potato')

      expect(authenticate).to eq nil
    end

    it "should return false if password is not valid" do
      user = User.find_by_email('Potato@carrots.com')
      authenticate = User.authenticate_with_credentials('Potato@carrots.com', 'Potatos!!!')

      expect(authenticate).to eq nil
    end
    
    it "should return user if info is valid even if there are extra spaces before or after email" do
      user = User.find_by_email('Potato@carrots.com')
      authenticate = User.authenticate_with_credentials('   Potato@carrots.com   ', 'Potato')

      expect(authenticate).to eq user
    end

    it "should return user if info is valid even if the case doesn't match" do
      user = User.find_by_email('Potato@carrots.com')
      authenticate = User.authenticate_with_credentials('potato@carrots.com', 'Potato')

      expect(authenticate).to eq user
    end
    
  end
end
