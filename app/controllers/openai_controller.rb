class OpenaiController < ApplicationController
  #Rails.application.credentials.openai[:password]
  require "ruby/openai"
  def index
    @translationText = "
    (not included in demo)
    +5 base cost
    , {EmpireName}
    , {TurnNumber}
    A: {Answer}
    AI
    AI is still thinking
    Base power cost = £{BaseCost}+{BaseCostPerUnit} per unit<lf>Incremental power cost = £{IncrementalBaseCost}+{IncrementalCostPerUnit} per unit<lf>{PowerTooltipAdditionalMessage}
    Cancel Game
    Chinese (Traditional)
    Choose a fleet to disband...
    Choose a military unit to disband...
    Choose an army to disband...
    Claim
    Confirm display setting change
    Defeated
    Difficulty: {DifficultyLevel}<lf>{Explanation}
    Disband an army
    E.g. If you have 1 unit and you buy <lf>3 power, you pay £5+10+15=£30<lf>(Requires at least one military unit)
    E.g. you have {NumUnits} {NumUnits}|plural(one=unit,other=units), so buying {PowerToBuy} power costs {Calculation} 
    FAQ
    First select this opportunity, then <cf>activate it on the Victory Panel <cf>(click the crown to open).
    GOG
    Game ID: {GameID}
    How to Play
    Japanese
    Joined ({X}/{Y})
    Leave Game
    Left game
    Open ({X}/{Y})
    Open Game
    P L A Y
    Player Name
    Players
    Q: {Question}
    Resetting in... {Seconds}
    Resign
    Resume
    Russian
    Save Game
    Save failed
    Saved!
    Select
    Skip
    Start Game
    Starts with {F}{Food} {W}{Wealth} {K}{Knowledge}
    Status
    Steam
    Sunday 3rd June, 1900 - Beirut
    Timer expired
    Today
    Total produced by territory: {Produced}<lf>Consumed by city population: {Consumed}
    Trait Name
    Turn
    Unit purchase cancelled
    V I E W
    Waiting ({ReverseTimeLeft}) 
    Yesterday
    current
    turn
    turns
    unspent"
    @albion =translate123(@translationText.html_safe)
  end

  

def translate123(text)
  require "ruby/openai"
  client = OpenAI::Client.new(access_token: Rails.application.credentials.openai[:password])
  prompt = "Fordítsd le magyarra a szöveget, () jel közt lévőket fordítsd le, a {} és a <> jelek közt lévőeket NE, viszont a válaszban mindenképpen szerepeljenek ezek is.:\n\nText: #{text}"
  
  response = client.completions(
    parameters: {
      prompt: prompt,
      model: "text-davinci-003",
      temperature: 0.3,
      max_tokens: 1000,          
    }
  )
  
  response['choices'][0]['text']
end


end
