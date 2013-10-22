Abtakeoverab::Application.routes.draw do
  scope "(:locale)", :locale => /en|fi|sv/ do
    resources :announcements
  end

  root :to => "announcements#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  ActiveAdmin.routes(self)
end
