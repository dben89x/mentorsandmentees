class SessionsController < ApplicationController
  def new
    if params['session']
      create
    end
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      log_in user
      flash[:success] = "Welcome back, #{user.full_name}!"
      if session_params[:remember_me] == '1'
        remember user
      else
        forget user
      end
      redirect_back_or root_path

    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?

    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :remember_me)
  end
end
