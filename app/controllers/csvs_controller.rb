class CsvsController < ApplicationController
  before_action :set_csv, only: %i[ show edit update destroy ]
  before_action :authorized?, only: %i[new edit update destroy show index]
  # GET /csvs or /csvs.json
  def index
    @csvs = Csv.all
  end

  # GET /csvs/1 or /csvs/1.json
  def show
    csv_file = Csv.find(params[:id])
    @csvdata = Csvdata.where(csvfile_id: csv_file.id).where("csv_data LIKE ?", "%L:04%").where("csv_data LIKE ?", "I2Languages-resources.assets-%")
    
  end
  def download
    
    redirect_to csvs_path
    send_file 'tmp/csv.csv',  :x_sendfile=>true
  end
  # GET /csvs/new
  def new
    @csv = Csv.new
  end
  def csv_mentes
    id = params[:id]
    #csv_adatok = Csvdata.joins("LEFT JOIN csvtranslate ON csvtranslate.csvdata_id = csvdata.id")
    #SELECT A.PK AS A_PK, A.Value AS A_Value, B.Value AS B_Value, B.PK AS B_PK FROM Table_A A LEFT JOIN Table_B B ON A.PK = B.PK
    csv_adatok = Csvdata.all.limit(10)
    t_content = []
    buzi = Csvtranslate.where(csvfile_id: id)
    buzi.each do |elemente|
      t_content << elemente.csvuniq
    end
    bullshit = ""
    csv_adatok.each do |kalap|
      p kalap.csvtranslate.inspect
      #p kalap.inspect
     
    end

  end
  def csv_mentes_old
    id = params[:id]
    csv_adatok = Csvdata.where(csvfile_id: id, csv_translated: false ).order(csv_row: :ASC)
    bullshit = ""
    csv_adatok.each do |kalap|
      csv_ford = Csvtranslate.where(csvfile_id: kalap.csvfile_id, csv_row: kalap.csv_row, csv_col_id: kalap.csv_col_id).order(created_at: :ASC).last
      if csv_ford.present?
          bullshit += csv_ford.csv_data+"\t\n" 
      else  
        bullshit += kalap.csv_data
      end
    end
    File.write('tmp/csv.csv', bullshit)
    redirect_to csvs_path

  end
  def csv_adatot_ment
    adat = process_params[:adat]
    id = process_params[:id]
    csv = Csv.find(id) #Fájl amit felkell dolgozni
    adatok = adat.each_line # Beolvasom soronként
    translation_content = []
    adatok.each do |adom| # A fájl sorain végig megyünk
      # p adom
      k = adom.split("# ")
      if k[1].present?
        csv_adat = Csvdata.find(k[0])
        string = csv_adat.csv_data
        string_split = string.split(/\t/)
        def_string = string_split[2]
        new_string = string.sub(def_string,k[1].strip).strip
        Csvtranslate.where(csvfile_id: id, csv_row: csv_adat.csv_row).destroy_all
      end
      translation_content << {csvuniq: csv.id.to_s + "-" + csv_adat.csv_row.to_s ,csvdata_id: csv_adat.id ,csvfile_id: id, csv_row: csv_adat.csv_row ,csv_col_id: 1, csv_data: new_string , csv_type: "none",user_id: current_user.id,created_at: Time.now, updated_at: Time.now }
      
    end
    Csvtranslate.insert_all(translation_content)


  end

  # GET /csvs/1/edit
  def edit
  end

  def create
    @csv = Csv.create(csv_params)
    @csv.user_id = current_user.id
    respond_to do |format|
      if @csv.save
        format.html { redirect_to csv_url(@csv), notice: "Csv was successfully created." }
        format.json { render :show, status: :created, location: @csv }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @csv.errors, status: :unprocessable_entity }
      end
    end
    
  end
  # POST /csvs or /csvs.json
  def csv_beolvas
    
    cfile = Csv.find(params[:id])
    if cfile.trans?
    p "le van fordítva"
    else
      translation_content = []
      filepath = ActiveStorage::Blob.service.send(:path_for, cfile.csv_file.key)
      data = File.read(filepath)
      translation_content = []
      enum_content = data.each_line
      enum_content.each_with_index do |content_line, index|
          translation_content << {csvfile_id: cfile.id, csv_row: index ,csv_col_id: 1, csv_data: content_line , csv_type: "none",csv_translated: false,user_id: current_user.id,created_at: Time.now, updated_at: Time.now }
        end
      Csvdata.insert_all(translation_content)
      cfile.trans = true
      cfile.save
    end
  end
  def fasz
    data_en = data.each_line
       data_en.each_with_index do |row, row_index|
        row_num = $.
        csv.parser(row, :col_sep => "\t")
        row.each do |line|
          line_num = $.
          translation_content << {csv_id: cfile.id, csv_row: row_num ,csv_col_id: line_num, csv_data: line , csv_type: "none",csv_translated: false,user_id: current_user.id }
        end
      end
      cfile.trans = true
      cfile.save
      Csvdata.insert_all(translation_content)
  end
  def create1
    @csv = Csv.new(game_name: game_name, game_string: l, game_version: game)
    
    @csv.user = current_user.id
    respond_to do |format|
      if @csv.save
        format.html { redirect_to csv_url(@csv), notice: "Csv was successfully created." }
        format.json { render :show, status: :created, location: @csv }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @csv.errors, status: :unprocessable_entity }
      end
    end
  end
  def proc
    de = Upload.find(params[:id])
    de.done = true
    de.save
    de.uploads.each do |ezafile|
      filepath = ActiveStorage::Blob.service.send(:path_for, ezafile.key)
      valami = ezafile.blob.filename
      data = File.read(filepath)
      translation_content = []
      enum_content = data.each_line
      enum_content.each do |content_line|
        #szétválasztás
        #key, value = content_line.split(' = ',2)
        #next if key == "\r\n"
        translation_content << {file_id:ezafile.id, trans_id: "", original: content_line.strip, translate: "", file: valami.to_s , upload_id: params[:id], status: 0, trans_type: false}
      end
      
      Translate.insert_all(translation_content)
    end
    redirect_to translater_path
  end
