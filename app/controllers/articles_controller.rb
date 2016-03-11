class ArticlesController <  ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    # Debe existir el id si no no podemos vizualizarlo
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      flash["notice"] = ""
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    # @article.save
    # redirect_to article_path(@article)

    if @article.save
      #do something
      flash[:notice] = "The article was successfully created"
      redirect_to article_path(@article)
    else
      render "new"
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

end