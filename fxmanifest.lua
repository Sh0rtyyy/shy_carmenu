fx_version 'cerulean'
game 'gta5'

author 'Shorty#2167'
description 'Car menu with ox_lib menu'
version '1.0.0'
lua54 'yes'

client_scripts {
    'client.lua'
}

shared_scripts {'@es_extended/imports.lua','@ox_lib/init.lua'}

dependencies {
    'es_extended',
    'ox_lib'
}