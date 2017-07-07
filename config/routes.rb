Rails.application.routes.draw do

  post('questions/', to: 'questions#create', as: :questions)
  get('questions/new', to: 'questions#new', as: :new_question)
  get('questions/:id', to: 'questions#show', as: :question)
  get('questions/:id/edit', to: 'questions#edit', as: :edit_question)

  # The order of routes matter. The first route matches is the one that
  # is taken. Make sure that more specific appear before more broad routes
  # (e.g. `questions/new` should always appear before `questions/:id`)

  # this rules defines the following: when we recieve a `GET` request to `/`
  # which is the home page, send the request to the `Welcome` controller and
  # `index` action within that controller. An action is a public instance method
  # that is defined within the controller.
  # as: :home will generate a URL helper that will gives a view helper method
  # to auto-generate the URL
  get('/', { to: 'welcome#index', as: :home })

  get('/contact', { to: 'contact#new' })
  # get '/contact', { to: 'contact#new' }
  # get '/contact', to: 'contact#new'

  post('/contact_submit', { to: 'contact#create' })
end
