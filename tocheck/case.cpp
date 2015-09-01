#include <case.ispc.h>


int main (int argc, char** argv)
{
    int a[2] = {1,1};
    int b[2] = {0,1};

    return ispc::test_ternary (a, b, 2);
}
