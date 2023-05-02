require_relative 'model'
require_relative 'generator'

class Pessoa
    def initialize
      @nome = Text_Field.new(:placeholder => "Nome", :verbose_name => "Nome", :length => 50)
      @cpf = Text_Field.new(:placeholder => "CPF", :verbose_name => "cpf", :length => 50)
    end
end

class Produto
  def initialize
    @nome = Text_Field.new(:placeholder => "Produto", :length => 50)
    @quantidade = Text_Field.new(:placeholder => "Valor", :type => 'int')
    @pessoa = ForeignKey_Field.new(:with => Pessoa, :referencing => 'nome')
  end
end

class Carro
  def initialize
    @marca = Text_Field.new(:placeholder => "Marca", :length => 50)
    @cor = Text_Field.new(:placeholder => "Cor", :length => 50)
    @pessoa = ForeignKey_Field.new(:with => Pessoa, :referencing => 'nome')
  end
end
  
register(Pessoa.new, Carro.new, Produto.new)
