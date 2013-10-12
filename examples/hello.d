import deimos.libtcc.libtcc;
import std.string;

enum helloC = "int main() { printf(\"Hello World!\"); return 0; }";

pragma(lib, "tcc");

void main()
{
    auto state = tcc_new();
    auto err = tcc_compile_string(state, helloC.toStringz);
    assert( err >= 0 );

    tcc_run(state, 0, null);
}
