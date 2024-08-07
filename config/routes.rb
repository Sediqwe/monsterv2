Rails.application.routes.draw do
  get 'tags', to: "genres#index"
  resources :genres  
  get 'gamerss/index'
  resources :gamereqs
  get 'qc.rss', to: 'gamerss#index', defaults: { format: 'rss' }
  get 'gupdate', to: "games#gupdate"
  get 'qc', to: "forum#index"
  get 'qc/:id', to: 'forum#indexketto', as: 'qct'
  get "backup", to: 'backup#index'
  get "backup_egyszer", to: 'backup#egyszer'
  get "bot_reset", to: "games#bot_reset"
  get "plus_upload", to: "uploads#plus_upload"
  get "minus_upload", to: "uploads#minus_upload"
  get "yttodiscord", to: "games#yttodiscord"
  post "gameforum", to: "games#forum"
  delete "rssdelete", to: "rss#rssdelete"
  get "genreset", to: "games#reset_game_genres"
  post "oldal", to: "games#oldal"
  get "gameforumdelete", to: "games#forumdelete"
  get "gameforumaccept", to: "games#forumaccept"
  get "gamereqsdelete", to: "gamereqs#reqsdelete"
  get "gamereqsaccept", to: "gamereqs#reqsaccept"
  get "gameforumaccept2", to: "games#forumaccept2"
  get "check_username", to: "games#check_username"
  resources :supportlists
  resources :supporters
  resources :uploads
  resources :games
  resources :todos
  resources :forums
  resources :hopps
  resources :autoforditoilists
  resources :projects
  resources :howtos
  resources :changers
  resources :scanners
  resources :cars
  resources :beolvas
  resources :csvs
  resources :databeolvas, to: 'beolvas#soronkent'
  resources :news
  resources :blogs
  resources :programs
  resources :translaters
  resources :platforms
  resources :users
  resources :user2s
  resources :lists
  resources :megas
  root 'games#index'
  get "todo_ok", to: "todos#ok"
  get "todo_nok", to: "todos#nok"
  get "discord", to: "games#discord"
  get 'done_todo', to: 'todos#done'
  post "new_yt", to: "games#new_yt"
  post "edit_yt", to: "games#edit_yt"
  post "delete_yt", to: "games#delete_yt"  
  delete '/pictures/:upload_id/pictures/:image_id', to: 'uploads#picturesdelete', as: 'delete_picture'
  get 'lemondva', to: "lemondva#index"
  get 'lefoglalva', to: "lefoglalva#index"  
  get 'statisztikabot', to: "stat#bot"
  get 'statisztika', to: "stat#sanyi"
  get 'stat/random_data'
  get 'kuki/index'
  get 'kuki/new'
  get 'kuki/create'
  get "bel", to: "games#features"
  get 'facebook', to: "facebook#index"
  get 'rssmagyhu', to: 'rssmagyhu#kan'
  get 'rssmagyhurefresh', to: 'rssmagyhu#index'
  get 'ipadress/index'
  get 'feltoltve', to:  'feltoltve#index'
  get 'supports', to: 'support#index'
  get 'openai/index'
  get 'regexp', to: 'games#regexp'
  get 'magyhu/index'
  get 'magyhu/beolvas'
  get 'search/kereses'
  get 'disqus', to: "disqus#index"
  get 'gmail', to: "gmail#index"
  get "kozelito", to: "beolvas#kozelito"
  get 'reinstall/index'
  get 'reinstall/game_up'
  get "file_process", to: "beolvas#file_process"
  get "file_process_new", to: "beolvas#file_process_new"
  get "igezo", to: "beolvas#igezo"
  get "nyito", to: "beolvas#nyito"
  get "line", to: "beolvas#soronkent"
  get "line_unreal", to: "beolvas#soronkent_unreal"
  get "unreal", to: "beolvas#unreal"
  get "linebyline", to: "beolvas#linebyline"
  post "linebyline_save", to: "beolvas#linebyline_save"
  post "file_download", to: "beolvas#file_download"
  post "revizio", to: "beolvas#revizio"
  post "uzenet", to: "uzenets#uzenet"
  post "muzenet", to: "uzenets#muzenet"
  get "file_download_original", to: "beolvas#file_download_original"
  post "forditas_elmentese", to: "beolvas#translate_save"
  post "forditas_eusave", to: "beolvas#translate_save_eu"
  post "forditas_unreal_save", to: "beolvas#translate_save_unreal"
  post "karakterek_be", to: "beolvas#karakter_save_be"
  post "karakterek_ki", to: "beolvas#karakter_save_ki"
  post "forditas_javitasa", to: "beolvas#igezo_save"
  post "forditas_unreal_javitasa", to: "beolvas#igezo_save_unreal"
  post "tomeges_csere_unreal", to: "beolvas#tomeges_csere_unreal"
  post "file_download_kalap", to: "beolvas#file_download_kalap"
  post "soron_mentes", to: "beolvas#soron_save"
  get "databeolvas_reset", to: "beolvas#databeolvas_reset"
  get "datatranslate_reset", to: "beolvas#datatranslate_reset"
  get "finish", to: "beolvas#finish"
  get "duplikalo", to: "beolvas#duplikalo"
  get "duplikalo_delete", to: "beolvas#duplikalo_delete"
  get "fordsor", to: "beolvas#fordsor"
  post "translateractive", to: "translaters#active"
  post "translaterdeactive", to: "translaters#deactive"
  get "mutasd", to: "beolvas#mutasd"
  get "universal", to: "beolvas#universal"
  post "universal_save", to: "beolvas#universal_save"
  get "delete_uzenet", to:"uzenets#delete_uzenet"
  post "gameforumusermute", to: "games#mute"
  post "gameforumuserunmute", to: "games#unmute"

  get 'lista', to: 'lists#friss'
  get 'mega', to: 'mega#index'
  get 'stat', to: 'stat#index'
  post 'down', to: 'megas#download'
  get 'download_games', to: 'games#download_games'
  get 'check_name', to: 'games#check_name'
  get 'check_steam', to: 'games#check_steam'
  get 'download_file', to: 'games#download_file'
 
  get "user", to: "user2s#index"
  get "recovery", to: "sessions#recovery"
  post "sessions_recovery_mail", to: "sessions#sessions_recovery_mail"
  get "recovery_mail_sent", to: "sessions#recovery_mail_sent"
  get "/recovery_mail", to: "sessions#recovery_mail"
  get "recovery_user", to: "sessions#recovery_user"
  get "new_password_ready", to: "sessions#new_password_ready"
  post 'download', to: "games#download"
  post 'editorka', to: "uploads#editorka"
  post 'lista_editor', to: "lists#editorka"
  post 'megas_editor', to: "megas#editorka"
  post 'upload_bad', to: "uploads#bad"
  post 'games_magyhu', to: "games#magyhu"
  get 'feloldas', to: 'games#feloldas'
  
  get 'rssgemo', to:  'rss#index'
  get 'lemondva', to:  'lemondva#index'
  
  get 'sessions/new'
  get 'sessions/create'
  get 'login/signin', to: 'sessions#new'
  get 'login/signout'
  get 'login/reg'
  get 'tomb', to: 'lists#tomb'
  post 'tomb', to: 'lists#tomb_feldolgozo'
  get 'lists_update', to: 'lists#lista_frissites'

