require 'sqlite3'

class ForeignKey
  attr_accessor :pointTo
  def initialize(with: '')
    if with.class.name == "String"
      raise ArgumentError, "'with argument is required."
    end

    @pointTo = with.to_s
  end
end


class Text_Field
  attr_accessor :placeholder, :verbose
  def initialize(placeholder: '', verbose_name:'')
    @placeholder = placeholder
    @verbose = verbose_name
  end
end