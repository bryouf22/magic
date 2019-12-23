class Exporter::ExtensionSetsImporter
  include Interactor

  def call
    # TODO
    # Date.new(2017,1,20) == ExtensionSet.first.release_date.to_date
    doc = File.open("#{Rails.root}/export_sets.xml") { |f| Nokogiri::XML(f) }

    doc.xpath('//set').each do |set_node|
      set = ExtensionSet.where(name: set_node.attribute('name').value).first
      date = set_node.attribute('release_date').value
      year = set_node.attribute('release_date').value.match(/(\d{4})-(\d{2})-(\d{2})/)[1]
      month = set_node.attribute('release_date').value.match(/(\d{4})-(\d{2})-(\d{2})/)[2]
      day = set_node.attribute('release_date').value.match(/(\d{4})-(\d{2})-(\d{2})/)[3]
      set.update(release_date: Date.new(year.to_i,month.to_i,day.to_i), code: set_node.attribute('code').value)
    end
    #   user_id = create_user(
    #     email:        user.xpath('@email').to_s,
    #     password:     user.xpath('@email').to_s,
    #     created_at:   user.xpath('@created_at').to_s,
    #     updated_at:   user.xpath('@updated_at').to_s,
    #     nickname:     user.xpath('@nickname').to_s,
    #     avatar:       user.xpath('@avatar').to_s,
    #     presentation: user.xpath('@presentation').to_s
    #   ).id
    #   User.find(user_id).update_columns(encrypted_password: user.xpath('@encrypted_password').to_s)
    #   collection_id = User.find(user_id).card_collection.id
    #   collection    = user.xpath("./card_collection").first
    #   collection.xpath('./card').each do |card|
    #     create_card_list(
    #       card_id:            retrieve_card_id(card.xpath('@name').to_s, card.xpath('./@set').to_s),
    #       card_listable_id:   collection_id,
    #       card_listable_type: 'CardCollection',
    #       number:             card.xpath('@number').to_s,
    #       foils_number:       card.xpath('@foils_number').to_s
    #     )
    #   end
    #   user.xpath('./wishlist').each do |wishlist|
    #     wishlist_id = create_wishlist(user_id: user_id, name: wishlist.xpath('@name').to_s)
    #     wishlist.xpath('./card').each do |card|
    #       create_card_list(
    #         card_id:            retrieve_card_id(card.xpath('@name').to_s, card.xpath('@set').to_s),
    #         card_listable_id:   wishlist_id,
    #         card_listable_type: 'Wishlist',
    #         number:             card.xpath('@number').to_s,
    #         foils_number:       card.xpath('@foils_number').to_s
    #       )
    #     end
    #   end
    #   user.xpath('./category').each do |category|
    #     Category.create(name: category.xpath('@name').to_s, user_id: user_id)
    #   end
    # end
  end
end
