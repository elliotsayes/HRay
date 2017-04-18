	module HRayMath, which contains some basic math functions needed in the HRay package
	intended for usage with the other modules in the HRay package, but can be used
	independed from the HRay package

   	author: Kenneth Hoste, 2004-2005
	part of a masters thesis at the University of Ghent, Belgium

	==========================================================================

> module HRayMath where


        representation of a point in a 2D-space

> type Point2D = (Int,Int)

        representation of a point in a 3D-space

> type Point3D = (Double,Double,Double)

        representation of a 3D-vector

> type Vector = (Double,Double,Double)

        representation of a 2D resolution

> type Resolution = (Int,Int)

        representation of a view window

> type Dimension = (Int,Int)

        representation of the supported object types

> data Object =   Sphere Double Point3D
>               | Plane (Double,Double,Double,Double)

        representation of a ray

> data Ray = Ray Point3D Vector

	function which constructs a ray given the start point and another point on the ray 

> mkRay :: Point3D -> Point3D -> Ray
> mkRay p1 p2 = Ray p1 (mkNormVect p1 p2)

        addition of two tuples

> (<+>) :: (Double,Double,Double) -> (Double,Double,Double) -> (Double,Double,Double)
> (x1,y1,z1) <+> (x2,y2,z2) = (x1+x2, y1+y2, z1+z2)

        subtraction of two tupels

> (<->) :: Point3D -> Point3D -> Vector
> (x1,y1,z1) <-> (x2,y2,z2) = (x1-x2,y1-y2,z1-z2)

	multiplication of two tuples

> (<*>) :: (Double,Double,Double) -> (Double,Double,Double) -> (Double,Double,Double)
> (x1,y1,z1) <*> (x2,y2,z2) = (x1*x2,y1*y2,z1*z2)

	multiplication of a tuple with a factor

> (*>) :: (Double,Double,Double) -> Double -> (Double,Double,Double)
> (x,y,z) *> f = (x*f,y*f,z*f)

	clips a tuple with a max value

> maxF :: Double -> (Double,Double,Double) -> (Double,Double,Double)
> maxF f (x,y,z) = (max x f, max y f, max z f)

	clips a tuple with a min value

> minF :: Double -> (Double,Double,Double) -> (Double,Double,Double)
> minF f (x,y,z) = (min x f, min y f, min z f)

        inner product

> (*.) :: Vector -> Vector -> Double
> (x1,y1,z1) *. (x2,y2,z2) = x1*x2 + y1*y2 + z1*z2

	length of a vector

> len :: Vector -> Double
> len v = sqrt (v *. v)

        normalizes a vector

> norm :: Vector -> Vector
> norm v 
>	| len v < 10**(-9) = (0.0,0.0,0.0) 
>	| otherwise        = v *> (1/(len v))

        construct a 3D normalised vector, given two 3D points

> mkNormVect :: Point3D -> Point3D -> Vector
> mkNormVect v w = norm (w <-> v)

        function which returns the distance between two points

> dist :: Point3D -> Point3D -> Double
> dist p0 p1 = sqrt ((p1 <-> p0) *. (p1 <-> p0))

        function which clips a color to correct values 
	- negative rgb values are casted to 0.0 values
        - positive rgb values higher than 1.0 are casted to 1.0

> clip :: (Double,Double,Double) -> (Double,Double,Double)
> clip = (maxF 0.0) . (minF 1.0)

        function which solves a quadratic equation (ax² + bx + c = 0)

> solveq :: (Double,Double,Double) ->[Double] 
> solveq (a,b,c)
>     | (d < 0)   = []
>     | (d > 0)   = [(- b - sqrt d)/(2*a), (- b + sqrt d)/(2*a)]
>     | otherwise = [-b/(2*a)]
>     where
>        d = b*b - 4*a*c

        function which intersects some object with a ray (line) (equation: origin + dir = 0)
        returns a _sorted_ list with the intersection points, or an empty list when there are no intersection points

> intRayWith :: Ray -> Object -> [Double]

        	function which intersects a ray with a sphere (equation: (x-cenA)²+(y-cenB)²+(z-cenC)² = rad²)

> intRayWith (Ray start dir) (Sphere rad cen) = solveq (dir *. dir, 2*(dir *. d), (d *. d) - rad^2)
>    where
>	 d = start <-> cen

	       function which intersects a ray with a plane (equation: Ax + By + Cz + D = 0)
        	where (A,B,C) is the normal on the plane, and D the distance from the origin to the normal if (A,B,C) is normalized
		when normal . dir = 0, the ray and plane are parallel, so there is no intersection

> intRayWith (Ray start dir) (Plane (a,b,c,d)) = if (abs(part) < 10**(-9)) then []  
>                                                                              else [- (d + ((a,b,c) *. start) ) / part]
>   where
>	part = (a,b,c) *. dir

        function which determines the normal at a certain point on some type of object

> normal :: Point3D -> Object -> Vector

	        function which determines the normal at a certain point on a sphere

> normal p (Sphere rad cen) = norm ((p <-> cen) *> (1/rad))

        	function which determines the normal at a certain point on a plane

> normal _ (Plane (a,b,c,d)) = norm (a,b,c)

 	determines the reflected direction given a certain direction vector and a normal

> reflectDir :: Vector -> Vector -> Vector
> reflectDir i n = i <-> (n *> (2*(n *. i)))

	determines the refracted direction given a certain direction (normalized) vector and a (normalized) normal

> refractDir :: Vector -> Vector -> Double -> Vector
> refractDir i n r = if (v < 0) then (0.0, 0.0, 0.0)
>		     else norm $ (i *> r_c) <+> (n *> (r_c*(abs c) - sqrt v))
>   where
>	c   = n *. (i *> (-1))
>       r_c = if (c < 0) then r else 1/r -- when cosVal < 0, inside of sphere (so travelling to vacuum)
>	v   = 1 + (r_c^2) * (c^2 - 1)

        function which returns a new 2D point for a certain window from a given 2D point and a given resolution
        (used for mapping a raster of pixels onto a view window)

> mapToWin :: Resolution -> Dimension -> Point2D -> Point3D
> mapToWin (rx,ry) (w,h) (px,py) = (x/rxD,y/ryD,0.0)
>   where
>	(rxD,ryD) = (fromIntegral rx, fromIntegral ry)
>	(pxD,pyD) = (fromIntegral px, fromIntegral py)
>	(wD,hD)   = (fromIntegral w, fromIntegral h)
>	(x,y)     = ( (pxD-rxD/2)*wD, (pyD-ryD/2)*hD )
