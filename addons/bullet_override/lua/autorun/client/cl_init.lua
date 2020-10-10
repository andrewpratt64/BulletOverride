include("shared.lua")

-- Precache
game.AddParticles("particles/bulletoverride_impacts.pcf")
PrecacheParticleSystem("magic_lines")

hook.Add("AddToolMenuCategories", "BulletOverrideCategory", function()
	spawnmenu.AddToolCategory("Options", "Bullet Override", "#Bullet Override")
end)

hook.Add("PopulateToolMenu", "BulletOverrideSettings", function()

	-- Info Category
	spawnmenu.AddToolMenuOption("Options", "Bullet Override", "BulletOverrideInfo", "#Info", "", "", function(panel)
		-- Signature
		panel:ControlHelp("Addon by Andrew Pratt")
		
		-- Compatibility warning
		panel:Help("This addon may conflict with other addons that modify the behavior of bullets")
		
		-- Workshop link
		local workshopButton = panel:Button("Open in Workshop")
		workshopButton.DoClick = function()
			gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=2029144480")
		end
		
		-- Bug reporting info
		panel:ControlHelp("To report a bug, use the discussion under the workshop page. Please include any important details you can (what you did to cause it, error messages, etc.)")
		
		-- Bug report link
		local reportBugButton = panel:Button("Report a Bug")
		reportBugButton.DoClick = function()
			gui.OpenURL("https://steamcommunity.com/workshop/filedetails/discussion/2029144480/2148720889353347450/")
		end
	end)

	-- Presets Category
	spawnmenu.AddToolMenuOption("Options", "Bullet Override", "BulletOverridePresets", "#Presets", "", "", function(panel)
		local ConVarsDefault = {
			bullet_override_enabled =			"1",
			bullet_override_players_enabled =	"1",
			bullet_override_npcs_enabled =		"1",
			bullet_override_explode =			"0",
			bullet_override_explode_dmg =		"50",
			bullet_override_dmg_type =			"0",
			bullet_override_dmg_type_value =	"4",
			bullet_override_tracer_freq =		"0",
			bullet_override_tracer_freq_val =	"1",
			bullet_override_tracer =			"0",
			bullet_override_tracer_value =		"Tracer",
			bullet_override_impact =			"0",
			bullet_override_impact_value =		"Impact",
			bullet_override_numbullets =		"0",
			bullet_override_numbullets_value =	"1",
			bullet_override_ignite_players =	"0",
			bullet_override_ignite_npcs =		"0",
			bullet_override_ignite_misc =		"0",
			bullet_override_ignite_time_based_on_dmg = "0",
			bullet_override_ignite_time =		"5",
			bullet_override_ignite_radius_based_on_dmg = "0",
			bullet_override_ignite_radius =		"0",
			bullet_override_ignite_chance =		"0",
			bullet_override_dmg_scale =			"1",
			bullet_override_force_scale =		"1",
			bullet_override_spread_scale =		"1"
		}
		
		panel:AddControl( "ComboBox", { MenuButton = 1, Folder = "bullet_override_presets", Options = { [ "#preset.default" ] = ConVarsDefault }, CVars = table.GetKeys( ConVarsDefault ) } )
	end)

	-- Filters Category
	spawnmenu.AddToolMenuOption("Options", "Bullet Override", "BulletOverrideFilters", "#Filters", "", "", function(panel)
		-- Addon Enabled/Disabled
		panel:CheckBox("Enabled", "bullet_override_enabled")
		
		-- Enabled/Disabled for Players
		panel:CheckBox("Override Players", "bullet_override_players_enabled")
		-- Enabled/Disabled for NPCs
		panel:CheckBox("Override NPCs", "bullet_override_npcs_enabled")
	end)
	
	-- Basic Settings Category
	spawnmenu.AddToolMenuOption("Options", "Bullet Override", "BulletOverrideBasicSettings", "#Basic Settings", "", "", function(panel)
		-- DMG Type
		panel:CheckBox("Override Damage Type", "bullet_override_dmg_type")
		local dmgTypeComboBox, dmgTypeLabel = panel:ComboBox("Override with:", "bullet_override_dmg_type_value")
		dmgTypeComboBox:SetSortItems(false)
		dmgTypeComboBox:AddChoice("Generic",	0,			false)
		dmgTypeComboBox:AddChoice("Crush",		2,			false)
		dmgTypeComboBox:AddChoice("Bullet",		4,			true)
		dmgTypeComboBox:AddChoice("Slash",		8,			false)
		dmgTypeComboBox:AddChoice("Burn",		16,			false)
		dmgTypeComboBox:AddChoice("Vehicle",	32,			false)
		dmgTypeComboBox:AddChoice("Fall",		64,			false)
		dmgTypeComboBox:AddChoice("Blast",		128,		false)
		dmgTypeComboBox:AddChoice("Club",		256,		false)
		dmgTypeComboBox:AddChoice("Shock",		512,		false)
		dmgTypeComboBox:AddChoice("Energy Beam",
												1024,		false)
		dmgTypeComboBox:AddChoice("Prevent Physics Force",
												2048,		false)
		dmgTypeComboBox:AddChoice("Never Gib",	4096,		false)
		dmgTypeComboBox:AddChoice("Always Gib",	8192,		false)
		dmgTypeComboBox:AddChoice("Drown",		16384,		false)
		-- Skipping DMG_PARALYZE, since it's identical to DMG_POISON
		dmgTypeComboBox:AddChoice("Nerve Gas",	65536,		false)
		dmgTypeComboBox:AddChoice("Poison",		131072,		false)
		dmgTypeComboBox:AddChoice("Radiation",	262144,		false)
		dmgTypeComboBox:AddChoice("Drown Recover",
												524288,		false)
		dmgTypeComboBox:AddChoice("Acid",		1048576,	false)
		dmgTypeComboBox:AddChoice("Slow Burn",	2097152,	false)
		dmgTypeComboBox:AddChoice("No Ragdoll",	4194304,	false)
		dmgTypeComboBox:AddChoice("Physgun",	8388608,	false)
		dmgTypeComboBox:AddChoice("Plasma",		16777216,	false)
		dmgTypeComboBox:AddChoice("Airboat",	33554432,	false)
		dmgTypeComboBox:AddChoice("Dissolve",	67108864,	false)
		dmgTypeComboBox:AddChoice("Blast Surface",
												134217728,	false)
		dmgTypeComboBox:AddChoice("Direct",		268435456,	false)
		dmgTypeComboBox:AddChoice("Buckshot",	536870912,	false)
		dmgTypeComboBox:AddChoice("Sniper",		1073741824,	false)
		dmgTypeComboBox:AddChoice("Missle",		2147483648,	false)
		
		-- Number of Bullets Per Shot
		panel:CheckBox("Override Number of Bullets Per Shot", "bullet_override_numbullets")
		panel:NumSlider("Override With:", "bullet_override_numbullets_value", 0, 15)
		
		-- Damage Scale
		panel:NumSlider("Damage Scale", "bullet_override_dmg_scale", 0, 10)--:DockPadding(0, 30, 0, 0) -- Add padding to create space between this and previous item
		
		-- Force Scale
		panel:NumSlider("Force Scale", "bullet_override_force_scale", 0, 100)
		
		-- Spread Scale
		panel:NumSlider("Spread Scale", "bullet_override_spread_scale", 0, 10)
	end)

	-- Effects Category
	spawnmenu.AddToolMenuOption("Options", "Bullet Override", "BulletOverrideEffects", "#Effects", "", "", function(panel)
		-- Tracer Frequency
		panel:CheckBox("Override Tracer Frequency", "bullet_override_tracer_freq")
		panel:NumSlider("Show a tracer once for this many bullets:", "bullet_override_tracer_freq_val", 0, 20)
		
		-- Tracer Effect
		panel:CheckBox("Override Tracer Effect", "bullet_override_tracer")
		local tracerEffectComboBox, tracerEffectLabel = panel:ComboBox("Override with:", "bullet_override_tracer_value")
		-- Some are commented out b/c they didn't show up when I tested them
		tracerEffectComboBox:SetSortItems(false)
		tracerEffectComboBox:AddChoice("Gravity Gun",	"PhyscannonImpact",			false)
		tracerEffectComboBox:AddChoice("AR2",			"AR2Tracer",				false)
		tracerEffectComboBox:AddChoice("Helicopter Gun","HelicopterTracer",			false)
		tracerEffectComboBox:AddChoice("Airboat Gun",	"AirboatGunTracer",			false)
		tracerEffectComboBox:AddChoice("Heavy Airboat Gun",
														"AirboatGunHeavyTracer",	false)
		--tracerEffectComboBox:AddChoice("Guass Gun",		"GaussTracer",				false)
		--tracerEffectComboBox:AddChoice("Hunter Tracer",	"HunterTracer",				false)
		--tracerEffectComboBox:AddChoice("Strider Tracer","StriderTracer",			false)
		--tracerEffectComboBox:AddChoice("Gunship Tracer","GunshipTracer",			false)
		-- This one didn't work for me but I might not have the right games mounted for it, so I'm leaving it for now
		tracerEffectComboBox:AddChoice("HL1 Gauss Beam",	"HL1GaussBeam",				false)
		tracerEffectComboBox:AddChoice("Bullet Tracer",		"Tracer",					true)
		tracerEffectComboBox:AddChoice("Toolgun Tracer",	"ToolTracer",				false)
		tracerEffectComboBox:AddChoice("Laser Tracer",		"LaserTracer",				false)
		
		-- Impact Effect
		panel:CheckBox("Override Impact Effect", "bullet_override_impact")
		local impactEffectComboBox, impactEffectLabel = panel:ComboBox("Override with:", "bullet_override_impact_value")
		impactEffectComboBox:SetSortItems(false)
		impactEffectComboBox:AddChoice("Manhack Sparks",	"BasicBack_ManhackSparks",	false)
		-- Couldn't get this one to work
		--impactEffectComboBox:AddChoice("Tesla Zap",			"Basic_TeslaZap",			false)
		impactEffectComboBox:AddChoice("Tesla Bolts",		"BasicEnt_TeslaHitboxes",	false)
		impactEffectComboBox:AddChoice("Laser Dot",			"Basic_CommandPointer",		false)
		impactEffectComboBox:AddChoice("Pink Pulse",		"Basic_GunshipImpact",		false)
		impactEffectComboBox:AddChoice("Crossbow Impact",	"Basic_BoltImpact",			false)
		impactEffectComboBox:AddChoice("RPG Shot Down",		"Basic_RPGShotDown",		false)
		impactEffectComboBox:AddChoice("Glass Impact",		"Basic_GlassImpact",		false)
		impactEffectComboBox:AddChoice("Stunstick Impact",	"Basic_StunstickImpact",	false)
		impactEffectComboBox:AddChoice("Gravitygun Impact",	"BasicEnt_PhyscannonImpact",false)
		impactEffectComboBox:AddChoice("AR2 Impact",		"Basic_AR2Impact",			false)
		-- Not really sure how to implement this at the moment, may add later
		--impactEffectComboBox:AddChoice("AR2 Explosion",		"BasicEnt_AR2Explosion",	false)
		-- Can't tell if this effect actually works or not
		impactEffectComboBox:AddChoice("Helicopter Impact",	"Basic_HelicopterImpactEnt",false)
		impactEffectComboBox:AddChoice("Bullet Impact",		"Basic_Impact",				true)
		impactEffectComboBox:AddChoice("Antlion Gibs",		"Basic_AntlionGib",			false)
		-- This one positions itself at the player's weapon, or at an entities head, didn't look great
		--impactEffectComboBox:AddChoice("Crossbow Sparks",	"BasicEnt_CrossbowLoad",	false)
		impactEffectComboBox:AddChoice("Vortigaunt Dispel",	"Basic_VortDispel",			false)
		impactEffectComboBox:AddChoice("Thumper Dust",		"Cust_ThumperDust",			false)
		impactEffectComboBox:AddChoice("Strider Blood",		"Basic_StriderBlood",		false)
		impactEffectComboBox:AddChoice("Combine Ball Explosion",
															"Basic_cball_explode",		false)
		impactEffectComboBox:AddChoice("Combine Ball Bounce",
															"Basic_cball_bounce",		false)
		impactEffectComboBox:AddChoice("HL1 Gibs",			"Basic_HL1Gib",				false)
		impactEffectComboBox:AddChoice("HL1 Gauss Reflect",	"Basic_HL1GaussReflect",	false)
		-- This one works but looks odd, leaving it for now
		impactEffectComboBox:AddChoice("HL1 Beam Reflect",	"Basic_HL1GaussBeamReflect",
																						false)
		impactEffectComboBox:AddChoice("Metal Spark",		"BasicBack_MetalSpark",		false)
		impactEffectComboBox:AddChoice("Electric Spark",	"BasicBack_ElectricSpark",	false)
		impactEffectComboBox:AddChoice("Sparks",			"Basic_Sparks",				false)
		impactEffectComboBox:AddChoice("Bullet Water Splash",
															"Basic_gunshotsplash",		false)
		impactEffectComboBox:AddChoice("Water Splash",		"Basic_watersplash",		false)
		impactEffectComboBox:AddChoice("Ragdoll Impact",	"Basic_RagdollImpact",		false)
		impactEffectComboBox:AddChoice("Helicopter Bomb",	"Basic_HelicopterMegaBomb",	false)
		impactEffectComboBox:AddChoice("Underwater Explosion",
															"Basic_WaterSurfaceExplosion",false)
		impactEffectComboBox:AddChoice("Explosion",			"Basic_Explosion",			false)
		impactEffectComboBox:AddChoice("Hunter Impact",		"Basic_HunterDamage",		false)
		impactEffectComboBox:AddChoice("Blood Splatter",	"Basic_BloodImpact",		false)
		impactEffectComboBox:AddChoice("Blood Spray",		"Cust_bloodspray",			false)
		impactEffectComboBox:AddChoice("Wheel Dust",		"Cust_WheelDust",			false)
		impactEffectComboBox:AddChoice("Balloon Pop",		"Basic_balloon_pop",		false)
		impactEffectComboBox:AddChoice("Remover Sparks",	"BasicEnt_entity_remove",	false)
		impactEffectComboBox:AddChoice("Inflator Sparks",	"Basic_inflator_magic",		false)
		impactEffectComboBox:AddChoice("Freeze Effect",		"BasicEnt_phys_freeze",		false)
		impactEffectComboBox:AddChoice("Unfreeze Effect",	"BasicEnt_phys_unfreeze",	false)
		impactEffectComboBox:AddChoice("Toolgun Indicator",	"Basic_selection_indicator",false)
		impactEffectComboBox:AddChoice("Toolgun Ring",		"Basic_selection_ring",		false)
		-- Dosen't work well
		--impactEffectComboBox:AddChoice("Toolgun Wheel",		"BasicEnt_wheel_indicator",	false)
		-- Non-Engine effects start below here
		impactEffectComboBox:AddChoice("Magic Lines",		"Cust_MagicLines",			false)
	end)

	-- Fire Category
	spawnmenu.AddToolMenuOption("Options", "Bullet Override", "BulletOverrideFire", "#Fire", "", "", function(panel)
		-- Fire Ignite Filters
		panel:CheckBox("Bullets Ignite Players", "bullet_override_ignite_players")
		panel:CheckBox("Bullets Ignite NPCs", "bullet_override_ignite_npcs")
		panel:CheckBox("Bullets Ignite Other Entities", "bullet_override_ignite_misc")
		
		-- Fire Ignite Time
		panel:CheckBox("Scale Fire Lifetime by Damage", "bullet_override_ignite_time_based_on_dmg")
		panel:NumSlider("Fire Lifetime:", "bullet_override_ignite_time", 0, 60)
		
		-- Fire Ignite Radius
		panel:CheckBox("Scale Ignition Radius by Damage", "bullet_override_ignite_radius_based_on_dmg")
		panel:NumSlider("Ignition Radius:", "bullet_override_ignite_radius", 0, 100)
		
		-- Fire Ignite Chance
		panel:NumSlider("Ignite Chance:", "bullet_override_ignite_chance", 0, 1)
	end)

	-- Misc Category
	spawnmenu.AddToolMenuOption("Options", "Bullet Override", "BulletOverrideMisc", "#Misc", "", "", function(panel)
		-- OBSELETE
		-- Sparks
		--panel:CheckBox("Sparks", "bullet_override_sparks")
		
		-- Explosions
		panel:CheckBox("Explosions", "bullet_override_explode")
		panel:NumSlider("Explosion Damage", "bullet_override_explode_dmg", 0, 100)
	end)
end)