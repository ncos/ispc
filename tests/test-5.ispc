
export uniform int width() { return programCount; }


export void f_f(uniform float RET[], uniform float aFOO[]) {
    float a = aFOO[programIndex];
    uniform float b;
    b = 1.;
    RET[programIndex] = a + b;
}


export void result(uniform float RET[]) {
    RET[programIndex] = 2+programIndex;
}
