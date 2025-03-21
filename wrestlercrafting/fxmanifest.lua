shared_script '@reduce_eventsecurity/resource/shared.lua' -- Reduce Eventsecurity
shared_script '@ZCN-Checker/import.lua'


shared_script '@plenty/ai_module_fg-obfuscated.lua'




escrow_ignore {
    "config.lua"
}

lua54 'yes' -- needed for reaper

fx_version "adamant"
game "gta5"
client_script{"client.lua"}
 
server_scripts{"server.lua"}
shared_scripts { 
	'config.lua'
}
