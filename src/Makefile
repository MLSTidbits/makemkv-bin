include makefile.common
include mmccextr/mmccextr.mak

GCC=gcc
GXX=g++ -std=c++11

CFLAGS=-g -O2 -D_linux_ -Wno-deprecated-declarations
CXXFLAGS=-g -O2
LDFLAGS=
DESTDIR=
prefix=/usr
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
bindir=${exec_prefix}/bin
FFMPEG_CFLAGS=-I/usr/include/x86_64-linux-gnu
FFMPEG_LIBS=-lavcodec -lavutil -lrt
ENABLE_DEBUG=no
NO_EC_DEF=
INSTALL=/usr/bin/install -c
OBJCOPY=objcopy
LD=/usr/bin/ld -m elf_x86_64
BUILDINFO_ARCH_NAME=$(shell $(GCC) -dumpmachine)
BUILDINFO_BUILD_DATE=$(shell date)

top_srcdir ?= .
INCF=-I$(top_srcdir)/

ifeq ($(ENABLE_DEBUG),no)
STRIP_FLAGS=--strip-all --strip-debug --strip-unneeded --discard-all
CFLAGS=-O2 -D_linux_ -Wno-deprecated-declarations
CXXFLAGS=-O2
endif

LIBABI_OBJ := $(patsubst %,tmp/%.o,$(LIBABI_SRC))
LIBFFABI_OBJ := $(patsubst %,tmp/%.o,$(LIBFFABI_SRC))
MMCCX_SRC := $(patsubst %,mmccextr/%,$(MMCCEXTR_SRC))

.PHONY: all clean install tmp/%.c.o out/% \
	build/libdriveio.so.0.full build/libmakemkv.so.1.full build/libmmbd.so.0.full build/mmccextr.full build/mmgplsrv.full

all: out/libdriveio.so.0 out/libmakemkv.so.1 out/libmmbd.so.0 out/mmccextr out/mmgplsrv

clean:
	@rm -rf out build tmp

install: out/libdriveio.so.0 out/libmakemkv.so.1 out/libmmbd.so.0 out/mmccextr out/mmgplsrv
	$(INSTALL) -D -m 644 out/libdriveio.so.0 $(DESTDIR)$(libdir)/libdriveio.so.0
	$(INSTALL) -D -m 644 out/libmakemkv.so.1 $(DESTDIR)$(libdir)/libmakemkv.so.1
	$(INSTALL) -D -m 644 out/libmmbd.so.0 $(DESTDIR)$(libdir)/libmmbd.so.0
ifeq ($(DESTDIR),)
	ldconfig
endif
	$(INSTALL) -D -m 755 out/mmccextr $(DESTDIR)$(bindir)/mmccextr
	$(INSTALL) -D -m 755 out/mmgplsrv $(DESTDIR)$(bindir)/mmgplsrv

# Strip unstripped binary from build/ into out/
out/%: build/%.full
	@mkdir -p out
	@echo "  \e[1;33mSTRIP\e[0m  $@"
	@$(OBJCOPY) $(STRIP_FLAGS) $< $@

build/libdriveio.so.0.full: tmp/gen_buildinfo.h
	@mkdir -p build
	@echo "  \e[1;32mLD\e[0m  $@"
	@$(GXX) $(CXXFLAGS) \
		$(CFLAGS) \
		$(LDFLAGS) \
		-D_REENTRANT \
		-shared \
		-Wl,-z,defs -o$@ \
		$(INCF)$(LIBDRIVEIO_INC) \
		$(LIBDRIVEIO_SRC) \
		-fPIC -Xlinker \
		-dy -Xlinker \
		--version-script=libdriveio/src/libdriveio.vers \
		-Xlinker \
		-soname=libdriveio.so.0 \
		-lc -lstdc++

tmp/%.c.o: %.c
	@mkdir -p $(dir $@)
	@echo "  \e[1;32mCC\e[0m  $@"
	@$(GCC) -c $(CFLAGS) \
		$(NO_EC_DEF) \
		-D_GNU_SOURCE \
		-D_REENTRANT -o$@ \
		$(INCF)$(LIBABI_INC) \
		$(INCF)$(LIBFFABI_INC) \
		-DHAVE_BUILDINFO_H \
		-Itmp $(FFMPEG_CFLAGS) \
		-fPIC $<

