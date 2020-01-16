#!/usr/bin/env ruby

require 'octokit'
require 'table_print'

org = ARGV[0]
client = Octokit::Client.new(
  access_token: ENV['GITHUB_AUTH_TOKEN']
)
client.auto_paginate = true

members = client.organization_members(org).map(&:login)
repos = client.organization_repositories(org)
              .select { |r| r.open_issues_count.positive? }
              .map(&:name)

prs = []

repos.each do |repo|
  client.issues("#{org}/#{repo}").each do |issue|
    prs << issue if issue.pull_request && members.include?(issue.user.login)
  end
end

prs = prs.map do |pr|
  labels = if pr.labels.empty?
             'needs review'
           else
             pr.labels.map(&:name).join(', ')
           end
  days_open = ((Time.now.getutc - pr.created_at).to_i / 86_400).to_i

  {
    user: pr.user.login,
    url: pr.html_url.sub('https://', ''),
    labels: labels,
    days_open: days_open
  }
end

prs = prs.sort_by { |pr| pr[:days_open] }

tp(
  prs,
  {
    user: {
      display_name: 'USER'
    }
  },
  {
    url: {
      width: 100
    }
  },
  {
    labels: {
      width: 100
    }
  },
  {
    days_open: {
      display_name: 'DAYS OPEN'
    }
  }
)
