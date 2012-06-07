class CommentsController < ApplicationController
  def create
    c = Comment.create(params[:comment])
    if c.user_id.present? && c.user_id != 0
      c.user = User.includes(:picture).select('id, name').where('id=?', c.user_id)[0]
      c.user_picture = c.user.picture.nil? ? nil : c.user.picture.file.head.url
      c.user_name = c.user.name
    end
    render :json => c.to_json(methods: [:user_name, :user_picture], except:[:visitor_email, :updated_at])
  end
end
