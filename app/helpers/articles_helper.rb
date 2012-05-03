module ArticlesHelper
  def catagory_sidebar
    unless params[:action] == 'edit' || params[:action] == 'new'
      render 'layouts/catagory', :catagories => @catagories, :user_id => @user_id
    else
      nil
    end
  end
end
