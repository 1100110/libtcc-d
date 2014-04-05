import deimos.tcc;
import std.string;
pragma(lib, "tcc");
/**
    Example shows compiling a file to an object, but not linking or running it.
*/

enum CFile = "views/helloWorld.c";

void main()
{
    /// Create the State & handle deletion on exit.
    auto state = tcc_new();
    scope(exit)
        state.tcc_delete();

    /// Tell it output to object.
    state.tcc_set_output_type(TCC_OUTPUT_OBJ);

    /// Read in the file.
    state.tcc_add_file( CFile.toStringz);

    /// Lastly, tell it where to write the file.
    state.tcc_output_file( "helloWorld.o".toStringz);
}
