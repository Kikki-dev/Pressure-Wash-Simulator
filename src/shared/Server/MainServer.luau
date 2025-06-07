local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MainServer = {}

local CleaningData = require(ReplicatedStorage.Shared.Server.Data.CleaningData)
local DataService = require(ReplicatedStorage.Shared.Server.Data.DataService)
local RemotesHandler = require(ReplicatedStorage.Shared.Server.Network.RemotesHandler)

function MainServer:Start(player)
	print("[MainServer] Starting...")

	DataService.SetUp(player)
	CleaningData.Init(player, workspace.Area1.DirtParts)
	RemotesHandler.Init()

	print("[MainServer] Ready ✅")
end

function MainServer:Close(player)
	print("[MainServer] Closing...")

	DataService.Save(player)

	print("[MainServer] Closed ✅")
end

return MainServer
