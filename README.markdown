PUNK.BLUR is a tiny AS3 library for doing motion blur in [FlashPunk](http://www.flashpunk.net "FlashPunk")
------------------------------------------------------------------------------------------------------------

There are two classes: BlurCanvas and BlurredGraphic. 
The demo folder holds a compilable demo, as an example of
how to use the library.

MINI DOCS:
-----------
(for more in-depth documentation, check out the wiki up top)

BlurCanvas extends Entity, and needs to be added to the current
World. The blur trails will show up on whatever layer the BlurCanvas
object is set to -- don't worry, though, the Entities themselves
will keep their normal layering. For most purposes, I'd recommend
setting the BlurCanvas to the layer below your Entities: that way,
the blur will appear beneath them, and not on top obscuring them.

BlurredGraphic is  a wrapper class for your Graphics; if you want a 
Graphic object to blur, just create a new BlurredGraphic object and
pass the Graphic, and your BlurCanvas instance, into its constructor. 
Set the Entity's graphic property to the BlurWrapper, and you're ready 
to go. Don't worry that the Entity's old graphic is now inside the 
wrapper -- it'll still render normally, on the appropriate Entity layer.