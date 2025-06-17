-- Module that handles hitbox detection for specific "dirty" parts in an area
local HitboxManager = {}

-- Services
local Workspace = game:GetService("Workspace")

-- Returns a list of parts with the attribute "IsDirty" set to true,
-- within a certain area based on shape (Box or Sphere)
function HitboxManager:GetDirtyPartsInArea(shape, center, range, filterFolder)
	local dirtyParts = {}

	local params = OverlapParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = { filterFolder or Workspace }

	-- Handle box-shaped area
	if shape == "Box" or shape == "box" then
		local size = Vector3.new(range, range, range)
		local parts = Workspace:GetPartBoundsInBox(CFrame.new(center), size, params)

		for _, part in ipairs(parts) do
			-- Check if part is marked as dirty via attribute
			if part:IsA("BasePart") and part:GetAttribute("IsDirty") == true then
				table.insert(dirtyParts, part)
			end
		end

	-- Handle sphere-shaped area
	elseif shape == "Sphere" or shape == "sphere" then
		-- Sphere approximation via a bounding box, extra check on distance
		local size = Vector3.new(range * 2, range * 2, range * 2)
		local parts = Workspace:GetPartBoundsInBox(CFrame.new(center), size, params)

		for _, part in ipairs(parts) do
			if part:IsA("BasePart") and part:GetAttribute("IsDirty") == true then
				-- Filter only parts truly inside the spherical radius
				if (part.Position - center).Magnitude <= range then
					table.insert(dirtyParts, part)
				end
			end
		end

	-- Unknown shape fallback
	else
		warn("[HitboxManager] Unknown shape:", shape)
	end

	return dirtyParts
end

return HitboxManager
