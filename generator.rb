require_relative 'model'

def register(*classes)
  independent = []
  has_relationship = []
  relantionship_with = {}
  class_description = {}

  event_listeners = "<script>\n"
  event_listeners_functions = ""

  html = "<!DOCTYPE html>
  <html lang=\"en\">
  <head>
      <meta charset=\"UTF-8\">
      <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
      <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
      <link rel=\"icon\" type=\"image/x-icon\" href=\"https://www.ruby-lang.org/favicon.ico\">
      <title>Ruby, Ruby, Ruby, Ruby!</title>
      <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css\"
        integrity=\"sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh\" crossorigin=\"anonymous\">
  </head>
  <body>
  <div class=\"container-fluid ps-2 mt-2 col-10\">
        <div class=\"row\" style=\"border: 1px solid #ccc; box-shadow: 2px 2px 4px rgba(0,0,0,0.2);\">
        <div class=\"col\">
  "
  for classe_no_arquivo, index in classes.each_with_index
    tmp_hash = {}

    html = html + "<form id=#{classe_no_arquivo.class.name.downcase}-form>\n
    <div class=\"form-group\">\n<p>Cadastro de #{classe_no_arquivo.class.name}</p>\n"

    for variavel_da_classe, i in classe_no_arquivo.instance_variables.each_with_index
      puts "#{index}, #{variavel_da_classe} = #{classe_no_arquivo.instance_variable_get(variavel_da_classe).class}"
      
      valor = classe_no_arquivo.instance_variable_get(variavel_da_classe)

      puts "valor: #{valor}\n"
    
      if valor.is_a?(Text_Field)
          puts "Verbose: #{valor.verbose}"
          tmp_hash[i] = variavel_da_classe.to_s.delete("@")
          if valor.verbose == ''
            html = html + "<p>#{variavel_da_classe.to_s.delete("@").capitalize}</p>\n"
          else
            html = html + "<p>#{valor.verbose}</p>\n"
          end
          html = html + "<input type=\"text\" class=\"form-control\" placeholder=\"#{valor.placeholder}\" name=\"#{tmp_hash[i]}\"><br>\n"
      end

      if valor.is_a?(ForeignKey_Field)
        puts "Valor #{valor}"
        if !has_relationship.include?(index)
          has_relationship.push(index)
          relantionship_with[index] = {'fieldName' => variavel_da_classe.to_s.delete('@'), 'relatedClass' => valor.with}
        end
      end
    end
    class_description[index] = tmp_hash
    if !has_relationship.include?(index)
      independent.push(index)
    end
    event_listeners = event_listeners + "const #{classe_no_arquivo.class.name.downcase}Form = document.querySelector('##{classe_no_arquivo.class.name.downcase}-form');\n"
    event_listeners_functions = event_listeners_functions +"
    #{classe_no_arquivo.class.name.downcase}Form.addEventListener('submit', (event) => {
                                  event.preventDefault();
                                  const formData = new FormData(#{classe_no_arquivo.class.name.downcase}Form);
                                  fetch('http://0.0.0.0:9292/cadastro-#{classe_no_arquivo.class.name.downcase}', {
                                        method: 'POST',
                                        body: formData,
                                  })
                                        .then(response => response.text())
                                        .then(data => console.log(data))
                                        .catch(error => console.error(error));
                            });\n
    "
    #puts event_listeners
    html = html + "<input type=\"submit\" class=\"btn btn-primary\" value=\"Salvar\"><br>\n"
    html = html + "</div>\n</form>\n"
    html = html + "<hr>\n"
  end
    html = html + "
    <hr>
    <form action='http://0.0.0.0:9292/criar-tabelas' method='post'>
          <input type='submit' class=\"btn btn-primary\" name='criar' value='Criar tabelas' />
    </form>
    <form action='http://0.0.0.0:9292/resetar-tabelas' method='post'>
          <input type='submit' class=\"btn btn-primary\" name='Deletar' value='Deletar tabelas' />
    </form>
    <hr>
    </div>
    </div>
    </div>
    #{event_listeners} #{event_listeners_functions} \n </script> \n
    <script src=\"https://code.jquery.com/jquery-3.4.1.slim.min.js\"
    integrity=\"sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n\"
    crossorigin=\"anonymous\"></script>
    <script src=\"https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js\"
    integrity=\"sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo\"
    crossorigin=\"anonymous\"></script>
    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js\"
    integrity=\"sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6\"
    crossorigin=\"anonymous\"></script>
    </body>
    </html>"


  criar_tabelas = """
require 'sqlite3'
require 'json'
require 'rack/request'

class App
  def criarTabelas
    db = SQLite3::Database.open('miniDB.db')
          """
  resetar_tabelas = """
  def resetarTabelas
    db = SQLite3::Database.open('miniDB.db')"""
  cadastrar_classe = ""
  listar_classe = ""
  app_call = """
  def call(env)
    headers = {'Content-Type' => 'text/html'}

    case env['PATH_INFO']
  """

  for classe_no_arquivo, index in classes.each_with_index
    tmp_hash = {}
    criar_tabelas = criar_tabelas + """
    db.execute('''
    CREATE TABLE #{classe_no_arquivo.class.name}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
    """
    resetar_tabelas = resetar_tabelas + """
    db.execute('DROP TABLE if exists #{classe_no_arquivo.class.name}')
    """

    app_call = app_call + """
    when '/cadastro-#{classe_no_arquivo.class.name.downcase}'
      cadastrar#{classe_no_arquivo.class.name}(env)
    when '/listar-#{classe_no_arquivo.class.name.downcase}s'
      listar#{classe_no_arquivo.class.name}s
      """

    atributos_classe = Array[]
    string_json_listagem = ""

    for variavel_da_classe, i in classe_no_arquivo.instance_variables.each_with_index
      valor = classe_no_arquivo.instance_variable_get(variavel_da_classe)

      if valor.is_a?(Text_Field)
        tmp_hash[i] = variavel_da_classe.to_s.delete("@")
        criar_tabelas = criar_tabelas + """
      #{tmp_hash[i]} VARCHAR(#{valor.length}),"""
      end

      if valor.is_a?(ForeignKey_Field)
        tmp_hash[i] = variavel_da_classe.to_s.delete("@")
        criar_tabelas = criar_tabelas + """
      fk_id_#{tmp_hash[i]} INT,
      FOREIGN KEY(fk_id_#{tmp_hash[i]}) REFERENCES #{valor.with.to_s}(id),"""
      end

      atributos_classe.push(tmp_hash[i])
      string_json_listagem = string_json_listagem + "#{tmp_hash[i]}: #{classe_no_arquivo.class.name.downcase}[#{i + 1}], "
    end

    criar_tabelas = criar_tabelas.chop
    criar_tabelas = criar_tabelas + ");"

    cadastrar_classe = cadastrar_classe + """
  def cadastrar#{classe_no_arquivo.class.name}(env)
    request = Rack::Request.new(env)
  """

    string_insert = ""
    string_insert_interrogacao = ""

    atributos_classe.each {|atributo| cadastrar_classe = cadastrar_classe + """
    #{atributo} = request.params['#{atributo}']"""
      string_insert = string_insert + "#{atributo},"
      string_insert_interrogacao = string_insert_interrogacao + "?,"
    }
    
    criar_tabelas = criar_tabelas + "''')"

    cadastrar_classe = cadastrar_classe + """

    db = SQLite3::Database.open('miniDB.db')
    db.execute('INSERT INTO #{classe_no_arquivo.class.name} (#{string_insert.chop}) VALUES (#{string_insert_interrogacao.chop})', [#{string_insert.chop}])
    db.close

    [200, {'Content-Type' => 'application/json'}, [{success: true}.to_json]]
  end
  """

    listar_classe = listar_classe + """
  def listar#{classe_no_arquivo.class.name}s
    db = SQLite3::Database.open('miniDB.db')

    #{classe_no_arquivo.class.name.downcase}s = db.execute('SELECT * FROM #{classe_no_arquivo.class.name}')

    resultado = []
    #{classe_no_arquivo.class.name.downcase}s.each do |#{classe_no_arquivo.class.name.downcase}|
        resultado << {id: #{classe_no_arquivo.class.name.downcase}[0], """ + string_json_listagem + """}
    end
    [200, {'Content-Type' => 'application/json'}, [resultado.to_json]]
  end
  """
  end

  criar_tabelas = criar_tabelas + """
    [200, {'Content-Type' => 'application/json'}, [{success: true}.to_json]]
  end
  """
  resetar_tabelas = resetar_tabelas + """
    [200, {'Content-Type' => 'application/json'}, [{success: true}.to_json]]
  end
  """
  app_call = app_call + """
    when '/criar-tabelas'
      criarTabelas
    when '/resetar-tabelas'
      resetarTabelas
    else
      file = File.open('index_generated.html')
      response = [file.read]
      [200, headers, response]
    end
  end
end
"""

  codigo_app = criar_tabelas + resetar_tabelas + cadastrar_classe + listar_classe + app_call
  
  db = SQLite3::Database.new("miniDB.db")

  File.open("index_generated.html", "w") do |file|
    file.write(html)
  end

  File.open("app_generated.rb", "w") do |file|
    file.write(codigo_app)
  end  

  codigo_config = """
require 'rack'
require_relative 'app_generated'

use Rack::Reloader, 0

run App.new
"""

  File.open("config.ru", "w") do |file|
    file.write(codigo_config)
  end 

end