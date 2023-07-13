class OpenaiController < ApplicationController
  #Rails.application.credentials.openai[:password]
  
  def index
    @albion =translate123("Do not share your API key with others, or expose it in the browser or other client-side code. In order to protect the security of your account, OpenAI may also automatically rotate any API key that we've found has leaked publicly.")
  end

  


  def translate123(text)
    require "openai"
    client = OpenAI::Client.new(access_token: Rails.application.credentials.openai[:password])
      response = client.chat(
      parameters: {
          model: "gpt-3.5-turbo", # Required.
          messages: [{ role: "user", content: "Fordítsd le 10x különböző módon magyarra: #{text}  elsőnek az eredeti angolt írd ki, majd sorszámozva a 10 fordítást alá"}], # Required.
          temperature: 0.7,
      })
      p response.dig("choices", 0, "message", "content")
    end

end
