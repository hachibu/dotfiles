require "http"
require "json"
require "./mappings/*"

class GitHub::Client
  alias Params = NamedTuple

  Host    = "https://api.github.com"
  Version = 3

  def initialize(@auth_token : String)
  end

  def org_issues(org : String, params : Params? = nil) : GitHub::Issues
    response = get(
      join_host("orgs", org, "issues"),
      params
    )
    GitHub::Issues.from_json(response)
  end

  def org_members(org : String, params : Params? = nil) : GitHub::Users
    response = get(
      join_host("orgs", org, "members"),
      params
    )
    GitHub::Users.from_json(response)
  end

  def get(url : String, params : Params? = nil) : String
    url += "?#{HTTP::Params.encode(params)}" unless params.nil?
    `curl --silent \
          --header "Authorization: token #{@auth_token}" \
          --header "Accept: application/vnd.github.v3+json" #{url}`
  end

  def join_host(*args : _) : String
    File.join(Host, *args)
  end
end
