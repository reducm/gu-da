require 'spec_helper'

describe CommentsController do
  before(:each) do
    @jas = FactoryGirl.create :jas
    @article = FactoryGirl.create :article, user:@jas
    10.times{ FactoryGirl.create :picture, pictureable:@jas }
    @pic = @jas.pictures.first
  end

end
