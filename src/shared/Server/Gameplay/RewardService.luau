local Reward = {}

function Reward.Add(player, value, amount)
	local leaderstats = player:FindFirstChild("leaderstats")

	if not leaderstats[value] then
		print("This value do not exist.")
		return
	end

	leaderstats[value].Value += amount
end

function Reward.Remove(player, value, amount)
	local leaderstats = player:FindFirstChild("leaderstats")

	if not leaderstats[value] then
		print("This value do not exist.")
		return
	end

	leaderstats[value].Value -= amount
end

return Reward
