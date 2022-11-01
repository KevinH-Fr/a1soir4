Rails.application.routes.draw do

  resources :modelsousarticles
  resources :articleoptions
  resources :textes
  resources :messages
  resources :friends

  resources :paiements do
    member do 
      post :edit
    end
  end
  
  resources :articles do
    member do
      get :toggle_selectProduit
      get :toggle_increaseQuantite
      post :edit
    end 
  end

  resources :sousarticles do
    member do
      get :toggle_sousarticleauto
      post :edit
    end
  end 

  resources :clients do
    member do
      post :edit
    end
  end

  resources :commandes do
    member do
      post :edit
    end
  end

  resources :produits do
    member do
      post :edit
    end
  end

  devise_for :users

  resources :posts
  resources :annonces

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