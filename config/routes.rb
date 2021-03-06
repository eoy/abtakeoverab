Abtakeoverab::Application.routes.draw do
  scope "(:locale)", :locale => /en|fi|sv/ do
    resources :announcements
    devise_for :users, :controllers => {:registrations => "registrations"}
  end

  root :to => "announcements#index"
  ActiveAdmin.routes(self)
end
