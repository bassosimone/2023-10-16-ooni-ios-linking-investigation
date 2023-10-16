This repository shows that, when compiling C code, linker flags
are not picked up by the compiler, which actually warns when passed
linker flags.

Here's what happens when running on macOS (our target environment):

```console
% make
gcc -fPIC -Wall -Wextra -c src/libtor/libtor.c -I. -o src/libtor/libtor.o
ar crv src/libtor/libtor.a src/libtor/libtor.o
a - src/libtor/libtor.o
gcc -fPIC -Wall -Wextra -Lsrc/libtor -ltor -c src/libgo/libgo.c -I. -o src/libgo/libgo.o
clang: warning: -ltor: 'linker' input unused [-Wunused-command-line-argument]
clang: warning: argument unused during compilation: '-Lsrc/libtor' [-Wunused-command-line-argument]
ar crv src/libgo/libgo.a src/libgo/libgo.o
a - src/libgo/libgo.o
gcc -fPIE -Wall -Wextra -I. -c src/app/main.c -o src/app/main.o
gcc -Lsrc/libtor -Lsrc/libgo -ltor -lgo src/app/main.o -o src/app/app
```

You can see for yourself two warnings about unused linker flags.
