class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    #log in ....

      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
          #put error

      if !user
        flash.now[:danger] = 'Invalid User.Sign up now'
      else
        flash.now[:danger] = 'Authentication fail,please check account or password again '
      end
    render'new'
    end

  end

  def destroy
    logout if logged_in?
    redirect_to root_path
  end
end
