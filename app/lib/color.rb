class Color
  COLORS_MAPPING = { red: 1, green: 2, black: 3, white: 4, blue: 5 }

  MANA_COST_MAPPING = {
    w: :white,
    u: :blue,
    b: :black,
    r: :red,
    g: :green,
    a: [:white, :blue],
    c: [:blue, :black],
    d: [:black, :red],
    e: [:red, :green],
    f: [:green, :white],
    h: [:white, :black],
    i: [:blue, :red],
    j: [:black, :green],
    k: [:red, :white],
    l: [:green, :blue],
    m: [:white],
    n: [:blue],
    o: [:black],
    p: [:red],
    q: [:green],
  }

  COLORS_MAPPING.each do |name, id|
    define_singleton_method (name) do
      id
    end
  end

  # rule
  # http://www.magiccorporation.com/gathering-lexique-view-43-couleur.html
end
