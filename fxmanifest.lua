--[[ FX Information ]]--
fx_version   'cerulean'
lua54        'yes'
game         'gta5'

--[[ Resource Information ]]--
name         'qp_hospital'
author       'Qpr'
version      '0.0.1'
repository   ''
description  'Hospital system'

--[[ Manifest ]]--
shared_script '@ox_lib/init.lua'
shared_script 'modules/init.lua'

client_scripts {
	'client/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua',
}

files {
	'modules/config.json',
}
