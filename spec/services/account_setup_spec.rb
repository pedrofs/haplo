require 'spec_helper'

describe AccountSetup do
  it "should create database schema for a new account" do
    account_setup = AccountSetup.new
    account = build(:account)

    expect { Apartment::Tenant.switch(account.subdomain) }.to raise_error(Apartment::SchemaNotFound)

    account_setup.setup account

    expect { Apartment::Tenant.switch(account.subdomain) }.not_to raise_error
  end
end