Rails.application.routes.draw do
  devise_for :users

  root to: 'welcome#index'

  get 'manifest', to: 'welcome#manifest', as: :manifest

  get 'mon-compte', to: 'account#index', as: :user_account

  get 'rechercher', to: 'card_search#new', as: :card_search
  get 'carte/:id', to: 'cards#show', as: :card

  post :add_card, to: 'decks#add_card', as: :add_card_to_deck

  get 'extensions', to: 'extension_sets#index', as: :extension_sets
  get 'extension-set-:slug', to: 'extension_sets#show', as: :extension_set
  get 'extension-set-:slug/:id', controller: 'extension_sets/cards', action: :show, as: :extension_set_card

  get 'mes-decks', to: 'decks#user_decks', as: :user_decks
  get 'decks', to: 'decks#index', as: :decks

  get 'ma-collection', to: 'card_collections#show', as: :card_collection

  get 'mes-listes', to: 'wishlists#index', as: :wishlists
  get 'ma-liste-:name', to: 'wishlists#show', as: :wishlist
  get 'ma-liste-:name/:id', controller: 'wishlists/cards', action: :show, as: :wishlist_card

  post '/ajouter', to: 'cards#add_to', as: :add_to
end
