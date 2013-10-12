module deimos.libtcc.libtcc;

extern (C) nothrow:

struct TCCState{}

TCCState tccstate;

/* create a new TCC compilation context */
TCCState* tcc_new();

/* free a TCC compilation context */
void tcc_delete(TCCState* s);

/* set CONFIG_TCCDIR at runtime */
void tcc_set_lib_path(TCCState* s, in char* path);

/* set error/warning display callback */
void tcc_set_error_func(TCCState* s, void* error_opaque,
    void function(void* opaque, in char* msg) error_func);

/* set options as from command line (multiple supported) */
int tcc_set_options(TCCState *s, in char *str);

/*****************************/
/* preprocessor */

/* add include path */
int tcc_add_include_path(TCCState* s, in char* pathname);

/* add in system include path */
int tcc_add_sysinclude_path(TCCState* s, in char* pathname);

/* define preprocessor symbol 'sym'. Can put optional value */
void tcc_define_symbol(TCCState* s, in char* sym, in char* value);

/* undefine preprocess symbol 'sym' */
void tcc_undefine_symbol(TCCState* s, in char* sym);

/*****************************/
/* compiling */

/* add a file (C file, dll, object, library, ld script). Return -1 if error. */
int tcc_add_file(TCCState* s, in char* filename);

/* compile a string containing a C source. Return -1 if error. */
int tcc_compile_string(TCCState* s, in char* buf);

/*****************************/
/* linking commands */

/* set output type. MUST BE CALLED before any compilation */
int tcc_set_output_type(TCCState* s, int output_type);

enum {
        TCC_OUTPUT_MEMORY   = 0, /* output will be run in memory (default) */
        TCC_OUTPUT_EXE      = 1, /* executable file */
        TCC_OUTPUT_DLL      = 2, /* dynamic library */
        TCC_OUTPUT_OBJ      = 3, /* object file */
        TCC_OUTPUT_PREPROCESS = 4, /* only preprocess (used internally) */
}

/* equivalent to -Lpath option */
int tcc_add_library_path(TCCState* s, in char* pathname);

/* the library name is the same as the argument of the '-l' option */
int tcc_add_library(TCCState* s, in char* libraryname);

/* add a symbol to the compiled program */
int tcc_add_symbol(TCCState* s, in char* name, in void* val);

/* output an executable, library or object file. DO NOT call
   tcc_relocate() before. */
int tcc_output_file(TCCState* s, in char* filename);

/* link and run main() function and return its value. DO NOT call
   tcc_relocate() before. */
int tcc_run(TCCState* s, int argc, char** argv);


/* do all relocations (needed before using tcc_get_symbol()) */
int tcc_relocate(TCCState* s1, void* ptr);
/* possible values for 'ptr':
   - TCC_RELOCATE_AUTO : Allocate and manage memory internally
   - NULL              : return required memory size for the step below
   - memory address    : copy code to memory passed by the caller
   returns -1 if error. */
enum TCC_RELOCATE_AUTO = cast(void*)1;

/* return symbol value or NULL if not found */
void* tcc_get_symbol(TCCState* s, in char* name);

