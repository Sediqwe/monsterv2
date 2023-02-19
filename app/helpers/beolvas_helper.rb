module BeolvasHelper
    def kieg2(start, utolso, id)
      
        adatok = ""
        forditas = Databeolva.where(beolva_id: id).where("id >= ?", start).where( "id <= ?", utolso).order(id: :ASC)
        
        forditas.each do |dot|
            if dot.tdata.present?
                new_string = kiemelo(dot.tdata,"\"","\"") 
                def_string = kiemelo(dot.data,"\"","\"")    
                if new_string.strip == def_string.strip
                    adatok += "\n##############################################\n" + dot.id.to_s + "#\t" + def_string + "\n=> "+ new_string + "\n" 
                else
                    veg = ""
                    if new_string[-2,2] != "\n"
                        veg = "\n"
                    end
                    adatok += dot.id.to_s + "#ǝǝ\t\t'" + def_string + "'\n => '" + new_string + "'" + veg
                    
                end
            end
        end
        p adatok
    end
    def kiegall(id)
        adatok = ""
        forditas = Databeolva.where(beolva_id: id)  .order(id: :ASC)
        forditas.each do |dot|
            if dot.tdata.present?
                string  = dot.data.split(/\"/)                  
                def_string = string[dot.col].to_s
                new_string = dot.tdata.split(/\"/)
                str_string = new_string[dot.col].to_s
                if str_string.strip == def_string.strip
                    adatok += dot.id.to_s + "#ǝǝ\t\t" + def_string +"\n" 
                end
            end 
        end
        p adatok
    end
    def kieg_unreal(start, utolso, idk)
        adatok = ""
        forditas = Databeolva.where(beolva_id: idk).where("id >= ?", start).where( "id <= ?", utolso).order(id: :ASC)
        forditas.each do |dot|
            if dot.tdata.present?
                def_string  = dot.data
                new_string = dot.tdata
                
                if new_string.strip == def_string.strip
                    adatok += "\n##############################################\n" + dot.id.to_s + "#\t\t" + mentes(def_string) +"\n=> " + mentes(new_string) + "\n\n" 
                else
                    adatok += dot.id.to_s + "#ǝǝ\t\t" + mentes(def_string) + " => " + mentes(new_string) + "\n"
                end
            end
        end
        p adatok
    end
    def kieg(start, utolso, idk)
        adatok = ""
        forditas = Databeolva.where(beolva_id: idk).where("id >= ?", start).where( "id <= ?", utolso).order(id: :ASC)
        forditas.each do |dot|
            if dot.tdata.present?
                string  = dot.data.split(/\t/)                  
                def_string = string[dot.col].to_s
                new_string = dot.tdata.split(/\t/)
                str_string = new_string[dot.col].to_s
                if str_string.strip == def_string.strip
                    adatok += "\n##############################################\n" + dot.id.to_s + "#\t\t" + mentes(str_string) +"\n=> " + mentes(def_string) + "\n\n" 
                else
                    adatok += dot.id.to_s + "#ǝǝ\t\t" + mentes(def_string) + "\n => " + mentes(str_string) +"\n" 
                end
            end
        end
        p adatok
    end
    def kiegminus2(start, utolso)
        adatok = ""
        forditas = Databeolva.where("id >= ?", start).where( "id <= ?", utolso).order(id: :ASC)
        forditas.each do |dot|
            if dot.tdata.present?
                string  = dot.data.split(/\"/)                  
                def_string = string[dot.col].to_s
                new_string = dot.tdata.split(/\"/)
                str_string = new_string[dot.col].to_s
                if str_string.strip == def_string.strip
                    adatok += dot.id.to_s + "#ǝǝ\t\t" + def_string +"\n" 
                end
            end 
        end
        p adatok
    end
    def kiegminus_unreal(start, utolso)
        adatok = ""
        forditas = Databeolva.where("id >= ?", start).where( "id <= ?", utolso).order(id: :ASC)
        forditas.each do |dot|
            if dot.tdata.present?
                def_string  = dot.data                  
                new_string = dot.tdata
                if new_string.strip == def_string.strip
                    adatok += dot.id.to_s + "#ǝǝ\t\t" +def_string
                end
            end 
        end
        p adatok
    end
    def kiegminus(start, utolso)
        adatok = ""
        forditas = Databeolva.where("id >= ?", start).where( "id <= ?", utolso).order(id: :ASC)
        forditas.each do |dot|
            if dot.tdata.present?
                string  = dot.data.split(/\t/)                  
                def_string = string[dot.col].to_s
                new_string = dot.tdata.split(/\t/)
                str_string = new_string[dot.col].to_s
                if str_string.strip == def_string.strip
                    adatok += dot.id.to_s + "#ǝǝ\t\t" + def_string +"\n" 
                end
            end 
        end
        p adatok
    end
    def universal(str, elvalaszto)
        ok = 0
    if elvalaszto == "egyenloseg"
        if str.count('=')>0
            str = str.split('=')
            str = str[1]
            ok = 1
        end
    end
    if elvalaszto == "tab"
        
    end
    if ok == 1
        str
    else
        str = ""
    end
    
    
    end


    def sanyi2(start, utolso)

    csv_file = Databeolva.find(start)
    csv_file  = Beolva.find(csv_file.beolva_id)
    cs = "%\"%"
    adatok = ""
    forditas = Databeolva.where("id >= ?", start).where( "id <= ?", utolso).where("data LIKE ?", cs).order(id: :ASC)
    forditas.each do |dot|
        
        if dot.tdata.present? && dot.data.length > 0
        else
            if dot.data.count('"')>1 && dot.data.strip.length > 0
                adatok += dot.id.to_s + "#ǝǝ\t\t" + kiemelo(dot.data.to_s, "\"","\"") + "\n"
            end
        end 
    end
    p adatok
end
    def sanyi(start, utolso)
        csv_file = Databeolva.find(start)
        csv_file  = Beolva.find(csv_file.beolva_id)
        cs = "%" + csv_file.fileend.to_s + "\t\r\n"
        adatok = ""
        forditas = Databeolva.where("id >= ?", start).where( "id <= ?", utolso).where("data LIKE ?", cs).order(id: :ASC)
        forditas.each do |dot|
            if dot.tdata.present?
            else
                string  = dot.data.split(/\t/)                  
                def_string = string[dot.col]
                    adatok += dot.id.to_s + "#ǝǝ\t\t" + def_string +"\n" 
                
            end 
        end
        p adatok
    end
    def sanyi_unreal(start, utolso)
        csv_file = Databeolva.find(start)
        csv_file  = Beolva.find(csv_file.beolva_id)
        adatok = ""
        forditas = Databeolva.where("id >= ?", start).where( "id <= ?", utolso).order(id: :ASC)
        forditas.each do |dot|
            if dot.tdata.present?
            else
                adatok += dot.id.to_s + "#ǝǝ\t\t" + dot.data.to_s
            end 
        end
        p adatok
    end
    def ekezetmentes(str, be, ki )
        str.gsub(be,ki)
    end
    def ellenorzo(szoveg)
        
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
        if szoveg[0,1] == '"' #Elején van idézőjel
            eleje  = "<div class=\"btn btn-success\">Eleje OK</div>"
            e = 1
        end
        if szoveg[-1,1] == '"' #Végén van idézőjel
            v = 1
            vege = "<div class=\"btn btn-success\">Vége OK</div>"
        end
        if szoveg.count('"') == 2 && v == 1 && e == 1 # Kettő idézőjel van, az is az elején és a végén!
            maxketto = "<div class=\"btn btn-success\">Maximum 2 OK</div>"
        end
        if counteven(szoveg,'"') #Páros az idézőjelek száma
            paros = "<div class=\"btn btn-success\">Páros az idézőjelek száma</div>"
            par = 1
        end
        if szoveg.count('"') >2 && par == 1 # Ha több mint 2 idézőjel van benne és azok párosan vannak OK
            ok = 0
                szovegdarab = szoveg.delete_prefix('"').delete_suffix('"')
                if counter_l(szovegdarab,'""').even?
                    tobbdenemparos = "<div class=\"btn btn-info text-light\">Dupla idézőjelek száma belül rendben</div>" 
                end
        end
        if szoveg.count('"') ==4
            negy = "<div class=\"btn btn-danger text-light\">4 idézőjel? Ez nem lesz jó!</div>" 
        end
        p eleje + " " + vege + " " + maxketto + " " + paros + " " + tobbdenemparos + negy
    end
    def ellenorzo_dat(szoveg)
        
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
        if szoveg[0,1] == '"' #Elején van idézőjel
            eleje  = "<div class=\"btn btn-success\">Eleje OK</div>"
            e = 1
            
        end
        if szoveg[-1,1] == '"' #Végén van idézőjel
            v = 1
            vege = "<div class=\"btn btn-success\">Vége OK</div>"
            
        end
        if szoveg.count('"') == 2 && v == 1 && e == 1 # Kettő idézőjel van, az is az elején és a végén!
            maxketto = "<div class=\"btn btn-success\">Maximum 2 OK</div>"
            m =1
            
        end
        if szoveg.count('"') == 4
            k = 0
        end
        if counteven(szoveg,'"') #Páros az idézőjelek száma
            paros = "<div class=\"btn btn-success\">Páros az idézőjelek száma</div>"
            par = 1
            
        end
        if szoveg.count('"') >2 && par == 1 # Ha több mint 2 idézőjel van benne és azok párosan vannak OK
            
                szovegdarab = szoveg.delete_prefix('"').delete_suffix('"')
                if counter_l(szovegdarab,'""').even?
                    tobbdenemparos = "<div class=\"btn btn-info text-light\">Dupla idézőjelek száma belül rendben</div>" 
                    ok = 1
                end
            
            
            
            
            
            
        end
        if v == 1 && e == 1 && par == 1 && ok == 1 && k == 1
            false
        else
            true
        end
    end
    def counteven(string, word)
        counter(string,word).even?
    end
    def antideepl(str)
        str = str.gsub("< ","<").gsub("- <","-<").gsub("> -",">-").gsub(" >",">").gsub('""""','"""').gsub('"" ""','"""')
        str = str.gsub('".','."')
        
        str = str.gsub('-<N>--<N>--<N>-', '-<N>--<N>-')
        str = str.gsub('-<N>-', 'äđĐ')
        str = str.gsub('-<N>', 'äđĐ')
        str = str.gsub('<N>-', 'äđĐ')
        str = str.gsub('<N>', 'äđĐ')
        str = str.gsub('äđĐ', '-<N>-')        
        p str
    end
    def szamol(id)
        csv_file = Beolva.find(id)
        cs = "%" + csv_file.fileend.to_s + "\t\r\n"
        szam = Databeolva.where(beolva_id: id).where("data LIKE ?", cs).size
        p szam
    end
    def mentes(str)
        if str.present?
            str = str.gsub("-<N>-","\n")
            str = str.gsub("-<R>-","\r")
            str = str.gsub("⇝",'""')
            str = str.gsub('✞','"')
        end
        p str
    end
    def visual(str)
        str = str.gsub("-<RN>-","<div class=\"btn btn-warning\">Sortörés</div>")
        str = str.gsub("-<NR>-","<div class=\"btn btn-success\">Sortörés</div>")
        str = str.gsub("-<N>-","<div class=\"btn btn-success\">Új sor</div>")
        str = str.gsub("-<R>-","<div class=\"btn btn-warning\">Kocsi vissza</div>")
        str = str.gsub("\t","<div class=\"btn btn-success\">TAB</div>")
        p str
    end
    def cserelo(str)
        str = str.gsub("\r\n","[RN]")
        str = str.gsub("\r","[R]")
        str = str.gsub("[RN]","\r\n")
        str = str.gsub('""', "⇝")
        str = str.gsub('"', "✞")
        p str
    end
    def mentes_char(str, id)
        c = Charto.where(beolva_id: id).order(id: :ASC)
        c.each do |todo|
            str = str.gsub(todo.car.openc,todo.car.open)
            str = str.gsub(todo.car.closec,todo.car.close)
        end
        p str
        
    end
    def cserelo_char(str, id)
        c = Charto.where(beolva_id: id).order(id: :ASC)
        if str.present?
            c.each do |todo|
                str = str.gsub(todo.car.open,todo.car.openc)
                str = str.gsub(todo.car.close,todo.car.closec)
            end
        end
        p str
    end
    def counter_l(str, substr)
        str.to_s.scan(/(?=#{substr.to_s})/).count
    end
    def counter(str, substr)
        str.to_s.scan(/(?=#{"\\" + substr.to_s})/).count
    end
    
    def analizator(data,tdata,id, hol)
        st1 = felbont(data.to_s,id)
        st2 = felbont(tdata,id)

        stb = st1 - st2
        str = st2 - st1
        p "STB:"
        p stb
        p "STR:"
        p str
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
    def kiemelo(str, start,stop)
        str[/#{start}(.*?)#{stop    }/m, 1]
    end
    def words(text)
        return text.split(" ").map{|word| word}
    end
    def felbont(str , id)
        #0 megjön a SZÖVEG és a FILE id
        #1 karaktereket begyüjtöm
        #karakterenként végig kellene menni, felbontani ahányszo van benne és kiemelni azokat sorban
        #emeljünk ki minden karakter adatot?
        #Alakítsuk át a [karaktereket]
        #Nézzük meg van e benne egyáltalán ilyen
        #ha van daraboljuk fel a STRINGET és úgy kosslassunk eredményért, vigyázz , az első karakter a [0 ban marad]
        karakterek = Charto.where(beolva_id: id).order(id: :ASC) # Szükséges karakterek begyüjtése
        str_origin = cserelo_char(str, id)
        st = ""
        ary = []
        str = cserelo_char(str, id) # STR átalakítása
        karakterek.each do |karakter|
            open = karakter.car.open
            openc = karakter.car.openc
            close = karakter.car.close
            closec = karakter.car.closec
            if str.present?
                if str.include? openc
                    strsplit = str.split(openc) #vágjuk fel a stringet, annyi darabra ahányszor megvan benne
                    strsplit.each_with_index do |st, index| #Nézzük át a tömböt
                        if st.include? "#{closec}"
                            st = openc + st
                            #<>
                            if st.include? "Ł"
                                p openc + closec
                                st = st[/#{openc}(.*?)#{closec}/m, 1]
                                
                            end
                            #{[]}
                            if st.include? "Đ"
                                p openc + closec
                                st = st[/#{openc}(.*?)#{closec}/m, 1]
                                
                            end
                            #[]
                            if st.include? "Ţ"
                                p openc + closec
                                st = st[/#{openc}(.*?)#{closec}/m, 1]
                                
                            end
                            #{}
                            if st.include? "Ŧ"
                                p openc + closec
                                st = st[/#{openc}(.*?)#{closec}/m, 1]
                                
                            
                            end
                            sed = openc + st.to_s + closec
                            numbi = counter(str_origin,sed)        
                            ary << {str: st, nu: numbi, start: open , endre: close}
                        end
                
                    end #Tömb vége
                
                else
                    p "nincs ilyen karakter benne hogy:" + openc 
                end# If
            end
        end #EachDo

        return ary
    end
    
   
    

end
