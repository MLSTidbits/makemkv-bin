LIBEBML_INC=libebml/inc

LIBEBML_DEF=-DEBML_NO_READ -DEBML_STRICT_API -DEBML_DEBUG

LIBEBML_SRC=libebml/src/EbmlBinary.cpp \
	libebml/src/EbmlContexts.cpp libebml/src/EbmlCrc32.cpp \
  	libebml/src/EbmlDate.cpp libebml/src/EbmlDummy.cpp \
	libebml/src/EbmlElement.cpp libebml/src/EbmlFloat.cpp \
  	libebml/src/EbmlHead.cpp libebml/src/EbmlMaster.cpp \
	libebml/src/EbmlSInteger.cpp libebml/src/EbmlString.cpp \
	libebml/src/EbmlSubHead.cpp libebml/src/EbmlUInteger.cpp \
	libebml/src/EbmlUnicodeString.cpp libebml/src/EbmlVersion.cpp \
	libebml/src/EbmlVoid.cpp libebml/src/IOCallback.cpp \
	libebml/src/MemIOCallback.cpp
