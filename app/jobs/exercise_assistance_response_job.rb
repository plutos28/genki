class ExerciseAssistanceResponseJob < ApplicationJob
  queue_as :default

  def perform(data, assistance_id)
    uri = URI("http://localhost:11434/api/generate")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
    request.body = {
      model: "phi3",
      prompt: data[:prompt],
      stream: false
    }.to_json

    response = http.request(request)
    response = JSON.parse(response.body)
    logger.info {response["response"]}

    ExerciseAssistanceRequest.find(assistance_id).update(response: response["response"])
  end
end
