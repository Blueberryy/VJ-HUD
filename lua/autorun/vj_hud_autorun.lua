/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "VJ HUD"
local AddonName = "VJ HUD"
local AddonType = "HUD"
local AutorunFile = "autorun/vj_hud_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include("autorun/vj_controls.lua")

	if CLIENT then
		-- Main Components
		VJ.AddClientConVar("vj_hud_enabled", 1) -- Enable VJ HUD
		VJ.AddClientConVar("vj_hud_health", 1) -- Enable health and suit
		VJ.AddClientConVar("vj_hud_ammo", 1) -- Enable ammo
		VJ.AddClientConVar("vj_hud_ammo_invehicle", 1) -- Should the ammo be enabled in the vehicle?
		VJ.AddClientConVar("vj_hud_compass", 1) -- Enable compass
		VJ.AddClientConVar("vj_hud_playerinfo", 1) -- Enable local player information
		VJ.AddClientConVar("vj_hud_trace", 1) -- Enable trace information
		VJ.AddClientConVar("vj_hud_trace_limited", 0) -- Should it only display the trace information when looking at a player or an NPC?
		VJ.AddClientConVar("vj_hud_scanner", 1) -- Enable proximity scanner
		
		-- Conversion
		VJ.AddClientConVar("vj_hud_metric", 0) -- Use Metric instead of Imperial

		-- Crosshair
		VJ.AddClientConVar("vj_hud_ch_enabled", 1) -- Enable VJ Crosshair
		VJ.AddClientConVar("vj_hud_ch_invehicle", 1) -- Should the Crosshair be enabled in the vehicle?
		VJ.AddClientConVar("vj_hud_ch_crosssize", 50) -- Crosshair Size
		VJ.AddClientConVar("vj_hud_ch_opacity", 255) -- Opacity of the Crosshair
		VJ.AddClientConVar("vj_hud_ch_r", 0) -- Crosshair Color - Red
		VJ.AddClientConVar("vj_hud_ch_g", 255) -- Crosshair Color - Green
		VJ.AddClientConVar("vj_hud_ch_b", 0) -- Crosshair Color - Blue
		VJ.AddClientConVar("vj_hud_ch_mat", 0) -- The Crosshair Material

		-- Garry's Mod HUD
		VJ.AddClientConVar("vj_hud_disablegmod", 1) -- Disable Garry's Mod HUD
		VJ.AddClientConVar("vj_hud_disablegmodcross", 1) -- Disable Garry's Mod Crosshair
		
		---------------------------------------------------------------------------------------------------------------------------
		hook.Add("PopulateToolMenu", "VJ_ADDTOMENU_HUD_SETTINGS", function()	
			spawnmenu.AddToolMenuOption("DrVrej", "HUDs", "VJ HUD Settings", "Client Settings", "", "", function(Panel)
				Panel:ControlHelp(" ") -- Spacer
				Panel:AddControl("Button",{Text = "#vjbase.menu.general.reset.everything", Command = "vj_hud_enabled 1\n vj_hud_disablegmod 1\n vj_hud_health 1\n vj_hud_ammo 1\n vj_hud_playerinfo 1\n vj_hud_trace 1\n vj_hud_compass 1\n vj_hud_scanner 1\n vj_hud_metric 0\n vj_hud_disablegmodcross 1\n vj_hud_ch_enabled 1\n vj_hud_ch_crosssize 50\n vj_hud_ch_opacity 255\n vj_hud_ch_r 0\n vj_hud_ch_g 255\n vj_hud_ch_b 0\n vj_hud_ch_mat 0\n vj_hud_ammo_invehicle 1\n vj_hud_ch_invehicle 1\n vj_hud_trace_limited 0"})
				Panel:AddControl("Label", {Text = "Garry's Mod HUD:"})
				Panel:AddControl("Checkbox", {Label = "Disable Garry's Mod HUD", Command = "vj_hud_disablegmod"})
				Panel:AddControl("Checkbox", {Label = "Disable Garry's Mod Crosshair", Command = "vj_hud_disablegmodcross"})
				
				Panel:AddControl("Label", {Text = "HUD:"})
				Panel:AddControl("Checkbox", {Label = "Enable VJ HUD", Command = "vj_hud_enabled"})
				Panel:AddControl("Checkbox", {Label = "Enable Health and Suit", Command = "vj_hud_health"})
				Panel:AddControl("Checkbox", {Label = "Enable Ammunition Counter", Command = "vj_hud_ammo"})
				Panel:AddControl("Checkbox", {Label = "Enable Local Player Information", Command = "vj_hud_playerinfo"})
				Panel:AddControl("Checkbox", {Label = "Enable Compass", Command = "vj_hud_compass"})
				Panel:AddControl("Checkbox", {Label = "Enable Trace Information", Command = "vj_hud_trace"})
				Panel:AddControl("Checkbox", {Label = "Enable Proximity Scanner", Command = "vj_hud_scanner"})
				Panel:AddControl("Checkbox", {Label = "Enable Ammunition Counter in Vehicle", Command = "vj_hud_ammo_invehicle"})
				Panel:AddControl("Checkbox", {Label = "Limited Trace Information", Command = "vj_hud_trace_limited"})
				Panel:ControlHelp("Will only display for NPCs & Players")
				Panel:AddControl("Checkbox", {Label = "Use Metric instead of Imperial", Command = "vj_hud_metric"})
				
				Panel:AddControl("Label", {Text = "Crosshair:"})
				Panel:AddControl("Checkbox", {Label = "Enable Crosshair", Command = "vj_hud_ch_enabled"})
				Panel:AddControl("Checkbox", {Label = "Enable Crosshair While in Vehicle", Command = "vj_hud_ch_invehicle"})
				local vj_crossoption = {Options = {}, CVars = {}, Label = "Crosshair Material:", MenuButton = "0"}
				vj_crossoption.Options["Arrow (Two, Default)"] = {
					vj_hud_ch_mat = "0",
				}
				vj_crossoption.Options["Dot (Five, Small)"] = {
					vj_hud_ch_mat = "1",
				}
				vj_crossoption.Options["Dot"] = {
					vj_hud_ch_mat = "2",
				}
				vj_crossoption.Options["Dot (Five, Sniper)"] = {
					vj_hud_ch_mat = "3",
				}
				vj_crossoption.Options["Circle (Dashed)"] = {
					vj_hud_ch_mat = "4",
				}
				vj_crossoption.Options["Dot (Four)"] = {
					vj_hud_ch_mat = "5",
				}
				vj_crossoption.Options["Circle"] = {
					vj_hud_ch_mat = "6",
				}
				vj_crossoption.Options["Line (Four, Angled)"] = {
					vj_hud_ch_mat = "7",
				}
				vj_crossoption.Options["Dot (Five, Large)"] = {
					vj_hud_ch_mat = "8",
				}
				Panel:AddControl("ComboBox", vj_crossoption)
				Panel:AddControl("Color",{ -- Color Picker
					Label = "Crosshair Color:", 
					Red = "vj_hud_ch_r", -- red
					Green = "vj_hud_ch_g", -- green
					Blue = "vj_hud_ch_b", -- blue
					ShowAlpha = "0", 
					ShowHSV = "1",
					ShowRGB = "1"
				})
				Panel:AddControl("Slider", {Label = "Crosshair Size",min = 0,max = 1000,Command = "vj_hud_ch_crosssize"})
				Panel:AddControl("Slider", {Label = "Crosshair Opacity",min = 0,max = 255,Command = "vj_hud_ch_opacity"})
			end)
		end)
	end
	
