addEventHandler('onClientResourceStart',resourceRoot,function()
	txd = engineLoadTXD('mods/satchel.txd')
	engineImportTXD(txd,363)
	dff = engineLoadDFF('mods/satchel.dff',363)
	engineReplaceModel(dff,363)
end)