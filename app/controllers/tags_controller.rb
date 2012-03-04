class TagsController < ApplicationController
  def show
    @tag = Tag.includes(:articles).find(params[:id])  
  end
end
