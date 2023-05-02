require 'sqlite3'

class ForeignKey_Field
  attr_accessor :with, :reference_field
  def initialize(with: "None", referencing: 'id')
    if with.class.name == "None"
      raise ArgumentError, "with argument is required."
    end
    @with = with.to_s
    @reference_field = referencing
  end
end

class Text_Field
  attr_accessor :placeholder, :verbose, :length, :type
  def initialize(placeholder: '', verbose_name:'', length: 50, type: 'string')
    @placeholder = placeholder
    @verbose = verbose_name
    @length = length
    if(type.downcase == 'string')
      @type = "text"
    else(type.downcase == 'int')
        @type = "number"
    end
  end
end