	module HRayEngine, which contains the functions needed to raytrace a scene
	intended for usage with the other modules in the HRay package

   	author: Kenneth Hoste, 2004-2005
	part of a masters thesis at the University of Ghent, Belgium

	==========================================================================

> module HRayEngine (Resolution, Color, Diff(Solid,Perlin), Texture(Texture), TexturedObject, 
>		     Light(AmbientLight,PointLight), Scene(Scene), Camera(Camera), rayTrace) where

> import Data.Maybe
> import Prelude hiding ((*>),(<*>))
> import HRayMath


        representation of a color

> type Color = (Double,Double,Double)

        representation of the diffuse component of a material: solid or perlin noise

> data Diff = Solid Color |
>             Perlin (Point3D -> Color)

        representation of a material

> data Texture = Texture Diff Double Int Double Double

        representation of an object

> type TexturedObject = (Object,Texture)

	representation of a light intensity

> type Intensity = (Double,Double,Double)

        representation of a light source

> data Light = PointLight Point3D Intensity
>            | AmbientLight Intensity

        representation of a camera

> data Camera = Camera Point3D Dimension

	representation of a scene

> data Scene = Scene Camera Color [TexturedObject] [Light]

        representation of an intersection

> data Intersection = Intersection Double Ray TexturedObject

        representation of an image

> type Image = Point2D -> Color

	determines the distance between the start point of the ray and the intersection point

> intDist :: (Maybe Intersection) -> Double
> intDist Nothing = 0.0
> intDist (Just (Intersection d _ _)) = d

	determines the texture of the intersected object

> intText :: (Maybe Intersection) -> Texture
> intText Nothing = Texture (Solid (0.0,0.0,0.0)) 0.0 0 0.0 0.0
> intText (Just (Intersection _ _ (_,t))) = t

	determines the color at the intersection point
	- if the texture has a solid color, this color is returned
	- if the texture has a noise function to determine the color, 
	  this function is used to determine the color for the given point

> colorAt :: (Maybe Intersection) -> Color
> colorAt Nothing   = (0.0,0.0,0.0)
> colorAt (Just (Intersection _ _ (_,Texture (Solid color) _ _ _ _) )) = color
> colorAt i@(Just (Intersection _ _ (_,Texture (Perlin f) _ _ _ _) )) = f (intPt i)

	determines the normal at the intersection point

> normalAt :: (Maybe Intersection) -> Vector
> normalAt Nothing   = (0.0,0.0,0.0)
> normalAt i@(Just (Intersection _ _ (o,_) )) = normal (intPt i) o

	determines the intersection point of the given intersection

> intPt :: (Maybe Intersection) -> Point3D
> intPt Nothing = (0.0,0.0,0.0)
> intPt (Just (Intersection d (Ray start dir) _)) = start <+> (dir *> d)


	determines the first positive value in a list

> fstPos :: [Double] -> Double
> fstPos   []   = 0.0
> fstPos (l:ls) = if l > 10**(-6) then l else fstPos ls

        determines the _closest_ intersection of a ray and an object, with a distance bigger then the given distance
        if no intersection (with a distance higher then the given distance) is found, the given intersection is returned,
        else, the new intersection is created and returned
        ! ! ! the list returned by intRayWith should be sorted ! ! !

> closestInt :: Ray -> (Maybe Intersection) -> TexturedObject -> (Maybe Intersection)

> closestInt r i (o,m) = if d > 10**(-6) && ((isNothing i) || d < (intDist i)) 
>				then Just (Intersection d r (o,m))
>				else i
>    where
>	d = fstPos (intRayWith r o)

	determines the closest intersection of aray and a list of objects

> intersect :: Ray -> [TexturedObject] -> (Maybe Intersection)
> intersect r o = foldl (closestInt r) Nothing o

	determines the diffuse color at the intersection point

