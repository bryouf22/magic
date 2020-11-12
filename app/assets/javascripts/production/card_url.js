$(document).ready(function() {
  $('#card_card_type').on('change', function () {
    if ($(this).val() == 'Eaturecray' || $(this).val().indexOf('Creature') > -1) {
      if ($('.js-powerdef').attr('class').indexOf('hidden') > -1) $('.js-powerdef').removeClass('hidden');
    } else {
      if ($('.js-powerdef').attr('class').indexOf('hidden') == -1) $('.js-powerdef').addClass('hidden');
    }
    if ($(this).val() == 'Legendary Planeswalker') {
      if ($('.js-loyalty').attr('class').indexOf('hidden') > -1) $('.js-loyalty').removeClass('hidden');
    } else {
      if ($('.js-loyalty').attr('class').indexOf('hidden') == -1) $('.js-loyalty').addClass('hidden');
    }
  });

  $('.js-retrieve-card-data').on('click', function () {
    $.ajax({
      method: "GET",
      url: "/admin/retrieve_data",
      dataType: 'json',
      data: { url: $('#card_url').val() },
      success: function(response) {
        $('#card_name').val(response['name'])
        $('#card_text').html(response['text'])
        $('#card_flavor_text').html(response['flavor_text'])
        $('#card_artist_name').val(response['artist_name'])
        $('#card_number_in_set').val(response['number_in_set'])
        $('#card_gatherer_id').val(response['gatherer_id'])
        $('#card_rarity').val(response['rarity'])
        $('#card_power_str').val(response['power_str'])
        $('#card_defense_str').val(response['defense_str'])
        $('#card_loyalty').val(response['loyalty'])

        // $('#extension-set-id').val(response['set_name'])

        $('.js-card-image img').attr('src', response['image_url']);
        $('.js-card-image-url').attr('value', response['image_url']);
        $('.js-card-image').removeClass('hidden');
        $('#card_image').addClass('hidden');

        if (response['color_indicator'] != null) {
          $('#card_color_indicator').val(response['color_indicator']);
        } else {
          $('#card_color_indicator').val("");
        }
        setManaCost(response['mana_cost']);
        setType(response['detailed_type']);
      }
    })
  });

  setType = function(detailedType) {
    $('#card_detailed_type').val(detailedType)
    type = detailedType.split(' — ');

    $.each($('#card_card_type option'), function (i, option) {
      if ($(option).attr('value') == type[0]) {
        $('#card_card_type').val(type[0]);
        $('#card_card_type').trigger('change');
      }
    });
    if (type.length > 1) {
      $('#card_subtypes').val(type[1]);
    }
  }

  setManaCost = function(manaCost) {
    if(manaCost == '') return '' ;
    $('#card_mana_cost').val(manaCost);
    $.each(manaCost.split('').join('#').replace('S#n#o#w', 'Snow').split("#"), function (i, value) {
      $.each($('.js-mana-panel div'), function(i, e) {
        if ($(e).data('mana') == value) {
          $('.js-mana-cost').append($(e).clone());
        }
      });
    })
  }

  $('.js-choose-mana-cost').on('click', function () {
    manaPanel = $('.js-mana-panel');
    if (manaPanel.attr('class').indexOf('hidden') > -1) {
      manaPanel.removeClass('hidden');
    } else {
      manaPanel.addClass('hidden');
    }
  })

  $('.js-mana-panel div').on('click', function () {
    color = $(this).attr('data-mana');
    $('.js-mana-cost').append($(this).clone());
    selectedColors = $('#card_mana_cost').val();
    selectedColors = selectedColors + color;
    $('#card_mana_cost').val(selectedColors);
  })
});
