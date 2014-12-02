module Report
  class ReportFactory
    def create namespace, name
      "Report::#{namespace.classify}::#{name.classify}".constantize.new
    rescue NameError
      p "NameError: Report::#{namespace.classify}::#{name.classify}"

      NullReport.new
    end
  end
end