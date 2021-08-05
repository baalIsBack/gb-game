
PRODUCT_NAME = demo
SRC_DIR=src
OBJ_SRC_DIR=obj
ASSET_DIR=assets
OBJ_ASSET_DIR=obj_assets

ASSEMBLER=rgbasm
ASSEMBLER_FLAGS=-Wall -L

LINKER=rgblink
LINKER_FLAGS=-n $(PRODUCT_NAME).sym

FIXER=rgbfix
FIXER_FLAGS= -v -p 0xFF



SRC=$(wildcard $(SRC_DIR)/*.asm)
ASSET=$(wildcard $(ASSET_DIR)/*.asm)
OBJ_SRC=$(patsubst $(SRC_DIR)/%.asm, $(OBJ_SRC_DIR)/%.o, $(SRC))
OBJ_ASSET=$(patsubst $(ASSET_DIR)/%.asm, $(OBJ_ASSET_DIR)/%.o, $(ASSET))



all: $(PRODUCT_NAME).gb
	@echo "Done"

$(PRODUCT_NAME).gb: $(OBJ_SRC) $(OBJ_ASSET)
	$(LINKER) $(LINKER_FLAGS) -o $@ $^
	$(FIXER) $(FIXER_FLAGS) $@ $@

$(OBJ_SRC_DIR)/%.o: $(SRC_DIR)/%.asm
	$(ASSEMBLER) $(ASSEMBLER_FLAGS) -o $@ $^

$(OBJ_ASSET_DIR)/%.o: $(ASSET_DIR)/%.asm
	$(ASSEMBLER) $(ASSEMBLER_FLAGS) -o $@ $^

.PHONY: all clean

clean:
	@echo "Clean"
	rm -f $(OBJ_SRC) $(OBJ_ASSET) $(PRODUCT_NAME).gb $(PRODUCT_NAME).sym