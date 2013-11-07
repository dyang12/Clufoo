module FieldsHelper
  def shrink(str)
    return str[0..22] +"..." if str.length > 23
    str
  end
end
