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

-- parser produced by Happy Version 1.15

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16
	= HappyTerminal Token
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16

action_0 (42) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail

action_1 (42) = happyShift action_2
action_1 _ = happyFail

action_2 (45) = happyShift action_5
action_2 (5) = happyGoto action_4
action_2 _ = happyFail

action_3 (50) = happyAccept
action_3 _ = happyFail

action_4 (17) = happyShift action_7
action_4 _ = happyFail

action_5 (41) = happyShift action_6
action_5 _ = happyFail

action_6 (45) = happyShift action_9
action_6 _ = happyFail

action_7 (47) = happyShift action_8
action_7 _ = happyFail

action_8 (40) = happyShift action_12
action_8 (6) = happyGoto action_11
action_8 _ = happyFail

action_9 (17) = happyShift action_10
action_9 _ = happyFail

action_10 (49) = happyShift action_15
action_10 _ = happyFail

action_11 (48) = happyShift action_14
action_11 _ = happyFail

action_12 (43) = happyShift action_13
action_12 _ = happyFail

action_13 (19) = happyShift action_18
action_13 (7) = happyGoto action_17
action_13 _ = happyFail

action_14 _ = happyReduce_1

action_15 (17) = happyShift action_16
action_15 _ = happyFail

action_16 (46) = happyShift action_21
action_16 _ = happyFail

action_17 (44) = happyShift action_20
action_17 _ = happyFail

action_18 (45) = happyShift action_19
action_18 _ = happyFail

action_19 (18) = happyShift action_24
action_19 _ = happyFail

action_20 (43) = happyShift action_23
action_20 _ = happyFail

action_21 (46) = happyShift action_22
action_21 _ = happyFail

action_22 _ = happyReduce_2

action_23 (20) = happyShift action_27
action_23 (8) = happyGoto action_26
action_23 _ = happyFail

action_24 (49) = happyShift action_25
action_24 _ = happyFail

action_25 (18) = happyShift action_30
action_25 _ = happyFail

action_26 (44) = happyShift action_29
action_26 _ = happyFail

action_27 (45) = happyShift action_28
action_27 _ = happyFail

action_28 (18) = happyShift action_33
action_28 _ = happyFail

action_29 (43) = happyShift action_32
action_29 _ = happyFail

action_30 (49) = happyShift action_31
action_30 _ = happyFail

action_31 (18) = happyShift action_36
action_31 _ = happyFail

action_32 (36) = happyShift action_35
action_32 _ = happyFail

action_33 (49) = happyShift action_34
action_33 _ = happyFail

action_34 (18) = happyShift action_39
action_34 _ = happyFail

action_35 (14) = happyGoto action_38
action_35 _ = happyReduce_20

action_36 (46) = happyShift action_37
action_36 _ = happyFail

action_37 (45) = happyShift action_44
action_37 _ = happyFail

action_38 (44) = happyShift action_42
action_38 (45) = happyShift action_43
action_38 (13) = happyGoto action_41
action_38 _ = happyFail

action_39 (49) = happyShift action_40
action_39 _ = happyFail

action_40 (18) = happyShift action_48
action_40 _ = happyFail

action_41 _ = happyReduce_21

action_42 (43) = happyShift action_47
action_42 _ = happyFail

action_43 (35) = happyShift action_46
action_43 _ = happyFail

action_44 (17) = happyShift action_45
action_44 _ = happyFail

action_45 (49) = happyShift action_52
action_45 _ = happyFail

action_46 (45) = happyShift action_51
action_46 _ = happyFail

action_47 (39) = happyShift action_50
action_47 _ = happyFail

action_48 (46) = happyShift action_49
action_48 _ = happyFail

action_49 _ = happyReduce_5

action_50 (16) = happyGoto action_57
action_50 _ = happyReduce_24

action_51 (33) = happyShift action_55
action_51 (34) = happyShift action_56
action_51 (9) = happyGoto action_54
action_51 _ = happyFail

action_52 (17) = happyShift action_53
action_52 _ = happyFail

action_53 (46) = happyShift action_64
action_53 _ = happyFail

action_54 (46) = happyShift action_63
action_54 _ = happyFail

action_55 (18) = happyShift action_62
action_55 _ = happyFail

action_56 (45) = happyShift action_61
action_56 _ = happyFail

