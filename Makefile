# ChemicalRascal's SeaBlock Rebalance Makefile
#
# Uses jq: https://stedolan.github.io/jq/
# You should use jq too. Fact. On Windows, chocolatey is a good way to install it.

NAME = $(shell jq .name src/info.json)
VER  = $(shell jq .version src/info.json)

FOLPATH = $(NAME)_$(VER)
ZIPPATH = $(NAME)_$(VER).zip
SRCPATH = src

.PHONY: all
all: build

.PHONY: build
build: clean
	cp -r $(SRCPATH) $(FOLPATH)
	zip -0r $(ZIPPATH) $(FOLPATH)
	rm -rf $(FOLPATH)

.PHONY: clean
clean:
	rm -rf $(FOLPATH) $(ZIPPATH)