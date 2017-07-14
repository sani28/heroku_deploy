class QuestionsController < ApplicationController
 # before_action :authenticate_user!, except: [:index, :show]
  # The New action is usually used to show a form of
  # the resource we'll create on submission
  # URL: /questions/new
  # VERB: GET

  before_action :authorize_user!, only: [:edit, :destroy, :update]

  def index
    @questions = Question.order(created_at: :desc)
  end


  def new
    # Instance variables declared in controllers are accessible
    # views rendered by that action.
    # This means that we can use `@question` inside of `views/questions/new.html.erb`.
    @question = Question.new
  end

  def edit
    @question = Question.find params[:id]
    if @question.user != current_user
      redirect_to root_path, alert: 'Access denied'
  end

  def update
      @question = Question.find params[:id]
      question_params = params.require(:question).permit(:title, :body)

      if @question.update question_params
        redirect_to question_path(@question)
      else
        render :edit
      end
    end

  def destroy
      @question = Question.find params[:id]
      @question.destroy
      redirect_to questions_path
  end

  def show
    @question = Question.find params[:id]
  end




  # The Create action is used to handle form submissions from the New
  # action to create a record (of a question in this case) in the database.
  # URL: /questions
  # VERB: POST
  def create
    # Byebug is a gem that is installed by default rails. You can use
    # to pause execution of any ruby program. In this case, we use pause
    # the server when the `create` action is called. This will pause server
    # itself. Go to your terminal tab when `rails s` was run to access
    # the debugger REPL. Type `exit` to leave byebug.
    # byebug

    question_params = params.require(:question).permit(:title, :body)
    # The params object is avaible in all controllers and it gives you
    # access to all the data coming from a form or url params

    # Require is used to get a nested hashed with the given symbol
    # inside of the params object (in this case :question)

    # Every input field of a form must be permitted individiually
    # otherwise rails will throw an error. This is to prevent users
    # from creating their fields
    @question = Question.new question_params
    @question.user = current_user

    if @question.save
      # redirect_to question_path(id: @question.id)
      # redirect_to question_path(@question.id)
      redirect_to question_path(@question)
    else
      # this will render the `views/questions/new.html.erb` to
      # show the form again (with errors). The default behaviour is to
      # render `create.html.erb`
      render :new
    end
  end



  #remember that if a `before_action` does `render`, `redirect_to` or `head`
  #it will stop the request from getting into the action


  def authorize_user!
    # @question = Question.find params[:id]
    # head :unauthorized unless can?(:manage, @question)

    unless can?(:manage, @question)
      # redirect_to root_path, alert: 'Access denied'

      #head will send an empty http response, it will take one argument as a string
      #and the argument will tell Rails to send the desired HTTP response code
      # :unauthorized -> 401
      # you can see more code on this page:
      #http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
      head :unauthorized
  end
end


end

end






##
