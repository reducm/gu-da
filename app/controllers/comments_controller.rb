class CommentsController < ApplicationController
  before_filter :check_session
  def create
    params[:user_id] = @user_id || 0
    c = Comment.create(params[:comment])
    if c.errors.any?
      render json: {errors:c.jerrors} 
      return
    end

    c.strtime = view_context.jtime(c.created_at)
    c.content = view_context.markdown(c.content)
    unless c.guest?
      c.user = User.includes(setting:[:picture]).select('id, nickname').where('id=?', c.user_id)[0]
      c.user_picture = c.user.head.nil? ? nil : c.user.head.file.head.url
    else
      c.user_picture = nil
    end
    render json: c.to_json(methods: [:strtime, :user_name, :user_picture], except:[:visitor_email, :updated_at])
  end

  def destroy
  end

  def update
  end
end
