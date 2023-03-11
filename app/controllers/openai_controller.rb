class OpenaiController < ApplicationController
  #Rails.application.credentials.openai[:password]
  require "ruby/openai"
  def index
    @translationText = "I would like a cup of milk please"
    @albion =translate123(@translationText)
  end

  

def translate123(text)
  require "ruby/openai"
  client = OpenAI::Client.new(access_token: Rails.application.credentials.openai[:password])
  prompt = "Fordítsd le magyarra a szöveget, utánna a magyar nyelvtani szabályok szerint javítsd ki:\n\nText: #{text}"
  
  response = client.completions(
    parameters: {
      prompt: prompt,
      model: "text-davinci-003",
      temperature: 0.3,
      max_tokens: 100,          
    }
  )
  
  response['choices'][0]['text']
end


end
