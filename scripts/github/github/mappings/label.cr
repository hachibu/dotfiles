require "json"

module GitHub
  alias Labels = Array(Label)

  class Label
    JSON.mapping(
      id: Int64,
      name: String,
      color: String
    )
  end
end
