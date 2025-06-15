fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Ezilii'
description 'Fire Pole Slide Script'
version '1.0.0'

-- Required dependencies
dependencies {
    'ox_lib',
    'ox_target'
}

-- Shared configuration
shared_scripts {
    '@ox_lib/init.lua',
    'fire_pole_config.lua'
}

-- Client-side logic
client_script 'client.lua'
