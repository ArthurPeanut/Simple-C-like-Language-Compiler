/*
 * Lexical Analyzer for a Simple Programming Language
 * 
 * This program uses Flex to perform lexical analysis. It scans an input file,
 * identifies tokens such as keywords, identifiers, operators, integers, and
 * strings, and writes the results to an output file.
 * 
 * Key Features:
 * - Recognizes and categorizes different types of tokens.
 * - Handles whitespace and comments gracefully.
 * - Reports unrecognized characters as errors.
 * - Outputs the results to a specified file for further use.
 * 
 * Author: Haoqing Liu
 * Date: June 21, 2022
 */

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define YYSTYPE char *
int line = 1;

# Error handling function
void yyerror(const char *msg);

#define _DUPTEXT {yylval = strdup(yytext);}
%}

INTEGER             ([0-9]+)
IDENTIFIER          ([_a-zA-Z][_a-zA-Z0-9]*)
WHITESPACE          ([ \t\r\a]+)
SINGLE_COMMENT1     ("//"[^\n]*)
SINGLE_COMMENT2     ("#"[^\n]*)
OPERATOR            ([+*-/%=,;!<>(){}])
STRING              (\042[^\042\n]*\042)

%%

\n                  { line++; }
{WHITESPACE}        { /* ignore every whitespace */ }
{SINGLE_COMMENT1}   { /* skip for single line comment (C-style) */    }
{SINGLE_COMMENT2}   { /* skip for single line comment (Python-style)*/    }

{OPERATOR}          {printf("No.%d, <operator>:%s\n", line++, yytext);}
"int"               {printf("No.%d, <keyword>:int\n", line++);}
"void"              {printf("No.%d, <keyword>:void\n", line++);}
"return"            {printf("No.%d, <keyword>:return\n", line++);}
"printf"             {printf("No.%d, <function>:printf\n", line++);}
"while"             {printf("No.%d, <keyword>while\n", line++);}
"if"                {printf("No.%d, <keyword>:if\n", line++);}
"else"              {printf("No.%d, <keyword>:else\n", line++);}
"break"             {printf("No.%d, <keyword>:\n", line++);}
"continue"          {printf("No.%d, <keyword>:\n", line++);}
{INTEGER}           {printf("No.%d, <integer>:%s\n", line++, yytext);}
{STRING}            {printf("No.%d, <string>:%s\n", line++, yytext);}
{IDENTIFIER}        {printf("No.%d, <identifier>:%s\n", line++, yytext);}

// Handle unrecognized characters as errors
.                   {fprintf(stderr, "Error at line %d: Unrecognized character '%s'\n", line, yytext); exit(1); }

%%

int main(){
    // Open the input file for reading
    FILE *input_file = fopen("test1.txt", "r");
    if (!input_file) {
        fprintf(stderr, "Error: Unable to open input file 'test1.txt'.\n");
        return -1;
    }
    yyin = input_file;

    // Open the output file for writing results
    output_file = fopen("output.txt", "w");
    if (!output_file) {
        fprintf(stderr, "Error: Unable to open output file 'output.txt'.\n");
        return -1;
    }

    // Start lexical analysis
    yylex();

    // Close input and output files
    fclose(input_file);
    fclose(output_file);

    printf("Lexical analysis complete. Results saved in 'output.txt'.\n");
    return 0;
}

// Flex-required function to handle end of input
int yywrap(void) { 
    return 1;
}

void yyerror(const char *msg) {
    fprintf(stderr, "Error at line %d:\n\t%s\n", line, msg);
    exit(-1);
}
