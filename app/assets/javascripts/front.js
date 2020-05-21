$(document).ready(function() {
  $('[data-toggle="popover"]').popover({
    html: true,
    placement: 'left',
    trigger: 'hover',
  });

  $('.datepicker').datetimepicker({ format: 'L' } );

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
    $(this).removeClass('js-unactivate-selection-mode').addClass('js-activate-selection-mode').html('mode s¨¦lection');
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
    placeholder: 'Search a card',
     allowClear: true,
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
    $(e).css('background-color', '#5cb85c');
    setTimeout(function(){
      $(e).css('background-color', 'white')
          .find('span').removeClass('glyphicon-ok')
                       .addClass('glyphicon-pencil');
      }, 1000);
  }

  $('.js-edit-collection-number').on('click', function () {
    if ($(this).find('span').hasClass('glyphicon-ok')) {
      closePopover($(this));
    }
    else {
      openPopover($(this));
    }
  });

  $('.js-change-visual').on('click', function (e) {
    e.preventDefault();
    _this = $(this);
    $.ajax({
      type: "GET",
      url: "/reprint-from-" + _this.data('cardId'),
      dataType: 'json',
      success: function (data, textStatus, jqXHR) {
        $.each(data, function (index) {
          cardId = parseInt(Object.keys(data[index])[0]);
          url = data[index][Object.keys(data[index])[0]];
          $('#edit-visual .modal-body ul').append('<li class="js-select-visual print-selection" data-card-id="' + cardId + '"><image class="inline" src="' + url + '"></li>');
        });
        newVisualSelectorListener();
      }
    });
    $('#edit-visual').attr('data-card-id', _this.data('cardId'));
    $('.js-submit-form').attr('disabled', true);
    $('#edit-visual').modal();
  });

  newVisualSelectorListener = function () {
    $('#edit-visual .js-select-visual').unbind();
    $('#edit-visual .js-select-visual').on('click', function () {
      $('.js-select-visual img').removeClass('print-selected');
      $(this).find('img').addClass('print-selected');
      $('#change_visual_initial_card_id').val($('#edit-visual').attr('data-card-id'));
      $('#change_visual_reprint_card_id').val($(this).data('cardId'));
    });
  }

  $(document).on('hidden.bs.modal', '#edit-visual', function () {
    if ($('#change_visual_initial_card_id').val() != "") {
      Rails.fire(document.getElementsByClassName('js-form-change-visual')[0], 'submit');
    }
  });

  $('#edit-visual').on('hidden.bs.modal', function () {
    $('#edit-visual ul').html('');
  });

  $('.new_card_search select').select2({
    placeholder: $(this).attr('placeholder')
  });

  $('#card_search_color_ids').on('change', function () {
    colors = [];
    _this = $(this);

    $.each($('#card_search_color_ids').val(), function (e, i) {
      colors.push(_this.find("option[value='" + $('#card_search_color_ids').val()[e] + "']").text());
    });
    if (colors.length > 0) {
      result = "";
      $.each(colors, function(index, value) {
        if (index == 0) {
          result = value;
        } else {
          if (index == colors.length - 1) {
            result += ' et ' + value;
          } else {
            result += ', ' + value;
          }
        }
      })
      $('.js-restric-label').html(result + ' uniquement');
    } else {
      $('.js-restric-label').html('Incolore uniquement');
    }
  });

  $('.verso').on('click', function () {
    $('.verso').hide();
    $('.recto').show();
  });
  $('.recto').on('click', function () {
    $('.recto').hide();
    $('.verso').show();
  });
  $('.flip').on('click', function () {
    if ($(this).css('transform') == 'none') {
      $('.flip').css('transform', 'rotate(180deg)');
    } else {
      $('.flip').css('transform', 'none');
    }
  });
  const getCellValue = (tr, idx) => tr.children[idx].innerText || tr.children[idx].textContent;

  const comparer = (idx, asc) => (a, b) => ((v1, v2) =>
      v1 !== '' && v2 !== '' && !isNaN(v1) && !isNaN(v2) ? v1 - v2 : v1.toString().localeCompare(v2)
      )(getCellValue(asc ? a : b, idx), getCellValue(asc ? b : a, idx));

  // do the work...
  document.querySelectorAll('th').forEach(th => th.addEventListener('click', (() => {
      const table = th.closest('table');
      Array.from(table.querySelectorAll('tr:nth-child(n+2)'))
          .sort(comparer(Array.from(th.parentNode.children).indexOf(th), this.asc = !this.asc))
          .forEach(tr => table.appendChild(tr) );
  })));
});
