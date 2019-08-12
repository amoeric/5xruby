document.addEventListener('turbolinks:load', () => {
  var navUlDefault = false; 
  $('.nav-list-ul').each(function(){
    var $ul = $(this),
        $lis = $ul.find('li');
    
    var result = {
      init: function(){
        result.setView('show', navUlDefault);
        result.clickEvt();
      },
      clickEvt: function(){
        $ul.on('click', function(){
          var currentShow = $(this).data('show');
          result.setView('show', !currentShow);
        });
      },
      setView: function(key, value){
        $ul.data(key, value);
        result.updateView();
      },
      updateView: function(){
        if($ul.data('show') === true)
          $lis.show();
        else
          $lis.hide();
      }
    }
    result.init();
  })
})