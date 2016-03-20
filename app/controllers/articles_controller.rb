class ArticlesController <  ApplicationController
  before_action :set_article, only: [:edit,:update,:show,:destroy]

  def index
    @articles = Article.all
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
      flash["notice"] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end

  def create
    # debugger #esto genera un debug en la consola, y se detiene usando ctrl + d y avanza pulsando n
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    # @article.save
    # redirect_to article_path(@article)
    @article.user = User.first #hard way

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

end