require 'sprite_factory'
require 'chunky_png'
#取自ruby-china的合图脚本,先把要合并的图放在app/assets/imgages/sprites/文件夹/下面,rake assets:resprite之后，会生成css文件
#假设放个slides有next.png 和 prev.png
#生成的class是.slides_next和 .slides_prev
namespace :assets do
  desc 'recreate sprite images and css'
  task :resprite => :environment do
    SpriteFactory.library = :chunkypng
    SpriteFactory.csspath = "image-path('sprites/$IMAGE')"
    dirs = Dir.glob("#{Rails.root}/app/assets/images/sprites/*/")
    dirs.each do |path|
      dir_name = path.split("/").last
      SpriteFactory.run!("app/assets/images/sprites/#{dir_name}",
                          :output_style => "app/assets/stylesheets/sprites/#{dir_name}.scss",
                          :selector => ".#{dir_name}_")
    end
  end
end
