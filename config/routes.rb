Rails.application.routes.draw do
  devise_for :users

  root to: 'welcome#index'

  get 'mon-compte', to: 'account#index', as: :user_account

  get 'rechercher', to: 'card_search#new', as: :card_search
  get 'carte/:id', to: 'cards#show', as: :card

  resources :extension_sets do
    resources :cards, controller: 'extension_sets/cards', except: :index
  end

  post :add_card, to: 'decks#add_card', as: :add_card_to_deck

  resources :decks do
    resources :cards, controller: 'decks/cards', except: :index
  end
  resources :wishlists do
    resources :cards, controller: 'wishlists/cards', except: :index
  end

  resources :card_collections do
    resources :cards, controller: 'card_collections/cards', except: :index
  end
end
