class Exporter::Importer
  include Interactor

  def call
    User.all.destroy_all
    doc = File.open("#{Rails.root}/export.xml") { |f| Nokogiri::XML(f) }

    doc.xpath('//user').each do |user|
      user_id = create_user(
        email:        user.xpath('@email').to_s,
        password:     user.xpath('@email').to_s,
        created_at:   user.xpath('@created_at').to_s,
        updated_at:   user.xpath('@updated_at').to_s,
        nickname:     user.xpath('@nickname').to_s,
        avatar:       user.xpath('@avatar').to_s,
        presentation: user.xpath('@presentation').to_s
      ).id
      User.find(user_id).update_columns(encrypted_password: user.xpath('@encrypted_password').to_s)
      collection_id = User.find(user_id).card_collection.id
      collection    = user.xpath("./card_collection").first
      collection.xpath('./card').each do |card|
        create_card_list(
          card_id:            retrieve_card_id(card.xpath('@name').to_s, card.xpath('./@set').to_s),
          card_listable_id:   collection_id,
          card_listable_type: 'CardCollection',
          number:             card.xpath('@number').to_s,
          foils_number:       card.xpath('@foils_number').to_s
        )
      end
      user.xpath('./wishlist').each do |wishlist|
        wishlist_id = create_wishlist(user_id: user_id, name: wishlist.xpath('@name').to_s)
        wishlist.xpath('./card').each do |card|
          create_card_list(
            card_id:            retrieve_card_id(card.xpath('@name').to_s, card.xpath('@set').to_s),
            card_listable_id:   wishlist_id,
            card_listable_type: 'Wishlist',
            number:             card.xpath('@number').to_s,
            foils_number:       card.xpath('@foils_number').to_s
          )
        end
      end
      user.xpath('./category').each do |category|
        Category.create(name: category.xpath('@name').to_s, user_id: user_id)
      end
      user.xpath('./deck').each do |deck|
        deck_id = create_deck(
          user_id:      user_id,
          name:         deck.xpath('@name').to_s,
          status:       deck.xpath('@status').to_s,
          is_public:    deck.xpath('@is_public').to_s,
          description:  deck.xpath('@description').to_s,
          category_id:  (deck.xpath('@category').to_s.present? ? retrieve_categroy_id(User.find(user_id), deck.xpath('@category').to_s) : nil)
        ).id
        deck.xpath('./card').each do |card|
          create_deck_card(
            card_id:                  retrieve_card_id(card.xpath('@name').to_s, card.xpath('@set').to_s),
            occurences_in_main_deck:  card.xpath('@occurences_in_main_deck').to_s,
            occurences_in_sideboard:  card.xpath('@occurences_in_sideboard').to_s,
            deck_id:                  deck_id
          )
        end
      end
    end
    finalize_import
  end

  private

  def finalize_import
    Deck.all.each(&:save)
    Format::Validator.call
  end

  def retrieve_categroy_id(user, category_name)
    user.categories.where(name: category_name).first.id
  end

  def create_wishlist(wishlist_data)
    Wishlist.create(wishlist_data)
  end

  def create_card_list(card_list_data)
    CardList.create(card_list_data)
  end

  def create_deck_card(deck_card_data)
    CardDeck.create(deck_card_data)
  end

  def create_user(user_data)
    User.create(user_data)
  end

  def create_deck(deck_data)
    Deck.create(deck_data)
  end

  def retrieve_card_id(name, extension_set_name)
    ExtensionSet.where(name: extension_set_name).first.cards.where(name: name).first.id
  end
end
