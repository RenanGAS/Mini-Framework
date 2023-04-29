require 'sqlite3'
require 'json'
require 'rack/request'

class App
    def criarTabelas
        db = SQLite3::Database.open('teste.db')
        db.execute('''
        CREATE TABLE Pessoa (
            id INTEGER PRIMARY KEY,
            nome VARCHAR(50),
            cpf VARCHAR(50));
        ''')
        db.execute('''
        CREATE TABLE Carro (
            id INTEGER PRIMARY KEY,
            marca VARCHAR(50),
            cor VARCHAR(50));
        ''')
        db.execute('''
        CREATE TABLE Pessoa_Tem_Carro (
            id_pessoa INTEGER,
            id_carro INTEGER,
            PRIMARY KEY (id_pessoa, id_carro),
            FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id),
            FOREIGN KEY (id_carro) REFERENCES Carro(id));
        ''')
        [200, {'Content-Type' => 'application/json'}, [{success: true}.to_json]]
    end

    def resetarTabelas
        db = SQLite3::Database.open('teste.db')
        db.execute("DROP TABLE if exists Pessoa_Tem_Carro")
        db.execute("DROP TABLE if exists Carro")
        db.execute("DROP TABLE if exists Pessoa")
        [200, {'Content-Type' => 'application/json'}, [{success: true}.to_json]]
    end

    def cadastrarPessoa(env)
        request = Rack::Request.new(env)

        nome = request.params['nome']
        cpf = request.params['cpf']
        
        db = SQLite3::Database.open('teste.db')
        db.execute("INSERT INTO Pessoa (nome, cpf) VALUES (?, ?)", [nome, cpf])
        db.close

        [200, {'Content-Type' => 'application/json'}, [{success: true}.to_json]]
      end
    
      def listarPessoas
        db = SQLite3::Database.open('teste.db')

        pessoas = db.execute("SELECT * FROM Pessoa")

        resultado = []
        pessoas.each do |pessoa|
            resultado << {id: pessoa[0], nome: pessoa[1], cpf: pessoa[2]}
        end

        [200, {'Content-Type' => 'application/json'}, [resultado.to_json]]
      end
        
    def cadastrarCarro(env)
        request = Rack::Request.new(env)

        marca = request.params['marca']
        cor = request.params['cor']
        
        db = SQLite3::Database.open('teste.db')
        db.execute("INSERT INTO Carro (marca, cor) VALUES (?, ?)", [marca, cor])
        db.close

        [200, {'Content-Type' => 'application/json'}, [{success: true}.to_json]]
      end
    
      def listarCarros
        db = SQLite3::Database.open('teste.db')

        carros = db.execute("SELECT * FROM Carro")

        resultado = []
        carros.each do |carro|
            resultado << {id: carro[0], marca: carro[1], cor: carro[2]}
        end

        [200, {'Content-Type' => 'application/json'}, [resultado.to_json]]
      end

      def cadastrarPessoaCarro(env)
        request = Rack::Request.new(env)
    
        id_pessoa = request.params['id_pessoa']
        id_carro = request.params['id_carro']
        
        db = SQLite3::Database.open('teste.db')
        db.execute("INSERT INTO Pessoa_Tem_Carro (id_pessoa, id_carro) VALUES (?, ?)", [id_pessoa, id_carro])
        db.close

        [200, {'Content-Type' => 'application/json'}, [{success: true}.to_json]]
      end

      def listarPessoasCarros
        db = SQLite3::Database.open('teste.db')

        pessoasCarros = db.execute("SELECT * FROM Pessoa_Tem_Carro")

        resultado = []
        pessoasCarros.each do |pessoaCarro|
            resultado << {id_pessoa: pessoaCarro[0], id_carro: pessoaCarro[1]}
        end

        [200, {'Content-Type' => 'application/json'}, [resultado.to_json]]
      end

    def call(env)
        headers = {'Content-Type' => 'text/html'}

        case env['PATH_INFO']
        when '/cadastro-Carro'
          cadastrarCarro(env)
        when '/listar-Carros'
          listarCarros
        when '/cadastro-Pessoa'
            cadastrarPessoa(env)
        when '/listar-Pessoas'
            listarPessoas
        when '/cadastro-PessoaCarro'
            cadastrarPessoaCarro(env)
        when '/listar-PessoasCarros'
            listarPessoasCarros
        when '/criar-tabelas'
            criarTabelas
        when '/resetar-tabelas'
            resetarTabelas
        else
          file = File.open('index.html')
          response = [file.read]
          [200, headers, response]
        end

    end
end