action_57 (44) = happyShift action_59
action_57 (45) = happyShift action_60
action_57 (15) = happyGoto action_58
action_57 _ = happyFail

action_58 _ = happyReduce_25

action_59 _ = happyReduce_3

action_60 (37) = happyShift action_69
action_60 (38) = happyShift action_70
action_60 _ = happyFail

action_61 (18) = happyShift action_68
action_61 _ = happyFail

action_62 (45) = happyShift action_67
action_62 _ = happyFail

action_63 (45) = happyShift action_66
action_63 (12) = happyGoto action_65
action_63 _ = happyFail

action_64 _ = happyReduce_4

action_65 (46) = happyShift action_76
action_65 _ = happyFail

action_66 (32) = happyShift action_75
action_66 _ = happyFail

action_67 (18) = happyShift action_74
action_67 _ = happyFail

action_68 (49) = happyShift action_73
action_68 _ = happyFail

action_69 (45) = happyShift action_72
action_69 _ = happyFail

action_70 (45) = happyShift action_71
action_70 _ = happyFail

action_71 (18) = happyShift action_81
action_71 _ = happyFail

action_72 (18) = happyShift action_80
action_72 _ = happyFail

action_73 (18) = happyShift action_79
action_73 _ = happyFail

action_74 (49) = happyShift action_78
action_74 _ = happyFail

action_75 (45) = happyShift action_77
action_75 _ = happyFail

action_76 _ = happyReduce_19

action_77 (21) = happyShift action_86
action_77 _ = happyFail

action_78 (18) = happyShift action_85
action_78 _ = happyFail

action_79 (49) = happyShift action_84
action_79 _ = happyFail

action_80 (49) = happyShift action_83
action_80 _ = happyFail

action_81 (49) = happyShift action_82
action_81 _ = happyFail

action_82 (18) = happyShift action_93
action_82 _ = happyFail

action_83 (18) = happyShift action_92
action_83 _ = happyFail

action_84 (18) = happyShift action_91
action_84 _ = happyFail

action_85 (49) = happyShift action_90
action_85 _ = happyFail

action_86 (22) = happyShift action_88
action_86 (31) = happyShift action_89
action_86 (11) = happyGoto action_87
action_86 _ = happyFail

action_87 (46) = happyShift action_100
action_87 _ = happyFail

action_88 (45) = happyShift action_99
action_88 _ = happyFail

action_89 (45) = happyShift action_98
action_89 _ = happyFail

action_90 (18) = happyShift action_97
action_90 _ = happyFail

action_91 (49) = happyShift action_96
action_91 _ = happyFail

action_92 (49) = happyShift action_95
action_92 _ = happyFail

action_93 (49) = happyShift action_94
action_93 _ = happyFail

action_94 (18) = happyShift action_115
action_94 _ = happyFail

action_95 (18) = happyShift action_114
action_95 _ = happyFail

action_96 (18) = happyShift action_113
action_96 _ = happyFail

action_97 (46) = happyShift action_112
action_97 _ = happyFail

action_98 (23) = happyShift action_104
action_98 (24) = happyShift action_105
action_98 (25) = happyShift action_106
action_98 (26) = happyShift action_107
action_98 (27) = happyShift action_108
action_98 (28) = happyShift action_109
action_98 (29) = happyShift action_110
action_98 (30) = happyShift action_111
action_98 (10) = happyGoto action_103
action_98 _ = happyFail

action_99 (18) = happyShift action_102
action_99 _ = happyFail

action_100 (18) = happyShift action_101
action_100 _ = happyFail

action_101 (17) = happyShift action_129
action_101 _ = happyFail

action_102 (49) = happyShift action_128
action_102 _ = happyFail

action_103 (46) = happyShift action_127
action_103 _ = happyFail

action_104 (45) = happyShift action_126
action_104 _ = happyFail

action_105 (45) = happyShift action_125
action_105 _ = happyFail

action_106 (45) = happyShift action_124
action_106 _ = happyFail

action_107 (45) = happyShift action_123
action_107 _ = happyFail

action_108 (18) = happyShift action_122
action_108 _ = happyFail

action_109 (45) = happyShift action_121
action_109 _ = happyFail

action_110 (45) = happyShift action_120
action_110 _ = happyFail

action_111 (45) = happyShift action_119
action_111 _ = happyFail

