# Fire Pole Slide Script

A lightweight and immersive fire pole sliding script for FiveM servers using the Overextended (OX) framework. Provides animated and configurable pole sliding with optional sound effects and camera shake.

[Click here to watch a very short demo video](https://www.youtube.com/watch?v=lGro457hOFY)

# Features

- Fully animated pole slide using native GTA animations
- Native sound support for slide and landing
- Configurable camera shake on landing
- Supports multiple pole locations
- Automatic unfreeze and anti-stuck logic
- Highly customizable via config

# Requirements

- ox_target
- ox_lib

# Installation

- Place the firepole folder in your resources directory.
- Add the following to your server.cfg:
- ensure firepole
- Configure fire_pole_config.lua as needed.

```lua

Configuration (fire_pole_config.lua)

fire_pole_config = {}

fire_pole_config.Debug = false                    -- Toggle debug prints and zone visuals
fire_pole_config.DistanceToPole = 1.8            -- Distance from which the player can activate the pole
fire_pole_config.PoleSpeed = 0.2                 -- Speed at which the player descends
fire_pole_config.SlideTimeout = 6000             -- Max slide time to prevent freezing
fire_pole_config.UseNativeSound = true           -- Enable native GTA parachute slide sound
fire_pole_config.LandingShake = true             -- Enable subtle camera shake on landing

fire_pole_config.PoleLocations = {
    ["Vespucci Pole"] = {
        ["Start Locations"] = {
            {
                coords = vec3(-1030.2, -1390.34, 11.24),
                boxSize = vec3(1.2, 1.2, 1.5),
                boxOffset = vec3(0, 0, 0.0)
            }
        },
        ["End Z Coordinate"] = 5.0,
        ["Heading"] = 306.01
    }
}

```

# Customization Tips

- Use different native sound names with PlaySoundFrontend for unique effects.
- Adjust PoleSpeed and SlideTimeout for longer or faster descents.
- Add more entries under PoleLocations to support multiple fire stations.

# License
- MIT

# Credits

- Developed by Ezilii. Utilizes native GTA assets and Overextended libraries.
- Animation and sound based on native GTA resources
- For questions or contributions, feel free to open a pull request or contact via GitHub.
