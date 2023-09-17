#include "my_application.h"
#include <iostream>
#include <unistd.h>

int main(int argc, char** argv) {

    if(setuid(0) == 0 ) {
      std::cout << "Root is granted" << std::endl;
    }
    else {
      std::cout << "Rroot is not granted" << std::endl;
    }

  g_autoptr(MyApplication) app = my_application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
