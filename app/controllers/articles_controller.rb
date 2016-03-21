class ArticlesController <  ApplicationController
  before_action :set_article, only: [:edit,:update,:show,:destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    # @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def show
    # @article = Article.find(params[:id])
  end

  def destroy
    # @article = Article.find(params[:id])
    @article.destroy
    flash[:danger] = "Articel was successfully deleted"
    redirect_to articles_path
  end

  def new
    @article = Article.new
  end

  def edit
    # Debe existir el id si no no podemos vizualizarlo
    # @article = Article.find(params[:id])
  end

  def update
    # @article = Article.find(params[:id])

    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end

  def create
    # debugger #esto genera un debug en la consola, y se detiene usando ctrl + d y avanza pul
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    # @article.save
    # redirect_to article_path(@article)
    # @article.user = User.first #hard way
    @article.user = current_user #esto es por que se esta requiriendo el suaurio en beforeaction required_user

    if @article.save
      #do something
      flash[:success] = "The article was successfully created"
      redirect_to article_path(@article)
    else
      render "new"
    end
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own article"
      redirect_to root_path
    end
  end

end