$(document).ready(function() {
  $('[data-toggle="popover"]').popover({
    html: true,
    trigger: 'hover',
    template: '<div class="popover" role="tooltip"><div class="popover-content"></div></div>'
  });

  $('.datepicker').datepicker();

  $('#menu-card-search input').on('keypress', function (e) {
    if (e.which == 13) {
      $('#menu-card-search').submit();
      return false;
    }
  });
});
