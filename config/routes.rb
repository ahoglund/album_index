Rails.application.routes.draw do
  get  'search/new'
  get  'search/results'
  root 'search#new'
end
