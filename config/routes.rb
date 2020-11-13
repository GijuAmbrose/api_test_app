Rails.application.routes.draw do
	
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
	namespace :api do
		namespace :v1 do
			resources :articles, except: [:new, :edit] do
				resources :comments, except: [:new, :edit]
			end
		end
	end
end
