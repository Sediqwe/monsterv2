$(document).on('turbo:load', function() {
  let uzenetKuldesFolyamatban = false;
  $('#uploadtranslaters_').on('click', function () {
    $("#upika").removeAttr("hidden");
});

  $('.delete-image').on('click', function() {
    var uploadId = $(this).data('upload-id');
    var imageId = $(this).data('image-id');
    if (confirm('Biztosan törölni szeretnéd ezt a képet?')) {
      $.ajax({
        url: '/pictures/' +uploadId + '/pictures/' + imageId, // Az endpoint, ahol a kép törlését kezelik a szerveren
        method: 'DELETE',
        success: function(response) {
          // Sikeres törlés esetén a kép eltűntetése a felületről
          $('img[data-image-id="' + imageId + '"]').hide(); // vagy $(this).remove(); attól függően, hogyan szeretnéd eltávolítani          
        },
        error: function(error) {
          alert('Hiba történt a kép törlése közben.');
          console.error(error);
        }
      });
    }
  });

  $('#username').on('keyup', function() {
    var username = $(this).val().trim();
    // AJAX kérés küldése a szervernek
    $.ajax({
      type: 'GET',
      url: '/check_username', // A szerveroldali útvonal
      data: { username: username }, // Az adatok elküldése a szervernek
      success: function(response) {
        if (response.exists) {
          $("#username").removeClass();
          $("#username").addClass(' col-12 bg-danger font-white ');
        } else {
          $("#username").removeClass("bg-danger");
          
        }
      },
      error: function(xhr, status, error) {
        
      }
  });
});

  $('#forumsubmit').on('click', function () {
    var id = $('#forumsubmit').data('id');
    var dumaData = $('#duma_'+ id).val(); // Az input mezőből származó adatok
    var username = $('#username').val(); 
    var azon = $('#azon').val(); 
    
    if(dumaData.length > 5 && username.length >0){
      $.ajax({
        type: 'GET',
        url: '/check_username', // A szerveroldali útvonal
        data: { username: username }, // Az adatok elküldése a szervernek
        success: function(response) {
          if (response.exists) {
            $("#username").removeClass();
            $("#username").addClass(' col-12 bg-danger font-white ');
          } else {
            $("#username").removeClass("bg-danger");
            $.ajax({
              type: 'POST',
              url: '/gameforum', // A szerveroldali útvonal
              data: { duma: dumaData, id: id, username: username, azon: azon }, // Az adatok elküldése a szervernek
              success: function(response) {
                uzenetKuldesFolyamatban = false;
                window.location.href = window.location.href; 
                
              },
              error: function(xhr, status, error) {
                  // Hibakezelés
              }
          });
          }
        },
        error: function(xhr, status, error) {
          
        }
    });


    
  }
  else{
    alert("Legalább 5 karakterben fogalmazd meg az üzeneted, és a felhasználói neved legyen kitöltve!");
  }
  });

  $('#forumsubmit2').on('click', function (event) {
    if (uzenetKuldesFolyamatban) {
      return; // Ha már folyamatban van kérés, ne csinálj semmit
  }
  event.preventDefault(); 
  uzenetKuldesFolyamatban = true;
  $(this).prop('disabled', true); 
    var id = $('#forumsubmit2').data('id');
    var dumaData = $('#duma_'+ id).val(); // Az input mezőből származó adatok
    var username = $('#username').val(); 
    var azon = $('#azon').val(); 
    alert(azon);
    if(dumaData.length > 5 && username.length >0){
      $.ajax({
        type: 'GET',
        url: '/check_username', // A szerveroldali útvonal
        data: { username: username }, // Az adatok elküldése a szervernek
        success: function(response) {
          if (response.exists) {
            $("#username").removeClass();
            $("#username").addClass(' col-12 bg-danger font-white ');
          } else {
            $("#username").removeClass("bg-danger");
            $.ajax({
              type: 'POST',
              url: '/gamereqs', // A szerveroldali útvonal
              data: { duma: dumaData, id: id, username: username, azon: azon }, // Az adatok elküldése a szervernek
              success: function(response) {
                uzenetKuldesFolyamatban = false;
                window.location.href = window.location.href; 
                
              },
              error: function(xhr, status, error) {
                  // Hibakezelés
              }
          });
          }
        },
        error: function(xhr, status, error) {
          
        }
    });


    
  }
  else{
    alert("Legalább 5 karakterben fogalmazd meg az üzeneted, és a felhasználói neved legyen kitöltve!");
  }
  });

  $('#new_yt').on('click', function () {
    var adat = $('#ytvideo').val();
    var id = $(this).data('id');
    if (adat.includes('watch')) {
      $.ajax({
        url: "/new_yt",
        type: "POST",
        data: { product: {done: adat, id: id } },
        success: function(data) {
        location.reload(); 
        },
        error: function(data) {
          // alert("ERROR" + data.valami);

        }
      })}
    else
    {
      alert("Nem jó a formátum!")
    }
  });

  
  $('[id^=delete_yt_').on('click', function () {
      var id = $(this).data('id');
      $.ajax({
        url: "/delete_yt",
        type: "POST",
        data: { product: {id: id, done: "Adat" } },
        success: function(data) {
        location.reload(); 
        },
        error: function(data) {
        }
      })
    
  });
  $('[id^=edit_').on('click', function () {
    
    var id = $(this).data('id');
    var adat = $('#edit_'+ id).val();
    
    if (adat.includes('watch')) {
      $.ajax({
        url: "/edit_yt",
        type: "POST",
        data: { product: {done: adat, id: id } },
        success: function(data) {
        location.reload(); 
        },
        error: function(data) {
          // alert("ERROR" + data.valami);

        }
      })}
    else
    {
      alert("Nem jó a formátum!")
    }
  });

  $('#modal').on('click', function () {
    var modal = $('#banModal');
// Megjeleníti a modalt
    modal.modal('show');
  }); 
  $('#letoltesvege').on('click', function(){
    $("#koszi").html('A letöltés előkészítése folyamatban, nagyobb fájl esetén kicsit várni kell az elindulásra!').show()
    $(this).hide('3000');
  }); 
    $('#sidebarCollapse').on('click', function() {
        $('#sidebar, #content').toggleClass('active');
      });
    	$('.card').delay(1800).queue(function(next) {
        $(this).removeClass('hover');
        $('a.hover').removeClass('hover');
        next();
      });
      $('#lobot').on('click', function(){
        var adat = $('#pityu').val();
        $.ajax({
          url: "/lobot",
          type: "POST",
          data: { product: {id: adat } },
          success: function(data) {
            if(data.info == "ok")
            {
              window.location.href = window.location.href + "&keyword=" + adat ; 
            }
          },
          error: function(data) {
            // alert("ERROR" + data.valami);

          }
        })

      }); 
      $('select[id^="translater_"]').on('click', function(){
        var adat = $(this).val();
        var id = $(this).attr('id').replace('translater_','');
        if(adat>0){
           $.ajax({
          url: "/translatertouser",
          type: "POST",
          data: { product: { id: id, data: adat} },
          success: function(data) {
            $('.aljas').removeClass('bg-primary');
            $('.aljas').addClass(' bg-success ');
          },
          error: function(data) {
            // alert("ERROR" + data.valami);

          }
        })
        }
      }); 
      $('select[id^="edit_"]').on('click', function(){
        var adat = $(this).val();
        var id = $(this).attr('id').replace('edit_','');
        if(adat>0){
           $.ajax({
          url: "/editorka",
          type: "POST",
          data: { product: { id: id, adat: adat} },
          success: function(data) {
            $('tr#'+ id).removeClass('bg-primary');
            $('tr#' + id).addClass(' bg-success ');
          },
          error: function(data) {
            // alert("ERROR" + data.valami);

          }
        })
        }
      }); 
      $('select[id^="lista_"]').on('click', function(){
        var adat = $(this).val();
        var id = $(this).attr('id').replace('lista_','');
        if(adat>0){
           $.ajax({
          url: "/lista_editor",
          type: "POST",
          data: { product: { id: id, adat: adat} },
          success: function(data) {
            $('tr#'+ id).removeClass('bg-primary');
            $('tr#' + id).addClass(' bg-success ');
          },
          error: function(data) {
            // alert("ERROR" + data.valami);

          }
        })
        }
      });
      $('[id^="nyito_"]').on('click', function(){
        var karakter = "/karakterek_ki";
        var szin = " bg-dark ";
        if($(this).prop("checked") == true){
          karakter = "/karakterek_be";
          szin = " bg-success "
        }
          
        var adat = $(this).val();
        var id = $(this).attr('id').replace('nyito_','');
        if(adat>0){
           $.ajax({
          url: karakter,
          type: "POST",
          data: { product: { id: id, adat: adat} },
          success: function(data) {
             $("tr#boss_"+ id).removeClass();
             $("tr#boss_"+ id).addClass(szin);
          },
          error: function(data) {
            // alert("ERROR" + data.valami);

          }
        })
        }
      });  
      $('select[id^="megalista_"]').on('click', function(){
        var adat = $(this).val();
        var id = $(this).attr('id').replace('megalista_','');
        if(adat>0){
           $.ajax({
          url: "/megas_editor",
          type: "POST",
          data: { product: { id: id, adat: adat} },
          success: function(data) {
            $('tr#'+ id).removeClass('bg-primary');
            $('tr#' + id).addClass(' bg-success ');
          },
          error: function(data) {
            // alert("ERROR" + data.valami);

          }
        })
        }
      });
      $("#universal").on('click', function(){
        
        let id = $(this).attr('name')
        let elvalaszto = $("#elvalaszto").val()
        window.location.href = '/universal?id=' + id + "&elvalaszto=" + elvalaszto;
      });

      
      $("#kereso_gomb_mutasd").on('click', function(){
        
        let id = $(this).attr('name')
        let keresd = $("#keresd").val()
        let sor = $("#sor").val()
        window.location.href = '/mutasd?id=' + id + "&keresd=" + keresd + "&sor=" + sor;
      });
      $('button#universal_beolvas').on('click', function(){
        
        let id = $(this).attr('data-id')
        let elvalaszto = $(this).attr('data-elvalaszto')
        let adat = $("#textarea_").val()
        if(adat.length>0){
          $.ajax({
                url: "/universal_save",
                type: "POST",
                data: { universal: {id: id, adat: adat, elvalaszto: elvalaszto} },
                success: function(data) {  
                  $('textarea#textarea_').removeClass().addClass('bg-success text-light');
                },
                error: function(data) {  
                  $('textarea#textarea_').removeClass().addClass('bg-danger'); 
                }
                })
        }
      });
      $('button#uzenet').on('click', function(){
        
        let id = $(this).attr('name')
        let adat = $('textarea#uzenet').val()
          $.ajax({
                url: "/uzenet",
                type: "POST",
                data: { product: { game_id: id, desc: adat} },
                success: function(data) { 
                  location.reload(); 
                  
                },
                error: function(data) {  
                  
                }
                })
        
      });

      $('div[id^="filesavekalap_"]').on('click', function(){
        
        let id = $(this).attr('name')
        let adat = $('input#savesize_'+ id).val()
        
          $.ajax({
                url: "/file_download_kalap",
                type: "POST",
                data: { product: { id: id, adat: adat} },
                success: function(data) {  
                  $('input#trans_'+ id).removeClass().addClass('form-control bg-success text-light');
                },
                error: function(data) {  
                  $('input#trans_'+ id).removeClass().addClass('bg-danger text-light form-control');
                }
                })
        
      });
      
      $('div[id^="filesave_"]').on('click', function(){
        
        let id = $(this).attr('name')
        let adat = $('input#savesize_'+ id).val()
        
          $.ajax({
                url: "/file_download",
                type: "POST",
                data: { product: { id: id, adat: adat} },
                success: function(data) {  
                  $('input#trans_'+ id).removeClass().addClass('form-control bg-success text-light');
                },
                error: function(data) {  
                  $('input#trans_'+ id).removeClass().addClass('bg-danger text-light form-control');
                }
                })
        
      });
      $('button[id^="beolvas_unreal"]').on('click', function(){
        let id = $(this).attr('name')
        let csv_id = $(this).attr('data-id')
        id = id.replace('beolvas"','');
        var adat = $("#textarea_"+ id).val();
        if(adat.length>0){
          $.ajax({
                url: "/forditas_unreal_save",
                type: "POST",
                data: { product: { id: csv_id, adat: adat} },
                success: function(data) {  
                  $('textarea#textarea_'+ id).removeClass().addClass('bg-success text-light');
                },
                error: function(data) {  
                  $('textarea#textarea_'+ id).removeClass().addClass('bg-danger'); 
                }
                })
        }
      });
      $('button[id^="readeu_"]').on('click', function(){
        let id = $(this).attr('name')
        let csv_id = $(this).attr('data-id')
        id = id.replace('beolvas"','');
        var adat = $("#textarea_"+ id).val();
        if(adat.length>0){
          $.ajax({
                url: "/forditas_eusave",
                type: "POST",
                data: { product: { id: csv_id, adat: adat} },
                success: function(data) {  
                  $('textarea#textarea_'+ id).removeClass().addClass('bg-success text-light');
                },
                error: function(data) {  
                  $('textarea#textarea_'+ id).removeClass().addClass('bg-danger'); 
                }
                })
        }
      }); 
      $('button[id^="beolvas_csv_"]').on('click', function(){
        let id = $(this).attr('name')
        let csv_id = $(this).attr('data-id')
        id = id.replace('beolvas"','');
        var adat = $("#textarea_"+ id).val();
        if(adat.length>0){
          $.ajax({
                url: "/forditas_elmentese",
                type: "POST",
                data: { product: { id: csv_id, adat: adat} },
                success: function(data) {  
                  $('textarea#textarea_'+ id).removeClass().addClass('bg-success text-light');
                },
                error: function(data) {  
                  $('textarea#textarea_'+ id).removeClass().addClass('bg-danger'); 
                }
                })
        }
      });
      $('div[id^="csereld_"]').on('click', function(){
        let id = $(this).attr('name')
        let adat1 = $('#mit_'+ id).val()
        let adat2 = $('#mire_'+ id).val()
        if(adat1.length>0){
          $.ajax({
                url: "/tomeges_csere_unreal",
                type: "POST",
                data: { product: { id: id, adat: adat1, file: adat2} },
                success: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('form-control bg-success text-light');
                },
                error: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('bg-danger text-light form-control');
                }
                })
        }
      }); 
      $('div[id^="igezo_"]').on('click', function(){
        
        let id = $(this).attr('name')
        let adat = $('#trans_'+ id).val()
        if(adat.length>0){
          $.ajax({
                url: "/forditas_javitasa",
                type: "POST",
                data: { product: { id: id, adat: adat} },
                success: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('form-control bg-success text-light');
                },
                error: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('bg-danger text-light form-control');
                }
                })
        }
      });
      $('div[id^="project_line_save_"]').on('click', function(){
        
        let id = $(this).attr('name')
        let adat = $('#trans_'+ id).val()
        if(adat.length>0){
          $.ajax({
                url: "/project_line_javitasa",
                type: "POST",
                data: { product: { id: id, data: adat} },
                success: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('form-control bg-success text-light');
                },
                error: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('bg-danger text-light form-control');
                }
                })
        }
      });
      $('div[id^="igezounreal_"]').on('click', function(){
        
        let id = $(this).attr('name')
        let adat = $('#trans_'+ id).val()
        if(adat.length>0){
          $.ajax({
                url: "/forditas_unreal_javitasa",
                type: "POST",
                data: { product: { id: id, adat: adat} },
                success: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('form-control bg-success text-light');
                },
                error: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('bg-danger text-light form-control');
                }
                })
        }
      }); 
      $('div[id^="soron_"]').on('click', function(){
        
        let id = $(this).attr('name')
        let adat = $('#trans_'+ id).val()
        if(adat.length>0){
          $.ajax({
                url: "/soron_mentes",
                type: "POST",
                data: { product: { id: id, adat: adat} },
                success: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('form-control bg-success text-light');
                },
                error: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('bg-danger text-light form-control');
                }
                })
        }
      });
      $('div#reply').on('click', function(){
        let id = $(this).attr('data-id');
        let allapot = $('div#reply_' + id).attr('data-show');
        
        if(allapot == "ok"){
          $('div#reply_' + id).show("slow");
          $('div#reply_' + id).attr('data-show', 'nok');
          
        }
        else{
          $('div#reply_' + id).hide("slow");
          $('div#reply_' + id).attr('data-show', 'ok');
        }
        
        
      });
      $('div#felold').on('click', function(){
        let id = $(this).attr('name');
        let adat = $('#lemondom').val();
        
        $.ajax({
              url: "/feloldas",
              type: "GET",
              data: { id: id, adat: adat},
              success: function(data) {  
                window.location.href = 'https://gep.monster';
              },
              error: function(data) {  
                window.location.href = 'https://gep.monster';
              }
              })
        
      });
      $('div#revizio').on('click', function(){
        let id = $(this).attr('name');
        let adat = "GotrabiGO";
        $.ajax({
              url: "/revizio",
              type: "POST",
              data: { product: { id: id, adat: adat} },
              success: function(data) {  
                $('#trans_'+ id).removeClass().addClass('form-control bg-success text-light');
              },
              error: function(data) {  
                $('#trans_'+ id).removeClass().addClass('bg-danger text-light form-control');
              }
              })
        
      });
      $('div[id^="linebyline"]').on('click', function(){
        
        let id = $(this).attr('name')
        let adat = $('#trans_'+ id).val()
        if(adat.length>0){
          $.ajax({
                url: "/linebyline_save",
                type: "POST",
                data: { product: { id: id, adat: adat} },
                success: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('form-control bg-success text-light');
                },
                error: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('bg-danger text-light form-control');
                }
                })
        }
      });
      $('[id^="ikon_"]').on('click', function(){
         let id = $(this).attr('id').replace("ikon_", "")
          $('#kepModal_' + id).modal('show'); // Amikor az egeret az ikonra viszed, a modális ablak megjelenik.
        
      });

    
      $('#game_name').on('change', function() {
        var gameName = $(this).val().trim();
        if (gameName) {
          $.ajax({
            url: '/check_name', // Az elérési út a nevellenőrzéshez
            method: 'GET',
            data: { name: gameName },
            success: function(response) {
              if (response.exists) {
                alert('Ez a játék már létezik!');
              }
            }
          });
        }
      });
      
      $('#game_link_steam').on('change', function() {
        var gameName = $(this).val().trim();
        if (gameName) {
          $.ajax({
            url: '/check_steam', // Az elérési út a nevellenőrzéshez
            method: 'GET',
            data: { name: gameName },
            success: function(response) {
              if (response.exists) {
                alert('Ez a játék már létezik!');
              }
            }
          });
        }
      });
      $(".elrejt").hide();
      $("#mutat").on('click', function(){
        $(".elrejt").show();
        $("#mutat").hide();
        $("#mutat2").hide();
      });
      $('a[id^="letoltes_gomb"]').on('click', function(){
        $('a[id^="letoltes_gomb"]').hide();
        var adat = $(this).attr('datagame');
        var done = $(this).attr('done');
        $.ajax({
          url: "/download",
          type: "POST",
          data: { product: { id: adat, done: done} },
          success: function(data) {
            //  alert("OK" + data.valami);
          },
          error: function(data) {
            // alert("ERROR" + data.valami);

          }
        })
      });
     
});
 