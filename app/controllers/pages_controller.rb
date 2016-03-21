class PagesController < ApplicationController
  def home
    redirect_to articles_path if logged_user?
  end
  def about

  end
end