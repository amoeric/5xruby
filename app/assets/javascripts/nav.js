document.addEventListener('turbolinks:load', () => {
  var check = 1;
  $('ul').hover(function(){
    if (check == 0){
      $("li").css("display", "none");
      check++;
    }
  })
  $('ul').on('click',function(){
    if (check == 0){
      $("li").css("display", "none");
      check++;
    }else{
      $("li").css("display", "block");
      check--;
    }
  })
})