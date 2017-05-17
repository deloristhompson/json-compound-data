require 'json'

jobs_text = File.read(File.join(File.dirname(__FILE__), 'positions.json'))
jobs_data = JSON.parse(jobs_text)

# How many jobs are remote?
puts "Remote Jobs:\n"
remote_count = 0
jobs_data.each do |job_data|
  if job_data["location"].downcase == 'remote' || job_data["location"].downcase == "anywhere"
puts job_data["title"]
remote_count += 1
end
end
puts "There are #{remote_count} jobs"
puts

# Who has more jobs, San Francisco or New York City?
jobs_counts = {
  "new york city" => 0,
  "san francisco" => 0
}

jobs_data.each do |job_data|
  if job_data["location"].downcase.include?("new york, ny") ||
    job_data["location"].downcase.include?("new york city")

    jobs_counts["new york city"] += 1
  end

  if job_data["location"].downcase.include?("san francisco")
     jobs_counts["san francisco"] += 1

end
end

puts jobs_counts

if jobs_counts["san francisco"] > jobs_counts["new york city"]
puts "There are more jobs in SF"
else
  puts "There are more jobs in NYC"
end
puts

# Provide a unique list of company url's from all of the postings
puts "Company URL:\n"
urls = []
jobs_data.each do | job_data|
if !job_data["company_url"].nil? && !urls.include?(job_data["company_url"])
    urls << job_data["company_url"]
end
end

puts urls
puts

# How many job postings indicate a dog friendly culture?
dog_friendly_count = 0
jobs_data.each do |job_data|
  if job_data["description"].downcase.include?('dog-friendly') ||
  job_data["location"].downcase == 'remote' ||
  job_data["location"].downcase == 'anywhere'
    dog_friendly_count += 1
  end
end
puts "#{dog_friendly_count} dog friendly office(s)"
puts

# Build a hash that relates a list of companies to the number of open jobs that they have
company_job_count = {}

jobs_data.each do |job_data|
  if company_job_count[job_data["company"]].nil?
    company_job_count[job_data["company"]] = 0
  end
  company_job_count[job_data["company"]] += 1
end

puts company_job_count
puts

# Buzzword count: build a hash that relates "solution", "requirements", "success", "integral", "self-starter", and "hackathons" to how often they are found in all of the job descriptions
buzzword = {
  "solution" => 0,
  "requirements" => 0,
  "success" => 0,
  "integral" => 0,
  "self-starter" => 0,
  "hackathons" => 0
}

jobs_data.each do |job_data|
  buzzword.each do |word, frequency|
    if job_data["description"].downcase.include?(word)
      buzzword[word] += 1
  end
  end
end
puts "Buzzword:\n"
puts buzzword
puts

# Build a hash that relates the type of role to the number of open positions for that type
type_map = {}
jobs_data.each do |job_data|
  if type_map[job_data["type"]].nil?
    type_map[job_data["type"]] = 0
  end
  type_map[job_data["type"]] += 1
end
puts "Type of role to number of open positions\n"
puts type_map
puts

# Build a hash that relates a location to its list of open jobs
puts "List of jobs in San Francisco"
city_map = {}
jobs_data.each do |job_data|
  if city_map[job_data["location"]].nil?
    city_map[job_data["location"]] = []
end
  city_map[job_data["location"]] << job_data
end

city_map["San Francisco, CA"].each do |job_data|
  puts job_data["title"]
end
