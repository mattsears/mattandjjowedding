Rails.application.routes.draw do

  post "/:rsvp/" => "pages#rsvp"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "pages#index"

   # Fallback to PagesController
  get "/(:page)" => "pages#show", as: :page
end
