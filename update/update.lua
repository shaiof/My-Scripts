local info = {
	user = 'shaiof', -- set to your github username
	repository = 'My-Scripts', -- set to your github repository
	resource = 'update' -- set to the script you want to update
}

function update()
	fetchRemote('https://raw.githubusercontent.com/'..info.user..'/'..info.repository..'/master/'..info.resource..'/meta.xml', function(data, err)
		if data and err == 0 then
			if fileExists('meta.xml') then fileDelete('meta.xml') end
			local file = File('meta.xml')
			file:write(data)
			file:close()
		end
	end)

	local files = {}
	local meta = XML.load('meta.xml')
	for i, v in pairs(meta.children) do
		if v.name == 'script' then
			local f = v:getAttribute('src')
			if f then
				files[#files+1] = f
			end
		end
	end
	meta:unload()

	for i=1, #files do
		fetchRemote('https://raw.githubusercontent.com/'..info.user..'/'..info.repository..'/master/'..info.resource..'/'..files[i], function(data, err)
			if data and err == 0 then
				if fileExists(files[i]) then fileDelete(files[i]) end
				local file = File(files[i])
				file:write(data)
				file:close()
			end
		end)
	end
	
	print('Resource: '..getResourceName(getThisResource())..' has been updated from github successfully, changes will be applied next time the resource starts.')
end
update()

addCommandHandler('update', update)