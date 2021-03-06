ifndef DEBUG
# Default: compile for debug
DEBUG=1
endif
#PROFILE=1

CC = gcc

BASICFLAGS= -std=c11

DEBUGFLAGS= -g 
OPTFLAGS= -g -finline -march=native -O3 -DNDEBUG

ifeq ($(PROFILE),1)
PROFFLAGS= -g -pg 
PLFLAGS= -g -pg
else
PROFFLAGS= 
PLFLAGS=
endif

INCLUDE_PATH=-I. 

CFLAGS= -Wall -D_GNU_SOURCE $(BASICFLAGS)

ifeq ($(DEBUG),1)
CFLAGS+=  $(DEBUGFLAGS) $(PROFFLAGS) $(INCLUDE_PATH)
else
CFLAGS+=  $(OPTFLAGS) $(PROFFLAGS) $(INCLUDE_PATH)
endif

LDFLAGS= $(PLFLAGS) $(BASICFLAGS)
LIBS=-lfl
FLEX=flex
BISON=bison

#------------------------------------------
# app
#------------------------------------------

PATH_TO_SRC= ./src/
PATH_TO_BIN= ./bin/
PATH_TO_BUILD= ./build/
C_PROG= ptucc ptucc_scan sample001
C_SOURCES= $(PATH_TO_SRC)ptucc.c $(PATH_TO_SRC)ptucc_scan.c $(PATH_TO_SRC)cgen.c
C_GEN=ptucc_lex.c ptucc_parser.tab.h ptucc_parser.tab.c sample001.c

C_SRC= $(C_SOURCES) $(C_GEN)

C_OBJECTS=$(C_SRC:.c=.o)

all: bison_compile flex_compile src_compile

flex_compile:
	$(FLEX) -o ptucc_lex.c $(PATH_TO_SRC)ptucc_lex.l

bison_compile: 
	$(BISON) -d -v -r all $(PATH_TO_SRC)ptucc_parser.y

src_compile:
	mkdir -p ${PATH_TO_BUILD}
	mkdir -p ${PATH_TO_BIN}
	mv ptucc_lex.c ${PATH_TO_BUILD}
	mv ptucc_parser.tab.c ${PATH_TO_BUILD}
	mv ptucc_parser.tab.h ${PATH_TO_BUILD}
	mv ptucc_parser.output ${PATH_TO_BUILD}
	$(CC) $(CFLAGS) -o fl_compiler ${PATH_TO_BUILD}ptucc_lex.c ${PATH_TO_BUILD}ptucc_parser.tab.c ${PATH_TO_SRC}cgen.c ${PATH_TO_SRC}ptucc.c $(LIBS)
	mv fl_compiler ${PATH_TO_BIN}

clean:
	$(RM) -r ${PATH_TO_BIN} ${PATH_TO_BUILD}
	$(RM) ./test/demoSamples/*.c
	$(RM) ./test/samples/*.c
	$(RM) runMe