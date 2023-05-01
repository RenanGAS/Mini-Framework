require_relative 'model'
require_relative 'generator'

class Pessoa
    def initialize
      @nome = Text_Field.new(:placeholder => "Nome", :verbose_name => "Nome", :length => 50)
      @raca = Text_Field.new(:placeholder => "CPF", :verbose_name => "cpf", :length => 50)
    end
end

class Carro
  def initialize
    @marca = Text_Field.new(:placeholder => "Marca", :length => 50)
    @cor = Text_Field.new(:placeholder => "Cor", :length => 50)
    @pessoa = ForeignKey_Field.new(:with => Pessoa)
  end
end
  
register(Pessoa.new, Carro.new)