action_112 _ = happyReduce_6

action_113 (46) = happyShift action_118
action_113 _ = happyFail

action_114 (46) = happyShift action_117
action_114 _ = happyFail

action_115 (46) = happyShift action_116
action_115 _ = happyFail

action_116 (46) = happyShift action_140
action_116 _ = happyFail

action_117 (45) = happyShift action_139
action_117 _ = happyFail

action_118 _ = happyReduce_7

action_119 (18) = happyShift action_138
action_119 _ = happyFail

action_120 (18) = happyShift action_137
action_120 _ = happyFail

action_121 (18) = happyShift action_136
action_121 _ = happyFail

action_122 _ = happyReduce_12

action_123 (18) = happyShift action_135
action_123 _ = happyFail

action_124 (18) = happyShift action_134
action_124 _ = happyFail

action_125 (18) = happyShift action_133
action_125 _ = happyFail

action_126 (18) = happyShift action_132
action_126 _ = happyFail

action_127 _ = happyReduce_17

action_128 (18) = happyShift action_131
action_128 _ = happyFail

action_129 (18) = happyShift action_130
action_129 _ = happyFail

action_130 (18) = happyShift action_150
action_130 _ = happyFail

action_131 (49) = happyShift action_149
action_131 _ = happyFail

action_132 (49) = happyShift action_148
action_132 _ = happyFail

action_133 (49) = happyShift action_147
action_133 _ = happyFail

action_134 (49) = happyShift action_146
action_134 _ = happyFail

action_135 (49) = happyShift action_145
action_135 _ = happyFail

action_136 (49) = happyShift action_144
action_136 _ = happyFail

action_137 (49) = happyShift action_143
action_137 _ = happyFail

action_138 (49) = happyShift action_142
action_138 _ = happyFail

action_139 (18) = happyShift action_141
action_139 _ = happyFail

action_140 _ = happyReduce_23

action_141 (49) = happyShift action_160
action_141 _ = happyFail

action_142 (18) = happyShift action_159
action_142 _ = happyFail

action_143 (18) = happyShift action_158
action_143 _ = happyFail

action_144 (18) = happyShift action_157
action_144 _ = happyFail

action_145 (18) = happyShift action_156
action_145 _ = happyFail

action_146 (18) = happyShift action_155
action_146 _ = happyFail

action_147 (18) = happyShift action_154
action_147 _ = happyFail

action_148 (18) = happyShift action_153
action_148 _ = happyFail

action_149 (18) = happyShift action_152
action_149 _ = happyFail

action_150 (46) = happyShift action_151
action_150 _ = happyFail

action_151 _ = happyReduce_18

action_152 (46) = happyShift action_169
action_152 _ = happyFail

action_153 (49) = happyShift action_168
action_153 _ = happyFail

action_154 (49) = happyShift action_167
action_154 _ = happyFail

action_155 (49) = happyShift action_166
action_155 _ = happyFail

action_156 (49) = happyShift action_165
action_156 _ = happyFail

action_157 (49) = happyShift action_164
action_157 _ = happyFail

action_158 (49) = happyShift action_163
action_158 _ = happyFail

action_159 (49) = happyShift action_162
action_159 _ = happyFail

action_160 (18) = happyShift action_161
action_160 _ = happyFail

action_161 (49) = happyShift action_177
action_161 _ = happyFail

action_162 (18) = happyShift action_176
action_162 _ = happyFail

action_163 (18) = happyShift action_175
action_163 _ = happyFail

action_164 (18) = happyShift action_174
action_164 _ = happyFail

action_165 (18) = happyShift action_173
action_165 _ = happyFail

action_166 (18) = happyShift action_172
action_166 _ = happyFail

action_167 (18) = happyShift action_171
action_167 _ = happyFail

action_168 (18) = happyShift action_170
action_168 _ = happyFail

action_169 _ = happyReduce_16

action_170 (46) = happyShift action_185
action_170 _ = happyFail

action_171 (46) = happyShift action_184
action_171 _ = happyFail

action_172 (46) = happyShift action_183
action_172 _ = happyFail

action_173 (46) = happyShift action_182
action_173 _ = happyFail

action_174 (46) = happyShift action_181
action_174 _ = happyFail

action_175 (46) = happyShift action_180
action_175 _ = happyFail

action_176 (46) = happyShift action_179
action_176 _ = happyFail

