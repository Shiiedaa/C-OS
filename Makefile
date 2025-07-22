#search all .asm files inside path
x86_64_asm_source_files := $(shell find src/imp/x86_64 -name '*.asm') 
#convert .asm src path to .o object file path in dir
x86_64_asm_object_files := $(patsubst src/imp/x86_64/%.asm, build/x86_64/%.o, $(x86_64_asm_source_files))

#build each .o listed used src file from same name but in src path, with asm extension
$(x86_64_asm_object_files): build/x86_64/%.o: src/imp/x86_64/%.asm
	mkdir -p $(dir $@) && \
	nasm -f elf64 $< -o $@

#make build label for commands instead of file
.PHONY: build-x86_64


#build bootable ISO
build-x86_64: $(x86_64_asm_object_files)
	mkdir -p dist/x86_64 && \
	x86_64-elf-ld -n -o dist/x86_64/kernel.bin -T target/x86_64/linker.ld $(x86_64_asm_object_files) && \
	cp dist/x86_64/kernel.bin target/x86_64/iso/boot/kernel.bin && \
	grub-mkrescue /usr/lib/grub/i386-pc -o dist/x86_64/kernel.iso target/x86_64/iso