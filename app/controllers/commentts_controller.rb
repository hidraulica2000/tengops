class CommenttsController < ApplicationController
  before_filter :authenticate_user!
  def create
    @new = New.find(params[:news_id])
    if current_user != nil
      @comment = @new.commentts.new(params[:commentt])
      @comment.user_id = current_user.id
      if @comment.save
        redirect_to news_path(@new), :notice => "El comentario fue enviado"
      else
        redirect_to news_path(@new), :alert => "El comentario no pudo ser enviado"
      end
    else
      redirect_to new_user_session_path, :alert => "Tienes que iniciar sesion para comentar"
    end
  end
end
