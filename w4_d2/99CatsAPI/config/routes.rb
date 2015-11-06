Rails.application.routes.draw do
  resources :cats do
    resources :cat_rental_requests do
      post "approve", on: :member
      post "deny", on: :member
    end
  end
end
