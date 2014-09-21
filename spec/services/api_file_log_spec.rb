require 'spec_helper'

describe ApiFileLog do
  let!(:apiLog) { ApiFileLog.new 'log/api' }

  it "should have a directory" do
    expect(apiLog.directory).to eq('log/api')
  end

  context "when logging objects" do
    before :each do
      foo = Foo.new
      foo.bar = 'test'
      foo.foo = 'test2'
      apiLog.log(foo)
    end

    after :each do
      File.unlink File.join(::Rails.root, "log/api/#{Date.today.to_s}.log")
    end

    it "should create file with today date" do
      expect(File.exists?(File.join(::Rails.root, "log/api/#{Date.today.to_s}.log"))).to be(true)
    end

    it "should have two line after two objects being parsed" do
      foo = Foo.new
      foo.bar = 'test2'
      foo.foo = 'test3'
      apiLog.log(foo)

      count = 0
      File.open(File.join(::Rails.root, "log/api/#{Date.today.to_s}.log")) {|f| count = f.read.count("\n")}

      expect(count).to eq(2)
    end
  end
end

class Foo
  attr_accessor :bar, :foo

  def to_csv
    [bar, foo]
  end
end