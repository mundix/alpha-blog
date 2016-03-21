class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit,:update, :destroy]
  before_action :require_admin, only: [:destroy]

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 2)
  end

  def new
    @user = User.new
  end

  def create
    # debugger
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the alpha block #{@user.username}"
      # redirect_to articles_path #por ahora lo redirigiremos a la lista de articulos.
      redirect_to user_path(@user)
    else
      render "new"
    end
  end

  def edit
    # @user = User.find_by(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render "edit"
    end
  end

  def show
    # @user = User.find(params[:id])
  #   Esto solo funciona desde aqui no funciona en la vista, aun no he comprobado
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user = User.find(params[:id])
    if current_user != @user
      @user.destroy
      flash[:danger] = "User and all articles created by user have been deleted"
    else
      flash[:dander] = "You don't have access this this info."
    end
      redirect_to users_path

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if  current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end

  def require_admin
    if logged_user? and !current_user.admin?
      flash[:dange] = "Only admin users can peform that action."
      redirect_to root_path
    end
  end

end