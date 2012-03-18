module ApplicationHelper
  def logout_path
    session[:logined] = false
    session[:user_id] = nil
    "/blog"
  end

  def blog_root_path
    root_path+"blog"
  end

end
