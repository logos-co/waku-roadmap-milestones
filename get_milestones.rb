require 'octokit'
require 'dotenv'

Dotenv.load(".env.local")

def query_repo
  begin
    client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    repo = "waku-org/pm"
    milestones = client.list_milestones(repo)

    def extract_links(body)
      body.scan(/https?:\/\/[\S]+/).uniq
    end

    milestones.each do |milestone|
      puts "Milestone: #{milestone.title}"
      puts "Link: #{milestone.html_url}"
      puts "----------------------------"

      issues = client.list_issues(repo, milestone: milestone.number)
    
      issues.each do |issue|
        puts "Epic: #{issue.title}"
        puts "Link: #{issue.html_url}"
        links = extract_links(issue.body)
        if links.any?
          puts "Issues in Epic:"
          links.each { |link| puts link }
        else
          puts "No issues in Epic description."
        end
        puts "----------------------------"
      end
      puts "\n"
    end

  rescue Octokit::InvalidRepository => e
    puts "Error: #{e.message}"
  end
end

query_repo
