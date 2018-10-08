require_relative './mock_var'

class MockCsv
  attr_reader :mock_vars

  def initialize(args)
    @mock_vars = args.map { |arg| MockVar.new(*arg.split(':')) }
  end

  def headers
    mock_vars.map(&:name).join(',')
  end

  def rows(count)
    Array.new(count) { mock_vars.map(&:fake).join(',') }.join("\n")
  end
end
