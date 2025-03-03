local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local plr = game:GetService("Players").LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local humanoid = char.Humanoid

--all for r6
local punch = 204062532
local swing = 218504594
local slamdown = 204295235

local spin = 188632011

local dance = 429703734

local spinpunch = 186934910

--local guardr15 = 582855105


function playanim(id, speed, priority)
	priority = priority or Enum.AnimationPriority.Action
	speed = speed or 1
	local a = Instance.new("Animation")
	a.AnimationId = "rbxassetid://" .. tostring(id)
	local track = humanoid:LoadAnimation(a)
	track.Looped = false
	track.Priority = priority
	track:Play()
	track:AdjustSpeed(speed)
	return track
end

local UIS = game:GetService("UserInputService")

local grappleAnimObj = Instance.new("Animation")
grappleAnimObj.AnimationId = "rbxassetid://125750759"
local grapple = humanoid:LoadAnimation(grappleAnimObj)
grapple.Looped = true

local inputConn = UIS.InputBegan:Connect(function(io, gp)
	if gp then return end
	local kc = io.KeyCode
	if kc == Enum.KeyCode.X then
		playanim(punch, 2)
	elseif kc == Enum.KeyCode.Z then
		playanim(swing, 2)
	elseif kc == Enum.KeyCode.Q then
		playanim(slamdown)
	elseif kc == Enum.KeyCode.C then
		playanim(spinpunch)
	elseif kc == Enum.KeyCode.E then
		--grapple
		if grapple.IsPlaying then
			grapple:Stop()
		else
			grapple:Play()
			grapple:AdjustSpeed(0.8)
		end
	end
end)


local rightarm = char:WaitForChild("Right Arm")
local leftarm = char:WaitForChild("Left Arm")

local conn = game:GetService("RunService").RenderStepped:Connect(function()
	rightarm.LocalTransparencyModifier = 0
	leftarm.LocalTransparencyModifier = 0
end)

plr.CharacterRemoving:Connect(function()
	if conn then conn:Disconnect() conn = nil end
	inputConn:Disconnect()
end)

local msg = Instance.new("Hint")
msg.Text = "r6 fe combat animation script loaded    controls: z x c Q E"
msg.Parent = workspace

Debris:AddItem(msg, 5)