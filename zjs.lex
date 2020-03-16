%{
	#include <stdlib.h>
	#include "zjs.tab.h"

%}

%option noyywrap

%%

	/*Regexes for point line circle rectrangel setting color and ending program*/ 

point {return POINT;}
line {return LINE;}
circle {return CIRCLE;}
rectangle {return RECTANGLE;}
set_color {return SET_COLOR;}
end {return END;}

	/*regexes for ints and floats*/
\-?[0-9]+\.[0-9]+ {return FLOAT;}
\-?[0-9]+ {yylval.i  = atoi(yytext); return INT;}

	/*find semicolons*/
; {return END_STATEMENT;}

	/*ignores whitespaces*/
[ \t\s\n\r] ;

	/*catches illegal characters*/
. {return GOOF;}

%%