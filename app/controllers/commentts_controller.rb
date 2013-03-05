class CommenttsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]
  def create
    @new = New.find(params[:news_id])
    if current_user != nil
      @comment = @new.commentts.new(params[:commentt])
      @comment.user_id = current_user.id
      if @comment.save
        respond_to do |format|
            format.html {redirect_to news_path(@new), :notice => "El comentario fue enviado"}
            format.js
        end
      else
        redirect_to news_path(@new), :alert => "El comentario no pudo ser enviado"
      end
    else
      redirect_to new_user_session_path, :alert => "Tienes que iniciar sesion para comentar"
    end
  end
  def index
    @new = New.find params[:news_id]
    @comments = @new.commentts
    render :layout => false
  end
end
