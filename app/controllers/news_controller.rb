class NewsController < ApplicationController
  def index
    if user_signed_in?
      if current_user.admin
        @news = New.order("created_at DESC").all
        return
      end
    end
    @news = New.published.order("created_at DESC")
  end

  def show
    @new = New.find(params[:id])
  end

  def like
    if user_signed_in?
      @new = New.find(params[:id])
      current_user.toggle_flag(@new, :like) if user_signed_in?
    else
      @must_login = true
      flash[:alert] = "Tienes que iniciar sesion para calificar"
    end
  end

  def friends
    @friends = current_user.get_friends
    render :layout => false
  end

end
