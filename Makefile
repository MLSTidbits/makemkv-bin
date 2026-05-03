include mmccextr/mmccextr.mak
include libdriveio/libdriveio.mk
include libebml/libebml.mk
include libmatroska/libmatroska.mk
include sstring/sstring.mk
include libabi/libabi.mk
include makemkvgui/makemkvgui.mk
include libffabi/libffabi.mk
include libmakemkv/libmakemkv.mk
include libmmbd/libmmbd.mk
include mmgpl/mmgpl.mk

BUILD_DIR = _build
DOC_DIR = doc
MAN_DIR = man

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
datarootdir=${prefix}/share
datadir=${datarootdir}/MakeMKV
mandir=${datarootdir}/man
firmwaredir=${libdir}/libredrive/firmware
FFMPEG_CFLAGS=-I/usr/include/x86_64-linux-gnu
FFMPEG_LIBS=-lavcodec -lavutil -lrt
ENABLE_DEBUG=no
NO_EC_DEF=
INSTALL=/usr/bin/install -c
OBJCOPY=objcopy
LD=/usr/bin/ld -m elf_x86_64
BUILDINFO_ARCH_NAME=$(shell $(GCC) -dumpmachine)
BUILDINFO_BUILD_DATE=$(shell date)

MMGPL_DEF=

top_srcdir ?= .
INCF=-I$(top_srcdir)/

ifeq ($(ENABLE_DEBUG),no)
STRIP_FLAGS=--strip-all --strip-debug --strip-unneeded --discard-all
CFLAGS=-O2 -D_linux_ -Wno-deprecated-declarations
CXXFLAGS=-O2
FINALISE=strip
else
FINALISE=copy
endif

LIBABI_OBJ   := $(patsubst %,tmp/%.o,$(LIBABI_SRC))
LIBFFABI_OBJ := $(patsubst %,tmp/%.o,$(LIBFFABI_SRC))
MMCCX_SRC    := $(patsubst %,mmccextr/%,$(MMCCEXTR_SRC))

DOCS = README.md \
	CODE_OF_CONDUCT.md \
	CONTRIBUTING.md \
	doc/version \
	doc/copyright \
	doc/eula

.PHONY: all clean install \
	_build/libdriveio.so.0 \
	_build/libmakemkv.so.1\
	_build/libmmbd.so.0\
	_build/mmccextr\
	_build/mmgplsrv \
	_build/bin \
	_build/man \
	_build/data \
	_build/doc

all: _build/libdriveio.so.0 \
	_build/libmakemkv.so.1 \
	_build/libmmbd.so.0 \
	_build/mmccextr \
	_build/mmgplsrv \
	_build/bin \
	_build/man \
	_build/data \
	_build/doc

clean:
	@rm -vrf _build tmp
	@rm -vf libdriveio/libdriveio.so.0.full
	@rm -vf libmakemkv/libmakemkv.so.1.full
	@rm -vf libmmbd/libmmbd.so.0.full
	@rm -vf mmccextr/mmccextr.full
	@rm -vf mmgpl/mmgplsrv.full

install: _build/libdriveio.so.0 _build/libmakemkv.so.1 _build/libmmbd.so.0 \
	_build/mmccextr _build/mmgplsrv _build/makemkvcon _build/man _build/data
	$(INSTALL) -D -m 755 _build/makemkvcon        $(DESTDIR)$(bindir)/makemkvcon
	$(INSTALL) -D -m 755 bin/sdftool              $(DESTDIR)$(bindir)/sdftool
	$(INSTALL) -D -m 644 _build/libdriveio.so.0   $(DESTDIR)$(libdir)/libdriveio.so.0
	$(INSTALL) -D -m 644 _build/libmakemkv.so.1   $(DESTDIR)$(libdir)/libmakemkv.so.1
	$(INSTALL) -D -m 644 _build/libmmbd.so.0      $(DESTDIR)$(libdir)/libmmbd.so.0
ifeq ($(DESTDIR),)
	ldconfig
