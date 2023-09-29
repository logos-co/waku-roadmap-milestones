require 'octokit'
require 'dotenv'

Dotenv.load(".env.local")

# Initialize the Octokit client
Octokit.configure do |c|
  c.access_token = ENV['GITHUB_TOKEN']  # Make sure you set this environment variable or replace with your token
end

# Function to query a repository's data
def query_repo(organization, repo_name)
  begin
    # Fetch repository data
    repo = Octokit.repo("#{organization}/#{repo_name}")

     puts "Repository Name: #{repo.name}"

     # Fetch issues for the repository
     issues = Octokit.list_issues("#{organization}/#{repo_name}")
 
     # Print details about each issue and its labels
     issues.each do |issue|
       puts "\nIssue Title: #{issue.title}"
       puts "Labels: #{issue.labels.map(&:name).join(', ')}"
     end

    
  rescue Octokit::InvalidRepository => e
    puts "Error: #{e.message}"
  end
end

# Replace with your desired organization and repository name
query_repo('waku-org', 'pm')
