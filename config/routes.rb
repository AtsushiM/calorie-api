Api::Application.routes.draw do
    get "/api/calories" => "api/calories#search"
    post "/api/calories" => "api/calories#create"
    get "/api/calories/:id" => "api/calories#show"
    put "/api/calories/:id" => "api/calories#update"
    delete "/api/calories/:id" => "api/calories#destory"
end
