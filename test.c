#include <stdio.h>

int main(int argc, char* argv[])
{
    int i;
    for(i = 0; i < argc; i++){
        fprintf(stderr,"E: %s\n",argv[i]);
        fprintf(stdout,"O: %s\n",argv[i]);
    }
}
