{
{- 
     module HRayParser, which contains a parser which allows to use files containing scene descriptions 
     intended for usage with the other modules in the HRay package
 
     author: Kenneth Hoste, 2004-2005
     part of a masters thesis at the University of Ghent, Belgium
-}

module HRayParser (RenderDescr(RenderDescr), readDescr) where

import HRayEngine (Scene(Scene), Texture(Texture), Diff(Solid,Perlin), TexturedObject, 
		   Light(AmbientLight, PointLight), Camera(Camera))
import HRayPerlin (perlinSolid, perlinSemiTurbulence,perlinTurbulence,perlinFire,perlinPlasma,perlinMarble,
		   perlinMarbleBase,perlinWood)
import HRayMath (Dimension, Resolution, Object(Sphere,Plane))
import Char (isSpace, isAlpha, isDigit)


-- representation of a full description of scene which should be rendered
data RenderDescr = RenderDescr Resolution Int Scene


readDescr :: String -> RenderDescr
readDescr = parseScene.lexer

}

%name parseScene
%tokentype { Token }

%token 
      int              { TokenInt $$ }
      double           { TokenDouble $$ }
      camera           { TokenCamera }
      background       { TokenBackground }
      diff             { TokenDiff }
      solid            { TokenSolid }
      perlinSolid      { TokenPerlinSolid }
      perlinSemiTurb   { TokenPerlinSemiTurb }
      perlinTurb       { TokenPerlinTurb }
      perlinFire       { TokenPerlinFire }
      perlinPlasma     { TokenPerlinPlasma }
      perlinMarble     { TokenPerlinMarble }
      perlinMarbleBase { TokenPerlinMarbleBase }
      perlinWood       { TokenPerlinWood }
      perlin           { TokenPerlin }
      texture          { TokenTexture }
      sphere           { TokenSphere }  
      plane            { TokenPlane }  
      object           { TokenTexturedObject }
      objects          { TokenObjects }
      pointLight       { TokenPointLight }
      ambientLight     { TokenAmbientLight }
      lights           { TokenLights }
      scene            { TokenScene }
      resolution       { TokenResolution }
      renderDescr      { TokenRenderDescr }
      '{'              { TokenOpenAcc }
      '}'              { TokenCloseAcc }
      '('              { TokenOpenBrack }
      ')'              { TokenCloseBrack }
      '['              { TokenOpenHook }
      ']'              { TokenCloseHook }
      ','              { TokenComma }

%%

RenderDescr : renderDescr Resolution int '[' Scene ']'                         { RenderDescr $2 $3 $5}

Resolution  : '(' resolution '(' int ',' int ')' ')'                           { ($4,$6) }

Scene       : scene '{' Camera '}' '{' Background '}' 
                    '{' objects Objects '}' '{' lights Lights '}'              { Scene $3 $6 $10 $14 }

Camera      : camera '(' double ',' double ',' double ')' 
                     '(' int ',' int ')'                                       { Camera ($3,$5,$7) ($10,$12) }

Background  : background '(' double ',' double ',' double ')'                  { ($3,$5,$7) }

Object      : sphere double '(' double ',' double ',' double ')'               { Sphere $2 ($4,$6,$8) }
            | plane '(' double ',' double ',' double ',' double ')'            { Plane ($3,$5,$7,$9) }

NoiseF      : perlinSolid '(' double ',' double ',' double ')' double          { perlinSolid ($3,$5,$7) $9 }
            | perlinSemiTurb '(' double ',' double ',' double ')' int double   { perlinSemiTurbulence ($3,$5,$7) $9 $10 }
            | perlinTurb '(' double ',' double ',' double ')' int double       { perlinTurbulence ($3,$5,$7) $9 $10 }
            | perlinFire '(' double ',' double ',' double ')' 
                         '(' double ',' double ',' double ')' int double       { perlinFire ($3,$5,$7) ($10,$12,$14) 
										            $16 $17 }
            | perlinPlasma double                                              { perlinPlasma $2 }
            | perlinMarble '(' double ',' double ',' double ')' int double
                           '(' double ',' double ',' double ')' double         { perlinMarble ($3,$5,$7) $9 $10 
										              ($12,$14,$16) $18 }
            | perlinMarbleBase '(' double ',' double ',' double ')' 
                               '(' double ',' double ',' double ')' int double
                               '(' double ',' double ',' double ')' double     { perlinMarbleBase ($3,$5,$7) 
										                  ($10,$12,$14) 
                                                                                                  $16 $17 
										                  ($19,$21,$23) $25 }
            | perlinWood '(' double ',' double ',' double ')' int double 
               	        double double                                          { perlinWood ($3,$5,$7) $9 $10 $11 $12 }

