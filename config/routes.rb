Rails.application.routes.draw do
  get "/rtm" => "rtm#messages"
  
  root "pages#home"
end
