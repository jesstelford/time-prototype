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
from from 1, or should the value no longer exist in frame 2? A solution could
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

Another disadvantage is that it makes rewinding harder. Using the original 3
frame movement example, how do we know the `position.x` value in frame 3 then
again in frame 2, since it has not been declaired yet in any of the known
frames. A solution would be to scan back until a suitable value is found.
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

## Multiple replays

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
