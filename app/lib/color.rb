class Color
  COLORS_MAPPING = { red: 1, green: 2, black: 3, white: 4, blue: 5 }

  COLORS_MAPPING.each do |name, id|
    define_singleton_method (name) do
      id
    end
  end

  # TODO : gérer les cartes hybrides
  # http://www.magic-ville.com/fr/carte?ref=grn221
  # http://gatherer.wizards.com/Pages/Card/Details.aspx?printed=true&name=Surgical%20Extraction
  # http://gatherer.wizards.com/Pages/Card/Details.aspx?printed=true&multiverseid=173296

  # rule
  # http://www.magiccorporation.com/gathering-lexique-view-43-couleur.html
end
