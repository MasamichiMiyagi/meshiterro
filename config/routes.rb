Rails.application.routes.draw do

  devise_for :users

  root to: 'homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'homes/about' => 'homes#about', as: 'about'

  #post_commentsは、post_imagesに結びつくものの為、親子関係になる。
  #単数形の「resource」は、いいね機能の場合は「1人のユーザーは1つの投稿に対して1回しかいいねできない」という仕様であるため、destroyをする際にもユーザーidと投稿(post_image)idが分かれば、どのいいねを削除すればいいのかが特定できる為、params[:id]を使う必要が無い
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update]

end
