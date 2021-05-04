%token <string> IDENT
%token <string> CST_CHAR
%token <string> CST_INT
%token <string> CST_FLOAT
%token <string> CST_STRING
%token <string> NAMED_TYPE
%token <Cabs.gnu_attrs> GNU_ATTRS

%token EOF
%token CHAR INT DOUBLE FLOAT VOID
%token ENUM STRUCT TYPEDEF UNION
%token SIGNED UNSIGNED LONG SHORT
%token VOLATILE EXTERN STATIC CONST AUTO REGISTER RESTRICT

%token SIZEOF ASM

%token <string * int> EQ PLUS_EQ MINUS_EQ STAR_EQ SLASH_EQ PERCENT_EQ
%token <string * int> AND_EQ PIPE_EQ CIRC_EQ INF_INF_EQ SUP_SUP_EQ
%token ARROW DOT

%token EQ_EQ EXCLAM_EQ INF SUP INF_EQ SUP_EQ
%token PLUS MINUS STAR SLASH PERCENT
%token TILDE AND PIPE CIRC
%token EXCLAM AND_AND PIPE_PIPE
%token INF_INF SUP_SUP
%token PLUS_PLUS MINUS_MINUS

%token <string * int> RPAREN LPAREN RBRACE LBRACE LBRACKET RBRACKET
%token <string * int> COLON SEMICOLON COMMA ELLIPSIS QUEST

%token <string * int> BREAK CONTINUE GOTO RETURN
%token <string * int> SWITCH CASE DEFAULT
%token <string * int> WHILE DO FOR
%token <string * int> IF ELSE

/* GNU attributes */
%token ATTRIBUTE EXTENSION INLINE

%%
