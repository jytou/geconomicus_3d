This is a set of tokens with their case and a card / token holder for the game Ğeconomicus. This is currently version 2 of the project.

They are developped in OpenScad, so you should be able to regenerate everything from the scad files.

At the moment, there are the following interesting files:
- token/token.scad which represents an individual token, and its derived token1_6.stl as well as a bigger token token.stl
- case/case.scad which is an adjustable case and cover for the tokens (just switch the boolean cover_only to true to render the cover)
- cards/holder.scad which is the holder to hold the playing cards as well as 3 sets of tokens. This way, in the Libre Money part of the game, the tokens can be rotated in order to always have the highest value on the left (or right if you prefer so)

Note that the .ini files are my parameters for slic3r which is currently the main slicer program I'm using for 3D printing. They may not suit you at all!

Here are a couple of pictures of the results:

Holding the card holder with both hands to show the different gripping possibilities:

![holder 1](https://github.com/jytou/geconomicus_3d/blob/master/pics/holderv2_holding.jpg)

The back of the holder:

![holder 2](https://github.com/jytou/geconomicus_3d/blob/master/pics/holderv2_back.jpg)

One token:

![tokens](https://github.com/jytou/geconomicus_3d/blob/master/pics/jetons.jpg)

A set of different colors for the tokens, colorblind-friendly:

![colors](https://github.com/jytou/geconomicus_3d/blob/master/pics/couleurs.jpg)

The frame view of the holder in openscad:

![holder inside](https://github.com/jytou/geconomicus_3d/blob/master/pics/holderv2_frame.jpg)

The 3d view of the holder in openscad:

![holder 3d](https://github.com/jytou/geconomicus_3d/blob/master/pics/holderv2_3d.jpg)

The open case:

![case open](https://github.com/jytou/geconomicus_3d/blob/master/pics/case_open.jpg)

The closed case:

![case clased](https://github.com/jytou/geconomicus_3d/blob/master/pics/case_closed.jpg)

The latch (I used simple paperclips for this one, but you can use any piece of wire):

![case latch](https://github.com/jytou/geconomicus_3d/blob/master/pics/case_latch.jpg)

The case upside-down:

![case down](https://github.com/jytou/geconomicus_3d/blob/master/pics/case_down.jpg)

A higher but narrowed case:

![case high](https://github.com/jytou/geconomicus_3d/blob/master/pics/high_case.jpg)

