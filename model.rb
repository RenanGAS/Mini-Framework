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
  attr_accessor :placeholder, :verbose, :length, :html_type, :sql_type
  def initialize(placeholder: '', verbose_name:'', length: 50, type: 'string')
    @placeholder = placeholder
    @verbose = verbose_name
    @length = length
    if(type.downcase == 'string')
      @html_type = "text"
      @sql_type = "VARCHAR"
    elsif(type.downcase == 'int')
      @html_type = "number"
      @sql_type = "INTEGER"
    end
  end
end

class Date
  attr_accessor :verbose, :html_type, :sql_type
  def initialize(verbose_name:'')
    @verbose = verbose_name
    @html_type = "date"
    @sql_type = "VARCHAR"
  end
end

class TextArea
  attr_accessor :placeholder, :verbose, :length, :html_type, :sql_type
  def initialize(placeholder: '', verbose_name:'', length: 100, type: 'string')
    @placeholder = placeholder
    @verbose = verbose_name
    @length = length
    @html_type = "textarea"
    @sql_type = "VARCHAR"
  end
end
