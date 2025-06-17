-- Reward: Handles adding and removing values (e.g., currency) from player leaderstats
local Reward = {}

-- Adds a value to a specific stat (e.g. Money, XP)
function Reward.Add(player, value, amount)
	local leaderstats = player:FindFirstChild("leaderstats")

	-- Check if the value exists
	if not leaderstats[value] then
		print("This value does not exist.")
		return
	end

	-- Increment the stat
	leaderstats[value].Value += amount
end

-- Removes a value from a specific stat
function Reward.Remove(player, value, amount)
	local leaderstats = player:FindFirstChild("leaderstats")

	-- Check if the value exists
	if not leaderstats[value] then
		print("This value does not exist.")
		return
	end

	-- Decrement the stat
	leaderstats[value].Value -= amount
end

return Reward
