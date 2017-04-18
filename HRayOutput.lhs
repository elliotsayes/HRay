	module HRayOutput, which contains IO related functions
	intended for usage with the other modules in the HRay package

   	author: Kenneth Hoste, 2004-2005
	part of a masters thesis at the University of Ghent, Belgium

	==========================================================================

> module HRayOutput (getRenderTime, createPPM, getImage) where

> import HRayEngine (Resolution, Color, Scene, rayTrace)


	determines the render time given the start and end cpu time 

> getRenderTime :: Integer -> Integer -> String
> getRenderTime before after = (show min) ++ "m" ++ secStr ++ "s"
>   where
>       total  = div (after - before) (10^12)
>       sec    = mod total 60
>       secStr = if (sec < 10) then "0" ++ (show sec) else show sec
>       min    = div total 60

	determines the array of colors representing an image

> getImage :: Int -> Resolution -> Scene -> [Color]
> getImage d r@(rx,ry) s = [image (fromIntegral x,fromIntegral (-y)) | y <- [-(ry-1)..0], x <- [0..(rx-1)]]
>   where
>	image = rayTrace d r s

        transforms a list of colors into a portable pixmap (PPM) file

> createPPM :: Resolution -> [Color] -> String
> createPPM (w,h) colors = ("P3\n"++) . shows w . (' ':) . shows h . ("\n255\n"++) 
>			           . stringify colors $ ""
>                 where stringify = flip $ foldr showC
>                       showC (r,g,b) = shows (round (r*255)) . (' ':) . shows (round (g*255)) 
>					. (' ':) . shows (round (b*255)) . (' ':)



	possible speed up: working without the use of string
	but using hPutBuf (System.IO) instead
	documentation on Ptr: http://www.cse.unsw.edu.au/~chak/haskell/ffi
	
