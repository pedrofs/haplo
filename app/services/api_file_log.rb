class ApiFileLog
  attr_accessor :directory

  FILENAME = 'access.csv'

  def initialize directory
    Dir.mkdir directory unless Dir.exists? directory
    @directory = directory
  end

  def log object
    return unless object.respond_to? :to_csv

    log_file = File.new log_file_name.to_s, "a"

    log_file.write object.csv_header if log_file.size == 0

    log_file.write "#{object.to_csv}"
    log_file.close
  end

  private

  def log_file_name
    Pathname.new [Rails.root, @directory, ApiFileLog::FILENAME].join '/'
  end
end