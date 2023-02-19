class BeolvasController < ApplicationController
  include BeolvasHelper
  before_action :set_beolva, only: %i[ show edit update destroy fordsor]
  before_action :authorized?, only: %i[new edit update destroy show index]
  # GET /beolvas or /beolvas.json
  def index
    @beolvas = Beolva.all.order(:id)
    
  end

  # GET /beolvas/1 or /beolvas/1.json
  def show
    @charto = Charto.where(beolva_id: params[:id])
    @karakterek = Car.all
    @beolva_adat = Beolva.find(params[:id])
    cs = "%" + @beolva_adat.fileend.to_s + "\t\r\n"
    @databeolvamax = Databeolva.where(beolva_id: @beolva_adat.id).order(id: :ASC).where("data LIKE ?", cs ).where("data LIKE ?", "%-resources.assets-%").last
    @beolva = Databeolva.where(beolva_id: @beolva_adat.id).order(id: :ASC).where("data LIKE ?", cs ).where("data LIKE ?", "%-resources.assets-%")
    @mindenis = ""
    Databeolva.where(col: nil).update_all(col: 1)
    
    @beolva.each do |te|
      if te.tdata.present?
      else
        str = te.data.split(/\t/)
        @mindenis +=  te.id.to_s + "#\t\t" + str[te.col] + "\n"
      end

    end

  end
  def mutasd
    @beolva_adat = Beolva.find(params[:id])
    @beolva = Databeolva.where(beolva_id: @beolva_adat.id).order(id: :ASC)
  end
  # GET /beolvas/new
  def new
    @beolva = Beolva.new
  end

  # GET /beolvas/1/edit
  def edit
    @karakterek = Car.all
    @charto = Charto.where(beolva_id: params[:id])

  end
  def karakter_save_ki
    nem = Charto.where(beolva: product_params[:adat], car: product_params[:id])
    nem.delete_all    
  end
  def karakter_save_be

    nem = Charto.new
    nem.beolva_id = product_params[:adat]
    nem.car_id = product_params[:id]
    nem.save
    
    
  end
  def file_download_original
    id = params[:id]
    beolva = Beolva.find(id)
    t_content = []
    adatok = Databeolva.where(beolva_id: beolva.id).order(row: :ASC)
    bullshit = ""
    adatok.each do |adom|
      bullshit += mentes(adom.data)
      end
    File.write("tmp/#{beolva.csv_file.filename}", bullshit)
    send_file "tmp/#{beolva.csv_file.filename}",  :x_sendfile=>true


  end
  def duplikalo_delete
    id = params[:id]
    dele = Databeolva.where(beolva_id: id).where.not(tdata: [nil, ""]).where.not("data like ?", "%0x00000000000000000C000000%").order(row: :ASC)
    dele.each do |a|
      a.tdata = nil
      a.save
    end
  end
  def duplikalo
    id = params[:id]
    adatok = Databeolva.where(beolva_id: id).where.not(tdata: [nil, ""]).where("data like ?", "%0x00000000000000000C000000\t%").order(row: :ASC)
    adatok.each do |adom|
      next_row = (adom.row + 1)
      next_adat = Databeolva.where(beolva_id: id, row: next_row).first
      if next_adat.present?
        eredeti = adom.data.split(/\t/)
        eredeti_tdata = adom.tdata.split(/\t/)
        next_eredeti = next_adat.data.split(/\t/)
        next_adat.tdata = next_eredeti[0] + "\t" + eredeti_tdata[1] + "\t\r\n"
        next_adat.save
      end
    end
    redirect_to beolvas_path
  end
  
  def finish
    id = params[:id]
    size = params[:adat]
    file = params[:file]
    beolva_data = Beolva.find(id)
    if size.present?
      adatok = Databeolva.where(beolva_id: beolva_data.id).order(row: :ASC).limit(size)
    else
      adatok = Databeolva.where(beolva_id: beolva_data.id).order(row: :ASC)
    end
    bullshit = ""
    adatok.each do |adom|
      tdata = adom.tdata
      bullshit += mentes(tdata) || mentes(adom.data)
    end
    if file == "kalap"
      changer = Changer.all
      changer.each do |t|
        bullshit = bullshit.gsub(t.ori, t.mod)
      end
    end
    File.write("tmp/#{beolva_data.csv_file.filename}", bullshit)
    send_file "tmp/#{beolva_data.csv_file.filename}",  :x_sendfile=>true
  end
  def tomeges_csere_unreal
    adat1 = product_params[:adat]
    adat2 = product_params[:file]
    id = product_params[:id]
    upd = Databeolva.where(beolva_id: id).where("tdata like ?", "%#{adat1}%")
    upd.each do |t|
      t.tdata = t.tdata.gsub(adat1, adat2)
      t.save
    end
  end
  def file_download_kalap
    redirect_to finish_path(id: product_params[:id], adat: product_params[:adat], file: "kalap")
  end
  def file_download
    redirect_to finish_path(id: product_params[:id], adat: product_params[:adat])
  end
  def igezo_save_unreal
    adat = product_params[:adat]
    id = product_params[:id]
    upd = Databeolva.find(id)
    upd.tdata = adat
    upd.save
  end
  def igezo_save
    adat = product_params[:adat]
    id = product_params[:id]
    upd = Databeolva.find(id)
    str = upd.tdata.split(/\t/)
    upd.tdata = str[0].to_s + "\t" + adat.to_s + "\t" + str[2].to_s + "\t" + str[3].to_s
    upd.save
  end
  def soron_save
    adat = product_params[:adat]
    id = product_params[:id]
    upd = Databeolva.find(id)
    upd.tdata = adat.to_s
    upd.save
  end
  def linebyline_save
    adat = product_params[:adat]
    id = product_params[:id]
    upd = Databeolva.find(id)
    def_string = kiemelo(upd.data, "\"", "\"")
    new_string = upd.data.gsub(def_string,adat)
    upd.tdata = new_string
    upd.save
  end

  def kozelito
    id = params[:id]
    beolvasva = Beolva.find(id)
    if id.present?
      session[:trans_id] = id
    else
      id = session[:trans_id] 
    end
    data = Databeolva.where(beolva_id: id).where.not(tdata: [nil, ""])
    data.each do |todt|
      upd = Databeolva.find(todt.id)
      str_data = upd.data.split(/\t/)
      str_data = str_data[1].split(/\t/)
      str_tdata = upd.tdata.split(/\t/)
      str_tdata = str_tdata[1].split(/\t/)
      td = str_tdata[0].gsub(beolvasva.fileend,"").gsub("I2Languages-resources.assets-","").to_s 
      d = str_data[0].gsub(beolvasva.fileend,"").gsub("I2Languages-resources.assets-","").to_s
      upd.file_id = compare_sections(td, d)
      upd.save
    end
    redirect_to line_path(szazalek: 1, id: id)
  end
  def linebyline
    id = params[:id]
    if id.present?
      session[:trans_id] = id
    else
      id = session[:trans_id] 
    end
    @adat = Beolva.find(id).game_name
    szazalek = params[:szazalek] 
      if id.present?
        session[:trans_id] = id
      else
        id = session[:trans_id] 
      end
    if szazalek.present?
      @q = Databeolva.where(beolva_id: id).order(file_id: :ASC).ransack(params[:q])
    else
      @q = Databeolva.where(beolva_id: id).where.not("tdata like ?", '%\r\n%').order(row: :ASC).ransack(params[:q])
    end
    
    
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
    @soronkent = @q.result(distinct: true).order('created_at DESC').page(params[:page]).per(session[:page_n])
    @ransack_path = linebyline_path
  end
  def fordsor
    @charto = Charto.where(beolva_id: params[:id])
    @karakterek = Car.all
    @beolva_adat = Beolva.find(params[:id])
    cs = "%\"%"
    @databeolvamax = Databeolva.where(beolva_id: @beolva_adat.id).order(id: :ASC).where("data LIKE ?", cs ).last
    @beolva = Databeolva.where(beolva_id: @beolva_adat.id).order(id: :ASC).where("data LIKE ?", cs )
    @ransack_path = fordsor_path
  end

  def soronkent
    id = params[:id]
    @orulet = params[:orulet]
    if id.present?
      session[:trans_id] = id
    else
      id = session[:trans_id] 
    end
    @adat = Beolva.find(id).game_name
    szazalek = params[:szazalek] 
      if id.present?
        session[:trans_id] = id
      else
        id = session[:trans_id] 
      end
    if szazalek.present?
      @q = Databeolva.where(beolva_id: id).where.not(tdata: [nil, ""]).where("length(tdata) > 100").order(file_id: :ASC).ransack(params[:q])
    else
      @q = Databeolva.where(beolva_id: id).where.not(tdata: [nil, ""]).order(row: :ASC).ransack(params[:q])
    end
    
    
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
    @soronkent = @q.result(distinct: true).order('created_at DESC').page(params[:page]).per(session[:page_n])
    @ransack_path = line_path
   
  end
