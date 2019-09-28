class Color
  COLORS_MAPPING = { red: 1, green: 2, black: 3, white: 4, blue: 5 }.freeze

  DECK_COLOR_MAPPING = {
    red: :r, green: :g, black: :b, white: :w, blue: :u
  }.freeze

  MANA_COST_MAPPING = {
    w: :white,
    u: :blue,
    b: :black,
    r: :red,
    g: :green,
    a: %i[white blue],
    c: %i[blue black],
    d: %i[black red],
    e: %i[red green],
    f: %i[green white],
    h: %i[white black],
    i: %i[blue red],
    j: %i[black green],
    k: %i[red white],
    l: %i[green blue],
    m: [:white],
    n: [:blue],
    o: [:black],
    p: [:red],
    q: [:green],
    x: [],
    s: [:white],
    t: [:blue],
    v: [:black],
    z: [:red],
    y: [:green]
  }.freeze

  SYMBOL_FILE_MAPPING = {
    w: :w,
    u: :u,
    b: :b,
    r: :r,
    g: :g,
    a: :wu,
    c: :ub,
    d: :br,
    e: :rg,
    f: :gw,
    h: :wb,
    i: :ur,
    j: :bg,
    k: :rw,
    l: :gu,
    m: :'2w',
    n: :'2u',
    o: :'2b',
    p: :'2r',
    q: :'2g',
    x: :x,
    s: :wp,
    t: :up,
    v: :bp,
    z: :rp,
    y: :gp,
    Snow: 's'
  }.freeze

  def self.mana_symbol(color)
    MANA_COST_MAPPING.invert[color.to_sym]
  end

  COLORS_MAPPING.each do |name, id|
    define_singleton_method(name) do
      id
    end
  end

  # rule
  # http://www.magiccorporation.com/gathering-lexique-view-43-couleur.html
end
