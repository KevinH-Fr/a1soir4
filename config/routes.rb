Rails.application.routes.draw do

  resources :modelsousarticles
  resources :articleoptions
  resources :paiements
  resources :textes
  resources :messages
  resources :friends

  resources :articles do
    member do
      get :toggle_selectProduit
      get :toggle_increaseQuantite
    end 
  end

  resources :sousarticles do
    member do
      get :toggle_sousarticleauto
    end
  end 

  resources :clients do
    member do
      post :edit
    end
  end

  devise_for :users
  resources :produits
  resources :posts
  resources :annonces
  resources :commandes
  resources :labels
  
  # partie publique
   root 'accueil#index' 
   get 'contact', to: 'accueil#contact'
   get 'boutique', to: 'accueil#boutique'
   get 'robes_soirees', to: 'accueil#soirees'
   get 'robes_mariees', to: 'accueil#mariees'
   get 'costumes_hommes', to: 'accueil#costumes'
   get 'accessoires', to: 'accueil#accessoires'
   get 'costumes_deguisements', to: 'accueil#deguisements'
   get 'plan', to: 'accueil#plan'
   
   # partie admin
   get 'accueil_admin', to: 'accueil_admin#index'
   get 'search', to: 'search#index'
   get 'marketing', to: 'accueil_admin#marketing'
   get 'listeSelection', to: 'accueil_admin#listeSelection'

end