def soronkent_unreal
  id = params[:id]
  if id.present?
    session[:trans_id] = id
  else
    id = session[:trans_id] 
  end
  @adat = Beolva.find(id).game_name
  @q = Databeolva.where(beolva_id: id).where.not(tdata: [nil, ""]).order(row: :ASC).ransack(params[:q])
  @soronkent = @q.result(distinct: true).order('created_at DESC').page(params[:page]).per(session[:page_n])
  @ransack_path = line_unreal_path
end

  def igezo
    id = params[:id]
    @igezo = Databeolva.where(beolva_id: id).order(id: :ASC).where("tdata LIKE ?", '%"%' ).where.not(tdata: [nil, ""])
    data = Databeolva.where("tdata like ?", '%""%')
    data.each do |o|
      
    if o.tdata.count('"') == 4
      de = Databeolva.find(o.id)
      de.tdata = de.tdata.gsub('""','"""')
      de.save
    end
  end
  end
  def nyito
    id = params[:id]
    @nyito = Databeolva.where(beolva_id: id).order(id: :ASC).where("tdata LIKE ?", '%<%' ).where.not(tdata: [nil, ""])
  end
  def translate_save_unreal
    adat = product_params[:adat]
    id = product_params[:id]
    beolva_adatok = Beolva.find(id) #Fájl amit felkell dolgozni
    adatok = adat.each_line # Beolvasom soronként
    adatok.each do |adom| # A fájl sorain végig megyünk
    k = adom.split("#ǝǝ") 
      if k[1].present?
        csv_adat = Databeolva.find(k[0])
        csv_adat.tdata = k[1].gsub("ǝ", "").strip + "\r\n"
        csv_adat.save
      end
    end
  end
  def translate_save_eu
    adat = product_params[:adat]
    id = product_params[:id]
    beolva_adatok = Beolva.find(id) #Fájl amit felkell dolgozni
    adatok = adat.each_line # Beolvasom soronként
    adatok.each do |adom| # A fájl sorain végig megyünk
    k = adom.split("#ǝǝ")
      if k[1].present?
        original_data = Databeolva.where(id: k[0], beolva_id: id).last
        original = original_data.data
        if (original.to_s.count("\"")==2)
          def_string = kiemelo(original,"\"","\"")
          new_string = original.gsub("\"" + def_string + "\"", "\"" + k[1].strip + "\"")
        end
       
        original_data = Databeolva.where(id: k[0], beolva_id: id).last
        original_data.tdata = new_string.gsub("ǝ ", "")
        original_data.save
        
      end
    end
  end
  def universal
    
    @beolva_adat = Beolva.find(params[:id])
    @beolva = Databeolva.where(beolva_id: @beolva_adat.id).where(tdata: [nil, ""]).order(id: :ASC)
    @ransack_path = fordsor_path
  end
  def universal_save
    beolva_adat = Beolva.find(universal_params[:id])
    adat = universal_params[:adat]
    id = universal_params[:id]
    elvalaszto = universal_params[:elvalaszto]
    adatok = adat.each_line # Beolvasom soronként
    adatok.each do |adom| # A fájl sorain végig megyünk
    if universal_params[:elvalaszto] == "egyenloseg"
      k = adom.split("#ǝǝ")
      adat = Databeolva.find(k[0])
      string = adat.data
      string_split = string.split("=")
      string = string.gsub(string_split[1],k[1])
      adat.tdata = string.to_s.gsub("ǝ  ", "").gsub("ǝ ", "").gsub("ǝ", "")
      adat.save
    end
    if universal_params[:elvalaszto] == "tab"
      k = adom.split("#ǝǝ") 
      if k[1].present?
        csv_adat = Databeolva.find(k[0])
        string = csv_adat.data
        string_split = string.split(/\t/)
        string_vege = string.split(/\t/, 2)
        string_vege = string_vege[1];
        def_string = string_split[csv_adat.col]
        new_string = string_vege.to_s.sub(def_string,k[1].strip).strip
        new_string = string_split[0].to_s + "\t" + antideepl(new_string.to_s.gsub("ǝ", "")).strip + "\t\r\n"
        if counter(new_string,"\t")<3
          new_string = new_string.gsub("\r\n","\t\r\n")
        end
        csv_adat.tdata = new_string
        csv_adat.save
     
    end
  end
