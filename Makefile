
CFLAGS = -m32 -O0 -g3

all: align_4 align_8

mrblib:
	cd mruby && CONFIG=../my_build.rb rake

align_4: mrblib main.c estalloc/estalloc.c estalloc/estalloc.h
	cc -DESTALLOC_ALIGNMENT=4 \
		$(CFLAGS) \
		-o build/$@ \
		main.c \
		estalloc/estalloc.c \
		-Imruby/include \
		-L./mruby/build/my_build/lib -lmruby \
		-lm

align_8: mrblib main.c estalloc/estalloc.c estalloc/estalloc.h
	cc -DESTALLOC_ALIGNMENT=8 \
		$(CFLAGS) \
		-o build/$@ \
		main.c \
		estalloc/estalloc.c \
		-Imruby/include \
		-L./mruby/build/my_build/lib -lmruby \
		-lm

phony: clean

clean:
	rm -f build/align_4 build/align_8
	cd mruby && CONFIG=../my_build.rb rake clean
