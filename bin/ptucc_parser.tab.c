/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 1 "./src/ptucc_parser.y" /* yacc.c:339  */

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>	
#include <string.h>
#include "../include/cgen.h"

extern int yylex(void);
extern int line_num;


#line 78 "ptucc_parser.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "ptucc_parser.tab.h".  */
#ifndef YY_YY_PTUCC_PARSER_TAB_H_INCLUDED
# define YY_YY_PTUCC_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IDENT = 258,
    POSINT = 259,
    REAL = 260,
    STRING = 261,
    KW_BOOLEAN = 262,
    KW_REAL = 263,
    KW_CHAR = 264,
    KW_INT = 265,
    KW_VAR = 266,
    KW_PROGRAM = 267,
    KW_BEGIN = 268,
    KW_END = 269,
    KW_FUNC = 270,
    KW_PROC = 271,
    KW_RESULT = 272,
    KW_ARRAY = 273,
    KW_DO = 274,
    KW_GOTO = 275,
    KW_RETURN = 276,
    KW_ELSE = 277,
    KW_IF = 278,
    KW_OF = 279,
    KW_THEN = 280,
    KW_FOR = 281,
    KW_REPEAT = 282,
    KW_UNTIL = 283,
    KW_WHILE = 284,
    KW_TO = 285,
    KW_DOWNTO = 286,
    KW_TRUE = 287,
    KW_FALSE = 288,
    KW_TYPE = 289,
    OP_EQ = 290,
    OP_INEQ = 291,
    OP_LT = 292,
    OP_LTE = 293,
    OP_GT = 294,
    OP_GTE = 295,
    OP_AND = 296,
    OP_OR = 297,
    OP_NOT = 298,
    OP_ASSIGN = 299,
    OP_CAST_INT = 300,
    OP_CAST_REAL = 301,
    OP_CAST_BOOL = 302,
    OP_CAST_CHAR = 303
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 14 "./src/ptucc_parser.y" /* yacc.c:355  */

	char* crepr;

#line 171 "ptucc_parser.tab.c" /* yacc.c:355  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PTUCC_PARSER_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 188 "ptucc_parser.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  5
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   423

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  62
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  67
/* YYNRULES -- Number of rules.  */
#define YYNRULES  139
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  233

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   303

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,    61,     2,     2,
      52,    53,    60,    57,    54,    58,    49,    59,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    51,    50,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    55,     2,    56,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    86,    86,   100,   103,   104,   107,   108,   111,   114,
     115,   118,   121,   124,   125,   128,   129,   132,   133,   136,
     139,   140,   143,   152,   153,   156,   159,   160,   163,   169,
     170,   173,   179,   182,   183,   187,   188,   194,   201,   202,
     205,   206,   207,   210,   211,   219,   220,   223,   224,   227,
     228,   229,   230,   243,   246,   247,   248,   251,   252,   257,
     258,   263,   264,   265,   270,   271,   272,   276,   277,   281,
     285,   288,   289,   292,   293,   298,   302,   303,   306,   307,
     312,   313,   317,   318,   322,   323,   327,   328,   329,   332,
     333,   334,   335,   340,   345,   346,   347,   351,   352,   353,
     354,   355,   358,   359,   360,   361,   362,   363,   366,   367,
     373,   374,   380,   381,   385,   386,   387,   388,   389,   390,
     391,   392,   393,   398,   399,   402,   405,   408,   409,   410,
     413,   414,   417,   418,   422,   423,   426,   429,   435,   436
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "IDENT", "POSINT", "REAL", "STRING",
  "KW_BOOLEAN", "KW_REAL", "KW_CHAR", "KW_INT", "KW_VAR", "KW_PROGRAM",
  "KW_BEGIN", "KW_END", "KW_FUNC", "KW_PROC", "KW_RESULT", "KW_ARRAY",
  "KW_DO", "KW_GOTO", "KW_RETURN", "KW_ELSE", "KW_IF", "KW_OF", "KW_THEN",
  "KW_FOR", "KW_REPEAT", "KW_UNTIL", "KW_WHILE", "KW_TO", "KW_DOWNTO",
  "KW_TRUE", "KW_FALSE", "KW_TYPE", "OP_EQ", "OP_INEQ", "OP_LT", "OP_LTE",
  "OP_GT", "OP_GTE", "OP_AND", "OP_OR", "OP_NOT", "OP_ASSIGN",
  "OP_CAST_INT", "OP_CAST_REAL", "OP_CAST_BOOL", "OP_CAST_CHAR", "'.'",
  "';'", "':'", "'('", "')'", "','", "'['", "']'", "'+'", "'-'", "'/'",
  "'*'", "'%'", "$accept", "program", "program_decl", "d", "de", "def",
  "subprogram_def", "func_def", "proc_def", "decl", "decl_kind",
  "type_decl", "init_type_decl", "type_assign", "type_type_assign",
  "var_decl", "init_var_decl", "var_assign", "var_type_assign",
  "subprogram_decl", "func_decl", "proc_decl", "param_list",
  "param_specifier", "var_list", "compound_type", "type", "bracket_list",
  "brackets", "prim_type", "body", "special_body", "statements",
  "expression", "basicExpr", "rawData", "variable", "basicDTV",
  "complexDTV", "complexBracketsL", "complexBrackets", "functionCall",
  "arguments", "arglist", "complexExpr", "exprWithOperators",
  "exprWithOneOperator", "exprWithOnePrefixOperator", "OP_CAST",
  "exprWithOneLogical", "exprWithTwoOperators", "numericOperation",
  "relationalOperation", "logicalOperation", "exprWithParenthsis",
  "commands", "basicCommand", "variableAssignment", "resultAssignment",
  "ifStatement", "ifStatementMiddle", "forLoop", "whileLoop",
  "labelStatement", "gotoStatement", "returnStatement", "commandGroup", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,    46,
      59,    58,    40,    41,    44,    91,    93,    43,    45,    47,
      42,    37
};
# endif