action_177 (18) = happyShift action_178
action_177 _ = happyFail

action_178 (46) = happyShift action_193
action_178 _ = happyFail

action_179 (17) = happyShift action_192
action_179 _ = happyFail

action_180 (45) = happyShift action_191
action_180 _ = happyFail

action_181 (17) = happyShift action_190
action_181 _ = happyFail

action_182 (45) = happyShift action_189
action_182 _ = happyFail

action_183 (17) = happyShift action_188
action_183 _ = happyFail

action_184 (17) = happyShift action_187
action_184 _ = happyFail

action_185 (18) = happyShift action_186
action_185 _ = happyFail

action_186 _ = happyReduce_8

action_187 (18) = happyShift action_200
action_187 _ = happyFail

action_188 (18) = happyShift action_199
action_188 _ = happyFail

action_189 (18) = happyShift action_198
action_189 _ = happyFail

action_190 (18) = happyShift action_197
action_190 _ = happyFail

action_191 (18) = happyShift action_196
action_191 _ = happyFail

action_192 (18) = happyShift action_195
action_192 _ = happyFail

action_193 (46) = happyShift action_194
action_193 _ = happyFail

action_194 _ = happyReduce_22

action_195 (18) = happyShift action_204
action_195 _ = happyFail

action_196 (49) = happyShift action_203
action_196 _ = happyFail

action_197 (45) = happyShift action_202
action_197 _ = happyFail

action_198 (49) = happyShift action_201
action_198 _ = happyFail

action_199 _ = happyReduce_10

action_200 _ = happyReduce_9

action_201 (18) = happyShift action_208
action_201 _ = happyFail

action_202 (18) = happyShift action_207
action_202 _ = happyFail

action_203 (18) = happyShift action_206
action_203 _ = happyFail

action_204 (18) = happyShift action_205
action_204 _ = happyFail

action_205 _ = happyReduce_15

action_206 (49) = happyShift action_211
action_206 _ = happyFail

action_207 (49) = happyShift action_210
action_207 _ = happyFail

action_208 (49) = happyShift action_209
action_208 _ = happyFail

action_209 (18) = happyShift action_214
action_209 _ = happyFail

action_210 (18) = happyShift action_213
action_210 _ = happyFail

action_211 (18) = happyShift action_212
action_211 _ = happyFail

action_212 (46) = happyShift action_217
action_212 _ = happyFail

action_213 (49) = happyShift action_216
action_213 _ = happyFail

action_214 (46) = happyShift action_215
action_214 _ = happyFail

action_215 (17) = happyShift action_220
action_215 _ = happyFail

action_216 (18) = happyShift action_219
action_216 _ = happyFail

action_217 (17) = happyShift action_218
action_217 _ = happyFail

action_218 (18) = happyShift action_223
action_218 _ = happyFail

action_219 (46) = happyShift action_222
action_219 _ = happyFail

action_220 (18) = happyShift action_221
action_220 _ = happyFail

action_221 _ = happyReduce_11

action_222 (18) = happyShift action_225
action_222 _ = happyFail

action_223 (45) = happyShift action_224
action_223 _ = happyFail

action_224 (18) = happyShift action_226
action_224 _ = happyFail

action_225 _ = happyReduce_13

action_226 (49) = happyShift action_227
action_226 _ = happyFail

action_227 (18) = happyShift action_228
action_227 _ = happyFail

action_228 (49) = happyShift action_229
action_228 _ = happyFail

action_229 (18) = happyShift action_230
action_229 _ = happyFail

action_230 (46) = happyShift action_231
action_230 _ = happyFail

action_231 (18) = happyShift action_232
action_231 _ = happyFail

action_232 _ = happyReduce_14

happyReduce_1 = happyReduce 6 4 happyReduction_1
happyReduction_1 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenInt happy_var_3)) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (RenderDescr happy_var_2 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_2 = happyReduce 8 5 happyReduction_2
happyReduction_2 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenInt happy_var_6)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenInt happy_var_4)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 ((happy_var_4,happy_var_6)
	) `HappyStk` happyRest

happyReduce_3 = happyReduce 15 6 happyReduction_3
happyReduction_3 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_14) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_10) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Scene happy_var_3 happy_var_6 happy_var_10 happy_var_14
	) `HappyStk` happyRest

