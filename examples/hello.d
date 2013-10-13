import deimos.libtcc.libtcc;
pragma(lib, "tcc");
/**
    Example that shows dynamically generating and running a C Example.
    It also shows most of the checks you should do to spot errors.
*/
enum helloC = // Simple hello world C example.
    "int main()\n{\n\tprintf(\"Hello World!\");\n\treturn 9;\n}\n";


void main()
{
    import std.stdio;
    import std.string: toStringz;

    /// Create a new TranslationUnit.
    auto tccstate = tcc_new();
    /// Delete the TranslationUnit upon leaving main.
    scope(exit)
        tcc_delete(tccstate);

    /// Assert if Error.
    assert( 0 <= tcc_compile_string(tccstate, helloC.toStringz)  );

    writefln( "Running:\n%s", helloC);
    /// Now run the new file passing along the args.
    /// tcc_run( tccstate, int argc, char** argv);
    auto ret = tcc_run(tccstate, 0, null);
    assert( 9 == ret );

    writefln( "\nreturned: %s", ret);
}
