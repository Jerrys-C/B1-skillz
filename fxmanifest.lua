fx_version 'cerulean'
game 'gta5'

description 'B1-Skillz'
version '1.3.5'
lua54 'yes'

ui_page "skill-menu/index.html"

shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
    'config.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

client_scripts {
    'client/main.lua',
    'client/functions.lua',
    'client/gui.lua'
}

files {
    "skill-menu/index.html",
    "skill-menu/app.css",
    "skill-menu/app.js"
}