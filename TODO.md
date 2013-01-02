# Unit Testing

[Busted, Elegant Lua unit testing](http://olivinelabs.com/busted/)

# Coding style
## Composition over inheritance

Start taking advantage of Lua's Prototypal structure. Instead of using an OOP
Class based system, use a prototypal composition based system for building up
objects.

To do so, we could go one of two ways:

### Multiple Prototypes

Where we do something like:

    Renderable = {}
    
    function Renderable:init(image)
    	self.image = image
    end
    
    Positionable = {}
    
    function Positionable:init(xpos, ypos)
    	self.xpos = xpos
    	self.ypos = ypos
    end
    
    Player = Positionable
    Player.addParent(Renderable) -- TODO: How do I do this so the Player has multiple prototypal parents..?

#### Caveats

Is it actually possible to have multiple parental prototypes?

 * What about naming conflicts?
 * What about metatables? Are they combined? Should they be combined?

### Extendable Modules & Sub Modules

Using the [Javascript Module Pattern](http://www.adequatelygood.com/2010/3/JavaScript-Module-Pattern-In-Depth),
we can compose a module from a series of other modules.

*foo.lua*

    return (function(parent, submoduleName)
    
    	-- ensure there's a default object passed in
    	if not not parent
    		parent = {}
    	end
    
    	-- ability to optionally set this as a sub module
    	if not not submoduleName then
    		parent[submoduleName] = {}
    		me = parent[submoduleName]
    	else
    		me = parent
    	end
    
    	local privateFunction = function() end
    
    	me.exportedVar = 123
    	me.exportedFunction = function() end
    	-- ... other capabilities
    
    	-- return the object passed in
    	return parent
    end)

*main.lua*

    local player = {}
    player.module = require "foo"({})

Then to expand on setting exported functions, you can do:

*bar.lua*

    return (function(me)
    	-- ensure there's a default object passed in
    	if not not parent
    		parent = {}
    	end
    
    	-- ability to optionally set this as a sub module
    	if not not submoduleName then
    		parent[submoduleName] = {}
    		me = parent[submoduleName]
    	else
    		me = parent
    	end
    
    	local old_exportedFunction = me.exportedFunction or function() end
    	
    	me.exportedFunction = function()
    		old_exportedFunction();
    	end
    	-- ... other capabilities
    
    	return parent
    end)

#### Caveats

 * Requires ensuring modules don't have variable naming conflicts. For example,
   instead of both a Renderable and PhysicObject using `position`, it should be
   `renderPosition` and `physicsPosition` respectively. This can be solved by
   using sub modules
 * Too verbose trying to set the parent, etc, for each module... But, that could
   be fixed easily by creating a module wrapper, like so:

*module.lua*

    return (function(parent, submoduleName = nil, moduleDefinition)
    	
    	-- ensure there's a default object passed in
    	if not not parent
    		parent = {}
    	end
    
    	-- ability to optionally set this as a sub module
    	if not not submoduleName then
    		parent[submoduleName] = {}
    		local me = parent[submoduleName]
    	else
    		local me = parent
    	end
    
    	return moduleDefinition(me)
    
    end)

### Copy-on-instantiate

(What is this actually called? Classes without Inheritance?)

This takes some parts from Prototyping and some from OOP, but keeps every
instantiation as a seperate entity.

    Renderable = {}
    
    function Renderable:init(image)
    	self.image = image
    end
    
    Positionable = {}
    
    function Positionable:init(xpos, ypos)
    	self.xpos = xpos
    	self.ypos = ypos
    end

    Class = {}

    function Class:extend(table)
    	for key, value in pairs(table)
    		if type(value) == 'table' then
    			self[key] = tree.clone(value)
    		else
    			self[key] = value
    		end
    	end
    end
    
    Player = Class
    Player.extend(Renderable)
    Player.extend(Positionable)

#### Extensions

Allow only extending of certain objects using lua's pattern matching?

    function Class:extend(table, patterns)
    	for key, value in pairs(table)
            	-- TODO: Probably a more efficient way to do this
            	for _, pattern in pairs(patterns)
            		if pattern.match(key) then -- TODO: Is this correct?
            			if type(value) == 'table' then
            				self[key] = tree.clone(value)
            			else
            				self[key] = value
            			end

            			break
            		end
            	end
    	end
    end


#### Caveats

 * What exactly does tree.clone() do?
 * What about naming conflicts?
 * What about metatables?

## Module loading

### Current system

Instead of the current system of loading modules like:

*foo.lua*

    Foo = {} -- avoid circular dependancy
    Bar = Bar or require "bar"

    Foo = {
    	bar: Bar
    }

    return Foo

*bar.lua*

    Bar = {} -- avoid circular dependancy
    Foo = Foo or require "foo"

    Bar = {
    	foo: Foo
    }

    return Bar

### Proposed System

Something like RequireJS (or a port of RequireJS to Lua?):

*main.lua*

    Require = require "require"

*my/foo.lua*

    return Require(
    	{ "my.bar" },
    	function (My_Bar)
    		local Foo = {
    			bar: My_Bar
    		}
    		return Foo
    	end
    )

*my/bar.lua*

    return Require(
    	{ "my.foo" },
    	function (My_Foo)
    		local Bar = {
    			bar: My_Foo
    		}
    		return Bar
    	end
    )

*require.lua*

    --[[
    Usage:

        In file my/bar.lua:

	return Require(
	    { --[[ dependancies ]]- },
	    function ( --[[ instantiated dependancies ]]--)
	        local Module = -- whatever
		return Module
	    end
	)

    Note that this assumes a few things:
     * Dependancies are passed in as an array of file names (in lua's 'dot' format)
     * Instantiated Dependancies are passed in the same order the dependancies are defined
     * The module will be returned from the load closure function

    TODO: How to solve circular dependancies? Because this method will currently
    pass a blank table as the dependancy to be used inside the load closure,
    which is incorrect.

    ]]--

    local Require = {
    	loaded: {}
    }
    
    local function load(self, dependancies, load)
    	-- TODO: Get the name of the file that is currently calling this load method, and store it in 'thisModule' below
    	local thisModule = 'blah.zoo'
    
    	if not not self.loaded[thisModule] then
    		return self.loaded[thisModule]
    	end
    
    	self.loaded[thisModule] = {} -- Avoid circular dependancies
    
    	loadedDependancies = {}
    
    	for _, file in pairs(dependancies)
    		if not self.loaded[file] then
    			self.loaded[file] = require file
    			table.insert(loadedDependancies, self.loaded[file])
    		end
    	end
    
    	self.loaded[thisModule] = load(unpack(loadedDependancies))
    
    	return self.loaded[thisModule]
    end

    -- TODO: I dont' think this is quite right, but the goal is to be able to call either Require.load(...) or just Require(...)
    return metatable {
    	Require,
    	__call = load
    }

An extension could be...

*require.lua*
    
local function load(self, dependancies, load)
	-- TODO: Get the name of the file that is currently calling this load method, and store it in 'thisModule' below
	local thisModule = 'blah.zoo'

	if not not self.loaded[thisModule] then
		return self.loaded[thisModule]
	end

	-- Only set a default for circular dependancies if there are any dependancies
	if #dependancies > 0
		self.loaded[thisModule] = {} -- Avoid circular dependancies
	end

	loadedDependancies = {}

	for _, file in pairs(dependancies)

		if not self.loaded[file] then
			self.loaded[file] = require file
			table.insert(loadedDependancies, self.loaded[file])
		end
	end
	
	loadedModule = load(unpack(loadedDependancies))


	if #dependancies > 0 then
		mt = {
			__index: function(key)
				return loadedModule[key]
			end,
			__indexSet: function(key, value)
				loadedModule[key] = value
			end,
			-- etc
		}

		-- proxy all the module calls through this new meta table.
		setmetatable(self.loaded[thisModule], mt)

		--[[
			TODO: What about any extra stuff already set on the meta
			table as returned from the load method? Can we loop over
			the existing metatable keys and copy them? Like:

			for key, value in pairs(loadedModule)
				if type(key) ~= 'function' then
					mt[key] = value
				end
			end

		]]--
	else
		-- if no dependancies, then just store the module directly as it can't have possibly been passed to any modules already
		self.loaded[thisModule] = loadedModule
	end


	return self.loaded[thisModule]
end

# Types of objects in the game
## Blockers

Things such as locked doors, debri in the path, etc. These are passive with no
damage to the player, but entirely stop them from continuing

## Danger Zones

Things such as spike pits, traps, periodicly timed traps, etc. These actively
damage the player, as well as stop them from continuing. They have a range of
0 - ie, the player has to touch them to receive damage.

## Enemies

These can be made up of combinations of the following:

### Ranged or Mele

Can damage from a distance
- or -
No range - must touch to damage

### Static or Active

Stay in the same place, and never move
- or -
Move to actively damage the player

### Dumb or Smart

Have a predefined movement pattern
- or -
Free roaming to move toward the player

# Collisions
## Collision Resolver

Basically, just move the object back to the last known good position.

This requires collidable objects to know their 'last' position. Do this at the
end of the resolution step - set 'lastGoodPosition' to the resolved position
(aka: 'currentPosition').

## ~~Visitor Pattern~~

# Record / replay mechanism

## Record

Have to record the player's actions as a framerate independant set of
movements which can be deterministcally played back.

Each action must be associated to a time stamp in game time, for syncronising
the multiple versions and playing them at the same time (aka: Ghosting)

### Serializable

Every entity that can be replayed must be serializable in such a way that it
can be restored to that exact same state from the serialized form.

### Temporal compression

Since between frames, a lot of things wont actually change, then we can do
some awesome temporal compression.

For example, instead of storing the following states over 3 frames:

    -- frame 1
    {
        position: {
            x: 10,
            y: 10
        },
        angle: 0
    }

    -- frame 2
    {
        position: {
            x: 10,
            y: 12
        },
        angle: 0
    }

    -- frame 3
    {
        position: {
            x: 10,
            y: 14
        },
        angle: 0
    }

Which shows that only the `position.y` value was changing, we can instead
store something that is temporally compressed:

    -- frame 1
    {
        position: {
            x: 10,
            y: 10
        },
        angle: 0
    }

    -- frame 2
    {
        position: {
            y: 12
        }
    }

    -- frame 3
    {
        position: {
            y: 14
        }
    }

Then the value of `position.x` and `angle` are read from frame 1's data,
rather than stored with each frame.

#### Disadvantages

##### Removed properties

This could have drawbacks such as when there is data that should simply be
removed from the object. Example:

    -- frame 1
    {
        -- ...
        colliding: true
    }

    -- frame 2
    {
        -- ...
    }

Where colliding is no longer set in frame 2, should it inherit its value
from from 1, or should the value no longer exist in frame 2?

A solution could
be to store which values are persistant in a 'headers' area of the compressed
data. Another solution could be to store the fact that the value has been
unset entirely in a particular frame, such as:

    -- frame 1
    {
        -- ...
        colliding: true
    }

    -- frame 2
    {
        -- ...
        colliding: 'unset'
    }

    -- frame 3
    {
        -- ...
    }

##### Rewinding

Another disadvantage is that it makes rewinding harder. Using the original 3
frame movement example, how do we know the `position.x` value in frame 3 then
again in frame 2, since it has not been declaired yet in any of the known
frames.

A solution would be to scan back until a suitable value is found.
Another solution would be to store the unchanging value at either end of the
change, for example:

    -- frame 1
    {
        position: {
            x: 10,
            y: 10
        },
        angle: 0
    }

    -- frame 2
    {
        position: {
            y: 12
        }
    }

    -- frame 3
    {
        position: {
            y: 14,
            x: 10
        }
    }

    -- frame 4
    {
        position: {
            y: 14,
            x: 8 
        }
    }

Here you can see the `position.x` value does not change in frame 2, but is
clearly set in frame 1, and frame 3, so no matter the direction of playback,
the value is known when frame 2 is reached.


## Replay

Have to be able to play back the movements even though the environment may
have changed around where the movements are taking place.

### All states as 'inputs'

Will need a 3-level heirarchy of 'state' an item can be in (in order of
decreasing priority):

 * Player controlled
 * Computed
 * Replay (aka: Forced)

The state system would have to do multiple passes, one for each level, where
the possible state of an object is determined based on the previous state of
all other objects.

For example;

Say we have an enemy object which begins in a static position with
coordinate `(100, 100)`. The player is currently out of range.

Input (like moving toward the enemy) puts the player within range of ... TBC

#### All players are interactable

When an enemy is computed, it will always try to attack any player (regardless
of time frame it is in), as would be expected. However, any attacks will fail
to kill the player. All attacks will continue as if the enemy can kill the
player.

When the player eventually kills the enemy, it must be before the enemy ever
tries to kill any version of the player, as it means the player will die at
some point before he can go back in time to kill the enemy. This adds the
puzzle element that the player has to have the foresight to avoid the enemies
/ draw them away / shield themselves until future them can come back to kill
it.

Also, this opens up the possibility to have enemies that aren't one-hit kills.
Which means that we'd need to have an extra solver whereby any 'past' self
that takes damage has that damage passed on to future selves, and if any of
the future selves take too much damage, then Fail Condition is triggered as
the player is dead at some point due to attacks from the enemy.

What about collisions?

Hmm... Two possibilities: No collision, or path finding.

No Collision means that at some point the player could get in a situation
where they should have collided with the enemy, but instead walked straight
through it like it wasn't there.

Path finding would be applied to the player that is being replayed and means
that the replay may not be identical each time, which poses potential issues
with timings and etc... Or would it? If we know that the player took 15
seconds to get to the machine, then goes back in time, and as a result the
original player now bumps into an enemy and has to path find around it,
resulting in the level taking 17 seconds to replay, the second player will
still have gone back in time to the start of the level regardless. So, it
wouldn't effect that player at all. Then, a 3rd player goes back in time which
causes the collision to no longer happen, so the 1st player should make it to
the machine in 15 seconds again, following the original path.

In summary: Only need to record the player's actions - everything else is
computed with the potential of a replay to be different between multiple runs
depending on how the future versions of the player interact with past
versions.

A side effect of this is that the player can interact with past versions of
himself.

This opens up another puzzle mechanic where self interactions must be limited
for fear of sending yourself crazy (and hence dying, or going off course?).
However, in some puzzles the interaction might be necessary to pass a past
self an item that would then be used automatically (opening a door with a key,
for example)

### Multiple replays

Must be able to replay the same recording multiple times simultaneously

# End game

When the player attempts to 'exit' the level, they are signalling that they
have solved the level and are ready to move on.

This triggers the level solver which Replays the player's original movements,
but with all enemies / obstacles / etc fully active and damaging.

## Win Condition

The win condition is triggered if the player's original recording can make it
through to the end without ever being damaged.

## Lose Condition

The lose condition is triggered as soon as a single damage occurs on the
player during replay of the original recording. As soon as this happens, all
'future' versions pop out of existence, and the player character dies. The
level is then reset.

# Feature Creep

## Time machine + Transporter

Can the time machine also physically transport the player?

If so, can it only do one or the other, but not both at the same time?

## Multiple machines per level

Can there be multiple time machines per level, to create more complex puzzles
involving multiple time / transport steps per 'future self'?
