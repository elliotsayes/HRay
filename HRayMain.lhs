		HRay main program, which contains the main function
	intended for usage with the other modules in the HRay package

   	author: Kenneth Hoste, 2004-2005
	part of a masters thesis at the University of Ghent, Belgium

	==========================================================================

> import HRayOutput (getRenderTime, createPPM, getImage)
> import HRayParser (RenderDescr(RenderDescr), readDescr)
> import System.Directory (doesFileExist)
> import System.Environment (getArgs)
> import System.CPUTime (getCPUTime)

        main function

> main :: IO()
> main = do args <- getArgs
>	    if (length args /= 2)
>              then error "Usage: HRay <input scene path> <output ppm path>\n"
>	       else do let input = head args
>	                   output = head (tail args)
>                      exists <- doesFileExist input
>                      case exists of
>                           True -> do fileContent <- readFile input
>                                      let (RenderDescr res depth scene) = readDescr fileContent
>                                      timeBefore <- getCPUTime
>			               writeFile output (createPPM res (getImage depth res scene))
>                                      timeAfter <- getCPUTime
>				       putStr $ "Image output written to " ++ output ++ " in PPM format\n"
>				       putStr $ "Time needed to render the image: " ++ (getRenderTime timeBefore timeAfter) ++ "\n"
>                           False -> error $ "File \"" ++ input ++ "\" does not exist.\n"
