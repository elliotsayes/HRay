	HRay visual main program, built with Gtk2Hs
	intended for usage with the other modules in the HRay package

   	author: Kenneth Hoste, 2004-2005
	part of a masters thesis at the University of Ghent, Belgium

	==========================================================================

> import Graphics.UI.Gtk hiding (Graphics.UI.Gtk.Gdk.Enums.Solid,Graphics.UI.Gtk.General.Structs.Color)
> import Data.IORef (newIORef,readIORef,writeIORef)
> import Data.Array (Array, (!), listArray) 
> import Maybe (isNothing)
> import PixBufExtras (pixbufSetPixelsRGB8)
> import HRayEngine (Scene(Scene))
> import HRayOutput (getRenderTime, getImage)
> import HRayParser (RenderDescr(RenderDescr), readDescr)
> import Directory (doesFileExist)
> import System.CPUTime (getCPUTime)

--------------------
| Reading a  scene |
--------------------

> loadThisScene :: String -> IO (Maybe RenderDescr)
> loadThisScene file = do 
>                          exists <- doesFileExist file 
>                          case exists of
>                               True -> do 
>                                    fileContent <- readFile file
>                                    return (Just (readDescr fileContent))
>                               False -> return Nothing 

-------------------------
| Handling click events |
------------------------

  loading a scene

> loadScene :: String -> Label -> Label -> Label -> IO (Maybe RenderDescr)

> loadScene "" messLabel descrLabel renderTimeLabel = do 
>   labelSetText messLabel "\nNo scene loaded.\n"
>   labelSetText descrLabel "\nScene description:\n\n Resolution: <none>\n Objects: <none>\n Lights: <none>\n"
>   labelSetText renderTimeLabel "\nRender time:\n\n   <none>\n"
>   return Nothing

> loadScene file messLabel descrLabel renderTimeLabel = do
>   renderDescr <- loadThisScene file
>   labelSetText renderTimeLabel "\nRender time:\n\n   <none>\n"
>   case renderDescr of
>        Nothing -> do 
>	    labelSetText messLabel "\nNo such file.\n"
>           labelSetText descrLabel "\nScene description:\n\n Resolution: <none>\n Objects: <none>\n Lights: <none>\n"
>        (Just (RenderDescr (rx,ry) depth (Scene _ _ objects lights)) ) -> do 
>           labelSetText messLabel "\nScene loaded.\n"
>           labelSetText descrLabel ("\nScene description:\n\n Resolution: "++(show rx)++"x"++
>				     (show ry)++"\n # Objects: "++(show (length objects))++"\n # Lights: "++
>				     (show (length lights))++"\n")
>   return renderDescr


  setting up a pixbuf with a Color array
  
> pixbufSetPixelsRGB8FromArray :: Int -> Pixbuf -> Array Int (Int,Int,Int) -> IO()
> pixbufSetPixelsRGB8FromArray w pixbuf arr =
>    pixbufSetPixelsRGB8 pixbuf (\x y -> (\ (r,g,b) -> (fromIntegral r, fromIntegral g, fromIntegral b)) $ arr!(y*w+x) )


  rendering a scene

> renderScene :: (Maybe RenderDescr) -> Label -> IO Pixbuf

> renderScene (Just (RenderDescr res@(rx,ry) depth scene)) descrLabel = do
>   let colorList   = map (\ (r,g,b) -> (round (r*255),round (g*255),round (b*255))) $ getImage depth res scene
>       colorArray  = listArray (0,rx*ry-1) colorList
>   pixBuf <- pixbufNew ColorspaceRgb False 8 rx ry
>   pixbufSetPixelsRGB8FromArray rx pixBuf colorArray
>   return pixBuf

---------------------------
| Handling closure events |
---------------------------

  returning 'False' results in destroys the window
  (and throws a destroy-event)

> deleteEvent :: Event -> IO Bool
> deleteEvent _ = do return False

  
  what should happen when the window is being closed

> destroyEvent :: IO()
> destroyEvent = do mainQuit

--------------------
| : : : MAIN : : : |
--------------------

> main :: IO()
> main = do 


    initializing GUI

>   initGUI


    setting up new window

>   window <- windowNew
>   onDelete window deleteEvent
>   onDestroy window destroyEvent
>   windowSetTitle window "HRay - a Haskell raytracer"


    creating a place to show the rendered image

>   scrollWindow <- scrolledWindowNew Nothing Nothing
>   containerSetBorderWidth scrollWindow 10
>   image <- imageNewFromFile "default.png"
>   scrolledWindowAddWithViewport scrollWindow image
>   widgetSetSizeRequest scrollWindow 800 600


    creating the control panel

>   controlPanel <- vBoxNew False 2
>   containerSetBorderWidth controlPanel 10


    setting up the file entry box

>   entry <- entryNew
>   entrySetWidthChars entry 20


    setting up the load button

>   loadButton <- buttonNewWithLabel "Load scene"


    setting up the message label

>   messageLabel <- labelNew (Just "\nNo scene loaded.\n")


    setting up the render button

>   renderButton <- buttonNewWithLabel "Render scene"


    setting up the scene description label

>   descrLabel <- labelNew (Just "\nScene description:\n\n Resolution: <none>\n Objects: <none>\n Lights: <none>\n")

    setting up the render time label

>   renderTimeLabel <- labelNew (Just "\nRender time:\n\n   <none>\n")


    preparing scene

>   renderDescrRef <- newIORef Nothing


    setting click actions

>   onClicked loadButton $ do
>      fileStr <- (entryGetText entry)
>      renderDescr <- loadScene fileStr messageLabel descrLabel renderTimeLabel
>      writeIORef renderDescrRef renderDescr

>   onClicked renderButton $ do
>      renderDescr <- readIORef renderDescrRef
>      let loop = do
>                   n <- eventsPending
>                   if n == 0 then return () else mainIterationDo False >> loop
>      if isNothing renderDescr then 
>                                labelSetMarkupWithMnemonic messageLabel "\n<b>Please load a scene.</b>\n"
>                         	else do 
>                                timeBefore <- getCPUTime
>                                labelSetMarkupWithMnemonic messageLabel ("\n<span foreground=\"red\">"++
>								          "<b>Rendering scene...</b></span>\n")
>                                loop
>                                pixBuf <- renderScene renderDescr descrLabel
>                                labelSetText messageLabel "\nScene rendered !\n"
>                                imageSetFromPixbuf image pixBuf
>                                timeAfter <- getCPUTime
>                                labelSetText renderTimeLabel $ "\nRender time:\n\n   " ++ 
>								(getRenderTime timeBefore timeAfter) ++ "\n"


    adding everything to the control panel

>   boxPackStart controlPanel entry PackNatural 0
>   boxPackStart controlPanel loadButton PackNatural 0
>   boxPackStart controlPanel messageLabel PackNatural 0
>   boxPackStart controlPanel renderButton PackNatural 0
>   boxPackStart controlPanel descrLabel PackNatural 0
>   boxPackStart controlPanel renderTimeLabel PackNatural 0


    adding everything to the window

>   hBox <- hBoxNew False 2
>   boxPackStart hBox scrollWindow PackNatural 0
>   boxPackStart hBox controlPanel PackNatural 0
>   containerAdd window hBox


    packing and showing everything

>   widgetShowAll window


    wait for events to occure

>   mainGUI
