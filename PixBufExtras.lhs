> {-# OPTIONS -O #-}


	module PixBufExtras, which contains a function needed to
	draw a bitmap image in the graphical user interface

   	author: Kenneth Hoste, 2004-2005
 	part of a masters thesis at the University of Ghent, Belgium

	special thanks to Duncan Coutts	

	=========================================================================


> module PixBufExtras (pixbufSetPixelsRGB8) where

> import Graphics.UI.Gtk

> import Data.Word (Word8)
> import Data.Array.MArray
> import Data.Array.Base (unsafeWrite)

> {-# INLINE pixbufSetPixelsRGB8 #-}
> pixbufSetPixelsRGB8 :: Pixbuf -> (Int -> Int -> (Word8, Word8, Word8)) -> IO ()
> pixbufSetPixelsRGB8 pixbuf setPixel = do
>  -- assert that the format is RGB8
>  3 <- pixbufGetNChannels pixbuf
>  8 <- pixbufGetBitsPerSample pixbuf
>  -- get the pixel array
>  pixelData <- pixbufGetPixels pixbuf
>  -- get the dimensions
>  rowStride <- pixbufGetRowstride pixbuf
>  width <- pixbufGetWidth pixbuf
>  height <- pixbufGetHeight pixbuf
>  doFromTo 0 (height-1) $ \y ->
>    doFromTo 0 (width-1) $ \x ->
>      case setPixel x y of
>        (red, green, blue) -> do
>          unsafeWrite pixelData (x*3 + y*rowStride + 0) red
>          unsafeWrite pixelData (x*3 + y*rowStride + 1) green
>          unsafeWrite pixelData (x*3 + y*rowStride + 2) blue

> {-# INLINE doFromTo #-}
> -- do the action for [from..to], ie it's inclusive.
> doFromTo :: Int -> Int -> (Int -> IO ()) -> IO ()
> doFromTo from to action =
>   let loop n | n > to   = return ()
>              | otherwise = do action n
>                               loop (n+1)
>    in loop from