> diff :: (Maybe Intersection) -> Light -> Color
> diff _ (AmbientLight _)     = (0.0,0.0,0.0)
> diff i (PointLight pos int) = (int *> ((mkNormVect (intPt i) pos) *. (normalAt i))) <*> (colorAt i)

	determines the specular color at the intersection point

> spec :: (Maybe Intersection) -> Vector -> Light -> Color
> spec _ _ (AmbientLight _)     = (0.0,0.0,0.0)
> spec i d (PointLight pos int) = int *> (reflCoef * ( ((normalAt i) *. h)**(fromIntegral specCoef) ))
>   where
>       h  				  = norm ((d *> (-1)) <+> (mkNormVect (intPt i) pos))
>	(Texture _ reflCoef specCoef _ _) = intText i  

        shades the intersection point 

> shadePt :: Intersection -> Vector -> [TexturedObject] -> Light -> Color 

		if there is an ambient light in the scene (always in front of the list), then use it 

> shadePt i d o (AmbientLight int) = int

		illuminate an intersection point with a point light

> shadePt i d o l@(PointLight pos int)
>	-- distance between light point and an object is smaller than distance between light point and shaded intersection 
>       -- => shadow -> no color factor added by this light source 
>	| s         = (0.0,0.0,0.0)
>	-- no shadow -> color factor added by this light source 
>	| otherwise = (diff (Just i) l) <+> (spec (Just i) d l)
>	where 
>		s     = not (isNothing i_s) && (intDist i_s) <= dist (intPt (Just i)) pos 
>           	i_s = intersect (mkRay (intPt (Just i)) pos) o 

        calculates the reflected component at the given intersection point 

> reflectPt :: Int -> Intersection -> Vector -> [TexturedObject] -> [Light] -> Color 
> reflectPt depth i d = colorPt depth (Ray (intPt (Just i)) (reflectDir d (normalAt (Just i)))) (0.0,0.0,0.0) 
 
        calculates the refracted component at the given intersection point

> refractPt :: Int -> Intersection -> Vector -> Color -> [TexturedObject] -> [Light] -> Color  
> refractPt depth i d b = if refractedDir == (0.0,0.0,0.0) then (\x y -> (0.0,0.0,0.0))  
>							   else colorPt depth (Ray (intPt (Just i)) refractedDir) (b *> refrCoef) 
>   where 
>	refractedDir                       = refractDir d (normalAt (Just i)) refrIndex  
>	(Texture _ _ _ refrCoef refrIndex) = intText (Just i)  


        determines the color at the given point of the view plane

> colorPt :: Int -> Ray -> Color -> [TexturedObject] -> [Light] -> Color

		when the maximum depth is reached, recursion stops

> colorPt (-1) _ _ _ _ = (0.0, 0.0, 0.0) 

> colorPt d r@(Ray _ dir) b o l = if (isNothing i) then b else clip $ shadeColor <+> reflectColor <+> refractColor
>   where 
>       shadeColor   = foldl (<+>) (0.0,0.0,0.0) (map (shadePt (fromJust i) dir o) l)
>       reflectColor = if (reflCoef == 0.0) then (0.0, 0.0, 0.0) 
>                                          else (reflectPt (d-1) (fromJust i) dir o l) *> reflCoef 
>       refractColor = if (refrCoef == 0.0) then (0.0, 0.0, 0.0) 
>                                          else (refractPt (d-1) (fromJust i) dir b o l) *> refrCoef 
>       i = intersect r o 
>	(Texture _ reflCoef _ refrCoef _) = intText i 

	determines the color of one ray through a given point 

> rayTracePt :: Int -> Scene -> Point3D -> Color 
> rayTracePt d (Scene (Camera eye _) b o l) p = colorPt d (Ray p (mkNormVect eye p)) b o l 

        raytraces the scene, and returns a list of colors representing the image

> rayTrace :: Int -> Resolution -> Scene -> Image 
> rayTrace d r s@(Scene (Camera _ dim) _ _ _) = (rayTracePt d s) . (mapToWin r dim) 
