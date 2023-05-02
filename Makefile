HOST = localhost
#HOST = 0.0.0.0

ifeq ($(OS),Windows_NT)
OPEN_BROWSER = cmd /C start http://$(HOST):9292
DELETAR = del
else
OPEN_BROWSER = xdg-open http://$(HOST):9292
DELETAR = rm
endif

all:
	ruby entrada.rb
	$(OPEN_BROWSER)
	puma -b tcp://$(HOST):9292

start:
	$(OPEN_BROWSER)
	puma -b tcp://$(HOST):9292

clear:
	$(DELETAR) app_generated.rb config.ru miniDB.db
	$(DELETAR) home.html
	$(DELETAR) listar*
	$(DELETAR) register*
	$(DELETAR) welcome.html