end
    
    
    
    




  end


  def translate_save
    adat = product_params[:adat]
    id = product_params[:id]
    beolva_adatok = Beolva.find(id) #Fájl amit felkell dolgozni
    adatok = adat.each_line # Beolvasom soronként
    adatok.each do |adom| # A fájl sorain végig megyünk
    k = adom.split("#ǝǝ") 
      if k[1].present?
        csv_adat = Databeolva.find(k[0])
        string = csv_adat.data
        string_split = string.split(/\t/)
        string_vege = string.split(/\t/, 2)
        string_vege = string_vege[1];
        def_string = string_split[csv_adat.col]
        new_string = string_vege.to_s.sub(def_string,k[1].strip).strip
        new_string = string_split[0].to_s + "\t" + antideepl(new_string.to_s.gsub("ǝ", "")).strip + "\t\r\n"
        if counter(new_string,"\t")<3
          new_string = new_string.gsub("\r\n","\t\r\n")
        end
        csv_adat.tdata = new_string
        csv_adat.save
        
        
      end
    end
  end
  def translate_save_old
    # Elmenti a beillesztett fordítást!
    adat = product_params[:adat]
    id = product_params[:id]
    adatok = adat.each_line # Beolvasom soronként
    translation_content = []
    adatok.each do |adom| # A fájl sorain végig megyünk
      k = adom.split("# ")
      if k[1].present?
        csv_adat = Databeolva.find(k[0])
        string = csv_adat.data
        string_split = string.split(/\t/)
        string_vege = string.split(/\t/, 2)
        string_vege = string_vege[1];
        def_string = string_split[csv.col]
        new_string = string_vege.to_s.sub(def_string,k[1].strip).strip
        new_string = string_split[0].to_s + "\t" + new_string.to_s + "\t\r\n"
        
        Datatranslate.where(beolva_id: id, row: csv_adat.row).destroy_all
        if new_string.count('"').even?
          translation_content << {beolva_id: csv.id , databeolva_id: csv_adat.id, data: new_string , row: csv_adat.row ,  col: csv_adat.col, user_id: current_user.id, created_at: Time.now, updated_at: Time.now }
        end
      end
    end
    Datatranslate.insert_all(translation_content)
  end

 
  
  def databeolvas_reset
      dt = Databeolva.where(beolva_id: params[:id])
      dt.destroy_all
      respond_to do |format|
        format.html { redirect_to beolvas_url, notice: "Beolvasott CSV adatok törölve" }
        
      end
  end

  def datatranslate_reset
      Databeolva.where(beolva_id: params[:id]).update_all(tdata: nil)
      
      respond_to do |format|
        format.html { redirect_to beolvas_url, notice: "Adatok sikeresen törölve!" }
        
      end
  end
