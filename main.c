#include "mruby.h"
#include "mruby/compile.h"
#include "estalloc/estalloc.h"

#include <stdio.h>
#include <stdlib.h>

static void *
mrb_estalloc_allocf(mrb_state *mrb, void *p, size_t size, void *est)
{
  if (size == 0) {
    est_free(est, p);
    return NULL;
  }
  return est_realloc(est, p, size);
}

int
main(void)
{
  int bytes = 1024*100000;
  void *mem = malloc(bytes);
  ESTALLOC *est = est_init(mem, bytes);
  mrb_state *mrb = mrb_open_allocf(mrb_estalloc_allocf, est);
  if (mrb == NULL) {
    fprintf(stderr, "Invalid mrb_state\n");
    return 1;
  }
  const char *script = "a=[]; 10_000.times { |i| puts i; a << i }";
  mrb_load_string(mrb, script);
  mrb_close(mrb);
  free(mem);
  return 0;
}
