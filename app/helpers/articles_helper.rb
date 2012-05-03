module ArticlesHelper
  def catagory_sidebar
    unless params[:action] == 'edit' || params[:action] == 'new'
      render 'layouts/catagory', :catagories => @catagories
    else
      nil
    end
  end
end
