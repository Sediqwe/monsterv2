$(document).on('ready', function() {
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
      $('a[id^="letoltes_gomb"]').on('click', function(){
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
 