import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  connect() {
    console.log("home controller has been connected"); 
    $("p").on("click",function(){
      $(this).hide();
    });
  }
}