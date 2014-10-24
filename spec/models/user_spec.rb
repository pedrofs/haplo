require 'spec_helper'

describe User do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  describe "associations" do
    it { should belong_to :role }
    it { should have_many :favorite_projects }
  end

  it "should validates password" do
    user = build(:user)
    user.password = '123123'
    user.password_confirmation = '123123'

    expect(user.valid?).to be(false)
    expect(user.errors.keys).to include(:password)
    expect(user.errors[:password].first).to eq("você precisa incluir um caracter especial: @#$%")

    user.password = '123321@'
    user.password_confirmation = '123321@'
    expect(user.valid?).to be(true)
  end
end