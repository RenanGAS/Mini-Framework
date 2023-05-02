ifeq ($(OS),Windows_NT)
OPEN_BROWSER = cmd /C start http://localhost:9292
else
OPEN_BROWSER = xdg-open http://localhost:9292
endif

all:
	ruby entrada.rb
	$(OPEN_BROWSER)
	puma -b tcp://localhost:9292

clear:
	rm app_generated.rb config.ru miniDB.db
	rm home.html
	find -type f -name 'listar*' -delete
	find -type f -name 'register*' -delete
	rm welcome.html