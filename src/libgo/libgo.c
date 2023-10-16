#include "src/libtor/libtor.h"

void *libgo_init(void) {
	void *tor = tor_config_new();
	return tor;
}
