class MegasController < ApplicationController
  before_action :set_mega, only: %i[ show edit update destroy ]
  
  # GET /megas or /megas.json
  def index
    @megas = Mega.all.order(:title)
    @meta_title = "A gépi fordítások oldala! Közvetlen elérés a legnagyobb fordítás fájlokhoz is! Már #{Game.all.size} játékhoz, #{(Upload.all.size + Mega.all.size)} fordítás érhető el közvetlenül a szerverről."
  end

  # GET /megas/1 or /megas/1.json
  def show
  end
  def download

    send_file "file/" + params[:id], :disposition => 'attachment'
    edit = Mega.find(params[:mega_id])
    temp = edit.szamlalo.to_i
    temp += 1
    edit.szamlalo = temp
    edit.save
  end
  # GET /megas/new
  def new
    @mega = Mega.new
  end

  # GET /megas/1/edit
  def edit
  end
  def editorka
    megas = Mega.find(editor_params[:id])
    megas.game = editor_params[:adat]
    megas.save
    
  end
  # POST /megas or /megas.json
  def create
    @mega = Mega.new(mega_params)

    respond_to do |format|
      if @mega.save
        format.html { redirect_to mega_url(@mega), notice: "Mega was successfully created." }
        format.json { render :show, status: :created, location: @mega }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mega.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /megas/1 or /megas/1.json
  def update
    respond_to do |format|
      if @mega.update(mega_params)
        format.html { redirect_to mega_url(@mega), notice: "Mega was successfully updated." }
        format.json { render :show, status: :ok, location: @mega }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mega.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /megas/1 or /megas/1.json
  def destroy
    @mega.destroy

    respond_to do |format|
      format.html { redirect_to megas_url, notice: "Mega was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mega
      @mega = Mega.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mega_params
      params.require(:mega).permit(:title, :link, :active, :version)
    end
    def editor_params
      params.require(:product).permit(:id, :adat )
    end
end
