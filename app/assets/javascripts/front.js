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

  $('body').on('click', '.js-unactivate-selection-mode', function (e) {
    e.preventDefault();
    $('.list-checkbox').addClass('hidden');
    $('.card-link').removeClass('hidden');
    $('.selection-mode').addClass('hidden');
    $(this).removeClass('js-unactivate-selection-mode').addClass('js-activate-selection-mode').html('mode sélection');
  });

  $('body').on('click', '.js-activate-selection-mode', function (e) {
    e.preventDefault();
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

  $('body').on('click', '.js-select-all', function (e) {
    e.preventDefault();
    $('.cards-list li:visible .js-select-card').prop('checked', 'cheched');
  });

  $('body').on('click', '.js-unselect-all', function (e) {
    e.preventDefault();
    $('.cards-list li:visible .js-select-card').prop('checked', false);
  });

  $('body').on('click', '.js-inverse-selection', function (e) {
    e.preventDefault();
    $('.cards-list li:visible .js-select-card').each(function (index) {
      if (this.checked) {
        $(this).prop('checked', false);
      } else {
        $(this).prop('checked', 'cheched');
      }
    });
  });

  $('.js-filter-btn').on('click', function(e) {
    e.preventDefault();
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

  $('#card-search').select2({
    multiple: true,
    ajax: {
    url: '/rechercher',
    dataType: 'json',
    data: function (params) {
      var query = {
        "card_search[term]" : params.term,
        type: 'public'
      }
      return query;
    },
    processResults: function (data, params) {
      return {
        results: data,
      };
    },
  }
  });

  $('#extension-set-search').select2({
    multiple: true,
    ajax: {
      url: '/rechercher-set',
      dataType: 'json',
      data: function (params) {
        var query = {
          "extension_set_search[term]" : params.term,
          type: 'public'
        }
        return query;
      },
      processResults: function (data, params) {
        return {
          results: data,
        };
      },
    }
  })

  openPopover = function (element) {
          $(element).popover({
          content: '<div class="popover-collection">\
                      <input type="number" value="' + $(element).data('occurrence') + '">\
                    </div>',
          html: true,
          trigger: 'manual',
        }).popover('show');
        $(element).find('span').removeClass('glyphicon-pencil')
                               .addClass('glyphicon-ok');
  }
  closePopover = function (element) {
    occurrence = $(element).next().find('input').val();
    $(element).popover('destroy');
    $(element).find('span').removeClass('glyphicon-ok')
                           .addClass('glyphicon-pencil');
    $.ajax({
      type: "POST",
      url: "ma-collection/ajout-occurrence/",
      data: {
        occurrence: occurrence,
        card_id: $(element).data('card-id'),
      },
      dataType: 'json',
      success: updateOccurrence(element, occurrence)
    });
  }

  updateOccurrence = function (e, occurrence) {
    $(e).data('occurrence', occurrence);
  }

  $('.js-edit-collection-number').on('click', function () {
    if ($(this).find('span').hasClass('glyphicon-ok')) {
      closePopover($(this));
    }
    else {
      openPopover($(this));
    }
  });


  $( "#sortable" ).sortable({
    items: ".bloc-row",
    cursor: "move",
    axis: "y",
    update: function() {
      $.post($(this).data('update-url'), $(this).sortable('serialize'));
    }
  }).disableSelection();
});
