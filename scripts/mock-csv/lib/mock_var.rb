require 'faker'

class MockVar
  attr_reader :name, :type

  def initialize(name, type)
    @name = name
    @type = type
  end

  def fake
    value =
      case type
      when 'email'
        Faker::Internet.email
      when 'quote'
        topics = [
          Faker::HitchhikersGuideToTheGalaxy,
          Faker::MichaelScott,
          Faker::PrincessBride,
          Faker::Seinfeld,
          Faker::StarWars
        ]
        topics.sample.quote
      when 'time'
        Faker::Time.backward(30).strftime('%F %T')
      end

    %("#{value}")
  end
end