Diff        : solid '(' double ',' double ',' double ')'                       { Solid ($3,$5,$7) }
            | perlin '(' NoiseF ')'                                            { Perlin $3 }

Texture    : '(' texture '(' diff Diff ')' double int double double')'         { Texture $5 $7 $8 $9 $10 }

TexturedObject : '(' object '(' Object ')' Texture ')'                         { ($4,$6) }

Objects     : {- empty -}                                                      { [] }
            | Objects TexturedObject                                           { $2 : $1 }

Light       : '(' pointLight '(' double ',' double ',' double ')' 
                            '(' double ',' double ',' double ')' ')'           { PointLight ($4,$6,$8) ($11,$13,$15) }
            | '(' ambientLight '(' double ',' double ',' double ')' ')'        { AmbientLight ($4,$6,$8) }

Lights      : {- empty -}                                                      { [] }
            | Lights Light                                                     { $2 : $1 }

{

happyError :: [Token] -> a
happyError _ = error "Parse error ! ! !"

data Token
       = TokenInt Int
       | TokenDouble Double
       | TokenCamera
       | TokenBackground
       | TokenDiff
       | TokenSolid
       | TokenPerlinSolid
       | TokenPerlinSemiTurb
       | TokenPerlinTurb
       | TokenPerlinFire
       | TokenPerlinPlasma
       | TokenPerlinMarble
       | TokenPerlinMarbleBase
       | TokenPerlinWood
       | TokenPerlin
       | TokenTexture
       | TokenSphere
       | TokenPlane
       | TokenObjType
       | TokenTexturedObject
       | TokenObjects
       | TokenPointLight
       | TokenAmbientLight
       | TokenLight
       | TokenLights
       | TokenScene
       | TokenResolution
       | TokenRenderDescr
       | TokenOpenAcc
       | TokenCloseAcc
       | TokenOpenBrack
       | TokenCloseBrack
       | TokenOpenHook
       | TokenCloseHook
       | TokenComma

lexer :: String -> [Token]
lexer [] = []
lexer (c:cs) 
      | isSpace c = lexer cs
      | isAlpha c = lexVar (c:cs)
      | isDigit c = lexNum (c:cs) 1
lexer ('{':cs) = TokenOpenAcc : lexer cs
lexer ('}':cs) = TokenCloseAcc : lexer cs
lexer ('(':cs) = TokenOpenBrack : lexer cs
lexer (')':cs) = TokenCloseBrack : lexer cs
lexer ('[':cs) = TokenOpenHook : lexer cs
lexer (']':cs) = TokenCloseHook : lexer cs
lexer (',':cs) = TokenComma : lexer cs
lexer ('-':cs) = lexNum cs (-1)

lexNum cs mul
          | (r == '.')  = TokenDouble (mul * (read (num++[r]++num2) :: Double)) : lexer rest2
          | otherwise = TokenInt (round (mul * (read num))) : lexer (r:rest)
          where (num,(r:rest)) = span isDigit cs
	        (num2,rest2)   = span isDigit rest

lexVar cs =
   case span isAlpha cs of
      ("camera",rest)            -> TokenCamera : lexer rest
      ("background",rest)        -> TokenBackground : lexer rest
      ("diff",rest)              -> TokenDiff : lexer rest
      ("solid",rest)             -> TokenSolid : lexer rest
      ("perlinSolid",rest)       -> TokenPerlinSolid : lexer rest
      ("perlinSemiTurb",rest)    -> TokenPerlinSemiTurb : lexer rest
      ("perlinTurb",rest)        -> TokenPerlinTurb : lexer rest
      ("perlinFire",rest)        -> TokenPerlinFire : lexer rest
      ("perlinPlasma",rest)      -> TokenPerlinPlasma : lexer rest
      ("perlinMarble",rest)      -> TokenPerlinMarble : lexer rest
      ("perlinMarbleBase",rest)  -> TokenPerlinMarbleBase : lexer rest
      ("perlinWood",rest)        -> TokenPerlinWood : lexer rest
      ("perlin",rest)            -> TokenPerlin : lexer rest
      ("texture",rest)           -> TokenTexture : lexer rest
      ("sphere",rest)            -> TokenSphere : lexer rest
      ("plane",rest)             -> TokenPlane : lexer rest
      ("object",rest)            -> TokenTexturedObject : lexer rest
      ("objects",rest)           -> TokenObjects : lexer rest
      ("pointLight",rest)        -> TokenPointLight : lexer rest
      ("ambientLight",rest)      -> TokenAmbientLight : lexer rest
      ("light",rest)             -> TokenLight : lexer rest
      ("lights",rest)            -> TokenLights : lexer rest
      ("scene",rest)             -> TokenScene : lexer rest
      ("resolution",rest)        -> TokenResolution : lexer rest
      ("renderDescr",rest)       -> TokenRenderDescr : lexer rest

  }
