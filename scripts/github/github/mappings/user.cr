require "json"

module GitHub
  alias Users = Array(User)

  class User
    JSON.mapping(
      id: Int64,
      login: String
    )
  end
end
