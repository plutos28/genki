class GenerateWorkoutPlanJob < ApplicationJob
  queue_as :default

  def perform(data, user_id)
    uri = URI("http://localhost:11434/api/generate")
    http = Net::HTTP.new(uri.host, uri.port)

    http.open_timeout = 10    # Increase open timeout
    http.read_timeout = 300   # Increase read timeout to 5 minutes

    request = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
    request.body = {
      model: "phi3",
      prompt: data[:prompt],
      stream: false
    }.to_json

    response = http.request(request)
    response = JSON.parse(response.body)
    logger.info {response["response"]}

    Workout.create!(user_id: user_id, content: response["response"])

  end
end
