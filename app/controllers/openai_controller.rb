class OpenaiController < ApplicationController
  require 'net/http'
  require 'json'
  
  def index
    text = "
    Layout_Day2End_Grandma_Intro
{Grandmom}Amor! What a day!{wc}{emotion=angry}And what a shame about the Nature Reserve![RN]{Grandad}{emotion=enquiry}But imagine all the good the luxury Hotel will do.{wc}Tourism coming back, businesses reopening, new jobs…{wc}Our children don’t need to move away anymore…{wc}It’s going to revitalise the whole island.[RN]{Grandmom}But not by sacrificing the Nature Reserve.{wc}Don't forget all the wildlife, it's their home too!{Grandad}Hmmm...{wc}{emotion=neutral}{emotion=neutral,grandmom}{x}
Layout_Day2End_Grandma_Question
{Grandmom}Anyway, Alba, you look hungry! [RN]I can make dinner now, if you want?
Layout_Day2End_Grandma_Petition
{Grandmom}My phone’s been pinging non-stop about your petition, Alba!{wc}Love the initiative, so proud of you! We obviously support you!{wc}Here, pass me the pen and we'll both sign it. Won't we, abuelo?[RN]{Grandad} Sure… I mean, yes, of course. Anything for Alba!
Layout_Day2End_Grandma_Petition_Question
{Grandmom}We got this!{wc} [RN]Alba, you look hungry!{wc}[RN]Want me to make dinner now?
Layout_Day2End_Grandma_Yes
{Grandmom}Fantastic, let’s go eat![RN]
Layout_Day3End_Grandma_Question_Intro
{Grandmom}Alba! You and Inés are trending!
Layout_Day3End_Grandad_Question_Intro
{Grandad}Bonica, we heard you and Inés had a very successful day.
Layout_Day3End_Grandma_Question
{Grandmom}Maria told us you’ve been building bridges… literally! High-five!{wc}{emotion=angry}The Mayor should be working together with the AIWRL…{wc}...and not with 'fire-friendly' Paco![RN]{grandad}{emotion=enquiry}Are you saying Paco was connected to the Nature Reserve fire?[RN]{Grandmom}Call it intuition. But Paco’s definitely banned to my no-trust-zone![RN]{Grandad}{emotion=neutral}{emotion=neutral,grandmom}Well, anyway, Eloi also stopped by to thank you again for helping his cat.{wc}He even left a basket full of fresh oranges...[RN]{Grandmom}...which we thoroughly washed and then turned into orange juice.{wc}You ready for dinner?[RN]
Layout_Day3End_Grandma_Yes
{Grandmom}Ace! I hope you've worked up an appetite.{Grandad}Come on, Alba. I'll race you to the table.
Layout_Day4End_Grandma_Question
{Grandmom}Sounds like you've had another busy day, Alba.{Grandmom}I can't believe you found an Eagle at the Castle!{Grandmom}And kept your abuelo out of trouble while you were at it.{Grandmom}Are you ready for dinner now?
Layout_Day4End_Grandma_Yes
{Grandmom}Come on then, dear. You can help me serve up.{Grandmom}It's the only way you'll beat your abuelo to the chicken!
Layout_DayXEnd_Grandma_Repeat
{Grandmom}[&Ready for dinner now?|Caused enough mischief for the day yet?|Are you done adventuring for the day?]
Layout_DayXEnd_Grandma_No
{Grandmom}[&That's alright, dinner will be waiting for you when you're done.|You can play a bit longer, but don't go far - it's almost past {i}my{/i} bed time!|We'll be here when you're good and done. Now go have fun!|Ok, but don't be too long or your abuelo will eat all the food!]
Layout_DayXEnd_Grandma_Yes_Dog
{Grandmom}Alright, but that dog's not coming in with you!
Layout_Day2End_Grandpa_Intro
{Grandad}Buenas noches, bonica!
Layout_Day2End_Grandpa_Question
{Grandad}Even wildlife rescuers have to eat though!{Grandad}Are you ready for dinner?
    "
    @albion =translate123(text)
  end

  
  def translate123(text)
    url = URI.parse("https://api.openai.com/v1/completions")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
  
    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{Rails.application.credentials.openai[:password]}"
    }
  
    data = {
      "model": "text-davinci-003",
      "prompt": "Fordítsd le a szöveget magyarra, a {} jelek közt hagyd fordítatlanul : #{text}.",
      "temperature": 0.3,
      "max_tokens": 2000,
      "top_p": 1.0,
      "frequency_penalty": 0.0,
      "presence_penalty": 0.0
    }
  
    request = Net::HTTP::Post.new(url.path, headers)
    request.body = data.to_json
  
    response = http.request(request)
    response_body = JSON.parse(response.body)
  
    # Process the response and return the translated text
    translated_text = response_body["choices"][0]["text"]
    return translated_text
  end

  def translate1234(text)
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