def proc_csv
    de = Upload.find(params[:id])
    de.done = true
    de.save
    de.uploads.each do |ezafile|
      filepath = ActiveStorage::Blob.service.send(:path_for, ezafile.key)
      valami = ezafile.blob.filename
      translation_content = []
      require "csv"
      k = CSV.open(filepath)
      k.each do |d|
        p d
      end

      CSV.foreach((filepath), headers: false, col_sep: ",").with_index(1) do |row, rindex|
        row.each_with_index do |item, cindex|
          
         if rindex == 1
            data = true
          else
            data = false
          end
        translation_content << {file_id:ezafile.id, original: "#{item}", trans_id: "", translate: "", row_num: rindex , col_num: cindex, file: valami.to_s , upload_id: params[:id], status: 0, trans_type: false, project_id: de.project_id, header: data }
        end
        
      end    
        #translation_content << {file_id:ezafile.id, trans_id: "", original: content_line.strip, translate: "", file: valami.to_s , upload_id: params[:id], status: 0, trans_type: false}
      
      
      
        Translate.insert_all(translation_content)  
    end
    
    redirect_to uploads_path
  end
  # PATCH/PUT /csvs/1 or /csvs/1.json
  def update
    respond_to do |format|
      if @csv.update(csv_params)
        format.html { redirect_to csv_url(@csv), notice: "Csv was successfully updated." }
        format.json { render :show, status: :ok, location: @csv }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @csv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /csvs/1 or /csvs/1.json
  def destroy
    game_name = @csv.game_name
    game_version = @csv.game_version
    @csv.destroy
    Csv.where(game_name: game_name, game_version: game_version).destroy

    respond_to do |format|
      format.html { redirect_to csvs_url, notice: "Csv was successfully destroyed." }
      format.json { head :no_content }
    end
  end
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_csv
      @csv = Csv.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def csv_params
      params.require(:csv).permit(:game_name, :game_version, :game_string, :csv_file )
    end
    def process_params
      params.require(:product).permit(:id, :adat )
    end
end
