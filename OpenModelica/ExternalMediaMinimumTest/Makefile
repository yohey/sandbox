
PRJ = ExternalMediaMinimumTest
SRC = src/$(PRJ).cpp
LIB = Resources/Library/lib$(PRJ).a
INC = Resources/Include/$(PRJ).h
OMLIB = $(HOME)/.openmodelica/libraries/$(PRJ)


.PHONY: test clean


default: $(LIB) $(INC) $(OMLIB)


$(LIB): $(SRC)
	mkdir -p $(@D)
	$(CC) -c -o $@ $<


$(INC): $(subst Resources/Include, src, $(INC))
	mkdir -p $(@D)
	cp -a $< $@


$(OMLIB):
	ln -s $(CURDIR) $(OMLIB)


test: $(LIB) $(INC) $(OMLIB)
	cd test && $(MAKE) test


clean:
	$(RM) $(OMLIB)
	$(RM) -r Resources
	cd test && $(MAKE) clean
