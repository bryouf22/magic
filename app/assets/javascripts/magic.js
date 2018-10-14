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

  $('body').on('click', '.js-unactivate-selection-mode', function () {
    $('.list-checkbox').addClass('hidden');
    $('.card-link').removeClass('hidden');
    $('.selection-mode').addClass('hidden');
    $(this).removeClass('js-unactivate-selection-mode').addClass('js-activate-selection-mode').html('mode sélection');
  });

  $('body').on('click', '.js-activate-selection-mode', function () {
    $('.list-checkbox.hidden').removeClass('hidden');
    $('.card-link').addClass('hidden');
    $('.selection-mode').removeClass('hidden');
    $(this).removeClass('js-activate-selection-mode').addClass('js-unactivate-selection-mode').html('mode navigation');
  });

  $('.js-select-card').on('change', function () {
    if (this.checked) {
      $('.js-select-count').html(parseInt($('.js-select-count').html()) + 1);
    } else {
      $('.js-select-count').html(parseInt($('.js-select-count').html()) - 1);
    }
  });

  $('body').on('click', '.js-select-all', function () {
    $('.cards-list .js-select-card:not(.hidden)').prop('checked', 'cheched');
  });

  $('body').on('click', '.js-unselect-all', function () {
    $('.cards-list .js-select-card:not(.hidden)').prop('checked', false);
  });
});
