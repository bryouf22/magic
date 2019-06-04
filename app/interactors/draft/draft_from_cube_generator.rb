class Draft::DraftFromCubeGenerator
  include Interactor

  # prendre en compte plusieurs exemplaire de chaque carte (et donc en compte le probabilité de tirage)
  # si le nombre de cartes dans le deck (cube) n'est pas multiple de 15, on affiche les cartes restants

  # 8 players - 3 packs of 15 cards
  # 7 players - 4 packs of 11/12 cards
  # 6 players - 5 packs of 9, or 4 packs of 11/12 cards
  # 5 players - 5 packs of 9
  # 4 players - 6 packs of 7/8


  # appel : Draft::DraftFromCubeGenerator.call(deck_id: 88).tirages
  def call
    cube = []

    deck = Deck.find(context.deck_id)

    deck.card_decks.each do |card_deck|
      (1..card_deck.occurences_in_main_deck).each do
        cube.push(card_deck.card_id)
      end
    end

    tirages = []
    reste   = []

    while cube.length > 14 do
      tirage = cube.sample(15)
      tirage.each do |card_id|
        cube.delete_at(cube.find_index(card_id))
      end
      tirages.push(tirage)
    end
    context.tirages = tirages
    #reste = cube
  end
end
