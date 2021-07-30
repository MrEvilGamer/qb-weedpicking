fx_version 'cerulean'
game 'gta5'

description 'qb-WeedPicking'
version '1.0.0'

shared_script '@qb-core/import.lua'

client_scripts {

	'config.lua',
	'client/main.lua'
}

server_scripts {
	'config.lua',
	'server/main.lua'
}
