require "json"

class GitHub::PullRequest
  JSON.mapping(html_url: String)
end
