require 'octokit'
require 'dotenv'

Dotenv.load(".env.local")

def query_repo
  begin
    client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    repo = "waku-org/pm"
    milestones = client.list_milestones(repo)

    milestones.each do |milestone|
      puts "Milestone: #{milestone.title}"
      puts "Link: #{milestone.html_url}"
      puts "----------------------------"

      issues = client.list_issues(repo, milestone: milestone.number)
    
      issues.each do |issue|
        puts "Issue: #{issue.title}"
        puts "Link: #{issue.html_url}"
        puts "----------------------------"
      end
      puts "\n"
    end

  rescue Octokit::InvalidRepository => e
    puts "Error: #{e.message}"
  end
end

query_repo
