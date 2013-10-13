import deimos.libtcc.libtcc;
import std.string;
pragma(lib, "tcc");
/**
    Example shows compiling a file to an executable, but not running it.
*/

enum CFile = "views/helloWorld.c";

void main()
{
    /// Create the State & handle deletion on exit.
    auto state = tcc_new();
    scope(exit)
        state.tcc_delete();

    /// Tell it output to executable.
    state.tcc_set_output_type(TCC_OUTPUT_EXE);
    /// Read in the file.
    state.tcc_add_file( CFile.toStringz);
    /// Lastly, tell it where to write the file.
    state.tcc_output_file( "views/helloCWorld".toStringz);
}
