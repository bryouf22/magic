Rails.application.routes.draw do
  default_url_options :host => "localhost:3000"
  devise_for :users

  root to: 'welcome#index'

  get 'manifest',                 to: 'welcome#manifest',          as: :manifest
  get 'mon-compte',               to: 'account#index',             as: :user_account
  get 'rechercher',               to: 'card_search#new',           as: :card_search
  get 'carte/:id',                to: 'cards#show',                as: :card
  post 'add_card',                to: 'decks#add_card',            as: :add_card_to_deck
  get 'extensions',               to: 'extension_sets#index',      as: :extension_sets
  get 'extension-set-:slug',      to: 'extension_sets#show',       as: :extension_set
  get 'extension-set-:slug/:id',  to: 'extension_sets/cards#show', as: :extension_set_card
  get 'mes-decks',                to: 'decks#user_decks',          as: :user_decks
  get 'decks',                    to: 'decks#index',               as: :decks
  get 'mes-decks/nouveau',        to: 'decks#new',                 as: :new_deck
  get 'mes-decks/:slug',          to: 'decks#show',                as: :deck
  get 'ma-collection',            to: 'card_collections#show',     as: :card_collection
  get 'mes-listes',               to: 'wishlists#index',           as: :wishlists
  get 'nouvelle-liste',           to: 'wishlists#new',             as: :new_wishlist
  get 'ma-liste-:name',           to: 'wishlists#show',            as: :wishlist
  get 'ma-liste-:name/:id',       to: 'wishlists/cards#show',      as: :wishlist_card
  post '/ajouter',                to: 'cards#add_to',              as: :add_to

  get '/admin', to: 'admin/welcome#index', as: :admin_root
  namespace 'admin' do
    resources :extension_sets
    resources :cards
    resources :users
  end
end
