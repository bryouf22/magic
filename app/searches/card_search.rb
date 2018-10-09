class CardSearch < Searchlight::Search

  def base_query
    Card.all
  end

  def search_term
    t = I18n.transliterate(term).downcase
    query.where('`cards`.`name_clean` LIKE ? OR `cards`.`name_fr_clean` LIKE ?', "%#{t}%", "%#{t}%")
  end
end
