class Exporter::ExportUsers
  include Interactor

  def call
    export_path = context.export_path.presence || "#{Rails.root}/export.xml"
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.root {
        User.find_each do |user|
          xml.user(email: user.email, encrypted_password: user.encrypted_password, reset_password_token: user.reset_password_token, reset_password_sent_at: user.reset_password_sent_at, remember_created_at: user.remember_created_at, created_at: user.created_at, updated_at: user.updated_at, nickname: user.nickname, avatar: user.avatar, presentation: user.presentation) {
              xml.card_collection {
                user.card_collection.card_lists.each do |card_list|
                  xml.card(name: card_list.card.name, set: card_list.card.extension_set.name, number: card_list.number, foils_number: card_list.foils_number)
                end
              }
              user.wishlists.each do |wishlist|
                xml.wishlist(name: wishlist.name) {
                  wishlist.card_lists.each do |card_list|
                    xml.card(name: card_list.card.name, set: card_list.card.extension_set.name, number: card_list.number, foils_number: card_list.foils_number)
                  end
                }
              end
              user.categories.each do |category|
                xml.category(name: category.name)
              end
              user.decks.each do |deck|
                xml.deck(name: deck.name, status: deck.status, is_public: deck.is_public?, description: deck.description, category: deck.category&.name) {
                  deck.card_decks.each do |card_deck|
                    xml.card(name: card_deck.card.name, set: card_deck.card.extension_set.name, occurences_in_main_deck: card_deck.occurences_in_main_deck, occurences_in_sideboard: card_deck.occurences_in_sideboard)
                  end
                }
              end
          }
        end
      }
    end
    File.open(export_path, 'w+') do |file|
      file.write builder.to_xml
    end
  end
end
