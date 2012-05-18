# encoding: utf-8
class JcatagoryInput < SimpleForm::Inputs::CollectionSelectInput
  #增加和修改文章时候的catagory select栏
  def input
    collection[0].id=0
    super
=begin
    str="<select id=\"catagory_select\" class=\"span2\" name=\"article[catagory_id]\">"
    collection.each do |c|
      str+="<option value=\"#{c.id}\">#{c.name}</option>"
    end
      str+="<option style=\"color:blue\" id=\"create_catagory\" onclick='Jajax.prototype.fuck()'>新增分类</option>"
    str+="</select>"
=end
  end
end

=begin
class CollectionSelectInput < CollectionInput
      def input
        label_method, value_method = detect_collection_methods

        @builder.collection_select(
          attribute_name, collection, value_method, label_method,
          input_options, input_html_options
        )
      end
end
=end
