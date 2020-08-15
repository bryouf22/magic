class ExtensionSetDecorator < Draper::Decorator
  include ApplicationHelper

  decorates_finders
  delegate_all

  def title_for_list
    name.gsub('From the Vault:', '')
        .gsub('Duel Decks:', '')
        .gsub('Duel Decks Anthology:', '')
        .gsub('Premium Deck Series:', '')
        .gsub('Guild Kit:', '').strip
  end
end
