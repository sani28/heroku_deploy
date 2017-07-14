Rails.application.routes.draw do


  #note that we are not using `resources` in this case, because
  #there should always only be one session. Singular resource will
  #not create any routes that requires id. Instead, it expects that
  #it will always be working with the same resource.


#the `namespace` feature of Rails routes will add the name space as section
# of the URL so in this case all routes defined within this `admin` namespace
# will be prepended with `/admin`so the url index for `dashbaord` will be:
# /admin/dashboard
#also note that the resources for controllers defined within the namespace
#will be expected to be in a folder with the same name as `namespace`
#which is `admin` in this case. so the dashboard_controller must be located in
# a subfolder called `admin` within `/app/controllers`


  namespace :admin do
    resources :dashboard, only: :index
  end

  #another example of a single resource is a user profile  : resource: profile -

  #even though resource is singular, and we gave an argument (ie session) that is singular,
  # it still expects the controller to be named in plural

  resource :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create]

#resources :questions, except : [:delete]
#resources :questions, only : [:index, :show]
  resources :questions  #model name, pluralized, lowercase

  #just creates path, doesnt have to have a model,
  #but by convention, ppl use resources with a model to generate all the models paths

  #resources :questions will generate all CRUD routes just like
  #we wrote below for a given resource name. Make sure that you write
  #plural `resources` and also pluralize the resource name (i.e :questions )

  #  post('questions/', to: 'questions#create', as: :questions)
  #  get('questions/new', to: 'questions#new', as: :new_question)
  #  get('questions/:id', to: 'questions#show', as: :question)
  #  get('questions/:id/edit', to: 'questions#edit', as: :edit_question)
  #  patch('questions/:id', to: 'questions#update')
  #  get('questions/', to: 'questions#index')
  #  delete('questions/:id', to: 'questions#destroy')

  # The order of routes matter. The first route matches is the one that
  # is taken. Make sure that more specific appear before more broad routes
  # (e.g. `questions/new` should always appear before `questions/:id`)

  # this rules defines the following: when we recieve a `GET` request to `/`
  # which is the home page, send the request to the `Welcome` controller and
  # `index` action within that controller. An action is a public instance method
  # that is defined within the controller.
  # as: :home will generate a URL helper that will gives a view helper method
  # to auto-generate the URL


  root 'welcome#index' # this will give you a helper method `root_path` that
                        # will take you to the home page which is welcome/index
                        # in our case


  # get('/', { to: 'welcome#index', as: :home })

  get('/contact', { to: 'contact#new' })
  # get '/contact', { to: 'contact#new' }
  # get '/contact', to: 'contact#new'

  post('/contact_submit', { to: 'contact#create' })


end