#define YYPACT_NINF -160

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-160)))

#define YYTABLE_NINF -139

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      -2,    16,    29,     7,   -33,  -160,    42,    73,    75,    79,
       0,  -160,  -160,  -160,  -160,  -160,     1,  -160,    54,  -160,
      81,  -160,    43,    44,  -160,  -160,    42,  -160,    -7,    46,
      51,    61,    79,  -160,    60,  -160,    56,  -160,  -160,  -160,
      82,    82,  -160,   123,   103,    42,    42,   123,  -160,   114,
      63,   105,  -160,    27,   120,   383,    27,   121,  -160,  -160,
      78,  -160,  -160,  -160,  -160,  -160,  -160,  -160,  -160,    87,
    -160,    90,    93,  -160,  -160,  -160,  -160,  -160,    91,  -160,
    -160,  -160,    95,  -160,  -160,  -160,     3,  -160,    -5,     4,
      97,    27,    60,    27,    27,   -30,  -160,    27,  -160,    14,
    -160,  -160,  -160,    27,  -160,  -160,  -160,  -160,    27,    27,
      27,   197,  -160,  -160,  -160,  -160,  -160,  -160,  -160,  -160,
    -160,  -160,    27,  -160,  -160,  -160,  -160,  -160,  -160,   -18,
      21,    60,   131,  -160,   115,  -160,    60,  -160,  -160,   144,
     -15,  -160,  -160,   109,  -160,   123,  -160,  -160,   333,  -160,
      87,   333,   110,   108,   252,    27,  -160,   333,   113,   333,
     279,   333,   333,   383,    27,    27,    27,    27,    27,    27,
      27,    27,    27,    27,    27,    27,    27,    27,   333,    27,
      27,   150,    27,   383,  -160,   129,   123,  -160,   123,   137,
    -160,    27,  -160,   333,  -160,   149,   333,   333,   333,   333,
     333,   333,   333,   333,   306,   333,   333,   333,   333,   333,
     142,   169,  -160,   333,  -160,  -160,  -160,  -160,  -160,   333,
     394,  -160,  -160,   383,   383,    27,  -160,  -160,  -160,   225,
     383,   149,  -160
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     0,     1,     0,     0,     0,     0,
       0,     4,     7,     8,     9,    10,     6,    13,    16,    17,
      15,    23,     0,     0,     3,    38,    25,    26,     0,     0,
       0,     0,    19,    20,    57,     5,     0,    14,    18,    24,
       0,     0,    27,     0,     0,    35,    35,     0,    21,     0,
       0,     0,   137,     0,     0,    54,     0,     0,   122,    58,
     112,   114,   115,   116,   117,   118,   119,   120,   121,   113,
       2,     0,     0,    44,    52,    51,    49,    50,    47,    41,
      29,    30,     0,    40,    43,    39,     0,    33,     0,     0,
       0,     0,   134,    76,     0,     0,    71,     0,   136,    69,
      64,    65,    66,     0,    89,    91,    92,    90,     0,     0,
       0,     0,    59,    61,    62,    67,    68,    63,    60,    80,
      82,    84,     0,    85,    83,    94,    95,    96,    81,     0,
       0,    57,     0,    55,     0,    53,     0,    11,    12,     0,
       0,    45,    28,     0,    34,     0,    32,    22,   123,   138,
     135,    78,     0,    77,     0,     0,    72,   125,    70,    93,
       0,    86,    87,    54,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    88,     0,
       0,     0,     0,    54,   139,     0,     0,    46,     0,    36,
      75,     0,    74,   124,   110,   127,   102,   103,   104,   105,
     106,   107,   108,   109,     0,    97,    98,    99,   100,   101,
       0,     0,    56,   133,   132,    48,    42,    31,    37,    79,
      54,   126,   111,    54,    54,     0,   129,   130,   131,     0,
      54,   127,   126
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -160,  -160,  -160,  -160,   181,  -160,  -160,  -160,  -160,  -160,
     176,  -160,   175,  -160,   163,  -160,   177,  -160,   172,  -160,
      17,    40,   166,   -27,     2,   -44,  -160,  -160,    74,  -160,
      50,  -159,    84,   -55,  -160,  -160,  -160,  -160,  -160,   117,
     -90,   -34,  -160,  -160,  -160,  -160,  -160,  -160,  -160,  -160,
    -160,  -160,  -160,  -160,  -160,  -160,   -32,   159,  -160,  -160,
     -14,  -160,  -160,  -160,  -160,  -160,   126
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     2,     3,    10,    11,    12,    13,    14,    15,    16,
      17,    18,    19,    32,    33,    20,    21,    26,    27,    79,
      80,    81,    86,    87,    88,    82,    83,   140,   141,    84,
      36,   132,    57,   111,   112,   113,   114,   115,   116,    95,
      96,   117,   152,   153,   118,   119,   120,   121,   122,   123,
     124,   125,   126,   127,   128,    59,   133,    61,    62,    63,
     221,    64,    65,    66,    67,    68,    69
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      58,   134,    60,    90,   195,   156,    25,    25,    28,   186,
       1,     6,     6,    34,   155,     7,     8,    24,     6,     4,
      22,    58,     7,     8,   214,    94,    91,    22,    28,     5,
      99,   100,   101,   102,     9,     9,   148,    94,   151,   154,
     139,     9,   157,    23,    43,    25,   145,    44,   159,    44,
      23,   179,   180,   160,   161,   162,   143,   146,    58,   144,
     149,   226,   144,    49,   227,   228,    93,   178,   156,    94,
     103,   231,   104,   105,   106,   107,    29,    50,    30,   108,
      51,    52,    31,    53,   109,   110,    54,    55,     9,    56,
      71,    72,     6,    40,    41,    34,    47,    58,    45,    60,
     193,   189,    58,    46,   184,    70,    85,    97,    98,   196,
     197,   198,   199,   200,   201,   202,   203,   204,   205,   206,
     207,   208,   209,   129,   210,   211,    73,   213,  -138,    58,
      74,    75,    76,    77,   183,   135,   219,   136,     7,     8,
     137,    78,   216,   138,   217,   142,   139,   147,   185,    58,
     164,   165,   166,   167,   168,   169,   170,   171,    91,   182,
     188,   223,   191,   190,   212,    92,    93,   172,    94,    94,
     229,   220,   173,   174,   175,   176,   177,   164,   165,   166,
     167,   168,   169,   170,   171,   215,    58,   218,   224,    58,
      58,    35,    37,    38,   172,    48,    58,    39,    42,   173,
     174,   175,   176,   177,   164,   165,   166,   167,   168,   169,
     170,   171,    89,   130,   187,   181,   158,   232,   150,     0,
       0,   172,   163,     0,     0,     0,   173,   174,   175,   176,
     177,     0,   164,   165,   166,   167,   168,   169,   170,   171,
       0,     0,     0,     0,     0,     0,     0,     0,     0,   172,
     230,     0,     0,     0,   173,   174,   175,   176,   177,     0,
     164,   165,   166,   167,   168,   169,   170,   171,     0,     0,
       0,     0,     0,     0,     0,     0,     0,   172,     0,     0,
       0,     0,   173,   174,   175,   176,   177,   164,   165,   166,
     167,   168,   169,   170,   171,     0,     0,     0,     0,     0,
       0,     0,     0,     0,   172,     0,     0,     0,   192,   173,
     174,   175,   176,   177,   164,   165,   166,   167,   168,   169,
     170,   171,     0,     0,     0,     0,     0,     0,     0,     0,
       0,   172,   194,     0,     0,     0,   173,   174,   175,   176,
     177,   164,   165,   166,   167,   168,   169,   170,   171,     0,
       0,     0,     0,     0,     0,     0,     0,     0,   172,   222,
       0,     0,     0,   173,   174,   175,   176,   177,   164,   165,
     166,   167,   168,   169,   170,   171,     0,     0,     0,     0,
       0,     0,     0,     0,     0,   172,    49,     0,     0,     0,
     173,   174,   175,   176,   177,     0,   131,    49,     0,     0,
      50,     0,     0,    51,    52,     0,    53,   131,     0,    54,
      55,    50,    56,     0,    51,    52,     0,   225,     0,     0,
      54,    55,     0,    56
};

