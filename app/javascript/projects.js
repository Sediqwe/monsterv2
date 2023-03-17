$(document).on('ready', function() { 
  
    $('#project_oszlop').on('click', function(){
        var id = $(this).attr('data-id');
        var adat = $("#oszlop").val();
        $.ajax({
          url: "/project_oszlop",
          type: "POST",
          data: { product: { id: id, data: adat} },
          success: function(data) {
            $('#hatalmas_').val(data.valami);
            },
          error: function(data) {
            }
        })
      });
      $('[id^="project_regex"]').on('click', function(){
        var id = $(this).attr('data-id');
        var indito = $('#start').val();
        var vege = $('#end').val();
        $.ajax({
          url: "/project_regex",
          type: "POST",
          data: { product: { id: id, data: indito, file: vege} },
          success: function(data) {
            $('div#regex').html(data.valami); 
             },
          error: function(data) {
            $('div#regex').html(data.valami); 
            }
        })
      }); 
      //Szöveg keresés a DATA-ban
      $('[id^="project_szoveg"]').on('click', function(){
        var id = $(this).attr('data-id');
        var adat = $('#text_').val();
        $.ajax({
          url: "/project_szoveg",
          type: "POST",
          data: { product: { id: id, data: adat} },
          success: function(data) {
            $('#hatalmas_').val(data.valami);
            
             },
          error: function(data) {
            }
        })
      }); 
      //Elválasztó beadása
      $('[id^="project_elvalaszto"]').on('click', function(){
        $(".rejtett").css("visibility", "visible");
        var id = $(this).attr('data-id');
        var data = $("#elvalaszto_").val();
        
        $.ajax({
          url: "/project_elvalaszto",
          type: "POST",
          data: { product:{ id: id, data: data} },
          success: function(data) {
            $('#hatalmas_').val(data.valami);
            },
          error: function(data) {
            }
        })
      });
      $('[id^="project_sorvalto"]').on('click', function(){
        let data = $("#sorvalto").val();
        $.ajax({
          url: "/project_sorvalto",
          type: "POST",
          data: { product: { data: data} },
          success: function(data) {
            $('#hatalmas_').val(data.valami);
             },
          error: function(data) {
            }
        })
      }); 
      $('[id^="project_nemvalto"]').on('click', function(){
        var id = $(this).attr('data-id');
        let data = $("#nemvalto").val();
        $.ajax({
          url: "/project_nemvalto",
          type: "POST",
          data: { product: {id: id, data: data} },
          success: function(data) {
            $('#hatalmas_').val(data.valami);
             },
          error: function(data) {
            }
        })
      });
      $('div[id^="project_idezo_mentes_"]').on('click', function(){
        
        let id = $(this).attr('name')
        let adat = $('#trans_'+ id).val()
        
          $.ajax({
                url: "/project_idezo_mentes",
                type: "POST",
                data: { product: { id: id, data: adat} },
                success: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('form-control bg-success text-light');
                },
                error: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('bg-danger text-light form-control');
                }
                })
        
      });
      $('div[id^="project_idezo_mentes_2_"]').on('click', function(){
        
        let id = $(this).attr('name')
        let adat = $('#trans_2_'+ id).val()
        
          $.ajax({
                url: "/project_idezo_mentes",
                type: "POST",
                data: { product: { id: id, data: adat} },
                success: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('form-control bg-success text-light');
                },
                error: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('bg-danger text-light form-control');
                }
                })
        
      });
      $('[id^="project_nyito_"]').on('click', function(){
        var karakter = "/project_char_off";
        var szin = " bg-dark ";
        if($(this).prop("checked") == true){
          karakter = "/project_char_on";
          szin = " bg-success "
        }
        var adat = $(this).val();
        var id = $(this).attr('id').replace('project_nyito_','');
        if(adat>0){
           $.ajax({
          url: karakter,
          type: "POST",
          data: { product: { id: id, data: adat} },
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
      //Fordítás mentése
      $('[id^="project_mentes"]').on('click', function(){
        var id = $(this).attr('data-id');
        var adat = $('#textarea_').val();
        $.ajax({
          url: "/project_mentes",
          type: "POST",
          data: { product: { id: id, data: adat} },
          success: function(data) {
            $('#textarea_').removeClass();
            $('#textarea_').addClass("bg-success");
            $('#textarea_').val("");
             },
          error: function(data) {
            $('#textarea_').removeClass();
            $('#textarea_').addClass("bg-danger");
            }
        })
      }); 
      $('div[id^="project_file_download_kalap"]').on('click', function(){
        
        let id = $(this).attr('name');
        let name = $(this).attr('data-name');
        let adat = $('input#savesize_'+ id).val();
        
          $.ajax({
                url: "/project_file_download_kalap",
                type: "POST",
                data: { product: { id: id, adat: adat, name: name} },
                success: function(data) {  
                  alert(data);
                  },
                error: function(data) {  
                  
                }
                })
        
      });
      $('#project_paros').on('click', function(){
        let adat = $('select#Paros').val();
        
        let id = $(this).attr('name');
        
          $.ajax({
                url: "/project_paros",
                type: "POST",
                data: { product: { id: id, data: adat} },
                success: function(data) {  
                  },
                error: function(data) {  
                  
                }
                })
        
      });
      $('#project_tomeges_csere').on('click', function(){
        let id = $(this).attr('name');
        let adat1 = $('#mit').val();
        let adat2 = $('#mire').val();
        if(adat1.length>0){
          $.ajax({
                url: "/project_tomeges_csere",
                type: "POST",
                data: { product: { id: id, data: adat1, file: adat2} },
                success: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('form-control bg-success text-light');
                },
                error: function(data) {  
                  $('#trans_'+ id).removeClass().addClass('bg-danger text-light form-control');
                }
                })
            }
        
            });
              
        


})