class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  require 'zip'
  include BeolvasHelper
  def index
    @projects = Project.all.order(id: :DESC)
  end
  def show
  end
  def new
    @project = Project.new
  end
  def edit
    @karakterek = Car.all
  end
  def char_on
    nem = Procharto.new
    nem.file = product_params[:data]
    nem.char = product_params[:id]
    nem.save
  end
  def char_off
    nem = Procharto.where(file: product_params[:data], char: product_params[:id])
    nem.delete_all  
  end
  def regex
  indito = product_params[:data]
  vege = product_params[:file]
  id = product_params[:id]
  adatok = Regexadatok.new
  adatok.indito = indito
  adatok.vege = vege
  p_id = Dataproject.where(file: id).first.project_id
  adatok.project_id = p_id
  
    if adatok.save
      render json: { valami: "A mentés sikeres" }
    else
      render json: { valami: "HIBA!"}
    end
  
  
  
  
  end
  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
   # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
    end
  end
  #Beolvassa a feltöltött CSV fájlt, feldarabolja és beteszi a DATABASE be.
  def fajlok_beolvasasa_normal
    cfile = Project.find(params[:id]) #Project ID lekérés
    cfile.files.each do |t| # A projecthez tartozó fájlokon végig lépkedünk
      filepath = ActiveStorage::Blob.service.send(:path_for, t.key)  #Adatok a fájlról
      data = File.read(filepath) #Beolvassuk a fájlt
      data = cserelo(data) #Kicseréljük a sortörést és a többi szarságot
      translation_content = []
      enum_content = data.each_line
      enum_content.each_with_index do |content_line, index| 
          translation_content << { file: t.id , project_id: cfile.id, row: index, data: content_line,created_at: Time.now, updated_at: Time.now }
        end
      Dataproject.insert_all(translation_content)    #Adatbázisba betültjük az adatokat
    end
    cfile.trans = true #Elmentem a projectet hogy ez már fel van véve!
    cfile.save
    redirect_to projects_path
  end
  def project_trans_reset
    dt = Project.find(params[:id])
    dt.trans = false
    dt.save
    torles = Dataproject.where(project_id: params[:id])
    torles.delete_all
    redirect_to projects_path
  end
  def project_tomeges_forditas_osszes
    @sample = valasz(id,200)
    @adatok = valasz(id,20000)
    @adatokmind = valasz(id,20000)
  end
  def project_tomeges_forditas
    id = params[:id]
    @sample = valasz(id,100)
    @adatok = valasz(id,5000)
    @adatokmind = valasz(id,200000)
  end
  def rendezo
    if current_user.admin?
      adatok = Dataproject.where.not(tdata: [nil, ""])
      adatok.each do |t|
        ad = t.data.strip    
        upd = Dataproject.find(t.id)
        up = upd.tdata.gsub(ad,"").strip
        if up.length>0
          upd.tdata = up  + "\r\n"
        else
          upd.tdata = nil
        end
        upd.save
      end
    end
  end
  def tomeges_csere
    adat1 = product_params[:data]
    adat2 = product_params[:file]
    id = product_params[:id]
    upd = Dataproject.where(file: id).where("tdata like ?", "%#{adat1}%")
    upd.each do |t|
      t.tdata = t.tdata.gsub(adat1, adat2)
      t.save
    end
  end
  def project_paros
    session[:project_paros] = product_params[:data]
  end
  def project_elvalaszto
    lv = product_params[:data]
    session[:project_elvalaszto] = lv
    lv = lvcontoll(lv)
    
    id = product_params[:id] #Fordított fájl ID je
    val = "" #Visszaadott válasz
    ##############################################################
    valasz = valasz(id,5000)
    valasz.each do |t|
      val += feldolgozo(t.id.to_s,t.data,t.tdata)
    end
    render json: { valami: val }
  end
  def project_line_save
    adat = product_params[:data]
    id = product_params[:id]
    upd = Dataproject.find(id)
    upd.tdata = adat
    upd.save
  end
  def project_oszlop
    session[:project_oszlop] = product_params[:data]
    oszlopom = product_params[:data].to_i
    id = product_params[:id] #Fordított fájl ID je
    valasz = valasz(id,5000)
    val = ""
    valasz.each_with_index do |t,index|
      val += feldolgozo(t.id.to_s,t.data,t.tdata)
    end
    render json: { valami:  val.to_s }
  end
  def project_szoveg
    session[:project_szoveg] = product_params[:data]
    szoveg = product_params[:data]
    id = product_params[:id] #Fordított fájl ID je
    valasz = valasz(id,5000)
    val = ""
    if szoveg.present?
      valasz.each do |t|
        val += feldolgozo(t.id.to_s,t.data,t.tdata)
      end
      render json: { valami: val }
    end
  end
  def project_file_download_kalap
    redirect_to project_finish_path(id: product_params[:id], adat: product_params[:adat], file: "kalap", name: product_params[:name])
  end
  def project_file_download
    redirect_to project_finish_path(id: product_params[:id], adat: product_params[:adat])
  end
  def project_file_zip
    projectem = Project.find(params[:id])

    projectem.files.each do |file|
      controllka("tmp/file/" + file.filename.to_s)
      cont_dir("tmp/file")
      leiras = ""
      data_all = Dataproject.where(file: file.id).order(id: "ASC")
      data_all.each do |data|
        if data.tdata.present?
          leiras << mentes(data.tdata)
        else
          leiras << mentes(data.data)
        end          

      end #Data_each end
      changer = Changer.all
      changer.each do |t|
        leiras = leiras.gsub(t.ori, t.mod)
      end
      File.write("tmp/file/" + file.filename.to_s, leiras)
      end
      directory_to_zip = "tmp/file/"
      controllka("tmp/file.zip")
      output_file = "tmp/file.zip"
      zf = ZipFileGenerator.new(directory_to_zip, output_file)
      zf.write()
  end
  def project_finish
    id = params[:id]
    size = params[:adat]
    file = params[:file]
    project = params[:project]
    if size.present?
      adatok = Dataproject.where(file: id).order(row: :ASC).limit(size)
    else
      adatok = Dataproject.where(file: id).order(row: :ASC)
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
    proj = params[:name]
    File.write("tmp/#{proj}", bullshit)
    send_data "tmp/#{proj}"
    send_file "tmp/#{proj}", :type => 'text/html; charset=utf-8',  :x_sendfile=>true
  end
  def project_forditas_mentes
    adat = product_params[:data]
    id = product_params[:id]
    adatok = adat.each_line # Beolvasom soronként
    adatok.each do |adom| # A fájl sorain végig megyünk
    lv = session[:project_elvalaszto]
    oszlop = session[:project_oszlop]
    k = adom.split("#ǝǝ") 
      if k[1].present?
        soradat = Dataproject.where(id: k[0]).first
        if soradat
          string = soradat.data
          if lv != "semmi"
            string_split = string.split(/#{lv}/)
            string_vege = string.split(/#{lv}/, 2)
            string_vege = string_vege[1];
            def_string = string_split[session[:project_oszlop].to_i]
            new_string = string_vege.to_s.sub(def_string,k[1].strip)
            new_string = string_split[0].to_s + lv + antideepl(new_string.to_s.gsub("ǝ ", "").gsub("ǝ", ""))
            if counter(new_string,"\t")<3
              new_string = new_string.gsub("\r\n","\t\r\n")
            end
          else
            new_string = k[1].gsub("ǝ ", "").gsub("ǝ", "")
          end
          soradat.tdata = new_string
          soradat.save
        end
      end
    end
  end
  def compare_sections(data, tdata )
    distance = Text::Levenshtein.distance(data, tdata).to_f
    calculate_diff(distance, data, tdata).to_i
  end
  def line
    id = params[:id]
    if id.present?
      session[:trans_id] = id
    else
      id = session[:trans_id] 
    end
    @q = Dataproject.where(file: id).where.not(tdata: [nil, ""]).order(row: :ASC).ransack(params[:q])
    @soronkent = @q.result(distinct: true).order('created_at DESC').page(params[:page]).per(session[:page_n])
    @ransack_path = project_line_path
  
  end
  def lines
    id = params[:id]
    if id.present?
      session[:trans_id] = id
    else
      id = session[:trans_id] 
    end
    ids = Dataproject.where(file: id).last.project_id
    @q = Dataproject.where(project_id: ids).where.not(tdata: [nil, ""]).order(row: :ASC).ransack(params[:q])
    @soronkent = @q.result(distinct: true).order('created_at DESC').page(params[:page]).per(session[:page_n])
    @ransack_path = project_lines_path
   end
  def project_nemvalto
    nemvalto = product_params[:data] # Mit mutasson, minden, Csak fordított, Nem fordított
    session[:project_nemvalto] = nemvalto
    id = product_params[:id] #Fordított fájl ID je
    val = "" #Visszaadott válasz
    valasz = ""
    valasz = valasz(id,5000)
    valasz.each do |t|
      val += feldolgozo(t.id.to_s,t.data,t.tdata)   
    end
    render json: { valami: val.to_s }    
  end
  def download
    send_file "tmp/file.zip", :disposition => 'attachment'
  end
  def project_sorvalto
    valasz = Dataproject.where(file: product_params[:id]).order(row: :ASC)
    val = ""
    lv = session[:elvalaszto].to_s
      valasz.each do |t|
        if lv == "semmi"
          val += t.id.to_s + "#ǝǝ\t\t" + t.data 
        else
          if t.data.include? "#{lv}" 
            oszlopos = t.data.split(lv)
            oszlopos = oszlopos[product_params[:data].to_i]
            if oszlopos.strip.length>0
              val += t.id.to_s + "#ǝǝ\t\t" + oszlopos + "\r\n"
            end
          else
            
          end
        end
    end
    session[:project_sorvalto] = product_params[:data]
    render json: { valami: val.to_s }
    
  end
  def feldolgozo(id,data,tdata)
    tmp = ""
    lv = session[:project_elvalaszto] #Elválasztó karakterek
    oszlopom = session[:project_oszlop].to_i
    paros = session[:project_paros].to_i
    lv = lvcontoll(lv)
    val = "" #alapválasz
    if lv == "semmi" # Ha nincs semmilyen elválasztó dolog, akkor
      val += id + "#ǝǝ\t\t" + data
    end
    if lv && lv!="semmi"
      if data.include? lv.to_s
        oszlopos = data.split(lv) #Daraboljuk fel elválasztás szerint
        oszlopos = oszlopos[oszlopom] #vegyük figyelembe hanyadik oszlop kell
        if oszlopos.strip.length>0
          if paros == 0 || paros.nil?
            tmp = id + "#ǝǝ\t\t" + oszlopos + "\r\n"  
          end
          if paros == 1
            if index.even?
              tmp += id + "#ǝǝ\t\t" + oszlopos + "\r\n"
            end
          end
          if paros == 2
            if index.odd?
              tmp += id + "#ǝǝ\t\t" + oszlopos + "\r\n"
            end
          end
          val =  tmp
        end
      end
    end
   val
  end
  def valasz(id,limit)
    lv = session[:project_elvalaszto] #Elválasztó karakterek
    lv = lvcontoll(lv)
    if lv == "semmi"
      lv = ""
    end
    szoveg = session[:project_szoveg].to_s #Keresett szöveg
    nemvalto = session[:project_nemvalto].to_i #Mindet(0), Csak a lefordítottat(1), Csak a nem lefordítottakat(2)
    valasz = Dataproject.where(file: id)
    if lv && szoveg==""
      valasz = Dataproject.where(file: id).where("data like ?" , "%#{lv}%" )
    end
    if lv && szoveg!=""
      valasz = Dataproject.where(file: id).where("data like ?" , "%#{szoveg}%" ).where("data like ?" , "%#{lv}%" )
      if szoveg[0]=="#"
          valasz = Dataproject.where(file: id).where.not("data like ?" , "%#{szoveg[1..-1]}%" ).where("data like ?" , "%#{lv}%" )
      end
    end
    if nemvalto
      if nemvalto == 1
        valasz = valasz.where.not(tdata: [nil, ""])
      end
      if nemvalto == 2
        valasz = valasz.where(tdata: [nil, ""])
      end
    end
    if limit 
      valasz = valasz.limit(limit)
      if limit.to_i == 200000
        valasz = valasz.order("LENGTH(tdata) DESC").limit(limit)
      end
    end

    valasz.order(row: :ASC)
  end
  def nyito
    id = params[:id]
    @nyito = Dataproject.where(file: id).order(id: :ASC).where.not(tdata: [nil, ""])
  end
  def idezojel_mentes
    adat = product_params[:data]
    lv = session[:project_elvalaszto]
    id = product_params[:id]
    upd = Dataproject.find(id)
    upd.tdata = adat
    upd.save
  end
  def idezojel
    id = params[:id]
    project_id = Dataproject.where(file: id).last.project_id
    @idezojel = Dataproject.where(project: project_id).order(id: :ASC).where("tdata LIKE ?", '%✞%' ).where.not(tdata: [nil, ""])
  end

  def lvcontoll(lv)
    if lv == "\\t"
      lv = "\t"
    end
    if lv == ""
      lv = "semmi"
    end
    lv
  end
  class ZipFileGenerator
  # Initialize with the directory to zip and the location of the output archive.
  def initialize(input_dir, output_file)
    @input_dir = input_dir
    @output_file = output_file
  end

  # Zip the input directory.
  def write
    entries = Dir.entries(@input_dir) - %w[. ..]
    ::Zip::File.open(@output_file, create: true) do |zipfile|
      write_entries entries, '', zipfile
    end
  end

  private

  # A helper method to make the recursion work.
  def write_entries(entries, path, zipfile)
    entries.each do |e|
      zipfile_path = path == '' ? e : File.join(path, e)
      disk_file_path = File.join(@input_dir, zipfile_path)

      if File.directory? disk_file_path
        recursively_deflate_directory(disk_file_path, zipfile, zipfile_path)
      else
        put_into_archive(disk_file_path, zipfile, zipfile_path)
      end
    end
  end

  def recursively_deflate_directory(disk_file_path, zipfile, zipfile_path)
    zipfile.mkdir zipfile_path
    subdir = Dir.entries(disk_file_path) - %w[. ..]
    write_entries subdir, zipfile_path, zipfile
  end
  def calculate_diff(distance, data , tdata)
    return 0 if data.length.zero? && tdata.length.zero?
    return 100 if data.length.zero? && tdata.length.positive?
    string_length = [data.length, tdata.length].max 
    distance / string_length * 100
  end
  def put_into_archive(disk_file_path, zipfile, zipfile_path)
    zipfile.add(zipfile_path, disk_file_path)
  end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:game, :version, :vege, :col, :copy, :trans, files: [])
    end
    def product_params
      params.require(:product).permit(:id, :data, :file, :name)
    end
end
