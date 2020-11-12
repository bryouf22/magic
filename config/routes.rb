Rails.application.routes.draw do
  default_url_options host: 'localhost:3000'

  devise_scope :user do
    get '/login' => 'devise/sessions#new',             as: :login
    get '/registration' => 'devise/registrations#new', as: :new_user_registration
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: 'welcome#index'

  get    'mon-compte',        to: 'account#index',         as: :user_account

  get    'rechercher',        to: 'cards#search',          as: :card_search
  get    'recherche-avancee', to: 'cards#adv_search',      as: :adv_card_search
  get    'rechercher-set',    to: 'extension_sets#search', as: :extension_set_search

  get    'carte/:id', to: 'cards#show',     as: :card
  post   'add_card',  to: 'decks#add_card', as: :add_card_to_deck
  post   'add_cards_collection/:card_id', to: 'cards#add_card_collection', as: :add_card_collection

  get    'extensions',          to: 'extension_sets#index',      as: :extension_sets
  get    'extension-:slug',     to: 'extension_sets#show',       as: :extension_set
  get    'extension-:slug/collection', to: 'extension_sets#collection', as: :extension_set_collection
  get    'extension-:slug/:id', to: 'extension_sets/cards#show', as: :extension_set_card


  get    'my-decks',              to: 'decks#user_decks',    as: :user_decks
  get    'my-decks/import',       to: 'decks#import',        as: :import_deck
  get    'my-decks/:slug/edit',   to: 'decks#edit',          as: :edit_deck
  get    'my-decks/new',          to: 'decks#new',           as: :new_deck
  get    'my-decks/:slug',        to: 'decks#show',          as: :my_deck
  get    'my-decks/:slug/color',  to: 'decks#show_by_color', as: :my_deck_by_color
  get    'my-decks/:slug/detail', to: 'decks#detail',        as: :detail_deck
  get    'my-decks/:slug/export', to: 'decks#export',        as: :export_deck
  patch  'edit-deck-:slug',       to: 'decks#update',        as: :update_deck
  post   'deck',                  to: 'decks#create',        as: :create_deck
  post   'my-deck/import',        to: 'decks#import_create', as: :create_import
  post   'my-decks/delete-:slug', to: 'decks#destroy',       as: :destroy_deck
  post   'deck-:slug',            to: 'decks#add_cards',     as: :deck_add_card
  post   'manage-card',           to: 'decks#manage_card',   as: :manage_card

  post   'missing-card-from-dekcs', to: 'decks#missing_card_from_decks', as: :missing_card_from_decks

  get 'add-to-wishlist/(:id)',   to: 'decks#add_wishlist',   as: :add_to_wishlist_deck
  get 'add-to-collection/(:id)', to: 'decks#add_collection', as: :add_to_collection_deck

  post 'add-to-collection/:id', to: 'decks#add_cards_to_collection', as: :deck_add_collection
  post 'my-decks-calculate-complete/:id', to: 'decks#calculate_complete_percent', as: :calculate_complete_percent_decks

  get    'generer-draft/:id', to: 'decks#generate_draft', as: :generate_draft

  get    'public-decks',     to: 'decks#public_decks',     as: :public_decks
  get    'public-decks/:id', to: 'decks#public_deck_show', as: :public_deck
  post   'copy-public-deck', to: 'decks#copy_public_deck', as: :copy_public_deck

  get    'ma-collection',                  to: 'card_collections#show',              as: :card_collection
  post   'ma-collection/ajout-occurrence', to: 'card_collections#update_occurrence', as: :update_occurrence_card_collection

  get    'mes-listes',                   to: 'wishlists#index',   as: :wishlists
  get    'nouvelle-liste',               to: 'wishlists#new',     as: :new_wishlist
  get    'ma-liste/:slug/editer',        to: 'wishlists#edit',    as: :edit_wishlist
  put    'nouvelle-liste',               to: 'wishlists#create',  as: :create_wishlist
  delete 'ma-liste/:slug/supprimer',     to: 'wishlists#destroy', as: :destroy_wishlist
  post   'ma-liste/:slug/mettre-a-jour', to: 'wishlists#update',  as: :update_wishlist
  get    'ma-liste/:slug',               to: 'wishlists#show',    as: :wishlist

  get    'utilisateurs/:id', to: 'users#show', as: :user

  post   '/ajouter', to: 'cards#add_to', as: :add_to

  get    '/reprint-from-:id',         to: 'cards#reprints_from_card'
  post   '/change-deck-card-visual',  to: 'decks#change_visual', as: :deck_change_visual

  resources :categories

  get 'legals', to: 'welcome#legals', as: :legals

  post 'remove-card-card_id', to: 'cards#destroy', as: :remove_card

  get '/admin', to: 'admin/welcome#index', as: :admin_root
  namespace 'admin' do
    resources :extension_sets do
      member do
        post :find_reeditions
        post :update_data
        get :create_card
      end
      resources :gatherer_card_urls, controller: 'extension_sets/gatherer_card_urls'
    end
    get :retrieve_data, defaults: { format: :json }

    post '/admin/export', to: 'welcome#export',        as: :export
    post 'deck-validity', to: 'welcome#deck_validity', as: :deck_validity

    resources :cards, only: %i[new edit update destroy create] do
      member { post 'create_duplicate' }
    end

    get '/duplicate-card-:id', to: 'cards#duplicate', as: :duplicate_card
    resources :users
    resources :set_lists
    resources :blocs, except: %i[new show edit update]
    resources :formats

    post :add_version, to: 'cards#add_version', as: :card_add_version

    post :crawl_card_data, to: 'crawler#crawl_card_data', as: :crawl_card_data, default: { format: :js }
  end

  get 'layout', to: 'welcome#layout'
end
