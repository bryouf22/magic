Rails.application.routes.draw do
  default_url_options :host => "localhost:3000"

  devise_scope :user do
    get "/connection"     =>    "devise/sessions#new" # custom path to login/sign_in
    get "/inscription"    =>    "devise/registrations#new", as: "new_user_registration" # custom path to sign_up/registration
  end

  devise_for :users

  root to: 'welcome#index'

  get 'manifest',                 to: 'welcome#manifest',          as: :manifest
  get 'mon-compte',               to: 'account#index',             as: :user_account
  get 'rechercher',               to: 'cards#search',              as: :card_search
  get 'carte/:id',                to: 'cards#show',                as: :card
  post 'add_card',                to: 'decks#add_card',            as: :add_card_to_deck

  get 'extensions',               to: 'extension_sets#index',      as: :extension_sets
  get 'extension-set-:slug',      to: 'extension_sets#show',       as: :extension_set
  get 'extension-set-:slug/:id',  to: 'extension_sets/cards#show', as: :extension_set_card

  get 'mes-decks',                  to: 'decks#user_decks',        as: :user_decks
  get 'mes-decks/importer',         to: 'decks#import',            as: :import_deck
  post 'mes-deck/importer',         to: 'decks#import_create',     as: :create_import
  post 'mes-decks/supprimer-:slug', to: 'decks#destroy',           as: :destroy_deck
  post 'deck',                      to: 'decks#create',            as: :create_deck

  get 'decks',                    to: 'decks#index',               as: :decks
  get 'editer-deck-:slug',        to: 'decks#edit',                as: :edit_deck
  patch 'edit-deck-:slug',        to: 'decks#update',              as: :update_deck
  post 'manage-card',             to: 'decks#manage_card',         as: :manage_card
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
    resources :extension_sets do
      resources :gatherer_card_urls, controller: 'extension_sets/gatherer_card_urls'
    end
    resources :cards
    resources :users

    resources :set_lists
    resources :blocs, except: [:new, :show, :edit, :update]

    post '/bloc_order', to: 'blocs#bloc_order'
  end
end
