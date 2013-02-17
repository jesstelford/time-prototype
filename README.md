# Time based game prototype

Using the [LÖVE game engine](https://love2d.org) and the [HUMP tools](https://github.com/vrld/hump)

Source code is released under the FreeBSD Licence. See LICENSE.md

## Requirements

[Lua stdlib](https://github.com/rrthomas/lua-stdlib) which can be installed via [luarocks](http://luarocks.org/en/Using_LuaRocks):

    $ sudo luarocks install stdlib

[LÖVE game engine](https://love2d.org/#download)

## Run

    $ love /path/to/src

## Notes

Lua passes variables by value, but tables by reference.
The stdlib provides tree.clone(table) for deep copy of tables.

# Influences

 * [Time Manipulation Experimental Gameplay Project](http://experimentalgameplay.com/blog/2012/08/time-manipulation-in-august-september/)
 * Braid
 * [The Misadventures of P.B. Winterbottom](http://www.youtube.com/watch?v=81zfIVo4CRE)
 * Prince Of Persia, Sands of Time
 * [Super Time Force](http://vimeo.com/48563418)

... But none of these deal with the paradoxes of time travel!

 * [Ratched & Clank: A Crack In Time](http://www.youtube.com/watch?v=B5ye6jp_iwo&list=PLD6BDC11F7BBAC32D)
  * This deals with the paradox of time by forcing the player to go in stages,
    using limited "Recordings" of themselves, which they can then record over
