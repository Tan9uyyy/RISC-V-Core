EXEC=firmware_words

all: $(EXEC)

firmware_words: femto_elf.o firmware_words.o
	g++ -o $@ $^

femto_elf.o: femto_elf.cpp
	g++ -O2 -DSTANDALONE_FEMTOELF $^ -c -o $@

firmware_words.o: firmware_words.cpp
	g++ -O2 -DSTANDALONE_FEMTOELF $^ -c -o $@

clean:
	rm -rf *.o
	rm -rf $(EXEC)
