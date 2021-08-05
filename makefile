
PRODUCT_NAME = demo
OBJDIR=obj
SRCDIR=src

ASSEMBLER=rgbasm
ASSEMBLER_FLAGS=-Wall -L

LINKER=rgblink
LINKER_FLAGS=-n $(PRODUCT_NAME).sym

FIXER=rgbfix
FIXER_FLAGS= -v -p 0xFF



SRC=$(wildcard $(SRCDIR)/*.asm)
OBJ=$(patsubst $(SRCDIR)/%.asm, $(OBJDIR)/%.o, $(SRC))

all: $(PRODUCT_NAME).gb
	@echo "Done"

$(PRODUCT_NAME).gb: $(OBJ)
	$(LINKER) $(LINKER_FLAGS) -o $@ $^
	$(FIXER) $(FIXER_FLAGS) $@ $@

$(OBJDIR)/%.o: $(SRCDIR)/%.asm
	$(ASSEMBLER) $(ASSEMBLER_FLAGS) -o $@ $^

.PHONY: all clean

clean:
	@echo "Clean"
	rm -f $(OBJ) $(PRODUCT_NAME).gb $(PRODUCT_NAME).sym