happyReduce_4 = happyReduce 13 7 happyReduction_4
happyReduction_4 (_ `HappyStk`
	(HappyTerminal (TokenInt happy_var_12)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenInt happy_var_10)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_7)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Camera (happy_var_3,happy_var_5,happy_var_7) (happy_var_10,happy_var_12)
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 8 8 happyReduction_5
happyReduction_5 (_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_7)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 ((happy_var_3,happy_var_5,happy_var_7)
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 9 9 happyReduction_6
happyReduction_6 (_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_8)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_6)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Sphere happy_var_2 (happy_var_4,happy_var_6,happy_var_8)
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 10 9 happyReduction_7
happyReduction_7 (_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_9)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_7)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Plane (happy_var_3,happy_var_5,happy_var_7,happy_var_9)
	) `HappyStk` happyRest

happyReduce_8 = happyReduce 9 10 happyReduction_8
happyReduction_8 ((HappyTerminal (TokenDouble happy_var_9)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_7)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (perlinSolid (happy_var_3,happy_var_5,happy_var_7) happy_var_9
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 10 10 happyReduction_9
happyReduction_9 ((HappyTerminal (TokenDouble happy_var_10)) `HappyStk`
	(HappyTerminal (TokenInt happy_var_9)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_7)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (perlinSemiTurbulence (happy_var_3,happy_var_5,happy_var_7) happy_var_9 happy_var_10
	) `HappyStk` happyRest

happyReduce_10 = happyReduce 10 10 happyReduction_10
happyReduction_10 ((HappyTerminal (TokenDouble happy_var_10)) `HappyStk`
	(HappyTerminal (TokenInt happy_var_9)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_7)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (perlinTurbulence (happy_var_3,happy_var_5,happy_var_7) happy_var_9 happy_var_10
	) `HappyStk` happyRest

happyReduce_11 = happyReduce 17 10 happyReduction_11
happyReduction_11 ((HappyTerminal (TokenDouble happy_var_17)) `HappyStk`
	(HappyTerminal (TokenInt happy_var_16)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_14)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_12)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_10)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_7)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (perlinFire (happy_var_3,happy_var_5,happy_var_7) (happy_var_10,happy_var_12,happy_var_14) 
										            happy_var_16 happy_var_17
	) `HappyStk` happyRest

happyReduce_12 = happySpecReduce_2 10 happyReduction_12
happyReduction_12 (HappyTerminal (TokenDouble happy_var_2))
	_
	 =  HappyAbsSyn10
		 (perlinPlasma happy_var_2
	)
happyReduction_12 _ _  = notHappyAtAll 

happyReduce_13 = happyReduce 18 10 happyReduction_13
happyReduction_13 ((HappyTerminal (TokenDouble happy_var_18)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_16)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_14)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_12)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_10)) `HappyStk`
	(HappyTerminal (TokenInt happy_var_9)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_7)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (perlinMarble (happy_var_3,happy_var_5,happy_var_7) happy_var_9 happy_var_10 
										              (happy_var_12,happy_var_14,happy_var_16) happy_var_18
	) `HappyStk` happyRest

