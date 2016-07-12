#Submodule management

submodules:
	@git submodule init && git submodule update

submodulemaster:
	@for i in `find game -type d -maxdepth 1`; do if [ $$i != game ]; then cd $$i; git checkout master; git pull; cd -; fi; done;


#Cycle Config

cycleconfig: game/carbon/src/scenes/config.js game/nitrogen/src/scenes/config.js game/water/src/scenes/config.js
	

game/nitrogen:
	@git submodule init && git submodule update

game/water:
	@git submodule init && git submodule update

game/carbon:
	@git submodule init && git submodule update

game/nitrogen/src/scenes/config.js: game/nitrogen
	@cp game/nitrogen/src/scenes/config.js{.template,} && echo 'game_type = NITROGEN_GAME;' >> game/nitrogen/src/scenes/config.js

game/water/src/scenes/config.js: game/water
	@cp game/water/src/scenes/config.js{.template,} && echo 'game_type = WATER_GAME;' >> game/water/src/scenes/config.js

game/carbon/src/scenes/config.js: game/carbon
	@cp game/carbon/src/scenes/config.js{.template,} && echo 'game_type = CARBON_GAME;' >> game/carbon/src/scenes/config.js

cleancycleconfig:
	@rm game/nitrogen/src/scenes/config.js ; rm game/water/src/scenes/config.js ; rm game/carbon/src/scenes/config.js

