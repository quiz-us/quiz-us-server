Rails.application.routes.draw do
  devise_for :teachers
  
  # for debugging
  # access graphiql with GET http://localhost:3000/graphiql
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
    # at: is the path where GraphiQL will be served. You can access GraphiQL by visiting that path in your app.
    # graphql_path: is the path to the GraphQL endpoint. GraphiQL will send queries to this path.
  end

  namespace :api, defaults: { format: :json } do
    resources :questions, only: [:create]
  end

  #react components will use this endpt
  post "/graphql", to: "graphql#execute"
end

