module CardTypeHelper
  def all_surtypes
    [
      'Creature',
      'Summon',
      'Eaturecray',
      'Legendary Creature',
      'Host Creature',
      'Snow Creature',
      'Scariest Creature You’ll Ever See',
      'Artifact',
      'Legendary Artifact',
      'Tribal Artifact',
      'Snow Artifact',
      'Legendary Artifact Creature',
      'Artifact Creature',
      'Host Artifact Creature',
      'Snow Artifact Creature',
      'Enchantment Creature',
      'Legendary Enchantment Creature',
      'Snow Enchantment',
      'Tribal Enchantment',
      'Legendary Enchantment',
      'Enchantment',
      'World Enchantment',
      'Legendary Snow Enchantment',
      'Tribal Sorcery',
      'Sorcery',
      'Legendary Sorcery',
      'Instant',
      'Tribal Instant',
      'instant',
      'Legendary Planeswalker',
      'Basic Land',
      'Basic Snow Land',
      'Land',
      'Legendary Land',
      'Legendary Snow Land',
      'Snow Land',
      'Creature token',
      'Land Creature',
      'Artifact Land',
      'Legendary Enchantment Artifact'
    ]
  end

  def retrieve_surtype(full_type)
    return '' unless full_type.present?
    if full_type.include?(' — ')
      full_type.split(' — ').first
    else
      full_type
    end
  end

  def retrieve_subtype(full_type)
    return '' unless full_type.present?
    if full_type.include?(' — ')
      full_type.split(' — ').last
    else
      nil
    end
  end
end