post 'login/create'
post 'sessions/create'
get 'login/create', to: 'login#reg'
get "fbn", to: "projects#fajlok_beolvasasa_normal"
get "project_trans_reset", to: "projects#project_trans_reset"
get "ptf", to: "projects#project_tomeges_forditas"
get "ptfo", to: "projects#project_tomeges_forditas_osszes"
post "project_oszlop", to: "projects#project_oszlop"
post "project_szoveg", to: "projects#project_szoveg"
post "project_elvalaszto", to: "projects#project_elvalaszto"
post "project_mentes", to: "projects#project_forditas_mentes"
post "project_nemvalto", to: "projects#project_nemvalto"
post "project_sorvalto", to: "projects#project_sorvalto"
get "project_file_download_kalap", to: "projects#project_file_download_kalap"
get "project_finish", to: "projects#project_finish"
get "project_line", to: "projects#line"
get "project_lines", to: "projects#lines"
get "project_file_zip", to: "projects#project_file_zip"
post "project_line_javitasa", to: "projects#project_line_save"
get "rendezo", to: "projects#rendezo"
post "project_tomeges_csere", to: "projects#tomeges_csere"
post 'project_download', to: "projects#download"
get 'project_download', to: "projects#download"
post 'project_paros', to: "projects#project_paros"
get "project_idezojel", to: "projects#idezojel"
get "project_nyito", to: "projects#nyito"
post "project_idezo_mentes", to: "projects#idezojel_mentes"
post "project_char_on", to: "projects#char_on"
post "project_char_off", to: "projects#char_off"
post "project_regex", to: "projects#regex"
post "translatertouser", to: "user2s#translatertouser"
get "search", to: "search#kereses"
get "searchmagyhu", to: "search#keresesmagyhu"
get "searchtl", to: "search#keresestl"
get "magyhu", to: "magyhu#beolvas"
get "downloadend", to: "games#downloadend"
get "jakab", to: "games#jakab"
get 'download_ticket/:id', to: 'tickets#download_ticket', as: 'download_ticket'
get 'filem', to: "projects#filem"
post 'lobot', to: "games#lobot"
get "hopper", to: "hopps#hopper"
get "regenerated", to: "translaters#regen"

end


