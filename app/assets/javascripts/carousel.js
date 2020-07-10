$( document ).on('turbolinks:load',function(){
    $('.owl-carousel').owlCarousel({
        loop:true,
        margin:10,
        nav:true,
        responsive:{
            0:{
                items:1
            },
            600:{
                items:2
            },
            1000:{
                items:3
            }
        }
    })
    $( ".owl-prev").html('<i class="fa fa-angle-left fa-3x"></i>');
    $( ".owl-next").html('<i class="fa fa-angle-right fa-3x"></i>');
  });