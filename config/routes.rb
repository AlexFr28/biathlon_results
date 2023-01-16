Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'front#home'

  get '/event/:event_id/competitions' => 'front#competitions_of_event'
  get 'race/:race_id' => 'front#race', as: 'race'
  get 'standings/:gender' => 'front#standings', as: 'standings', default: {gender: :men}
  get 'standings/competition/:ibu_id/results' => 'front#add_results', defaults: { format: :json }
end
