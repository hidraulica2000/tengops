class WelcomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:profile]
  def profile
    @user = User.find_by_id(params[:id])
    unless @user
      redirect_to root_path
    end
  end

  def cover
    
  end

  def psn_info
    @id = params[:id]
    render partial: 'psn_info'
  end
end
