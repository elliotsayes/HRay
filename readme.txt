HRay - a Haskell ray tracer
:==========================:

Command line interface:
-----------------------

To compile the command line interface with GHC:

ghc --make -O HRayMain -o HRay.exe

To run the progrma, execute HRay.exe !

Graphical user interface:
-----------------------

To compile the graphical user interface with GHC:

ghc --make -O HRayGUI -o HRayGUI.exe

To run the progrma, execute HRayGUI.exe !

Note: please make sure you have gtk2hs 0.9.7 (http://haskell.org/gtk2hs/)
installed an your system, together with the last release of Gtk+ (www.gtk.org). 
