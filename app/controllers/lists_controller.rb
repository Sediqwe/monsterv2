class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update destroy ]

  # GET /lists or /lists.json
  def index

      @q = List.ransack(params[:q])
      if params[:page_n].present?
        number = params[:page_n]
        session[:page_n] = number
        if number>"30"
          session[:page_n] = "30"
        end
        
      else
        if session[:page_n].nil?
          session[:page_n] = "30"
        end
      end
      @lists = @q.result(distinct: true).order('title ASC').page(params[:page]).per(session[:page_n])
      @list_all = List.all.size
      @list_controll = List.where.not(link: nil ).size      
  end

  # GET /lists/1 or /lists/1.json
  def show
  end

  def tomb
  end
  def friss
    lista = List.all
    upload = Upload.all.last(10)
    
    lista.each do |t|
      title = t.title
      upload.each do |t|
        p t.game_files.inspect
      end
    
  end
  end
  def editorka
    lista = List.find(editor_params[:id])
    lista.link = editor_params[:adat]
    lista.save
    
    
  end
  def tomb_feldolgozo
    array2 = params[:post].split("\r\n")
    array2.each do |f|
      code = List.new(title: f, desc: params[:desc],list_type: params[:list_type])
      code.save
    end
    redirect_to tomb_url()
  end
  def lista_frissites
    List.update(active: :true)
  end
  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists or /lists.json
  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to list_url(@list), notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to list_url(@list), notice: "List was successfully updated." }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_url, notice: "List was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(:title, :desc, :active, :list_type, :link, :local, :ready, :version)
    end
    def editor_params
      params.require(:product).permit(:id, :adat, :adat2 )
    end
end
