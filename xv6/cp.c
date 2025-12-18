#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
  int srcfd, dstfd;

  if(argc != 3){
    printf(2, "Usage: _cp source dest\n");
    exit();
  }

  if((srcfd = open(argv[1], O_RDONLY)) < 0){
    printf(2, "_cp: cannot open %s\n", argv[1]);
    exit();
  }

  if((dstfd = open(argv[2], O_WRONLY | O_CREATE)) < 0){
    printf(2, "_cp: cannot open %s\n", argv[2]);
    close(srcfd);
    exit();
  }

  if(copyfd(srcfd, dstfd) < 0){
    printf(2, "_cp: copy error\n");
    close(srcfd);
    close(dstfd);
    exit();
  }

  close(srcfd);
  close(dstfd);

  // Print only on successful copy
  printf(1, "cp successful\n");

  exit();
}
