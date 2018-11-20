$(document).ready(function() {
  $('[data-toggle="popover"]').popover({
    html: true,
    trigger: 'hover',
    template: '<div class="popover" role="tooltip"><div class="popover-content"></div></div>',
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

  $('.js-filter-btn').on('click', function() {
    if ($('.filters').attr('class').indexOf('hidden') > -1){
      $('.filters').removeClass('hidden');
    } else {
      $('.filters').addClass('hidden');
    }
  });

  $('.js-select-color-filter').change(function() {
    filterColor = $(this).val();
    regex = RegExp("(?:^|\D)("+filterColor+")(?:$|\D)");
    if (this.checked){
      $('.js-color').each(function(){
        if (regex.test( ($(this).data('colors') || ''))) {
          $(this).removeClass('to-hide-color');
        }
      });
      manageVisibility();
    } else {
      $('.js-color').each(function(){
        if (regex.test(($(this).data('colors') || ''))) {
          $(this).addClass('to-hide-color');
        }
      });
      manageVisibility();
    }
  });

  $('.js-select-rarity-filter').change(function() {
    filterRarity = $(this).val();
    if (this.checked){
      $('.js-rarity').each(function(){
        if ($(this).find('span').attr('class') == filterRarity) {
          $(this).removeClass('to-hide-rarity');
        }
      });
      manageVisibility();
    } else {
      $('.js-rarity').each(function(){
        if ($(this).find('span').attr('class') == filterRarity) {
          $(this).addClass('to-hide-rarity');
        }
      });
      manageVisibility();
    }
  });

  manageVisibility = function () {
    $('.cards-list li').each(function () {
      if ($(this).attr('class').indexOf('hide') > -1) {
        $(this).hide();
        checkbox = $(this).find('input');
        if (checkbox.prop('checked')) {
          checkbox.attr('data-checked', true);
          checkbox.prop('checked', false);
        }
      } else {
        $(this).show();
        checkbox = $(this).find('input');
        if (checkbox.attr('data-checked') == 'true') {
          checkbox.prop('checked', true);
          checkbox.attr('data-checked', false);
        }
      }
    })
  }
});
