#include "src/libgo/libgo.h"

#include <stdio.h>

int main() {
	fprintf(stdout, "%p\n", libgo_init());
}
