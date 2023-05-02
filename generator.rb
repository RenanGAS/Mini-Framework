require_relative 'model'

Host = 'localhost'
#Host = '0.0.0.0'

def register(*classes)
  independent = []
  has_relationship = []
  relantionship_with = {}
  class_description = {}
  rotas = ""

  event_listeners = "<script>\n"
  event_listeners_functions = ""
  list_page = ""
  html_page = ""
  html_home = ""
  html = "<!DOCTYPE html>
  <html lang=\"en\">
  <head>
      <meta charset=\"UTF-8\">
      <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
      <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
      <!--https://www.youtube.com/watch?v=qObzgUfCl28&t=51s-->
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
  lsit_page = html
  html_home = html + "<div class='mb-3'> </div>\n"
  html_home = html_home + "\n<p style=\"text-align:center;color: red;line-height: 16px;letter-spacing: -4px;\" hidden>⢰⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⡆
  ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
  ⢸⣿⣿⣿⣿⣿⣿⣿⠟⣩⣶⣿⣿⣿⣶⣝⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
  ⢸⣿⣿⣿⣿⣿⡿⢡⣾⣿⣿⣿⡿⣿⣿⠟⡈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢟⣵⣶⣝⡻⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠿⣿⣿⣿⣿⣿⡏⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
  ⢸⣿⣿⣿⣿⡿⢡⣿⣿⠟⣫⣭⡄⣨⣿⣿⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⢟⣛⣛⣻⣿⣿⣿⢸⣿⣿⣿⣿⢸⣿⣿⢏⣼⡌⣿⣿⣿⣿⣿⣿⢸⣿⣿⣶⡝⣿⣿⣿⡇⣿⣿⣿⣿⢇⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
  ⢸⣿⣿⣿⣿⢡⣿⡟⣡⠾⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣩⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣿⣿⣿⡿⣸⣿⡿⣸⣿⣷⡹⣿⣿⣿⣿⣿⢸⣿⣿⣿⡇⣿⣿⣿⡣⣿⣿⣿⢏⣾⣿⣿⡿⠿⣛⣛⣽⣿⣿⡇
  ⢸⣿⣿⣿⡇⣾⡟⣰⢣⣾⣿⣿⠿⢃⠹⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣿⣿⡿⣸⣿⣿⢣⣿⣿⣿⡇⣿⣿⣿⣿⣿⢸⣿⣿⣿⡇⣿⣿⣿⣷⢹⡿⣡⣿⣿⣿⢱⣾⣿⣿⣿⣿⣿⣿⡇
  ⢸⣿⣿⣿⢰⣿⢰⢃⣿⣿⣿⣿⣿⣆⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣭⣝⡻⠿⣿⣿⣿⣿⣿⣯⡩⣬⣭⣭⣵⣿⣿⡏⣾⣿⣿⣿⣇⢻⣿⣿⣿⣿⢸⣏⢩⣵⣶⣿⣿⣿⢃⢏⣼⣿⣿⣿⡏⢾⣿⣿⣿⣿⣿⣿⣿⡇
  ⢸⣿⣿⡟⣸⡇⡞⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣍⢿⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⢰⣶⣶⣶⣶⣶⡘⣿⣿⣿⣿⢸⣿⣮⡻⣿⣿⣿⣿⢸⡜⣿⣿⣿⣿⣿⣷⣶⣶⣌⢿⣿⣿⣿⡇
  ⢸⣿⣿⡇⣾⢰⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⢹⣿⣿⡇⣿⣿⣿⣿⣿⡟⣼⣿⣿⣿⣿⣿⣇⠿⣿⣿⣿⢸⣿⣿⡎⣿⣿⣿⡇⣿⣿⣜⢿⣿⣿⣿⣿⣿⣿⢏⣼⣿⣿⣿⡇
  ⢸⣿⣿⡇⡿⢸⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣿⣿⣿⢸⣿⣿⣿⣿⢱⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⣿⢸⣿⣿⣿⡸⢿⣿⡇⣿⣿⣿⣷⣾⣿⣿⣫⣭⣭⣼⣿⣿⣿⣿⡇
  ⢸⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣛⣛⣭⣾⣿⣿⣿⢸⣿⣿⣿⣿⣼⣿⣿⣿⣿⣿⣿⣿⣧⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
  ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⠿⠿⠿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⡇
  ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣛⣛⣛⣫⣭⣶⣶⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣭⣽⣿⣿⡇
  ⠸⠟⠿⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠟⠿⠻⠟⠿⠻⠟⠿⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠟⠟⠿⠻⠻⠻⠇</p>"
  for classe_no_arquivo, index in classes.each_with_index
    event_listeners = "<script>\n"
    event_listeners_functions = ""
    list_page = html

    list_page = list_page + "<a href=\"http://#{Host}:9292/home\" class=\"btn btn-link p-1 mb-2\">&lt;- Voltar</a>" +"
    <h1>Lista de #{classe_no_arquivo.class.name.downcase}</h1>
    <div id=\"lista-#{classe_no_arquivo.class.name.downcase}\"></div>
    <script>
    async function getData() {
  try {
    await new Promise((r) => setTimeout(r, 500));
    const response = await fetch(\"http://#{Host}:9292/listar-#{classe_no_arquivo.class.name.downcase}s\", {
      method:\"GET\",
    });
    const json_data = await response.json();
    const results = json_data;
    const listaResult = document.getElementById(\"lista-#{classe_no_arquivo.class.name.downcase}\");
    const columns = Object.keys(results[0]);

    colunas = columns.map((column) => \"<th>\" + column + \"</th>\").join('')
    let tableHtml = \"<table class='table'><thead><tr>\" + colunas + \"</tr></thead><tbody>\";

    results.forEach(function (result) {
      tableHtml += \"<tr>\";
      columns.forEach(function (column) {
        tableHtml += \"<td>\" + result[column] + \"</td>\";
      });
      tableHtml += \"</tr>\";
    });

    tableHtml += \"</tbody></table>\";
    listaResult.innerHTML = tableHtml;
  } catch (error) {
    console.error(\"Error:\", error);
  }
}

    getData()
    console.log(`⢰⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⡆
⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
⢸⣿⣿⣿⣿⣿⣿⣿⠟⣩⣶⣿⣿⣿⣶⣝⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
⢸⣿⣿⣿⣿⣿⡿⢡⣾⣿⣿⣿⡿⣿⣿⠟⡈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢟⣵⣶⣝⡻⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠿⣿⣿⣿⣿⣿⡏⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
⢸⣿⣿⣿⣿⡿⢡⣿⣿⠟⣫⣭⡄⣨⣿⣿⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⢟⣛⣛⣻⣿⣿⣿⢸⣿⣿⣿⣿⢸⣿⣿⢏⣼⡌⣿⣿⣿⣿⣿⣿⢸⣿⣿⣶⡝⣿⣿⣿⡇⣿⣿⣿⣿⢇⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
⢸⣿⣿⣿⣿⢡⣿⡟⣡⠾⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣩⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣿⣿⣿⡿⣸⣿⡿⣸⣿⣷⡹⣿⣿⣿⣿⣿⢸⣿⣿⣿⡇⣿⣿⣿⡣⣿⣿⣿⢏⣾⣿⣿⡿⠿⣛⣛⣽⣿⣿⡇
⢸⣿⣿⣿⡇⣾⡟⣰⢣⣾⣿⣿⠿⢃⠹⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣿⣿⡿⣸⣿⣿⢣⣿⣿⣿⡇⣿⣿⣿⣿⣿⢸⣿⣿⣿⡇⣿⣿⣿⣷⢹⡿⣡⣿⣿⣿⢱⣾⣿⣿⣿⣿⣿⣿⡇
⢸⣿⣿⣿⢰⣿⢰⢃⣿⣿⣿⣿⣿⣆⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣭⣝⡻⠿⣿⣿⣿⣿⣿⣯⡩⣬⣭⣭⣵⣿⣿⡏⣾⣿⣿⣿⣇⢻⣿⣿⣿⣿⢸⣏⢩⣵⣶⣿⣿⣿⢃⢏⣼⣿⣿⣿⡏⢾⣿⣿⣿⣿⣿⣿⣿⡇
⢸⣿⣿⡟⣸⡇⡞⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣍⢿⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⢰⣶⣶⣶⣶⣶⡘⣿⣿⣿⣿⢸⣿⣮⡻⣿⣿⣿⣿⢸⡜⣿⣿⣿⣿⣿⣷⣶⣶⣌⢿⣿⣿⣿⡇
⢸⣿⣿⡇⣾⢰⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⢹⣿⣿⡇⣿⣿⣿⣿⣿⡟⣼⣿⣿⣿⣿⣿⣇⠿⣿⣿⣿⢸⣿⣿⡎⣿⣿⣿⡇⣿⣿⣜⢿⣿⣿⣿⣿⣿⣿⢏⣼⣿⣿⣿⡇
⢸⣿⣿⡇⡿⢸⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣿⣿⣿⢸⣿⣿⣿⣿⢱⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⣿⢸⣿⣿⣿⡸⢿⣿⡇⣿⣿⣿⣷⣾⣿⣿⣫⣭⣭⣼⣿⣿⣿⣿⡇
⢸⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣛⣛⣭⣾⣿⣿⣿⢸⣿⣿⣿⣿⣼⣿⣿⣿⣿⣿⣿⣿⣧⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⣛⠿⠿⠿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⡇
⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣛⣛⣛⣫⣭⣶⣶⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣭⣽⣿⣿⡇
⠸⠟⠿⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠟⠿⠻⠟⠿⠻⠟⠿⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠻⠟⠟⠿⠻⠻⠻⠇`)
  </script>
  </body>
  </html>
    "
    html_page = html + "<a href=\"http://#{Host}:9292/home\" class=\"btn btn-link p-1 mb-2\">&lt;- Voltar</a>"
    html_home = html_home + "<div class='row'>\n"
    html_home = html_home + "<div class=\"col\">\n<p class=\"border p-2\"><a href='/register-#{classe_no_arquivo.class.name.downcase}'><i style='color:green; font-size: 1.5em;'><strong>&plus;</strong></i> Cadastrar #{classe_no_arquivo.class.name.downcase}</a></p>\n</div>\n"
    html_home = html_home + "<div class=\"col\">\n<p class=\"border p-2\"><a href='/listar-#{classe_no_arquivo.class.name.downcase}s-page'><i style='color:green; font-size: 1.5em;'><strong>&Xi;</strong></i> Listar #{classe_no_arquivo.class.name.downcase}</a></p>\n</div>\n"
    html_home = html_home + "</div>\n"
  # when '/criar-tabelas'
  #   criarTabelas
  # when '/resetar-tabelas'
  rotas = rotas + """
    when '/register-#{classe_no_arquivo.class.name.downcase}'
      file = File.open('register-#{classe_no_arquivo.class.name.downcase}.html')
      response = [file.read]
      [200, headers, response]
    when '/listar-#{classe_no_arquivo.class.name.downcase}s-page'
      file = File.open('listar-#{classe_no_arquivo.class.name.downcase}s.html')
      response = [file.read]
      [200, headers, response]
    """
    tmp_hash = {}

    html_page = html_page + "<form id=#{classe_no_arquivo.class.name.downcase}-form>\n
    <div class=\"form-group\">\n<p>Cadastro de #{classe_no_arquivo.class.name}</p>\n"
    
    for variavel_da_classe, i in classe_no_arquivo.instance_variables.each_with_index
      
      valor = classe_no_arquivo.instance_variable_get(variavel_da_classe)
    
      if valor.is_a?(Text_Field)
          tmp_hash[i] = variavel_da_classe.to_s.delete("@")
          if valor.verbose == ''
            html_page = html_page + "<p>#{variavel_da_classe.to_s.delete("@").capitalize}</p>\n"
          else
            html_page = html_page + "<p>#{valor.verbose}</p>\n"
          end
          html_page = html_page + "<input type=\"#{valor.type}\" class=\"form-control\" placeholder=\"#{valor.placeholder}\" name=\"#{tmp_hash[i]}\"><br>\n"
          
      end

      if valor.is_a?(ForeignKey_Field)
        if !has_relationship.include?(index)
          has_relationship.push(index)
          html_page = html_page + "<p>#{variavel_da_classe.to_s.delete("@").capitalize}</p>\n"
          html_page = html_page + "<select name=\"#{variavel_da_classe.to_s.delete("@")}\" id=\"#{classe_no_arquivo.class.name}#{variavel_da_classe.to_s.delete("@").capitalize}s\" required aria-invalid=\"false\">\n"
          html_page = html_page + "<option value=\"\" selected disabled>Select an option</option>\n</select>\n"
          relantionship_with[index] = {'fieldName' => variavel_da_classe.to_s.delete('@'), 'relatedClass' => valor.with}
          

          event_listeners_functions = event_listeners_functions + "async function get#{variavel_da_classe.to_s.delete("@").capitalize}s() {
            try {
              await new Promise(r => setTimeout(r, 500));
                const response = await fetch('http://#{Host}:9292/listar-#{variavel_da_classe.to_s.delete("@")}s', {
                    method: 'GET',
              })
                const json_data = await response.json();
                console.log('Success:', json_data);
        
                return json_data;
            }
            catch (error) {
                console.error('Error:', error);
            }
        
        }\n"


          event_listeners_functions = event_listeners_functions +
          "async function addToDropdown#{classe_no_arquivo.class.name}#{variavel_da_classe.to_s.delete("@").capitalize}s(){
            var select = document.getElementById('#{classe_no_arquivo.class.name}#{variavel_da_classe.to_s.delete("@").capitalize}s');
            var json = await get#{variavel_da_classe.to_s.delete("@").capitalize}s();
            const reference_field = '#{valor.reference_field}'
            for (i = 0; i < json.length; i++) {
              nome = json[i][reference_field]
              select.options[select.options.length] = new Option(nome , json[i].id);
            };
            $(\"##{classe_no_arquivo.class.name}#{variavel_da_classe.to_s.delete("@").capitalize}s\")[0].selectedIndex = 0;
        }\n"

         
          event_listeners_functions = event_listeners_functions +"window.addEventListener('load', function() {
            addToDropdown#{classe_no_arquivo.class.name}#{variavel_da_classe.to_s.delete("@").capitalize}s();
          });\n"
          
          # adicionar uma função nos scripts pra pegar os dados e colocar no dropdown
          # chamar ela on load e na função acima

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
                                  fetch('http://#{Host}:9292/cadastro-#{classe_no_arquivo.class.name.downcase}', {
                                        method: 'POST',
                                        body: formData,
                                  })
                                        .then(response => response.text())
                                        .then(data => console.log(data))
                                        .catch(error => console.error(error));
                            });\n
    "
    html_page = html_page + "<input type=\"submit\" class=\"btn btn-success\" value=\"Salvar\"><br>\n"
    html_page = html_page + "</div>\n</form>\n"
    html_page = html_page + "<hr>\n"

    html_page = html_page + "
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

    File.open("register-#{classe_no_arquivo.class.name.downcase}.html", "w") do |file|
      file.write(html_page)
    end 
    File.open("listar-#{classe_no_arquivo.class.name.downcase}s.html", "w") do |file|
      file.write(list_page)
    end 
  end
  html_home = html_home +"\n </div>\n </div>\n </div>\n </body>\n </html>"
  File.open("home.html", "w") do |file|
    file.write(html_home)
  end  

  html_welcome = """
  <!DOCTYPE html>
  <html>
  <head>
    <title>Ruby, Ruby, Ruby, Ruby!</title>
    <style>
      body {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100vh;
        margin: 0;
      }
      
      h1 {
        font-size: 10rem;
      }
      h2 {
        font-size: 8rem;
      }
    </style>
  </head>
  <body>
  <a href='http://#{Host}:9292/home'>
    <h1>S P A R K S</h1>
    </a>
  </body>
  </html>
  
  """
  File.open("welcome.html", "w") do |file|
    file.write(html_welcome)
  end  

   
  inicio_app = """
require 'sqlite3'
require 'json'
require 'rack/request'

class App
          """
  criar_tabelas = ""
  resetar_tabelas = ""
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
    CREATE TABLE if not exists #{classe_no_arquivo.class.name}(
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
      #{tmp_hash[i]} INTEGER,
      FOREIGN KEY(#{tmp_hash[i]}) REFERENCES #{valor.with.to_s}(id),"""
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

  app_call = app_call + rotas + """
    when '/home'
      file = File.open('home.html')
      response = [file.read]
      [200, headers, response]
    else
      db = SQLite3::Database.open('miniDB.db')
    """ + 
    resetar_tabelas + criar_tabelas +
    """
      file = File.open('welcome.html')
      response = [file.read]
      [200, headers, response]
    end
  end
end
"""

  codigo_app = inicio_app + cadastrar_classe + listar_classe + app_call
  
  db = SQLite3::Database.new("miniDB.db")

  # Aqui se criaria as tabelas
  # ou mais cedo caso fosse criar sem ler do arquivo
  # e por que que o método não tem um if not exists?
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