require 'sqlite3'

class ForeignKey_Field
  attr_accessor :with
  def initialize(with: "None")
    if with.class.name == "None"
      raise ArgumentError, "with argument is required."
    end

    @with = with.to_s
  end
end


class Text_Field
  attr_accessor :placeholder, :verbose, :length
  def initialize(placeholder: '', verbose_name:'', length: 50)
    @placeholder = placeholder
    @verbose = verbose_name
    @length = length
  end
end