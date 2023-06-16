%{
  //gramatica.y -> es la extencion para el archivo Yacc
    #include <stdio.h>  //
    #include <stdlib.h>

    extern int yylex();// yylex-> es la extencion para el analizador lexico

    void yyerror(char *msg);// es una funcion para manejar errores que se encuentran 
                            // de las lineas de 41 a 43
%}
%union {  //aqui declaramos los tipos de union tanto en Yacc y cc donde usamos float cuyo prefijo es F.
    float f;
}
// definimos los tokens

%token <f> NUM //DEFINIMOS NUM
%type <f> E T F  // definimos los tipos que son las variables que tomaran diferenctes formas.
 
 // las singuiente entre porcentajes se define todo el codigo YACC
%%

S : E            {printf("%f\n", $1);}
  ;

E : E '+' T       {$$ = $1 + $3;}
  | E '-' T       {$$ = $1 - $3;}
  | T 
  ;

T : T '*' T       {$$ = $1 * $3;}
  | T '/' F       {$$ = $1 / $3;}
  | F             {$$ = $1;}
  ;

F : '(' E ')'     {$$ = $2;}
  | '-' F         {$$ = -$2;}
  | NUM           {$$ = $1;}
  ;

 %%

 void yyerror(char *msg){
    fprintf(stderr, "%s\n", msg);
    exit(1);
 }

 
  int main(int argc, char *argv[]){
    char* text = "false or true";
    
    if(argc > 1) text = argv[1];
    yy_scan_string(text); 
    fprintf("Input: '%s'\n", text);

       int a = yyparse(); 

    fprintf("La expresion es correcta");
    return 0;

 }