require 'faker'

class MockCsvError < StandardError
end

class MockVar
  attr_reader :name, :type

  TYPES = {
    'email' => ->() { Faker::Internet.email },
    'quote' => lambda do
      [
        Faker::HitchhikersGuideToTheGalaxy,
        Faker::MichaelScott,
        Faker::PrincessBride,
        Faker::Seinfeld,
        Faker::StarWars
      ].sample.quote
    end,
    'time' => ->() { Faker::Time.backward(30).strftime('%F %T') }
  }

  def initialize(name = nil, type = nil)
    @name = name
    @type = type

    validate!
  end

  def fake
    %("#{TYPES[type][]}")
  end

  def validate!
    valid_types = "Expecting #{TYPES.keys}"

    if name.nil? || name.empty?
      raise MockCsvError, %(Missing MockVar name)
    elsif type.nil? || type.empty?
      raise(
        MockCsvError,
        %(Missing MockVar type for name: "#{name}". #{valid_types})
      )
    elsif !TYPES.has_key?(type)
      raise(
        MockCsvError,
        %(Invalid MockVar type: "#{type}" for name: "#{name}". #{valid_types})
      )
    end
  end
end
