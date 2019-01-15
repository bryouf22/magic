class ExtensionSetSearch < Searchlight::Search

  def base_query
    ExtensionSet.all
  end

  def search_term
    t = I18n.transliterate(term).downcase
    query.where("extension_sets.name ILIKE ?", "%#{t}%")
  end
end
