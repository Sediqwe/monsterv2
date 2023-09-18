class HoppsController < ApplicationController
  before_action :set_hopp, only: %i[ show edit update destroy ]
  require 'securerandom'

  def generate_random_string
    characters = ('a'..'z').to_a + ('A'..'Z').to_a
    random_string = ''
    
    # Adjuk hozzá az aktuális dátumot milliszekundumokban
    timestamp = (Time.now.to_i).to_s + "_"
    random_string << timestamp
  
    # Generáljuk a maradék karaktereket
    (20).times do
      random_char = characters.sample
      random_string << random_char
    end
  
    return random_string
  end
  # GET /hopps or /hopps.json
  def index
    @hopps = Hopp.all.order(id: :ASC)
  end

  # GET /hopps/1 or /hopps/1.json
  def show
    
  end

  def hopper
    if params[:id]
      @hopp = Hopp.find_by(gen: params[:id])
      if @hopp
        # Növeld meg az "open" értékét 1-el
        @hopp.open += 1
        @hopp.save
        
        # Végezd el az átirányítást az @hopp.link-re
        redirect_to @hopp.link, allow_other_host: true
        return
      end
    end
  
    
    # Ide érhetsz csak, ha a rekord nem található vagy más hiba történik
    # Kezeld le ezt a helyzetet a saját igényeid szerint
  end

  # GET /hopps/new
  def new
    @hopp = Hopp.new
  end

  # GET /hopps/1/edit
  def edit
  end

  # POST /hopps or /hopps.json
  def create
    if(params[:passkey] == Rails.application.credentials.km[:password])
      @hopp = Hopp.new(hopp_params)
      @hopp.gen = generate_random_string
      session[:hopp_link_id] = @hopp.id
      respond_to do |format|
        if @hopp.save

          format.html { redirect_to hopp_url(@hopp), notice: "Új hopp legenerálva." }
          format.json { render :show, status: :created, location: @hopp }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @hopp.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_hopp_path
    end
  end
  
  # PATCH/PUT /hopps/1 or /hopps/1.json
  def update
    respond_to do |format|
      if @hopp.update(hopp_params)
        format.html { redirect_to hopp_url(@hopp), notice: "Hopp was successfully updated." }
        format.json { render :show, status: :ok, location: @hopp }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hopp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hopps/1 or /hopps/1.json
  def destroy
    @hopp.destroy
    respond_to do |format|
      format.html { redirect_to hopps_url, notice: "Hopp was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hopp
      @hopp = Hopp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hopp_params
      params.require(:hopp).permit(:link, :gen, :open, :passkey)
    end
end
