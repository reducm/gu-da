# encoding: utf-8
class JcatagoryInput < SimpleForm::Inputs::CollectionSelectInput
  #增加和修改文章时候的catagory select栏
  def input
    collection[0].id=0
    result = super
    p "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy  \n #{result}"
    result
#    result<<"<option style=\"color:red\" id=\"create_catagory\">增加分类</option>"
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
