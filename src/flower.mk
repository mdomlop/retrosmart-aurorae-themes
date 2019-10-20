THEME = flower

$(THEME): $(BASENAME)-$(THEME) $(addprefix $(BASENAME)-$(THEME), /metadata.desktop /$(BASENAME)-$(THEME)rc /alldesktops.svg /help.svg /maximize.svg /restore.svg /close.svg /keepabove.svg /menu.svg /shade.svg /decoration.svg /keepbelow.svg /minimize.svg)

$(BASENAME)-$(THEME):
	mkdir $@
	$(eval THEME = $(lastword $(subst -, ,$@)))

$(BASENAME)-$(THEME)/metadata.desktop: src/metadata.desktop
	@echo '[Desktop Entry]' > $@
	@echo 'Name=Retrosmart $(THEME)' >> $@
	@cat $^ >> $@

$(BASENAME)-$(THEME)/$(BASENAME)-$(THEME)rc: src/rc
	@echo '[General]' > $@
	@echo 'ActiveTextColor=255,255,255,255' >> $@
	@echo 'InactiveTextColor=0,0,0,255' >> $@
	@cat $^ >> $@

$(BASENAME)-$(THEME)/alldesktops.svg: src/alldesktops.svg
	@sed < $^ \
	-e 's/#0000f1/#800080/g' \
	-e 's/#fffff1/#ffffff/g' \
	-e 's/#0000f2/#00ff00/g' \
	-e 's/#fffff2/#000000/g' \
	-e 's/#0000f3/#ffcc00/g' \
	-e 's/#fffff3/#000000/g' \
	-e 's/#0000f4/#000000/g' \
	-e 's/#fffff4/#bfbfbf/g' \
	-e 's/#0000f5/#999999/g' \
	-e 's/#fffff5/#000000/g' \
	-e 's/#0000f6/#009900/g' \
	-e 's/#fffff6/#000000/g' \
	-e 's/#0000f7/#ff9900/g' \
	-e 's/#fffff7/#000000/g' \
	-e 's/#0000f8/#333333/g' \
	-e 's/#fffff8/#bfbfbf/g' \
	> $@

$(BASENAME)-$(THEME)/close.svg: src/close.svg
	@sed < $^ \
	-e 's/#0000f1/#800080/g' \
	-e 's/#fffff1/#ffffff/g' \
	-e 's/#0000f2/#ff0000/g' \
	-e 's/#fffff2/#ffffff/g' \
	-e 's/#0000f3/#ff5252/g' \
	-e 's/#fffff3/#ffffff/g' \
	-e 's/#0000f4/#000000/g' \
	-e 's/#fffff4/#bfbfbf/g' \
	-e 's/#0000f5/#999999/g' \
	-e 's/#fffff5/#000000/g' \
	-e 's/#0000f6/#ff0000/g' \
	-e 's/#fffff6/#ffffff/g' \
	-e 's/#0000f7/#ff5252/g' \
	-e 's/#fffff7/#ffffff/g' \
	-e 's/#0000f8/#333333/g' \
	-e 's/#fffff8/#bfbfbf/g' \
	> $@

$(BASENAME)-$(THEME)/decoration.svg: src/decoration.svg
	@sed < $^ \
	-e 's/#d10000/#000000/g' \
	-e 's/#00d200/#800080/g' \
	-e 's/#0000d3/#999999/g' \
	> $@

$(BASENAME)-$(THEME)/help.svg: src/help.svg
	@sed < $^ \
	-e 's/#0000f1/#800080/g' \
	-e 's/#fffff1/#ffffff/g' \
	-e 's/#0000f2/#00ff00/g' \
	-e 's/#fffff2/#000000/g' \
	-e 's/#0000f3/#ffcc00/g' \
	-e 's/#fffff3/#000000/g' \
	-e 's/#0000f4/#000000/g' \
	-e 's/#fffff4/#bfbfbf/g' \
	-e 's/#0000f5/#999999/g' \
	-e 's/#fffff5/#000000/g' \
	-e 's/#0000f6/#009900/g' \
	-e 's/#fffff6/#000000/g' \
	-e 's/#0000f7/#ff9900/g' \
	-e 's/#fffff7/#000000/g' \
	-e 's/#0000f8/#333333/g' \
	-e 's/#fffff8/#bfbfbf/g' \
	> $@
$(BASENAME)-$(THEME)/keepabove.svg: src/keepabove.svg
	@sed < $^ \
	-e 's/#0000f1/#800080/g' \
	-e 's/#fffff1/#ffffff/g' \
	-e 's/#0000f2/#00ff00/g' \
	-e 's/#fffff2/#000000/g' \
	-e 's/#0000f3/#ffcc00/g' \
	-e 's/#fffff3/#000000/g' \
	-e 's/#0000f4/#000000/g' \
	-e 's/#fffff4/#bfbfbf/g' \
	-e 's/#0000f5/#999999/g' \
	-e 's/#fffff5/#000000/g' \
	-e 's/#0000f6/#009900/g' \
	-e 's/#fffff6/#000000/g' \
	-e 's/#0000f7/#ff9900/g' \
	-e 's/#fffff7/#000000/g' \
	-e 's/#0000f8/#333333/g' \
	-e 's/#fffff8/#bfbfbf/g' \
	> $@
