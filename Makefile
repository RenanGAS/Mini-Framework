all:
	ruby entrada.rb
	puma

clear:
	rm app_generated.rb config.ru index_generated.html miniDB.db