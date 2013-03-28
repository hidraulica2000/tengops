class CommenttsController < ApplicationController
  def create
    @new = New.find(params[:news_id])
    if current_user != nil
      @comment = @new.commentts.new(params[:commentt])
      @comment.user_id = current_user.id
      @can_comment = true
      if current_user.commentts.any?
        time = current_user.commentts.order('created_at desc').first.created_at
        unless (Time.now - time ) >= 15
          @can_comment = false
        end
      end
      if @can_comment
        if @comment.save
          respond_to do |format|
              format.html {redirect_to news_path(@new), :notice => "El comentario fue enviado"}
              format.js
          end
        else
          redirect_to news_path(@new), :alert => "El comentario no pudo ser enviado"
        end
      end
    else
      @must_login = true
      flash[:alert] = "Tienes que iniciar sesion para comentar"
    end
  end
  def destroy
    @new = New.find(params[:news_id])
    @comment = Commentt.find(params[:id])
    if @comment.destroy
      respond_to do |format|
        format.html {redirect_to news_path(@new), :notice => "El comentario fue eliminado"}
        format.js
      end
    else
      redirect_to news_path(@new), :alert => "El comentario no pudo ser eliminado"
    end

  end
  def index
    @new = New.find params[:news_id]
    @comments = @new.commentts.order("created_at desc")
    render :layout => false
  end
  def like
    if user_signed_in?
      @new = New.find params[:news_id]
      @comment = Commentt.find(params[:id])
      current_user.toggle_flag(@comment, :like) if user_signed_in?
    else
      @must_login = true
      flash[:alert] = "Tienes que iniciar sesion para calificar"
    end
  end
end