$(BASENAME)-$(THEME)/keepbelow.svg: src/keepbelow.svg
	@sed < $^ \
	-e 's/#0000f1/#800080/g' \
	-e 's/#fffff1/#ffffff/g' \
	-e 's/#0000f2/#00ff00/g' \
	-e 's/#fffff2/#000000/g' \
	-e 's/#0000f3/#ffcc00/g' \
	-e 's/#fffff3/#000000/g' \
	-e 's/#0000f4/#000000/g' \
	-e 's/#fffff4/#bfbfbf/g' \
	-e 's/#0000f5/#999999/g' \
	-e 's/#fffff5/#000000/g' \
	-e 's/#0000f6/#009900/g' \
	-e 's/#fffff6/#000000/g' \
	-e 's/#0000f7/#ff9900/g' \
	-e 's/#fffff7/#000000/g' \
	-e 's/#0000f8/#333333/g' \
	-e 's/#fffff8/#bfbfbf/g' \
	> $@
$(BASENAME)-$(THEME)/maximize.svg: src/maximize.svg
	@sed < $^ \
	-e 's/#0000f1/#800080/g' \
	-e 's/#fffff1/#ffffff/g' \
	-e 's/#0000f2/#00ff00/g' \
	-e 's/#fffff2/#000000/g' \
	-e 's/#0000f3/#ffcc00/g' \
	-e 's/#fffff3/#000000/g' \
	-e 's/#0000f4/#000000/g' \
	-e 's/#fffff4/#bfbfbf/g' \
	-e 's/#0000f5/#999999/g' \
	-e 's/#fffff5/#000000/g' \
	-e 's/#0000f6/#009900/g' \
	-e 's/#fffff6/#000000/g' \
	-e 's/#0000f7/#ff9900/g' \
	-e 's/#fffff7/#000000/g' \
	-e 's/#0000f8/#333333/g' \
	-e 's/#fffff8/#bfbfbf/g' \
	> $@
$(BASENAME)-$(THEME)/menu.svg: src/menu.svg
	@sed < $^ \
	-e 's/#0000f1/#800080/g' \
	-e 's/#fffff1/#ffffff/g' \
	-e 's/#0000f2/#00ff00/g' \
	-e 's/#fffff2/#000000/g' \
	-e 's/#0000f3/#ffcc00/g' \
	-e 's/#fffff3/#000000/g' \
	-e 's/#0000f4/#000000/g' \
	-e 's/#fffff4/#bfbfbf/g' \
	-e 's/#0000f5/#999999/g' \
	-e 's/#fffff5/#000000/g' \
	-e 's/#0000f6/#009900/g' \
	-e 's/#fffff6/#000000/g' \
	-e 's/#0000f7/#ff9900/g' \
	-e 's/#fffff7/#000000/g' \
	-e 's/#0000f8/#333333/g' \
	-e 's/#fffff8/#bfbfbf/g' \
	> $@
$(BASENAME)-$(THEME)/minimize.svg: src/minimize.svg
	@sed < $^ \
	-e 's/#0000f1/#800080/g' \
	-e 's/#fffff1/#ffffff/g' \
	-e 's/#0000f2/#00ff00/g' \
	-e 's/#fffff2/#000000/g' \
	-e 's/#0000f3/#ffcc00/g' \
	-e 's/#fffff3/#000000/g' \
	-e 's/#0000f4/#000000/g' \
	-e 's/#fffff4/#bfbfbf/g' \
	-e 's/#0000f5/#999999/g' \
	-e 's/#fffff5/#000000/g' \
	-e 's/#0000f6/#009900/g' \
	-e 's/#fffff6/#000000/g' \
	-e 's/#0000f7/#ff9900/g' \
	-e 's/#fffff7/#000000/g' \
	-e 's/#0000f8/#333333/g' \
	-e 's/#fffff8/#bfbfbf/g' \
	> $@
$(BASENAME)-$(THEME)/restore.svg: src/restore.svg
	@sed < $^ \
	-e 's/#0000f1/#800080/g' \
	-e 's/#fffff1/#000000/g' \
	-e 's/#0000f2/#00ff00/g' \
	-e 's/#fffff2/#000000/g' \
	-e 's/#0000f3/#ffcc00/g' \
	-e 's/#fffff3/#000000/g' \
	-e 's/#0000f4/#000000/g' \
	-e 's/#fffff4/#bfbfbf/g' \
	-e 's/#0000f5/#999999/g' \
	-e 's/#fffff5/#000000/g' \
	-e 's/#0000f6/#009900/g' \
	-e 's/#fffff6/#000000/g' \
	-e 's/#0000f7/#ff9900/g' \
	-e 's/#fffff7/#000000/g' \
	-e 's/#0000f8/#333333/g' \
	-e 's/#fffff8/#bfbfbf/g' \
	> $@
$(BASENAME)-$(THEME)/shade.svg: src/shade.svg
	@sed < $^ \
	-e 's/#0000f1/#800080/g' \
	-e 's/#fffff1/#ffffff/g' \
	-e 's/#0000f2/#00ff00/g' \
	-e 's/#fffff2/#000000/g' \
	-e 's/#0000f3/#ffcc00/g' \
	-e 's/#fffff3/#000000/g' \
	-e 's/#0000f4/#000000/g' \
	-e 's/#fffff4/#bfbfbf/g' \
	-e 's/#0000f5/#999999/g' \
	-e 's/#fffff5/#000000/g' \
	-e 's/#0000f6/#009900/g' \
	-e 's/#fffff6/#000000/g' \
	-e 's/#0000f7/#ff9900/g' \
	-e 's/#fffff7/#000000/g' \
	-e 's/#0000f8/#333333/g' \
	-e 's/#fffff8/#bfbfbf/g' \
	> $@
