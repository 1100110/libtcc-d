import deimos.libtcc.libtcc;
import std.string;
import std.stdio;
pragma(lib, "tcc");

enum CFile = "views/helloWorld.c";

void main()
{
    auto tccstate = tcc_new();
    scope(exit)
        tcc_delete(tccstate);

    auto ret = tcc_add_file(tccstate, CFile.toStringz);
    assert( ret == 0 );

    ret = tcc_run( tccstate, 0, null);
    assert( ret == 9 );
}