static const yytype_int16 yycheck[] =
{
      34,    56,    34,    47,   163,    95,     3,     3,     6,    24,
      12,    11,    11,    13,    44,    15,    16,    50,    11,     3,
       3,    55,    15,    16,   183,    55,    44,    10,    26,     0,
       3,     4,     5,     6,    34,    34,    91,    55,    93,    94,
      55,    34,    97,     3,    51,     3,    51,    54,   103,    54,
      10,    30,    31,   108,   109,   110,    53,    53,    92,    86,
      92,   220,    89,     3,   223,   224,    52,   122,   158,    55,
      43,   230,    45,    46,    47,    48,     3,    17,     3,    52,
      20,    21,     3,    23,    57,    58,    26,    27,    34,    29,
      40,    41,    11,    50,    50,    13,    35,   131,    52,   131,
     155,   145,   136,    52,   136,    49,     3,    44,     3,   164,
     165,   166,   167,   168,   169,   170,   171,   172,   173,   174,
     175,   176,   177,     3,   179,   180,     3,   182,    50,   163,
       7,     8,     9,    10,    19,    14,   191,    50,    15,    16,
      50,    18,   186,    50,   188,    50,    55,    50,     4,   183,
      35,    36,    37,    38,    39,    40,    41,    42,    44,    28,
      51,    19,    54,    53,    14,    51,    52,    52,    55,    55,
     225,    22,    57,    58,    59,    60,    61,    35,    36,    37,
      38,    39,    40,    41,    42,    56,   220,    50,    19,   223,
     224,    10,    16,    18,    52,    32,   230,    20,    26,    57,
      58,    59,    60,    61,    35,    36,    37,    38,    39,    40,
      41,    42,    46,    54,   140,   131,    99,   231,    92,    -1,
      -1,    52,    25,    -1,    -1,    -1,    57,    58,    59,    60,
      61,    -1,    35,    36,    37,    38,    39,    40,    41,    42,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    52,
      25,    -1,    -1,    -1,    57,    58,    59,    60,    61,    -1,
      35,    36,    37,    38,    39,    40,    41,    42,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    52,    -1,    -1,
      -1,    -1,    57,    58,    59,    60,    61,    35,    36,    37,
      38,    39,    40,    41,    42,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    52,    -1,    -1,    -1,    56,    57,
      58,    59,    60,    61,    35,    36,    37,    38,    39,    40,
      41,    42,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    52,    53,    -1,    -1,    -1,    57,    58,    59,    60,
      61,    35,    36,    37,    38,    39,    40,    41,    42,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    52,    53,
      -1,    -1,    -1,    57,    58,    59,    60,    61,    35,    36,
      37,    38,    39,    40,    41,    42,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    52,     3,    -1,    -1,    -1,
      57,    58,    59,    60,    61,    -1,    13,     3,    -1,    -1,
      17,    -1,    -1,    20,    21,    -1,    23,    13,    -1,    26,
      27,    17,    29,    -1,    20,    21,    -1,    23,    -1,    -1,
      26,    27,    -1,    29
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    12,    63,    64,     3,     0,    11,    15,    16,    34,
      65,    66,    67,    68,    69,    70,    71,    72,    73,    74,
      77,    78,    82,    83,    50,     3,    79,    80,    86,     3,
       3,     3,    75,    76,    13,    66,    92,    72,    74,    78,
      50,    50,    80,    51,    54,    52,    52,    35,    76,     3,
      17,    20,    21,    23,    26,    27,    29,    94,   103,   117,
     118,   119,   120,   121,   123,   124,   125,   126,   127,   128,
      49,    92,    92,     3,     7,     8,     9,    10,    18,    81,
      82,    83,    87,    88,    91,     3,    84,    85,    86,    84,
      87,    44,    51,    52,    55,   101,   102,    44,     3,     3,
       4,     5,     6,    43,    45,    46,    47,    48,    52,    57,
      58,    95,    96,    97,    98,    99,   100,   103,   106,   107,
     108,   109,   110,   111,   112,   113,   114,   115,   116,     3,
     119,    13,    93,   118,    95,    14,    50,    50,    50,    55,
      89,    90,    50,    53,    85,    51,    53,    50,    95,   118,
     128,    95,   104,   105,    95,    44,   102,    95,   101,    95,
      95,    95,    95,    25,    35,    36,    37,    38,    39,    40,
      41,    42,    52,    57,    58,    59,    60,    61,    95,    30,
      31,    94,    28,    19,   118,     4,    24,    90,    51,    87,
      53,    54,    56,    95,    53,    93,    95,    95,    95,    95,
      95,    95,    95,    95,    95,    95,    95,    95,    95,    95,
      95,    95,    14,    95,    93,    56,    87,    87,    50,    95,
      22,   122,    53,    19,    19,    23,    93,    93,    93,    95,
      25,    93,   122
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    62,    63,    64,    65,    65,    66,    66,    67,    68,
      68,    69,    70,    71,    71,    72,    72,    73,    73,    74,
      75,    75,    76,    77,    77,    78,    79,    79,    80,    81,
      81,    82,    83,    84,    84,    85,    85,    85,    86,    86,
      87,    87,    87,    88,    88,    89,    89,    90,    90,    91,
      91,    91,    91,    92,    93,    93,    93,    94,    94,    95,
      95,    96,    96,    96,    97,    97,    97,    98,    98,    99,
     100,   101,   101,   102,   102,   103,   104,   104,   105,   105,
     106,   106,   107,   107,   108,   108,   109,   109,   109,   110,
     110,   110,   110,   111,   112,   112,   112,   113,   113,   113,
     113,   113,   114,   114,   114,   114,   114,   114,   115,   115,
     116,   116,   117,   117,   118,   118,   118,   118,   118,   118,
     118,   118,   118,   119,   119,   120,   121,   122,   122,   122,
     123,   123,   124,   124,   125,   125,   126,   127,   128,   128
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     4,     3,     1,     2,     1,     1,     1,     1,
       1,     4,     4,     1,     2,     1,     1,     1,     2,     2,
       1,     2,     4,     1,     2,     2,     1,     2,     4,     1,
       1,     7,     5,     1,     2,     0,     3,     4,     1,     3,
       1,     1,     4,     1,     1,     1,     2,     0,     3,     1,
       1,     1,     1,     3,     0,     1,     3,     0,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       2,     1,     2,     0,     3,     4,     0,     1,     1,     3,
       1,     1,     1,     1,     1,     1,     2,     2,     2,     1,
       1,     1,     1,     2,     1,     1,     1,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     4,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     3,     4,     3,     5,     0,     6,     2,
       6,     6,     4,     4,     2,     3,     2,     1,     1,     3
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 87 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { 
	/* We have a successful parse! 
		Check for any errors and generate output. 
	*/
	if(yyerror_count==0) {
		puts(c_prologue);
		printf("/* program  %s */ \n\n", (yyvsp[-3].crepr));
		printf("%s\n", (yyvsp[-2].crepr));		
		printf("int main() %s \n", (yyvsp[-1].crepr));
		
	}
}
#line 1502 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 3:
#line 100 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = (yyvsp[-1].crepr); 							}
#line 1508 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 4:
#line 103 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", (yyvsp[0].crepr)); 			}
#line 1514 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 5:
#line 104 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s%s", (yyvsp[-1].crepr), (yyvsp[0].crepr) ); 	}
#line 1520 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 6:
#line 107 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", (yyvsp[0].crepr)); 			}
#line 1526 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 108 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", (yyvsp[0].crepr)); 			}
#line 1532 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 8:
#line 111 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", (yyvsp[0].crepr)); 			}
#line 1538 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 9:
#line 114 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s\n", (yyvsp[0].crepr)); 		}
#line 1544 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 10:
#line 115 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s\n", (yyvsp[0].crepr)); 		}
#line 1550 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 11:
#line 118 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s%s", (yyvsp[-3].crepr), (yyvsp[-1].crepr)); 	}
#line 1556 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 12:
#line 121 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s%s", (yyvsp[-3].crepr), (yyvsp[-1].crepr)); 	}
#line 1562 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 13:
#line 124 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 			}
#line 1568 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 125 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s%s", (yyvsp[-1].crepr), (yyvsp[0].crepr) ); 	}
#line 1574 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 15:
#line 128 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 			}
#line 1580 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 129 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 			}
#line 1586 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 132 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 			}
#line 1592 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 18:
#line 133 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s%s",(yyvsp[-1].crepr), (yyvsp[0].crepr)); 	}
#line 1598 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 136 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", (yyvsp[0].crepr)); 			}
#line 1604 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 20:
#line 139 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", (yyvsp[0].crepr)); 			}
#line 1610 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 21:
#line 140 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s%s", (yyvsp[-1].crepr), (yyvsp[0].crepr) ); 	}
#line 1616 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 22:
#line 143 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { char* C_ct = make_C_comp_type((yyvsp[-1].crepr));
													  
													  if(set_typedef((yyvsp[-3].crepr), C_ct))
													  	(yyval.crepr) = template("typedef %s %s;\n", C_ct, (yyvsp[-3].crepr));
													  else
													  	yyerror("Typedef Error!\n"); 
													}
