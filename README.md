Supt
====

**Supt** is simple interrupt notifier for World of Warcraft. It does **not** announce interrupts to other people. Instead it displays a message on your screen when you successfully interrupt a spell, to help you keep track of when you're actually interrupting things.

There are no in-game commands, but some simple configuration options can be found at the top of **main.lua**. The options available are:
* x & y position (from centre of the screen)
* Time to keep the display on screen
* How long the display will take to fadeout
* The size of the font
* Whether to print to the chat log (does not send a message to other players)
* Whether to show the mob name in the output

The default values are listed below (in case you break something!) 

```lua
local x, y = 0, 150         -- x & y positioning from the centre of the screen
local displayDuration = 3   -- how long to keep the display on screen (seconds)
local fadeDuration = 1.5    -- how long for the display to fadeout (seconds)
local fontSize = 14         -- size of the font
local fontFlag = "OUTLINE"  -- font decoration ("OUTLINE", "THICKOUTLINE" or "MONOCHROME")

local alsoPrint = false     -- also print to the chatlog - does NOT send to other players! (true/false)
local showMobName = true    -- show the mob name in the output (true/false)
```
