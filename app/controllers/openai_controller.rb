class OpenaiController < ApplicationController
  def index
    translated_text1 = trans("Ez egy példa szöveg.", "text-davinci-002", "en", "hu")
    p magam
  end
  def trans(text, model, source_lang, target_lang)
    require 'ruby/openai' 
    client = OpenAI::Client.new(access_token: "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")
    client = OpenAI::Client.new
    client.models.list
    client.models.retrieve(id: "code-cushman-001")
    response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: "Fordítsd le kérlek angolról magyarra és adj vissza legalább 10 különböző verziót <BR> el elválasztva : 'Body of Millionaire's Daughter Found'"}], # Required.
        
    })
    result = client.translate(
    engine: 'davinci',
    prompt: 'Translate this sentence to Hungarian.',
    target: 'hu'
    )
    @ant2 = result[:data][:translations][0][:translated_text]
  @ant = response.dig("choices", 0, "message", "content")
  end     


end
