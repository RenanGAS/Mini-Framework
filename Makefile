#HOST = localhost
HOST = 0.0.0.0

ifeq ($(OS),Windows_NT)
OPEN_BROWSER = cmd /C start http://$(HOST):9292
else
OPEN_BROWSER = xdg-open http://$(HOST):9292
endif

all:
	ruby entrada.rb

start:
	$(OPEN_BROWSER)
	puma -b tcp://$(HOST):9292

clear:
	rm app_generated.rb config.ru miniDB.db
	rm home.html
	find -type f -name 'listar*' -delete
	find -type f -name 'register*' -delete
	rm welcome.html