def revizio
  id = product_params[:id]
  aktual_copy = Beolva.find(id).copy
  proba = Databeolva.where(beolva_id: aktual_copy).where.not(tdata: [nil, ""])
  p proba.size
  proba.each do |t|
    if t.tdata.present?
      rev = Databeolva.where(beolva_id: id).where("data like ?", "#{t.data}").first
      if rev.present?
        rev.tdata = t.tdata.to_s
        rev.save
      end
    end
  end
  redirect_to beolvas_path
end
def file_process_new
    #Beolvassa a feltöltött CSV fájlt, feldarabolja és beteszi a DATABASE be.
  cfile = Beolva.find(params[:id])
  if cfile != true
    translation_content = []
    filepath = ActiveStorage::Blob.service.send(:path_for, cfile.csv_file.key)
    data = File.read(filepath)
    data = cserelo(data)
    data = data.gsub("-<N>-","\n")    
    translation_content = []
    enum_content = data.each_line
    enum_content.each_with_index do |content_line, index|
        translation_content << { beolva_id: cfile.id, row: index ,col: cfile.col, data: content_line ,user_id: current_user.id,created_at: Time.now, updated_at: Time.now }
      end
    Databeolva.insert_all(translation_content)
    cfile.trans = true
    if  cfile.save
      redirect_to beolvas_path
    else
      format.html { redirect_to beolvas_path }      
    end
  end
