class StaticPagesController < ApplicationController
  def index
  end

  def show
    if params[:page] == "information"
      redirect_to "/overview"
    else
      render template: "pages/#{params[:page]}"
    end
  end
end
