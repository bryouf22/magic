Rails.application.routes.draw do
  default_url_options :host => 'localhost:3000'

  devise_scope :user do
    get    '/connection'                       => 'devise/sessions#new' # custom path to login/sign_in
    get    '/inscription'                      => 'devise/registrations#new',         as: :new_user_registration # custom path to sign_up/registration
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: 'welcome#index'

  get    'manifest',                         to: 'welcome#manifest',                   as: :manifest
  get    'mon-compte',                       to: 'account#index',                      as: :user_account
  get    'rechercher',                       to: 'cards#search',                       as: :card_search
  get    'recherche-avancee',                to: 'cards#adv_search',                   as: :adv_card_search
  get    'rechercher-set',                   to: 'extension_sets#search',              as: :extension_set_search

  get    'carte/:id',                        to: 'cards#show',                         as: :card

  post   'add_card',                         to: 'decks#add_card',                     as: :add_card_to_deck

  get    'extensions',                       to: 'extension_sets#index',               as: :extension_sets
  get    'extension-set-:slug',              to: 'extension_sets#show',                as: :extension_set
  get    'extension-set-:slug/:id',          to: 'extension_sets/cards#show',          as: :extension_set_card

  get    'mes-decks',                        to: 'decks#user_decks',                   as: :user_decks
  get    'mes-decks/importer',               to: 'decks#import',                       as: :import_deck
  post   'mes-deck/importer',                to: 'decks#import_create',                as: :create_import
  post   'mes-decks/supprimer-:slug',        to: 'decks#destroy',                      as: :destroy_deck
  post   'deck',                             to: 'decks#create',                       as: :create_deck
  get    'decks',                            to: 'decks#index',                        as: :decks
  get    'editer-deck-:slug',                to: 'decks#edit',                         as: :edit_deck
  patch  'edit-deck-:slug',                  to: 'decks#update',                       as: :update_deck
  post   'deck-:slug',                       to: 'decks#add_cards',                    as: :deck_add_card
  post   'manage-card',                      to: 'decks#manage_card',                  as: :manage_card
  get    'mes-decks/nouveau',                to: 'decks#new',                          as: :new_deck
  get    'mes-decks/:id',                    to: 'decks#show',                         as: :my_deck
  get    'mes-decks/:slug/color',            to: 'decks#show_by_color',                as: :my_deck_by_color
  get    'mes-decks/detail/:slug',           to: 'decks#detail',                       as: :detail_deck
  get    'public-decks',                     to: 'decks#public_decks',                 as: :public_decks
  get    'public-decks/:id',                 to: 'decks#public_deck_show',             as: :public_deck
  get    'exporter-deck/:id',                to: 'decks#export',                       as: :export_deck
  get    'generer-draft/:id',                to: 'decks#generate_draft',               as: :generate_draft
  post   'copy-public-deck',                 to: 'decks#copy_public_deck',             as: :copy_public_deck

  get    'ma-collection',                    to: 'card_collections#show',              as: :card_collection
  post   'ma-collection/ajout-occurrence',   to: 'card_collections#update_occurrence', as: :update_occurrence_card_collection

  get    'mes-listes',                       to: 'wishlists#index',                    as: :wishlists
  get    'nouvelle-liste',                   to: 'wishlists#new',                      as: :new_wishlist
  get    'ma-liste-:id/editer',              to: 'wishlists#edit',                     as: :edit_wishlist
  put    'nouvelle-liste',                   to: 'wishlists#create',                   as: :create_wishlist
  delete 'ma-list-id/supprimer',             to: 'wishlists#destroy',                  as: :destroy_wishlist
  post   'ma-liste:id/mettre-a-jour',        to: 'wishlists#update',                   as: :update_wishlist
  get    'ma-liste-:id',                     to: 'wishlists#show',                     as: :wishlist

  get    'utilisateurs/:id',                 to: 'users#show',                         as: :user

  post   '/ajouter',                         to: 'cards#add_to',                       as: :add_to

  get    '/reprint-from-:id',                to: 'cards#reprints_from_card'
  post   '/change-deck-card-visual',         to: 'decks#change_visual',                as: :deck_change_visual

  resources :categories

  get    'mentions-legals',                  to: 'welcome#legals',                     as: :legals

  get    '/admin',                           to: 'admin/welcome#index',                as: :admin_root
  post   'remove-card-card_id',              to: 'cards#destroy',                      as: :remove_card

  namespace 'admin' do
    resources :extension_sets do
      resources :gatherer_card_urls, controller: 'extension_sets/gatherer_card_urls'
    end

    post '/admin/export', to: 'welcome#export', as: :export

    resources :cards
    resources :users

    resources :set_lists
    resources :blocs, except: %i[new show edit update]

    resources :formats

    post   'deck-validity', to: 'welcome#deck_validity', as: :deck_validity
    post   '/bloc_order',   to: 'blocs#bloc_order'
  end
end
