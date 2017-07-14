class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user =  User.new user_params

    if @user.save

      #if the user is successfully created, immedietly store their id in the
      #session hash effectievely signing them in


      session[:user_id] = @user.id
      # The flash ia s temporary store that will last until the next request ends
      # we typically use it to store information to dispaly to the user what just hapepned
      #When using redirect to, we can include the flash as an argument instead of
      # writing :   flash[:notice] = 'Thank you for signing up '
      redirect_to root_path, notice: 'Thank you for signing up!'
    else
      #sometimes, we want the flash message to appear in the current request and
      #not the next one. `Use flash.now[...]` in that situation .
      flash.now[:alert] = @user.errors.full_messages.join(',')
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