end

def unreal
  @charto = Charto.where(beolva_id: params[:id])
  @karakterek = Car.all
  @beolva_adat = Beolva.find(params[:id])
  @databeolvamax = Databeolva.where(beolva_id: @beolva_adat.id).order(id: :ASC).last
  @beolva = Databeolva.where(beolva_id: @beolva_adat.id).order(row: :ASC)
  @mindenis = ""
  Databeolva.where(col: nil).update_all(col: 1)
  
  @beolva.each do |te|
    if te.tdata.present?
    else
      str = te.data
      @mindenis +=  te.id.to_s + "#\t\t" + str + "\n"
    end

  end


end


  def file_process
      #Beolvassa a feltöltött CSV fájlt, feldarabolja és beteszi a DATABASE be.
    cfile = Beolva.find(params[:id])
    if cfile != true
      translation_content = []
      filepath = ActiveStorage::Blob.service.send(:path_for, cfile.csv_file.key)
      data = File.read(filepath)
      
      data = data.encode('utf-8')
      data = cserelo(data)
      data = data.gsub("-<RN>-","\r\n")
      
      translation_content = []
      enum_content = data.each_line
      enum_content.each_with_index do |content_line, index|
          translation_content << { beolva_id: cfile.id, row: index ,col: cfile.col, data: content_line ,user_id: current_user.id,created_at: Time.now, updated_at: Time.now }
        end
      Databeolva.insert_all(translation_content)
      cfile.trans = true
      if  cfile.save
        redirect_to beolvas_path
        
      else
        format.html { redirect_to beolvas_path }
        format.json { render json: @beolva.errors, status: :unprocessable_entity }
      end
     

    end
  end

  # POST /beolvas or /beolvas.json
  def create
    @beolva = Beolva.new(beolva_params)
    @beolva.user_id = current_user.id
   respond_to do |format|
      if @beolva.save
        format.html { redirect_to beolvas_path, notice: "Beolva was successfully created." }
        format.json { render :show, status: :created, location: @beolva }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @beolva.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beolvas/1 or /beolvas/1.json
  def update
    respond_to do |format|
      if @beolva.update(beolva_params)
        format.html { redirect_to beolvas_url(), notice: "Beolva was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
       end
    end
  end

  # DELETE /beolvas/1 or /beolvas/1.json
  def destroy
    @beolva.destroy

    respond_to do |format|
      format.html { redirect_to beolvas_url, notice: "Beolva was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  # calculate difference in perentage between contents
  def compare_sections(data, tdata )
    distance = Text::Levenshtein.distance(data, tdata).to_f
    calculate_diff(distance, data, tdata).to_i
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beolva
      @beolva = Beolva.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def beolva_params
      params.require(:beolva).permit(:game_name, :game_version, :trans, :user_id, :csv_file, :fileend, :col, :copy)
    end
    def product_params
      params.require(:product).permit(:id, :adat , :file)
    end
    def universal_params
      params.require(:universal).permit(:id, :adat , :elvalaszto)
    end
    def calculate_diff(distance, data , tdata)
      return 0 if data.length.zero? && tdata.length.zero?
      return 100 if data.length.zero? && tdata.length.positive?
      string_length = [data.length, tdata.length].max 
      distance / string_length * 100
    end
end
