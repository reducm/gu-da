#encoding: UTF-8
class CommentsController < ApplicationController
  layout false
  before_filter :check_session
  def index
    cs = Comment.get_by_article_id params[:article_id]
    cs_arr = []
    cs.each do|c|
      c.switch_content{|user| user_path(user)}
      c.content =view_context.markdown(c.content)
      cs_arr << JSON.parse(c.to_json)
    end
    respond_to do |format|
      format.json { render json: cs_arr.to_json }
    end
  end

  def create
    params[:user_id] = @user_id || 0
    c = Comment.create(params[:comment])
    if c.errors.any?
      render json: {errors:c.jerrors} 
      return
    end
    c.switch_content{|user| user_path(user)}
    c.strtime = view_context.jtime(c.created_at)
    c.content = view_context.markdown(c.content)
    unless c.guest?
      c.user = User.includes(setting:[:picture]).select('id, nickname').where('id=?', c.user_id)[0]
      c.user_picture = c.user.head.nil? ? nil : c.user.head.file.head.url
    else
      c.user_picture = nil
    end
    render json: c.to_json(methods: [:strtime, :user_name, :user_head, :user_picture, :user, :author_id], except:[:visitor_email, :updated_at])
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.article.user_id != @user_id
      #render :text => '用户不是文章拥有者，不能删除', :status => 403, layout:false
      render json:{errors: '用户不是文章拥有者，不能删除'}
      return
    else
      comment.destroy()
      render json: comment.to_json
      return
    end
  end

  def update
  end
end
