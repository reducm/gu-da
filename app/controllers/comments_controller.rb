class CommentsController < ApplicationController
  def create
    c = Comment.create(params[:comment])
    if c.user_id.present?
      c.user_name = User.select('name').where('id=?', c.user_id)[0].name
    end
    render :json => c.to_json
  end
end
