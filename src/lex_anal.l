%{
#define YYSTYPE char *
#define _DUPTEXT {yylval = strdup(yytext);}
#include "y.tab.h"
int cur_line = 1;
void yyerror();
%}


WHITESPACE          ([ \t\r\a]+)
COMMENT             ("//"[^\n]*)
OPERATOR            ([+*-/%=,;!<>(){}])
INTEGER             ([0-9]+)
IDENTIFIER          ([_a-zA-Z][_a-zA-Z0-9]*)
STRING              (\042[^\042\n]*\042)

%%
\n                  { cur_line++; }
{WHITESPACE}        { /* ignore every whitespace */ }
{COMMENT}           { /* skip for single line comment */    }
{INTEGER}           { _DUPTEXT return T_IntConstant; }
{STRING}            { _DUPTEXT return T_StringConstant; }
{OPERATOR}          { return yytext[0]; }
"int"               { return T_Int; }
"void"              { return T_Void; }
"return"            { return T_Return; }
"print"             { return T_Print; }
"readint"           { return T_ReadInt; }
"while"             { return T_While; }
"if"                { return T_If; }
"else"              { return T_Else; }
"break"             { return T_Break; }
"continue"          { return T_Continue; }
"=="                { return T_Eq; }
"!="                { return T_Ne; }
"<="                { return T_Le; }
">="                { return T_Ge; }
"&&"                { return T_And; }
"||"                { return T_Or; }
{IDENTIFIER}        { _DUPTEXT return T_Identifier; }

%%

int yywrap(void) { 
    return 1;
}

void yyerror() {
    exit(-1);
}
