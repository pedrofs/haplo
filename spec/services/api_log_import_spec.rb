require 'spec_helper'

describe ApiLogImport do
  let(:api_log_import) {ApiLogImport.new}

  context "with a invalid log" do
    it "should return an empty array" do
      api_logs = api_log_import.build_api_logs 'no_file'

      expect(api_logs.count).to eq(0)
    end
  end

  context "with a valid log" do
    let(:filename) { File.join 'log/api/test', "access.csv" }

    before :each do
      api_file_log = ApiFileLog.new File.dirname filename
      api_file_log.log(build(:api_log))
    end

    it "should right import the csv" do
      api_logs = api_log_import.build_api_logs filename

      expect(api_logs.count).to eq(1)
      expect(api_logs.first.controller).to eq('test_controller')
    end
  end
end