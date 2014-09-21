class ApiFileLog
  attr_accessor :directory

  FILE_EXTENSION = '.log'

  def initialize directory
    Dir.mkdir directory unless Dir.exists? directory
    @directory = directory
  end

  def log object
    return unless object.respond_to? :to_csv

    log_file = File.new log_file_name.to_s, "a"
    log_file.write "#{object.to_csv}\n"
    log_file.close
  end

  private

  def log_file_name
    filename = [Date.today.to_s, ApiFileLog::FILE_EXTENSION].join
    Pathname.new [Rails.root, @directory, filename].join '/'
  end
end