fire_pole_config = {}

fire_pole_config.Debug = false -- kind of obvious, on and off toggle. If you have it on you see the box, and more debug printing
fire_pole_config.DistanceToPole = 1.8 -- I like to stand far from things, this could be over kill but prevents falling in the hole.
fire_pole_config.PoleSpeed = 0.2 -- Lower the number including 0.001 the slower the speed. Atm set to sync sounds.
fire_pole_config.SlideTimeout = 6000 -- helps break a character out of the frozen state.
fire_pole_config.UseNativeSound = true -- This uses native sounds and you can trun them off here.
fire_pole_config.LandingShake = true -- A very subtle camera shake is applied. You can turn it off here.

fire_pole_config.PoleLocations = { -- Set your starting coords, may take a bit to tweak, set it slightly to the right of the pole.
    ["Vespucci Pole"] = { -- The pole in Prompt's Vespucci Fire House, set your own.
        ["Start Locations"] = {
            {
                coords = vec3(-1030.2, -1390.34, 11.24),
                boxSize = vec3(1.2, 1.2, 1.5), -- Make this a big bigger to also prevent falling down the hole.
                boxOffset = vec3(0, 0, 0.0)
            }
        },
        ["End Z Coordinate"] = 5.0, -- litterally the end Z.
        ["Heading"] = 306.01 -- the heading the character is facing.
    }
}
