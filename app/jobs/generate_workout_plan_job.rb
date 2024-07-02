class GenerateWorkoutPlanJob < ApplicationJob
  queue_as :default

  def perform(data)
    uri = URI("http://localhost:11434/api/generate")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
    request.body = {
      model: "phi3",
      prompt: "say hi in swahili",
      stream: false
    }.to_json

    response = http.request(request)
    response = JSON.parse(response.body)
    logger.info "API call successful. Response: #{response}"

  end
end
