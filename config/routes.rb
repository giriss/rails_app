RailsSite::Application.routes.draw do

  get "test/one"
  get "test/two"
  get "test/three"
  get "test/four"
	get "intersital/index"
	namespace :deposits do
		post "form_submit"
		post "set_express_checkout_paypal"
		get "do_express_checkout_paypal"
		post "set_express_checkout_payza"
	end

	get "advertiser", to:"advertisers#index"
	get "advertiser/wallet", to:"advertisers#wallet"
	get "advertiser/wallet/page/:page_number", to:"advertisers#wallet", constraints: {:page_number => /[0-9]+/}
	get "advertiser/campaign", to:"advertisers#campaign"
	get "advertiser/create_ad", to:"advertisers#create_ad"
	post "advertiser/create_ad", as:"advertiser_create_ad_post", to:"advertisers#create_ad_post"
	post "advertiser/destroy_ad/:id", as:"advertiser_destroy_ad", to:"advertisers#destroy_ad", id: /[0-9]+/
	post "advertiser/create_ad_preview", to:"advertisers#create_ad_preview"
	get "advertiser/create_ad/design/:id", to:"advertisers#design_ad", id: /[0-9]+/, as: "advertiser_design_ad"
	post "advertiser/create_ad/design/:id", to:"advertisers#design_ad", id: /[0-9]+/, as: "advertiser_design_ad_post"
	get "advertiser/create_ad/clone/:id", to:"advertisers#clone_ad", id: /[0-9]+/, as: "advertiser_clone_ad"
	post "advertiser/create_ad/clone/:id", to:"advertisers#clone_ad", id: /[0-9]+/, as: "advertiser_clone_ad_post"
	get "advertiser/account",  to:"advertisers#account"

	resources :announcements

	get  "r/:referer_key", to: "referal#initiate", constraints:{ referer_key: /[-~_.0-9A-Za-z]{4}/ }, as: "referal_init"
	post "referal/create"
	post "referal/destroy"

	root "welcome#index"

	get   "welcome/index"
	get   ":who/learn_more", to: "welcome#learnMore", as: :welcome_learnMore, constraints: {who: /publisher|advertiser|pub|adv/}

	namespace :url_action do
		post "shrink"
		post ":id/destroy", as: :destroy, action: :destroy
		post "update_urls"
		post "mass_shrink"
		post "multi_links_shrink"
	end

	# Users
	resource :users
	post  "users/login", as: "login_users"
	post  "users/logout", as: "logout_users"
	post  "user/google_analytics/add", to: "users#add_google_analytics", as: "add_google_analytics"
	post  "user/google_analytics/destroy", to: "users#destroy_google_analytics", as: "destroy_google_analytics"

	get   "u", as: "user_home", to: "users#home"
	get   "u/dashboard", to: "users#home"
	get   "u/referals", to: "users#referals"
	get   "u/tools", to: "users#tools"
	get   "u/withdraw", to: "users#withdraw"
	get   "u/account", to: "users#account"

	get  "api/user_id/:user_id/api_key/:api_key/url/*url", to: "url_action#api", constraints:{api_key: /\w{64}/, user_id: /[0-9]+/, url: /(http\:\/|https\:\/|)\w+[.]{1}\w+([.]{1}\w+|)+(\/.+|)/}, format: false
	get  "api/get", to: "url_action#api", format: false
	post "api/post", to: "url_action#api", format: false

	get "tests", to: "url_action#test"

	get  "bookmarklet/*url", to: "url_action#bookmarklet", format: false

	# Easy_links // Last priority in routes to prevent confusion to actual roots
	get  ":user_id/*url", to: "url_action#easy_link", as: "easy_link", constraints:{user_id: /[0-9]+[+]{1}/, url: /((http\:\/|https\:\/|)\w+[.]{1}\w+([.]{1}\w+|)+(\/.+|))|http:\/localhost\:3000\/tests/}, format: false
	get  ":user_id/:digest_url", to: "url_action#digest_easy_link", as: "digest_easy_link", constraints:{user_id: /[+]{1}[0-9]+/, digest_url: /\w{32}/}, format: false

	get   "intersital/generate/:id", to: "intersital#generate_ad", constraints:{ id: /[0-9]+/ }, as: :generate_intersital
	get   "intersital/generate/preview/:id", to: "intersital#generate_ad_preview", constraints:{ id: /[0-9]+/ }, as: :generate_intersital_preview
    get   ":key", to: "intersital#index", constraints:{ key: /[-~_.0-9A-Za-z]{4}/ }

	# The priority is based upon order of creation: first created -> highest priority.
	# See how all your routes lay out with "rake routes".

	# You can have the root of your site routed with "root"
	# root 'welcome#index'

	# Example of regular route:
	#   get 'products/:id' => 'catalog#view'

	# Example of named route that can be invoked with purchase_url(id: product.id)
	#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

	# Example resource route (maps HTTP verbs to controller actions automatically):
	#   resources :products

	# Example resource route with options:
	#   resources :products do
	#     member do
	#       get 'short'
	#       post 'toggle'
	#     end
	#
	#     collection do
	#       get 'sold'
	#     end
	#   end

	# Example resource route with sub-resources:
	#   resources :products do
	#     resources :comments, :sales
	#     resource :seller
	#   end

	# Example resource route with more complex sub-resources:
	#   resources :products do
	#     resources :comments
	#     resources :sales do
	#       get 'recent', on: :collection
	#     end
	#   end

	# Example resource route with concerns:
	#   concern :toggleable do
	#     post 'toggle'
	#   end
	#   resources :posts, concerns: :toggleable
	#   resources :photos, concerns: :toggleable

	# Example resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end
end
