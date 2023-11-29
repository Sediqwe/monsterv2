module ProjectsHelper
    
    def fajl_sor_szamolo(file)
        Dataproject.where(file: file).size        
    end
    def fajl_tdata_sor_szamolo(file)
        Dataproject.where(file: file).where.not(tdata: [nil, ""]).size        
    end
    def project_cserelo(str)
        str = str.gsub("\r\n","-<RN>-")
        str = str.gsub("\n","-<N>-")
        str = str.gsub("\r","-<R>-")
        str = str.gsub('""', "⇝")
        str = str.gsub('"', "✞")      
        str = str.gsub("-<RN>-","\r\n")  
    end
    def compare_sections(data, tdata )
        distance = Text::Levenshtein.distance(data, tdata).to_f
        calculate_diff(distance, data, tdata).to_i
    end
    def calculate_diff(distance, data , tdata)
        return 0 if data.length.zero? && tdata.length.zero?
        return 100 if data.length.zero? && tdata.length.positive?
        string_length = [data.length, tdata.length].max 
        distance / string_length * 100
    end
    def counter(str, substr)
        str.to_s.scan(/(?=#{"\\" + substr.to_s})/).count
    end
    def megjelenito(str)
        str = str.gsub("\t","<font color=\"orange\"> TAB </font>")
        str = str.gsub("\r\n","<font color=\"orange\"> SORTÖRÉS </font>")
        str = str.gsub("\n","<\\N>\n")
        str = str.gsub("\r","<\\R>\r")
        str = str.gsub("<font color=\"orange\"> SORTÖRÉS </font>", "<font color=\"orange\"> SORTÖRÉS </font>\r\n")
        
    end
    def controllka(file)
        if File.exists?(file)
            File.delete(file)
        end
    end
    def cont_dir(file)
        if Dir.exists?(file)
        else
            Dir.mkdir(file)  
        end
    end
    def project_ellenorzo(szoveg, eredeti)
        if szoveg.present? 
        #Ellenörzöm a beérkező szöveget idézőjelre
        eleje = "<div class=\"btn btn-danger\">Eleje NOK</div>"
        vege = "<div class=\"btn btn-danger\">Vége NOK</div>"
        maxketto = "<div class=\"btn btn-info\">Több mint 2 Idézőjel</div>"
        e = 0
        v = 0
        par = 0
        negy = ""
        paros = "<div class=\"btn btn-danger\">Páratlan az idézőjelek száma</div>"
        ok = ""
        tobbdenemparos = "<div class=\"btn btn-danger\">Dupla idézőjelek száma belül hibás</div>"
        vissza = ""
        tobblet = ""
        if szoveg[0,1] == '✞' #Elején van idézőjel
            eleje  = "<div class=\"btn btn-success\">Eleje OK</div>"
            e = 1
        end
        if szoveg[-1,1] == '✞' #Végén van idézőjel
            v = 1
            vege = "<div class=\"btn btn-success\">Vége OK</div>"
        end
        if szoveg.count('✞') == 2 && v == 1 && e == 1 # Kettő idézőjel van, az is az elején és a végén!
            maxketto = "<div class=\"btn btn-success\">Maximum 2 OK</div>"
        end
        if counteven(szoveg,'✞') #Páros az idézőjelek száma
            paros = "<div class=\"btn btn-success\">Páros az idézőjelek száma</div>"
            par = 1
        end
        if szoveg.count('✞') >2 && par == 1 # Ha több mint 2 idézőjel van benne és azok párosan vannak OK
            ok = 0
                szovegdarab = szoveg.delete_prefix('✞').delete_suffix('✞')
                if counter_l(szovegdarab,'✞✞').even?
                    tobbdenemparos = "<div class=\"btn btn-info text-light\">Dupla idézőjelek száma belül rendben</div>" 
                end
        end
        if szoveg.count('✞') ==4
            negy = "<div class=\"btn btn-danger text-light\">4 idézőjel? Ez nem lesz jó!</div>" 
        end
        if szoveg.count('✞') != eredeti.count('✞')
        tobblet = "<div class=\"btn btn-warning text-light\">Eltérő számú idézőjel</div>" 
        end
        p eleje + " " + vege + " " + maxketto + " " + paros + " " + tobbdenemparos + negy + tobblet
        end
    end
    def project_ellenorzo_dat(szoveg)
        if szoveg.present?

        #Ellenörzöm a beérkező szöveget idézőjelre
        eleje = "<div class=\"btn btn-danger\">Eleje NOK</div>"
        vege = "<div class=\"btn btn-danger\">Vége NOK</div>"
        maxketto = "<div class=\"btn btn-info\">Több mint 2 Idézőjel</div>"
        e = 0
        v = 0
        m = 
        par = 0
        k = 1
        paros = "<div class=\"btn btn-danger\">Páratlan az idézőjelek száma</div>"
        ok = 0
        tobbdenemparos = "<div class=\"btn btn-danger\">Dupla idézőjelek száma belül hibás</div>"
        vissza = ""
        if szoveg[0,1] == '✞' #Elején van idézőjel
            eleje  = "<div class=\"btn btn-success\">Eleje OK</div>"
            e = 1
            
        end
        if szoveg[-1,1] == '✞' #Végén van idézőjel
            v = 1
            vege = "<div class=\"btn btn-success\">Vége OK</div>"
            
        end
        if szoveg.count('✞') == 2 && v == 1 && e == 1 # Kettő idézőjel van, az is az elején és a végén!
            maxketto = "<div class=\"btn btn-success\">Maximum 2 OK</div>"
            m =1
            
        end
        if szoveg.count('✞') == 4
            k = 0
        end
        if counteven(szoveg,'✞') #Páros az idézőjelek száma
            paros = "<div class=\"btn btn-success\">Páros az idézőjelek száma</div>"
            par = 1
            
        end
        if szoveg.count('✞') >2 && par == 1 # Ha több mint 2 idézőjel van benne és azok párosan vannak OK
            
                szovegdarab = szoveg.delete_prefix('✞').delete_suffix('✞')
                if counter_l(szovegdarab,'✞✞').even?
                    tobbdenemparos = "<div class=\"btn btn-info text-light\">Dupla idézőjelek száma belül rendben</div>" 
                    ok = 1
                end
            
            
        end
        if v == 1 && e == 1 && par == 1 && k == 1
            false
        else
            true
        end
        end
    end
    def analizator(data,tdata,id, hol)

    st1 = felbont(data.to_s,id)
    st2 = felbont(tdata,id)
    stb = st1 - st2
    str = st2 - st1

    if stb.size > 0 && hol == 0
        #többlet van a DATA ban
        s = "fent több van\n" 
        stb.uniq.each do |dort|
            s += "<div class=\" btn btn-success\"><i class=\"bi bi-arrow-down-right\"></i>" + dort[:start] + " " + dort[:str] + dort[:endre] + "<span class=\"badge badge-warning\">"   +"\t\t"+  dort[:nu].to_s  + "</span>???</div>"
            k = str.find{|i| i[:str] == dort[:str] }
            if k.present?
                s +="<div>" +  "mert lent:" +  k[:nu].to_s+ "</div>"
            else
                s += "<div>" + "mert lent:0"+ "</div>"
            end
            
        end
        

    end
    if str.size > 0 && hol == 1
        #többlet van a TDATA ban
        k = []
        s = "lent több van\n\r"
        str.uniq.each do |dort|
            k = stb.find{|i| i[:str] == dort[:str] }
            bom = ""
            if k.present?
                bom = k[:nu].to_s
            else
                bom= "0 \t"
            end
            s += "<div class=\" btn btn-success  btn-block\"><i class=\"bi bi-arrow-down-right\"></i><span class=\"badge badge-danger\">" +    dort[:nu].to_s   + "</span><i class=\"bi bi-arrow-up-right\"></i>" +"\t\t"+ bom + "</span>" + dort[:start] + " " + dort[:str] +  dort[:endre]  +"!!</div>"
            
        end
    end
    if str.size == stb.size
        s = ""
        if stb.size > 0 && hol == 0
        s += "Egyenlő de fent valami van"
        stb.uniq.each do |dort|
            s += "<div class=\" btn btn-success btn-block\"><i class=\"bi bi-arrow-down-right\"></i>"  + dort[:start] + " " + dort[:str] + dort[:endre]  + "<span class=\"badge badge-warning\">" + "\t\t"+  dort[:nu].to_s + "</span>???</div>"
            k = str.find{|i| i[:str] == dort[:str]}
            if k.present?
                s += "<div>" + "mert lent:" +  k[:nu].to_s + "\n""</div>"
            else
                s +="<div>" + "mert lent:0""</div>"
            end
        end
        
        end
        if str.size > 0 && hol == 1
        s += "Egyenlő de lent valami van"
        str.uniq.each do |dort|
            k = stb.find{|i| i[:str] == dort[:str] }
            bom = ""
            if k.present?
                bom = k[:nu].to_s
            else
                bom= "0 \t"
            end
            s = "<div class=\" btn btn-success\">" + bom + "<i class=\"bi bi-arrow-down-right\"></i><i class=\"bi bi-arrow-up-right\"></i>"  + dort[:start] + " " + dort[:str] + dort[:endre] + "<span class=\"badge badge-danger\">"  +"\t\t"+ dort[:nu].to_s + "</span>!!!</div>"
            end
        
        end
    end
    s.to_s.html_safe
    end
    def cserelo_char(str, id)
        c = Procharto.where(file: id).order(id: :ASC)
        if str.present?
            c.each do |todo|
                t = Car.find(todo.char)
                str = str.gsub(t.open,t.openc)
                str = str.gsub(t.close,t.closec)
            end
        end
        p str
    end
    def felbont(str , id)
    #0 megjön a SZÖVEG és a FILE id
    #1 karaktereket begyüjtöm
    #karakterenként végig kellene menni, felbontani ahányszo van benne és kiemelni azokat sorban
    #emeljünk ki minden karakter adatot?
    #Alakítsuk át a [karaktereket]
    #Nézzük meg van e benne egyáltalán ilyen
    #ha van daraboljuk fel a STRINGET és úgy kosslassunk eredményért, vigyázz , az első karakter a [0 ban marad]
    karakterek = Procharto.where(file: id).order(id: :ASC) # Szükséges karakterek begyüjtése
    str_origin = cserelo_char(str, id)
    st = ""
    ary = []
    str = cserelo_char(str, id) # STR átalakítása
    karakterek.each do |karakter|
        open = Car.find(karakter.char).open
        openc = Car.find(karakter.char).openc
        close = Car.find(karakter.char).close
        closec = Car.find(karakter.char).closec
        if str.present?
            if str.include? openc
                strsplit = str.split(openc) #vágjuk fel a stringet, annyi darabra ahányszor megvan benne
                strsplit.each_with_index do |st, index| #Nézzük át a tömböt
                    if st.include? "#{closec}"
                        st = openc + st
                        #<>
                        if st.include? "Ł"
                            st = st[/#{openc}(.*?)#{closec}/m, 1]
                            
                        end
                        #{[]}
                        if st.include? "Đ"
                            st = st[/#{openc}(.*?)#{closec}/m, 1]
                            
                        end
                        #[]
                        if st.include? "Ţ"
                            st = st[/#{openc}(.*?)#{closec}/m, 1]
                            
                        end
                        #{}
                        if st.include? "Ŧ"
                            st = st[/#{openc}(.*?)#{closec}/m, 1]
                            
                        
                        end
                        sed = openc + st.to_s + closec
                        numbi = counter(str_origin,sed)        
                        ary << {str: st, nu: numbi, start: open , endre: close}
                    end
            
                end #Tömb vége
            
            else
                
            end# If
        end
    end #EachDo

    return ary
    end
end