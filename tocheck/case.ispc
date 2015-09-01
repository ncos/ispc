void 
ternary (
int aa,
int bb,
int & A)
{
    // if then else does the right thing
    if (bb != 0)
    {
        A = aa % bb;
        print ("% = aa %% bb\n", A);
    }
    else
    {
        A = 0.0;    
        print ("0.0\n");
    }
    // ternary operator fails
    A = bb != 0 ? aa % bb : 0;

    print ("A = %\n", A);

}

export uniform int 
test_ternary (
uniform int a[],
uniform int b[],
uniform int size)
{
    uniform int result;

    foreach (i = 0 ... size)
    {
        int A;

        ternary (a[i], b[i], A);

        result += reduce_add (A);
    }

    return result;
}
