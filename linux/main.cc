#include "my_application.h"
#include <iostream>
#include <unistd.h>

int main(int argc, char** argv) {

  g_autoptr(MyApplication) app = my_application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
