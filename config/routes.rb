GenHackday::Application.routes.draw do
  match "/search", :to => "hospitals#search"
  resources :hospitals, :only => [:show]
end