-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if CLIENT then
		COLOR_0200200 = Color(0, 200, 200)
		COLOR_02550 = Color(0,255,0)
		COLOR_2551000 = Color(255,100,0)
		COLOR_20000150 = Color(200,0,0,150)
		COLOR_000150 = Color(0, 0, 0, 150)
		COLOR_0255255150 = Color(0, 255, 255, 150)
		COLOR_2551000150 = Color(255, 100, 0, 150)
		COLOR_02550150 = Color(0, 255, 0, 150)
		COLOR_255255255150 = Color(255, 255, 255, 150)
		COLOR_255001 = Color(255, 0, 0, -1)
		COLOR_025525540 = Color(0, 255, 255, 40)
		COLOR_025525550 = Color(0,255,255,50)
		COLOR_221160221255 = Color(221, 160, 221, 255)
		COLOR_0255255150 = Color(0,255,255,150)
		COLOR_0255255160 = Color(0, 255, 255, 160)
		COLOR_0255255255 = Color(0, 255, 255, 255)
		COLOR_2552130255 = Color(255, 213, 0, 255)
		COLOR_505050150 = Color(50, 50, 50, 150)
		COLOR_200255153255 = Color(200, 255, 153, 255)
		COLOR_102178255255 = Color(102, 178, 255, 255)
		COLOR_255255255200 = Color(255, 255, 255, 200)
		COLOR_25500255 = Color(255, 0, 0, 255)
		COLOR_2551500255 = Color(255, 150, 0, 255)
		COLOR_02550255 = Color(0, 255, 0, 255)

		chat.AddText(COLOR_0200200,PublicAddonName,
		COLOR_02550," was unable to install, you are missing ",
		COLOR_02550,"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if CLIENT then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),COLOR_20000150)
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif SERVER then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end