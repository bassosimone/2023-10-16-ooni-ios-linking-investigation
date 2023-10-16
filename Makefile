all: src/app/app

src/app/app: src/libtor/libtor.a src/libgo/libgo.a src/app/main.o
	gcc -Lsrc/libtor -Lsrc/libgo -ltor -lgo src/app/main.o -o src/app/app

src/app/main.o: src/app/main.c src/libgo/libgo.h
	gcc -fPIE -Wall -Wextra -I. -c src/app/main.c -o src/app/main.o

src/libtor/libtor.a: src/libtor/libtor.o
	ar crv src/libtor/libtor.a src/libtor/libtor.o

src/libtor/libtor.o: src/libtor/libtor.c src/libtor/libtor.h
	gcc -fPIC -Wall -Wextra -c src/libtor/libtor.c -I. -o src/libtor/libtor.o

src/libgo/libgo.a: src/libgo/libgo.o
	ar crv src/libgo/libgo.a src/libgo/libgo.o

src/libgo/libgo.o: src/libgo/libgo.c src/libgo/libgo.h
	# Note well: here we add linker flags, which should have no effect
	# whatsoever because we're creating a static library.
	gcc -fPIC -Wall -Wextra -Lsrc/libtor -ltor -c src/libgo/libgo.c -I. -o src/libgo/libgo.o

.PHONY: clean
clean:
	rm -rf src/app/app src/app/main.o src/libtor/libtor.a src/libtor/libtor.o src/libgo/libgo.a src/libgo/libgo.o
