%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	void yyerror(const char* msg);
	int yylex();
	
	
%}

//Union to define token types
%union{int i; float f; char* s;}
%start ZoomJoyStrong


//Tokens
%token INT
%token FLOAT
%token END_STATEMENT
%token END
%token RECTANGLE
%token CIRCLE
%token POINT
%token LINE
%token GOOF
%token SET_COLOR

//token type
%type<i> INT
%type<f> FLOAT
%type<s> END_STATEMENT
%type<s> END
%type<s> RECTANGLE
%type<s> CIRCLE
%type<s> POINT
%type<s> LINE
%type<s> GOOF
%type<s> SET_COLOR

%%

//A zoomjoystrong is a zoomjoystrong and a statement or a statement
ZoomJoyStrong: ZoomJoyStrong Statement
		|Statement
;		


//A statement is a line, point, circle, rectangle, set_color, a goof or a statement followed by end
Statement: Line
		| Point
		| Circle
		| Rectangle
		| Set_Color
		| Goof
		| End
;		

//Draws a line
//A line is a line token followed by 4 ints and a ;
Line: LINE INT INT INT INT END_STATEMENT {
	line( $2, $3, $4, $5);
};

//Draws a point
//A point is a point token 2 ints and a ;
Point: POINT INT INT END_STATEMENT{
	point($2,$3);	
};

//Draws a cricle
//A circle is a circle token 4 ints and a ;
Circle: CIRCLE INT INT INT END_STATEMENT{
	circle($2,$3,$4);
};

//Draws a rectangle
//A rectangle  is a rectangle Token 4 ints and a ;
Rectangle: RECTANGLE INT INT INT INT END_STATEMENT{
	rectangle($2,$3,$4,$5);
};

//Sets color
//Sets color Token 3 ints between 0 and 255 and a ;
Set_Color: SET_COLOR INT INT INT END_STATEMENT{
	if($2 > 255 | $2 < 0 | $3 > 255 | $3 < 0 | $4 > 255 | $4 <0){
		yyerror("Invalid value: value must be between 0 and 255");
	}
	set_color($2,$3,$4);
};

//Catches mistakes
//Any other charater not in a token
Goof: GOOF {
	yyerror("you done goofed, you.");	
};

//catches end token
//ends the program
End: END{
	finish();
	exit(0);
};

%%
//main setsup screen and parses
int main(int argc, char** argv){
	setup();
	yyparse();
}

//ends program after catching error
void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s", msg);
	printf("%s"," exiting program\n");
	exit(1);
}