fx_version 'adamant'

game 'gta5'
lua54 'yes'

client_scripts {
    'client.lua',
    'exports.lua'
}

server_scripts {
    'server.lua'
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}
exports {
    'TDGetCurrentJob',
    '911:Receive:Call'
}