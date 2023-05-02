all:
	ruby entrada.rb
	puma

clear:
	rm app_generated.rb config.ru miniDB.db
	rm home.html
	find -type f -name 'listar*' -delete
	find -type f -name 'register*' -delete
	rm welcome.html