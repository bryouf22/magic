class ApplicationController < ActionController::Base

  private

  def list_by_colors
    @white_cards     = @cards.white.decorate
    @blue_cards      = @cards.blue.decorate
    @black_cards     = @cards.black.decorate
    @red_cards       = @cards.red.decorate
    @green_cards     = @cards.green.decorate
    @gold_cards      = @cards.gold.decorate
    @colorless_cards = @cards.colorless.decorate
  end
end
