require_relative 'model'

# BEGIN {
#     ARGV.each do|a|
#         puts "Argument: #{a}"
#     end
# }

def register(*classes)
    independent = []
    has_relationship = []
    relantionship_with = {}
    class_description = {}

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

      html = html + "<form method=\"POST\" action=\"http://0.0.0.0:9292/cadastro-#{classe_no_arquivo.class.name}\">\n<div class=\"form-group\">\n<p>Cadastro de #{classe_no_arquivo.class.name}</p>\n"

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
            html = html + "<input type=\"text\" class=\"form-control\" placeholder=\"#{valor.placeholder}\"><br>\n"
        end
  
        if valor.is_a?(ForeignKey)
         puts "Valor #{valor}"
          if !has_relationship.include?(index)
            has_relationship.push(index)
            relantionship_with[index] = {'fieldName' => variavel_da_classe.to_s.delete('@'), 'relatedClass' => valor.pointTo}
          end
        end
      end
      class_description[index] = tmp_hash
      if !has_relationship.include?(index)
        independent.push(index)
      end
      html = html + "<input type=\"submit\" class=\"btn btn-primary\" value=\"Salvar\"><br>\n"
      html = html + "</div>\n</form>\n"
      html = html + "<hr>\n"
    end
      html = html + "
      </div>
      </div>
      </div>
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
      
    puts class_description
    puts  relantionship_with
    puts independent
    puts has_relationship

    # db = SQLite3::Database.open("teste.db")
    #             db.execute("DROP TABLE if exists Pessoa")
    #             db.execute("DROP TABLE if exists Carro")
    # db.execute("CREATE TABLE Pessoa(id INTEGER AUTO_INCREMENT PRIMARY KEY,Nome VARCHAR(50),cpf VARCHAR(50));")
  
    codigo_app = '''
    require \'sqlite3\'

    class App
        def cadastrarCarro()
            begin
                db.execute "INSERT INTO Pessoa VALUES(67,'Renan','57127')"
            rescue SQLite3::Exception => e
                puts "Exception ocurred"
                puts e
            ensure
                db.close if db
            end
        end

        def call(env)
            headers = {'Content-Type' => 'text/html'}

            return [200, headers, ['favicon']] if env['PATH_INFO'] == '/favicon.ico'

            if env['PATH_INFO'] == '/cadastro-Carro'
                cadastrarCarro()
            end
            
            file = File.open("index.html")
            response = [file.read]

            [200, headers, response]

        end
    end

    '''
    
    for i in independent
      codigo_app = "CREATE TABLE #{classes[i].class.name}(id INTEGER AUTO_INCREMENT PRIMARY KEY"
      currentClass = class_description[i]
   
      for key in currentClass.keys
        codigo_app = codigo_app + ",#{currentClass[key]} VARCHAR(50)"
      end
      codigo_app = codigo_app + ");"
      puts codigo_app
      db.execute(codigo_app)
    end
  
    for j in has_relationship
      codigo_app = "CREATE TABLE #{classes[j].class.name}(id INTEGER AUTO_INCREMENT PRIMARY KEY"
      currentClass = class_description[j]
   
      for key in currentClass.keys
        codigo_app = codigo_app + ",#{currentClass[key]} VARCHAR(50)"
      end
      puts "j #{j} #{relantionship_with[j]}"
      codigo_app = codigo_app + ",#{relantionship_with[j]['fieldName']} INTEGER"
      codigo_app = codigo_app + ",FOREIGN KEY (#{relantionship_with[j]['fieldName']}) REFERENCES #{relantionship_with[j]['relatedClass']}(id)"
      codigo_app = codigo_app + ");"
      puts codigo_app
      db.execute(codigo_app)
    end
  
  
  
  # open a file for writing, creates it if it doesn't exist
    File.open("index.html", "w") do |file|
    file.write(html)
    end
  
  end