class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # debugger
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the alpha block #{@user.username}"
      redirect_to articles_path #por ahora lo redirigiremos a la lista de articulos.
    else
      render "new"
    end
  end

  def edit
    @user = User.find_by(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end