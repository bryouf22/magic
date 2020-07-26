class Card::RandomGeneration
  include Interactor

  def call
    0/0
  end

  def color
    w 17
    g 17
    r 17
    u 17
    b 17
    n 15
  end

  def type
    :creature
    :land
    :enchantment
    :sorcery
    :instant
    :
end