endif
	$(INSTALL) -D -m 755 _build/mmccextr          $(DESTDIR)$(bindir)/mmccextr
	$(INSTALL) -D -m 755 _build/mmgplsrv          $(DESTDIR)$(bindir)/mmgplsrv
	$(INSTALL) -D -m 644 _build/data/appdata.tar  $(DESTDIR)$(datadir)/appdata.tar
	$(INSTALL) -D -m 644 _build/data/blues.jar    $(DESTDIR)$(datadir)/blues.jar
	$(INSTALL) -D -m 644 _build/data/blues.policy $(DESTDIR)$(datadir)/blues.policy
	@for f in data/Internal/*; do \
		$(INSTALL) -D -m 644 "$$f" "$(DESTDIR)$(firmwaredir)/internal/$$(basename $$f)"; \
	done
	@for f in data/Slim/*; do \
		$(INSTALL) -D -m 644 "$$f" "$(DESTDIR)$(firmwaredir)/slim/$$(basename $$f)"; \
	done
	@for f in _build/man/*.1; do \
		$(INSTALL) -D -m 644 "$$f" "$(DESTDIR)$(mandir)/man1/$$(basename $$f)"; \
	done

# ── Finalize — strip (release) or copy (debug) into _build/ ──────────────── #

_build/libdriveio.so.0: libdriveio/libdriveio.so.0.full
	@mkdir -p _build
ifeq ($(FINALISE),strip)
	@echo "\e[1;33mST\e[0m  $@"
	@$(OBJCOPY) $(STRIP_FLAGS) $< $@
else
	@echo "\e[1;34mCP\e[0m   $@"
	@cp $< $@
endif

_build/libmakemkv.so.1: libmakemkv/libmakemkv.so.1.full
	@mkdir -p _build
ifeq ($(FINALISE),strip)
	@echo "\e[1;33mST\e[0m  $@"
	@$(OBJCOPY) $(STRIP_FLAGS) $< $@
else
	@echo "\e[1;34mCP\e[0m   $@"
	@cp $< $@
endif

_build/libmmbd.so.0: libmmbd/libmmbd.so.0.full
	@mkdir -p _build
ifeq ($(FINALISE),strip)
	@echo "\e[1;33mST\e[0m  $@"
	@$(OBJCOPY) $(STRIP_FLAGS) $< $@
else
	@echo "\e[1;34mCP\e[0m   $@"
	@cp $< $@
endif

_build/mmccextr: mmccextr/mmccextr.full
	@mkdir -p _build
ifeq ($(FINALISE),strip)
	@echo "\e[1;33mST\e[0m  $@"
	@$(OBJCOPY) $(STRIP_FLAGS) $< $@
else
	@echo "\e[1;34mCP\e[0m   $@"
	@cp $< $@
endif

_build/mmgplsrv: mmgpl/mmgplsrv.full
	@mkdir -p _build
ifeq ($(FINALISE),strip)
	@echo "\e[1;33mST\e[0m  $@"
	@$(OBJCOPY) $(STRIP_FLAGS) $< $@
else
	@echo "\e[1;34mCP\e[0m   $@"
	@cp $< $@
endif

_build/bin:
	@mkdir -p $@
	@echo "\e[1;32mCP\e[0m  $@"
	@cp -f bin/* $@/

_build/man:
	@mkdir -p $@
	@if ! command -v pandoc >/dev/null 2>&1; then \
		echo 'pandoc could not be found. Please install pandoc to build the manual page.'; \
		exit 1; \
	fi

	@for manpage in $(MAN_DIR)/*.md ; do \
		output=$@/$$(basename "$${manpage%.md}"); \
		echo "\e[1;32mMD\e[0m  $@/$$(basename "$${manpage%.md}")"; \
		pandoc -s -t man -o "$$output" "$$manpage"; \
	done

_build/data:
	@mkdir -p $@
	@echo "\e[1;32mCP\e[0m $@"
	@cp -R data/* $@/

_build/doc:
	@mkdir -p $@
	@for d in $(DOCS) ; do \
		echo "\e[1;32mCP\e[0m $$d"; \
		cp $$d $@/; \
	done

# ── Compile unstripped binaries into source directories ───────────────────── #

libdriveio/libdriveio.so.0.full: tmp/gen_buildinfo.h
	@echo "\e[1;32mLD\e[0m  $@"
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
	@echo "\e[1;32mCC\e[0m  $<"
	@$(GCC) -c $(CFLAGS) \
		$(NO_EC_DEF) \
		-D_GNU_SOURCE \
		-D_REENTRANT -o$@ \
		$(INCF)$(LIBABI_INC) \
		$(INCF)$(LIBFFABI_INC) \
		-DHAVE_BUILDINFO_H \
		-Itmp $(FFMPEG_CFLAGS) \
		-fPIC $<

libmakemkv/libmakemkv.so.1.full: tmp/gen_buildinfo.h $(LIBABI_OBJ) $(LIBFFABI_OBJ)
	@echo "\e[1;32mLD\e[0m  $@"
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

libmmbd/libmmbd.so.0.full: tmp/gen_buildinfo.h $(LIBABI_OBJ) $(LIBFFABI_OBJ)
	@echo "\e[1;32mLD\e[0m  $@"
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

mmccextr/mmccextr.full: $(MMCCX_SRC) tmp/gen_buildinfo.h
	@echo "\e[1;32mCC\e[0m  $@"
	@$(GCC) $(CFLAGS) $(LDFLAGS) $(MMCCEXTR_DEF) -DHAVE_BUILDINFO_H -Itmp -D_GNU_SOURCE -o$@ $(MMCCX_SRC) -lc \
	-ffunction-sections -Wl,--gc-sections -Wl,-z,defs

mmgpl/mmgplsrv.full: $(MMGPL_SRC) tmp/gen_buildinfo.h
	@echo "\e[1;32mCC\e[0m  $@"
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

# ── Build info header ─────────────────────────────────────────────────────── #

tmp/gen_buildinfo.h:
	@mkdir -p tmp
	@printf '#define BUILDINFO_ARCH_NAME "%s"\n#define BUILDINFO_BUILD_DATE "%s"\n' \
		"$(BUILDINFO_ARCH_NAME)" "$(BUILDINFO_BUILD_DATE)" > $@
