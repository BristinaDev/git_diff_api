Rails.application.routes.draw do
  get 'repositories/:user/:repo/commits/:id', to: 'commits#show'
  get 'repositories/:user/:repo/commits/:id/diff/:base', to: 'commits#diff'
end
