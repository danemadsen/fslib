CC=c99
CFLAGS=-I./src -I./examples -I./examples/../src -O3

SRC := src
OBJ := obj
BIN := bin
TST := test

dir_guard=@mkdir -p $(@D)

_OBJECTS := compile.o sr.o fst.o sort.o queue.o bitset.o print.o draw.o compose.o shortest.o match.o heap.o iter.o trim.o
OBJECTS := $(patsubst %, $(OBJ)/%, $(_OBJECTS))

TESTS := test_fst test_queue test_bitset test_print test_iter test_io test_compile test_sort test_hash test_stack test_trim test_compose test_heap test_shortest test_symt

BINARIES := fscompile fsprint fsstat fssort fsdraw fscompose fsshort

binaries: $(BINARIES)
all: tests $(BINARIES)

$(OBJ)/%.o: $(SRC)/%.c
	@mkdir -p $(@D)
	$(CC) -I$(SRC) -c $< -o $@

$(TESTS): $(OBJECTS) 
	@mkdir -p $(TST)
	$(CC) $^ -o $(TST)/$@ $(TST)/$@.c

tests: $(TESTS)
	echo -e "one 1\ntwo 2" > $(TST)/test_symt.txt
	@$(foreach x, $(TESTS), $(TST)/$x;)

$(BINARIES): $(OBJECTS) 
	@mkdir -p $(BIN)
	$(CC) $(CFLAGS) $^ -o $(BIN)/$@ ./examples/$@.c

.PHONY: clean

clean:
	@rm -f $(OBJ)/*.o
	@rm -f $(BIN)/fs*
	@rm -df $(OBJ)
	@rm -df $(BIN)
