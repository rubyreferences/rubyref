# DSL

Simple DSL implementation for Ripper code generation

input:   % ripper: stmts_add(stmts_new, void_stmt) %

output:
    VALUE v1, v2;
    v1 = dispatch0(stmts_new);
    v2 = dispatch0(void_stmt);
    $$ = dispatch2(stmts_add, v1, v2);