#line 1628 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 23:
#line 152 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 			}
#line 1634 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 24:
#line 153 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s%s", (yyvsp[-1].crepr), (yyvsp[0].crepr) ); 	}
#line 1640 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 156 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", (yyvsp[0].crepr)); 			}
#line 1646 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 26:
#line 159 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", (yyvsp[0].crepr)); 			}
#line 1652 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 27:
#line 160 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s%s", (yyvsp[-1].crepr), (yyvsp[0].crepr) ); 	}
#line 1658 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 163 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { 
														char* C_decl = make_C_decl((yyvsp[-1].crepr), (yyvsp[-3].crepr)); 
														(yyval.crepr) = template("%s;\n", C_decl); 
													}
#line 1667 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 29:
#line 169 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", (yyvsp[0].crepr)); 			}
#line 1673 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 30:
#line 170 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", (yyvsp[0].crepr)); 			}
#line 1679 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 31:
#line 173 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { 
																	char* C_ct = make_C_comp_type((yyvsp[0].crepr)); 
																	(yyval.crepr) = template("%s %s(%s)", C_ct , (yyvsp[-5].crepr), (yyvsp[-3].crepr) ); 
																}
#line 1688 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 32:
#line 179 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("void %s(%s)", (yyvsp[-3].crepr), (yyvsp[-1].crepr) ); }
#line 1694 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 33:
#line 182 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 			}
#line 1700 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 34:
#line 183 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s%s", (yyvsp[-1].crepr), (yyvsp[0].crepr));  	}
#line 1706 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 187 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = "";							}
#line 1712 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 36:
#line 188 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { 
	       												char* C_ct = make_C_comp_type((yyvsp[0].crepr)); 
	       												char* C_params = make_C_params(C_ct, (yyvsp[-2].crepr));
	       												(yyval.crepr) = template("%s", C_params); 
	       											}