happyReduce_14 = happyReduce 25 10 happyReduction_14
happyReduction_14 ((HappyTerminal (TokenDouble happy_var_25)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_23)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_21)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_19)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_17)) `HappyStk`
	(HappyTerminal (TokenInt happy_var_16)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_14)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_12)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_10)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_7)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (perlinMarbleBase (happy_var_3,happy_var_5,happy_var_7) 
										                  (happy_var_10,happy_var_12,happy_var_14) 
                                                                                                  happy_var_16 happy_var_17 
										                  (happy_var_19,happy_var_21,happy_var_23) happy_var_25
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 12 10 happyReduction_15
happyReduction_15 ((HappyTerminal (TokenDouble happy_var_12)) `HappyStk`
	(HappyTerminal (TokenDouble happy_var_11)) `HappyStk`
	(HappyTerminal (TokenDouble happy_var_10)) `HappyStk`
	(HappyTerminal (TokenInt happy_var_9)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_7)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (perlinWood (happy_var_3,happy_var_5,happy_var_7) happy_var_9 happy_var_10 happy_var_11 happy_var_12
	) `HappyStk` happyRest

happyReduce_16 = happyReduce 8 11 happyReduction_16
happyReduction_16 (_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_7)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (Solid (happy_var_3,happy_var_5,happy_var_7)
	) `HappyStk` happyRest

happyReduce_17 = happyReduce 4 11 happyReduction_17
happyReduction_17 (_ `HappyStk`
	(HappyAbsSyn10  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (Perlin happy_var_3
	) `HappyStk` happyRest

happyReduce_18 = happyReduce 11 12 happyReduction_18
happyReduction_18 (_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_10)) `HappyStk`
	(HappyTerminal (TokenDouble happy_var_9)) `HappyStk`
	(HappyTerminal (TokenInt happy_var_8)) `HappyStk`
	(HappyTerminal (TokenDouble happy_var_7)) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Texture happy_var_5 happy_var_7 happy_var_8 happy_var_9 happy_var_10
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 7 13 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn12  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 ((happy_var_4,happy_var_6)
	) `HappyStk` happyRest

happyReduce_20 = happySpecReduce_0 14 happyReduction_20
happyReduction_20  =  HappyAbsSyn14
		 ([]
	)

happyReduce_21 = happySpecReduce_2 14 happyReduction_21
happyReduction_21 (HappyAbsSyn13  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_2 : happy_var_1
	)
happyReduction_21 _ _  = notHappyAtAll 

happyReduce_22 = happyReduce 17 15 happyReduction_22
happyReduction_22 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_15)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_13)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_11)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_8)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_6)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_4)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (PointLight (happy_var_4,happy_var_6,happy_var_8) (happy_var_11,happy_var_13,happy_var_15)
	) `HappyStk` happyRest

happyReduce_23 = happyReduce 10 15 happyReduction_23
happyReduction_23 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_8)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_6)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenDouble happy_var_4)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (AmbientLight (happy_var_4,happy_var_6,happy_var_8)
	) `HappyStk` happyRest

happyReduce_24 = happySpecReduce_0 16 happyReduction_24
happyReduction_24  =  HappyAbsSyn16
		 ([]
	)

happyReduce_25 = happySpecReduce_2 16 happyReduction_25
happyReduction_25 (HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_2 : happy_var_1
	)
happyReduction_25 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 50 50 (error "reading EOF!") (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenInt happy_dollar_dollar -> cont 17;
	TokenDouble happy_dollar_dollar -> cont 18;
	TokenCamera -> cont 19;
	TokenBackground -> cont 20;
	TokenDiff -> cont 21;
	TokenSolid -> cont 22;
	TokenPerlinSolid -> cont 23;
	TokenPerlinSemiTurb -> cont 24;
	TokenPerlinTurb -> cont 25;
	TokenPerlinFire -> cont 26;
	TokenPerlinPlasma -> cont 27;
	TokenPerlinMarble -> cont 28;
	TokenPerlinMarbleBase -> cont 29;
	TokenPerlinWood -> cont 30;
	TokenPerlin -> cont 31;
	TokenTexture -> cont 32;
	TokenSphere -> cont 33;
	TokenPlane -> cont 34;
	TokenTexturedObject -> cont 35;
	TokenObjects -> cont 36;
	TokenPointLight -> cont 37;
	TokenAmbientLight -> cont 38;
	TokenLights -> cont 39;
	TokenScene -> cont 40;
	TokenResolution -> cont 41;
	TokenRenderDescr -> cont 42;
	TokenOpenAcc -> cont 43;
	TokenCloseAcc -> cont 44;
	TokenOpenBrack -> cont 45;
	TokenCloseBrack -> cont 46;
	TokenOpenHook -> cont 47;
	TokenCloseHook -> cont 48;
	TokenComma -> cont 49;
	_ -> happyError' (tk:tks)
	}

happyError_ tk tks = happyError' (tk:tks)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Monad HappyIdentity where
    return = HappyIdentity
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [Token] -> HappyIdentity a
happyError' = HappyIdentity . happyError

parseScene tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq

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
{-# LINE 1 "GenericTemplate.hs" #-}
-- $Id$

{-# LINE 15 "GenericTemplate.hs" #-}






















































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	 (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 154 "GenericTemplate.hs" #-}


-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
	 sts1@(((st1@(HappyState (action))):(_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where sts1@(((st1@(HappyState (action))):(_))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail  (1) tk old_st _ stk =
--	trace "failing" $ 
    	happyError_ tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
	action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
