require 'spec_helper'
require 'csv'

describe ApiFileLog do
  let!(:api_log) { ApiFileLog.new 'log/api/test' }
  let!(:filename) { File.join(::Rails.root, "log/api/test", "access.csv") }

  it "should have a directory" do
    expect(api_log.directory).to eq('log/api/test')
  end

  context "when logging objects" do
    before :each do
      foo = Foo.new
      foo.bar = 'test'
      foo.foo = 'test2'
      api_log.log(foo)
    end

    it "should create file with today date" do
      expect(File.exists?(filename)).to be(true)
    end

    it "should have a header corresponding to the object properties" do
      count = 0
      CSV.foreach filename, headers: true do |row|
        expect(row.to_hash).to satisfy { |v| v.has_key? "bar" }
        count += 1
      end

      expect(count).to eq(1)
    end

    it "should have three lines after two objects being parsed (one header)" do
      foo = Foo.new
      foo.bar = 'test2'
      foo.foo = 'test3'
      api_log.log(foo)

      count = 0
      File.open(filename) {|f| count = f.read.count("\n")}

      expect(count).to eq(3)
    end
  end
end

class Foo
  attr_accessor :bar, :foo

  def to_csv
    [bar, foo].to_csv
  end

  def csv_header
    ['bar', 'foo'].to_csv
  end
end