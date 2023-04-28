require_relative 'model'
require_relative 'generator'

# class Learning(models.Model):
#   id = models.BigAutoField(primary_key=True)
#   name = models.CharField(max_length=128, blank=False)
#   course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name='learnings', null=False, blank=False)

class Pessoa
    attr_accessor :teste, :teste2
    def initialize
      #Text_field tem parametro opcional, vazio ele usa o valro default, ou então faz passando como parametro nomeado
      #@teste3 = Text_Field.new(:placeholder => 'red')
      @Nome = Text_Field.new(:placeholder => "Nome", :verbose_name => "Seu nome")
      @cpf = Text_Field.new(:placeholder => "CPF", :verbose_name => "cpf")
    end
end

class Carro
  attr_accessor :teste, :teste2
  def initialize
    #Text_field tem parametro opcional, vazio ele usa o valro default, ou então faz passando como parametro nomeado
    #@teste3 = Text_Field.new(:placeholder => 'red')
    @nomeDoCarro = Text_Field.new(:placeholder => "Nome do carro.")
    @dono = ForeignKey.new(:with => Pessoa)
  end
end
  
  
register(Pessoa.new, Carro.new)