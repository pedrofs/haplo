class ApiLogImport
  def initialize filename = false
    @filename = filename
  end

  def build_api_logs filename = false
    @filename = filename if filename

    return [] unless File.exists? @filename

    api_logs = []
    CSV.foreach @filename, headers: true do |row|
      api_log = ApiLog.new(row.to_hash)
      api_logs << api_log if api_log.valid?

      yield api_logs if block_given?
    end

    api_logs
  end

  def remove_log
    File.unlink @filename if File.exists? @filename
  end
end