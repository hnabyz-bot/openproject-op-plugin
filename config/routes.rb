OpenProject::Application.routes.draw do
  scope '/projects/:project_id' do
    namespace :op_plugin do
      resources :entries, only: %i[index new create show edit update destroy]
    end
  end

  namespace :op_plugin do
    namespace :admin do
      resource :settings, only: %i[show update]
    end
  end
end
