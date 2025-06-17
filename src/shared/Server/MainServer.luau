local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MainServer = {}

local CleaningData = require(ReplicatedStorage.Shared.Server.Data.CleaningData)
local DataService = require(ReplicatedStorage.Shared.Server.Data.DataService)
local RemotesHandler = require(ReplicatedStorage.Shared.Server.Network.RemotesHandler)

-- Setup every Server modules we need : DataService, CleaningData & the remotes

function MainServer:Start(player)
	print("[MainServer] Starting...")

	DataService.SetUp(player)
	CleaningData.Init(player, workspace.Area1.DirtParts)
	RemotesHandler.Init()

	print("[MainServer] Ready ✅")
end

-- make sure to save when the player leaves

function MainServer:Close(player)
	print("[MainServer] Closing...")

	DataService.Save(player)

	print("[MainServer] Closed ✅")
end

-- return the module so the Server script can acces it

return MainServer
