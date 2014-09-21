# require 'spec_helper'

describe ApiLog do
  describe 'validations' do
    it { should validate_presence_of :ip_address }
    it { should validate_presence_of :url }
    it { should validate_presence_of :path }
    it { should validate_presence_of :controller }
    it { should validate_presence_of :action }
  end
end
