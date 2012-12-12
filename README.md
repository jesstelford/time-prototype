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
