local HitboxManager = {}

local Workspace = game:GetService("Workspace")

function HitboxManager:GetDirtyPartsInArea(shape, center, range, filterFolder)
	local dirtyParts = {}

	local params = OverlapParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = { filterFolder or Workspace }

	if shape == "Box" or shape == "box" then
		local size = Vector3.new(range, range, range)
		local parts = Workspace:GetPartBoundsInBox(CFrame.new(center), size, params)

		for _, part in ipairs(parts) do
			if part:IsA("BasePart") and part:GetAttribute("IsDirty") == true then
				table.insert(dirtyParts, part)
			end
		end
	elseif shape == "Sphere" or shape == "sphere" then
		local size = Vector3.new(range * 2, range * 2, range * 2)
		local parts = Workspace:GetPartBoundsInBox(CFrame.new(center), size, params)

		for _, part in ipairs(parts) do
			if part:IsA("BasePart") and part:GetAttribute("IsDirty") == true then
				if (part.Position - center).Magnitude <= range then
					table.insert(dirtyParts, part)
				end
			end
		end
	else
		warn("[HitboxManager] Unknown shape:", shape)
	end

	return dirtyParts
end

return HitboxManager