build/libmakemkv.so.1.full: tmp/gen_buildinfo.h $(LIBABI_OBJ) $(LIBFFABI_OBJ)
	@mkdir -p build
	@echo "  \e[1;32mLD\e[0m  $@"
	@$(GXX) $(CXXFLAGS) \
		$(CFLAGS) \
		$(LDFLAGS) \
		$(NO_EC_DEF) \
		-D_GNU_SOURCE \
		-D_REENTRANT \
		-shared -Wl,-z,defs \
		-o$@ $(INCF)$(LIBEBML_INC) \
		$(LIBEBML_DEF) \
		$(INCF)$(LIBMATROSKA_INC) \
		$(INCF)$(LIBMAKEMKV_INC) \
		$(INCF)$(SSTRING_INC) \
		$(INCF)$(MAKEMKV_INC) \
		$(INCF)$(LIBABI_INC) \
		$(INCF)$(LIBFFABI_INC) \
		$(LIBEBML_SRC) \
		$(LIBMATROSKA_SRC) \
		$(LIBMAKEMKV_SRC) \
		$(SSTRING_SRC) \
		$(LIBABI_SRC_LINUX) \
		$(LIBABI_OBJ) \
		$(LIBFFABI_OBJ) \
		-DHAVE_BUILDINFO_H -Itmp \
		-fPIC -Xlinker -dy -Xlinker \
		--version-script=libmakemkv/src/libmakemkv.vers \
		-Xlinker -soname=libmakemkv.so.1 \
		-lc -lstdc++ -lcrypto -lz -lexpat $(FFMPEG_LIBS) -lm -lrt

build/libmmbd.so.0.full: tmp/gen_buildinfo.h $(LIBABI_OBJ) $(LIBFFABI_OBJ)
	@mkdir -p build
	@echo "  \e[1;32mLD\e[0m  $@"
	@$(GXX) $(CXXFLAGS) \
		$(CFLAGS) \
		$(LDFLAGS) \
		-D_REENTRANT \
		-shared \
		-Wl,-z,defs -o$@ \
		$(INCF)$(MAKEMKV_INC) \
		$(INCF)$(LIBMMBD_INC) \
		$(INCF)$(LIBDRIVEIO_INC) \
		$(INCF)$(LIBMAKEMKV_INC) \
		$(INCF)$(SSTRING_INC) \
		$(INCF)$(LIBABI_INC) \
		$(LIBMMBD_SRC) \
		$(LIBMMBD_SRC_LINUX) \
		$(SSTRING_SRC) \
		$(LIBDRIVEIO_SRC_PUB) \
		-fPIC -Xlinker -dy -Xlinker \
		--version-script=libmmbd/src/libmmbd.vers \
		-Xlinker -soname=libmmbd.so.0 \
		-lc -lstdc++ -lrt -lpthread -lcrypto -ldl

build/mmccextr.full: $(MMCCX_SRC) tmp/gen_buildinfo.h
	@mkdir -p build
	@echo "  \e[1;32mCC\e[0m  $@"
	@$(GCC) $(CFLAGS) $(LDFLAGS) $(MMCCEXTR_DEF) -DHAVE_BUILDINFO_H -Itmp -D_GNU_SOURCE -o$@ $(MMCCX_SRC) -lc \
	-ffunction-sections -Wl,--gc-sections -Wl,-z,defs

build/mmgplsrv.full: $(MMGPL_SRC) tmp/gen_buildinfo.h
	@mkdir -p build
	@echo "  \e[1;32mCC\e[0m  $@"
	@$(GCC) $(CFLAGS) \
	$(LDFLAGS) \
	$(INCF)$(MMGPL_INC) \
	$(INCF)$(DVDNAV_INC) \
	$(INCF)$(DVDREAD_INC) \
	$(INCF)$(MAKEMKV_INC) \
	$(INCF)$(LIBMAKEMKV_INC) \
	$(INCF)$(LIBDRIVEIO_INC) \
	$(INCF)$(LIBABI_INC) \
	$(MMGPL_DEF) \
	-D_GNU_SOURCE -Dstl=std \
	-o$@ $(MMGPL_SRC) \
	$(MMGPL_SRC_LINUX) -lc -lstdc++ \
	-ffunction-sections -Wl,--gc-sections -Wl,-z,defs

tmp/gen_buildinfo.h:
	@mkdir -p tmp
	@printf '#define BUILDINFO_ARCH_NAME "%s"\n#define BUILDINFO_BUILD_DATE "%s"\n' \
		"$(BUILDINFO_ARCH_NAME)" "$(BUILDINFO_BUILD_DATE)" > $@


