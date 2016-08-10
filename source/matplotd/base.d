/**
All modules need to import this.
*/

module matplotd.base;

shared static this() {
    import pyd.pyd : py_init;
    py_init();
}