#line 1722 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 37:
#line 194 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { 
	       												char* C_ct = make_C_comp_type((yyvsp[-1].crepr));
					          							char* C_params = make_C_params(C_ct, (yyvsp[-3].crepr));
						  								(yyval.crepr) = template("%s, ", C_params); 
						  							}
#line 1732 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 39:
#line 202 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s, %s", (yyvsp[-2].crepr), (yyvsp[0].crepr)); }
#line 1738 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 40:
#line 205 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", (yyvsp[0].crepr)); 			}
#line 1744 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 206 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", (yyvsp[0].crepr)); 			}
#line 1750 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 207 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = make_parsable_comp_type((yyvsp[0].crepr), (yyvsp[-2].crepr)); }
#line 1756 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 43:
#line 210 "./src/ptucc_parser.y" /* yacc.c:1646  */
    {  (yyval.crepr) = template("%s", (yyvsp[0].crepr)); }
#line 1762 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 44:
#line 211 "./src/ptucc_parser.y" /* yacc.c:1646  */
    {	
														if(get_typedef((yyvsp[0].crepr))) 
		  													(yyval.crepr) = template("%s", (yyvsp[0].crepr));
												  		else 
												  			yyerror("Error! Typedef does not exist..."); 
												  	}
#line 1773 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 219 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", (yyvsp[0].crepr)); 			}
#line 1779 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 46:
#line 220 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s%s", (yyvsp[-1].crepr), (yyvsp[0].crepr)); 	}
#line 1785 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 47:
#line 223 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = ""; 							}
#line 1791 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 48:
#line 224 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("[%s]", (yyvsp[-1].crepr)); 		}
#line 1797 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 227 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", "char"); 		}
#line 1803 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 50:
#line 228 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", "int"); 		}
#line 1809 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 51:
#line 229 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", "double"); 	}
#line 1815 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 52:
#line 230 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", "int"); 		}
#line 1821 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 53:
#line 243 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("{\n \n %sreturn result;\n}\n", (yyvsp[-1].crepr)); }
#line 1827 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 246 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = ";"; }
#line 1833 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 55:
#line 247 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s\n", (yyvsp[0].crepr)); 			}
#line 1839 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 248 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("\n{\n\t%s\n}\n", (yyvsp[-1].crepr)); }
#line 1845 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 57:
#line 251 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = ""; 								}
#line 1851 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 58:
#line 252 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s\n", (yyvsp[0].crepr)); 			}
#line 1857 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 59:
#line 257 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 		  }
#line 1863 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 60:
#line 258 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 		  }
#line 1869 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 61:
#line 263 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 		  }
#line 1875 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 62:
#line 264 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 		  }
#line 1881 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 63:
#line 265 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 		  }
#line 1887 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 64:
#line 270 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 		  }
#line 1893 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 65:
#line 271 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 		  }
#line 1899 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 66:
#line 272 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 		  }
#line 1905 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 69:
#line 281 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 		  }
#line 1911 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 70:
#line 285 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s%s",(yyvsp[-1].crepr),(yyvsp[0].crepr)); 	  }
#line 1917 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 71:
#line 288 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s", (yyvsp[0].crepr)); 		  }
#line 1923 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 72:
#line 289 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s%s", (yyvsp[-1].crepr), (yyvsp[0].crepr));  }
#line 1929 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 73:
#line 292 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = ""; 						  }
#line 1935 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 74:
#line 293 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("[%s]", (yyvsp[-1].crepr)); 	  }
#line 1941 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 75:
#line 298 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s(%s)",(yyvsp[-3].crepr),(yyvsp[-1].crepr));  }
#line 1947 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 76:
#line 302 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = ""; 						  }
#line 1953 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 77:
#line 303 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = (yyvsp[0].crepr); 						  }
#line 1959 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 78:
#line 306 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); }
#line 1965 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 79:
#line 307 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s,%s", (yyvsp[-2].crepr), (yyvsp[0].crepr)); }
#line 1971 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 86:
#line 327 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("+%s",(yyvsp[0].crepr)); 		 	}
#line 1977 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 87:
#line 328 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("-%s",(yyvsp[0].crepr)); 		 	}
#line 1983 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 88:
#line 329 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s%s",(yyvsp[-1].crepr),(yyvsp[0].crepr)); 		}
#line 1989 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 89:
#line 332 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("(int)"); 		 	}
#line 1995 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 90:
#line 333 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("(char)");			}
#line 2001 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 91:
#line 334 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("(float)");			}
#line 2007 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 92:
#line 335 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("(int)");			}
#line 2013 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 93:
#line 340 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("!%s",(yyvsp[0].crepr));  		}
#line 2019 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 97:
#line 351 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s + %s",(yyvsp[-2].crepr),(yyvsp[0].crepr));  }
#line 2025 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 98:
#line 352 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s - %s",(yyvsp[-2].crepr),(yyvsp[0].crepr));  }
#line 2031 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 99:
#line 353 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s / %s",(yyvsp[-2].crepr),(yyvsp[0].crepr));  }
#line 2037 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 100:
#line 354 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s * %s",(yyvsp[-2].crepr),(yyvsp[0].crepr));  }
#line 2043 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 101:
#line 355 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s % %s",(yyvsp[-2].crepr),(yyvsp[0].crepr));  }
#line 2049 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 102:
#line 358 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s == %s",(yyvsp[-2].crepr),(yyvsp[0].crepr)); }
#line 2055 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 103:
#line 359 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s != %s",(yyvsp[-2].crepr),(yyvsp[0].crepr)); }
#line 2061 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 104:
#line 360 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s < %s",(yyvsp[-2].crepr),(yyvsp[0].crepr));  }
#line 2067 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 105:
#line 361 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s <= %s",(yyvsp[-2].crepr),(yyvsp[0].crepr)); }
#line 2073 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 106:
#line 362 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s > %s",(yyvsp[-2].crepr),(yyvsp[0].crepr));  }
#line 2079 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 107:
#line 363 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s >= %s",(yyvsp[-2].crepr),(yyvsp[0].crepr)); }
#line 2085 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 108:
#line 366 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s && %s",(yyvsp[-2].crepr),(yyvsp[0].crepr)); }
#line 2091 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 109:
#line 367 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s || %s",(yyvsp[-2].crepr),(yyvsp[0].crepr)); }
#line 2097 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 110:
#line 373 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("(%s)",(yyvsp[-1].crepr));    	   }
#line 2103 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 111:
#line 374 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s (%s)",(yyvsp[-3].crepr),(yyvsp[-1].crepr));  }
#line 2109 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 112:
#line 380 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 				}
#line 2115 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 113:
#line 381 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr));				}
#line 2121 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 114:
#line 385 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s;",(yyvsp[0].crepr)); 				}
#line 2127 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 115:
#line 386 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s;",(yyvsp[0].crepr)); 				}
#line 2133 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 116:
#line 387 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 				}
#line 2139 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 117:
#line 388 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 				}
#line 2145 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 118:
#line 389 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 				}
#line 2151 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 119:
#line 390 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr)); 				}
#line 2157 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 120:
#line 391 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s;",(yyvsp[0].crepr));				}
#line 2163 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 121:
#line 392 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s;",(yyvsp[0].crepr));				}
#line 2169 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 122:
#line 393 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s;",(yyvsp[0].crepr)); 				}
#line 2175 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 123:
#line 398 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s = %s",(yyvsp[-2].crepr),(yyvsp[0].crepr));	  	}
#line 2181 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 124:
#line 399 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s%s = %s",(yyvsp[-3].crepr),(yyvsp[-2].crepr),(yyvsp[0].crepr));	}
#line 2187 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 125:
#line 402 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("result = %s",(yyvsp[0].crepr));    	}
#line 2193 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 126:
#line 405 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("if(%s)%s%s",(yyvsp[-3].crepr),(yyvsp[-1].crepr),(yyvsp[0].crepr)); }
#line 2199 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 127:
#line 408 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = ""; 	    						}
#line 2205 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 128:
#line 409 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("else if(%s)%s%s",(yyvsp[-3].crepr),(yyvsp[-1].crepr),(yyvsp[0].crepr)); }
#line 2211 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 129:
#line 410 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("else%s",(yyvsp[0].crepr)); 			}
#line 2217 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 130:
#line 413 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("for(%s;%s<%s;%s++)%s",(yyvsp[-4].crepr),incrementStep((yyvsp[-4].crepr)),(yyvsp[-2].crepr),incrementStep((yyvsp[-4].crepr)),(yyvsp[0].crepr));}
#line 2223 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 131:
#line 414 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("for(%s;%s>%s;%s--)%s",(yyvsp[-4].crepr),incrementStep((yyvsp[-4].crepr)),(yyvsp[-2].crepr),incrementStep((yyvsp[-4].crepr)),(yyvsp[0].crepr));}
#line 2229 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 132:
#line 417 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("while(%s)%s",(yyvsp[-2].crepr),(yyvsp[0].crepr)); 		 }
#line 2235 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 133:
#line 418 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("do%swhile(!(%s));",(yyvsp[-2].crepr),(yyvsp[0].crepr)); }
#line 2241 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 134:
#line 422 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s:\n ",(yyvsp[-1].crepr));		}
#line 2247 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 135:
#line 423 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s:\n 	%s",(yyvsp[-2].crepr),(yyvsp[0].crepr));	}
#line 2253 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 136:
#line 426 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("goto %s",(yyvsp[0].crepr));		}
#line 2259 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 137:
#line 429 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("return result");	}
#line 2265 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 138:
#line 435 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s",(yyvsp[0].crepr));			}
#line 2271 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;

  case 139:
#line 436 "./src/ptucc_parser.y" /* yacc.c:1646  */
    { (yyval.crepr) = template("%s\n%s",(yyvsp[-2].crepr),(yyvsp[0].crepr));    }
#line 2277 "ptucc_parser.tab.c" /* yacc.c:1646  */
    break;


#line 2281 "ptucc_parser.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 440 "./src/ptucc_parser.y" /* yacc.c:1906  */
