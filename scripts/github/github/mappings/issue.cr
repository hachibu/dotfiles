require "json"

module GitHub
  alias Issues = Array(Issue)

  class Issue
    JSON.mapping(
      id: Int64,
      user: User,
      html_url: String,
      labels: Labels,
      created_at: Time,
      pull_request: PullRequest?
    )
  end
end
