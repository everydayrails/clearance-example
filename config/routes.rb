Rails.application.routes.draw do
  resources :items

  constraints Clearance::Constraints::SignedIn.new { |user| user.admin? } do
    root to: "admin#index", as: "admin_root"
  end

  constraints Clearance::Constraints::SignedIn.new do
    root to: "items#index", as: "signed_in_root"
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "marketing#index"
  end
end
