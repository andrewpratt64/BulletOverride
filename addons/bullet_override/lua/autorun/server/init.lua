--if (!SERVER) then return end
--AddCSLuaFile("client/cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

-- Precache
resource.AddFile("sound/bullet_override/magic_line.wav")
game.AddParticles("particles/bulletoverride_impacts.pcf")


-- Returns true if given entity is worldspawn
local function IsEntWorldspawn(ent)
	return (IsValid(ent) && ent:EntIndex())
end

-- Returns true if a str starts with beginning
local function StrStartsWith(str, beginning)
	return (
		string.len(str) >= string.len(beginning)
		&& string.sub(str, 1, string.len(beginning)) == beginning
	)
end
-- Returns true if a str starts with beginning AND has more characters after that
local function StrStartsWithAndMore(str, beginning)
	return (
		string.len(str) > string.len(beginning)
		&& string.sub(str, 1, string.len(beginning)) == beginning
	)
end

-- Returns true if a given entity should use default bullet behavior, aka not overriden
local function DefaultBulletsSkipForEnt(ent)
	if (ent:IsPlayer()) then
		if (GetConVar("bullet_override_players_enabled"):GetFloat() == 0) then
			return true
		end
	elseif (GetConVar("bullet_override_npcs_enabled"):GetFloat() == 0) then
		return true
	end
	return false
end

local function DoBulletOverrideImpactEffect(tr, effect)
	-- Effects prepended with "Basic_" are (or at least should be) followed by an engine effect
	if (StrStartsWithAndMore(effect, "Basic_")) then
		local effectdata = EffectData()
		effectdata:SetOrigin(tr.HitPos)
		effectdata:SetNormal(tr.Normal)
		util.Effect(string.sub(effect, 7), effectdata, true, true)
	-- Effects prepended with "BasicBack_" are the same as "Basic_", but in the opposite direction
	elseif (StrStartsWithAndMore(effect, "BasicBack_")) then
		local effectdata = EffectData()
		effectdata:SetOrigin(tr.HitPos)
		effectdata:SetNormal(-tr.Normal)
		util.Effect(string.sub(effect, 11), effectdata, true, true)
	-- Effects prepended with "BasicEnt_" are the same as "Basic_", but require hitting an entity to work
	elseif (StrStartsWithAndMore(effect, "BasicEnt_")) then
		local effectdata = EffectData()
		effectdata:SetOrigin(tr.HitPos)
		effectdata:SetNormal(tr.Normal)
		if (tr.HitWorld || !IsValid(tr.Entity)) then return end
		effectdata:SetEntity(tr.Entity)
		effectdata:SetMagnitude(2)
		util.Effect(string.sub(effect, 10), effectdata, true, true)
	-- Effects prepended with "Cust_" are custom, and defined below
	elseif (StrStartsWithAndMore(effect, "Cust_")) then
		local effectName = string.sub(effect, 6)
		if (effectName == "ThumperDust") then
			local effectdata = EffectData()
			effectdata:SetOrigin(tr.HitPos)
			effectdata:SetNormal(tr.Normal)
			effectdata:SetScale(20)
			util.Effect("ThumperDust", effectdata, true, true)
		elseif (effectName == "WheelDust") then
			local effectdata = EffectData()
			effectdata:SetOrigin(tr.HitPos)
			effectdata:SetNormal(tr.Normal)
			effectdata:SetScale(3)
			util.Effect("WheelDust", effectdata, true, true)
		elseif (effectName == "bloodspray") then
			local effectdata = EffectData()
			effectdata:SetEntity(tr.Entity)
			effectdata:SetOrigin(tr.HitPos)
			effectdata:SetNormal(-tr.Normal)
			effectdata:SetScale(6)
			effectdata:SetFlags(3)
			util.Effect("bloodspray", effectdata, true, true)
		elseif (effectName == "MagicLines") then
			sound.Play("weapons/ar2/npc_ar2_altfire.wav", tr.HitPos, 90, math.Rand(180, 220))
			ParticleEffect("magic_lines", tr.HitPos, Angle(0, 0, 0))
		end
	end
end

local function OnEntityFireBulletsPost(attacker, tr, dmginfo)
	-- Test that bullet override is enabled
	if (GetConVar("bullet_override_enabled"):GetFloat() == 0) then return end

	-- Don't suppress effects
	SuppressHostEvents(NULL)

	-- Filter by players/npcs, and test that the bullet actually hit something
	if (
			DefaultBulletsSkipForEnt(attacker)
		||	!tr.Hit
		||	tr.HitSky
	--) then return end
	) then return true end
	
	-- OBSELETE
	-- Sparks
	-- if (GetConVar("bullet_override_sparks"):GetFloat() > 0) then
		-- local spark = ents.Create("env_spark")
		-- spark:SetPos(tr.HitPos)
		-- spark:Spawn()
		-- spark:Fire("SparkOnce")
		-- spark:Remove()
	-- end

	-- Explosion
	if (GetConVar("bullet_override_explode"):GetFloat() > 0) then
		local explosion = ents.Create("env_explosion")
		explosion:SetPos(tr.HitPos)
		explosion:SetKeyValue("iMagnitude", GetConVar("bullet_override_explode_dmg"):GetFloat())
		explosion:Spawn()
		explosion:Fire("Explode")
		--explosion:Remove()
	end

	-- DMG type
	if (GetConVar("bullet_override_dmg_type"):GetFloat() > 0) then
		dmginfo:SetDamageType(GetConVar("bullet_override_dmg_type_value"):GetFloat())
	end
	
	-- Impact Effect
	if (GetConVar("bullet_override_impact"):GetFloat() > 0) then
		DoBulletOverrideImpactEffect(tr, GetConVar("bullet_override_impact_value"):GetString())
	end
	
	-- Damage Scale
	dmginfo:ScaleDamage(GetConVar("bullet_override_dmg_scale"):GetFloat())
	
	-- Ignite Fire
	if (
		IsValid(tr.Entity)
		&&
		(
			GetConVar("bullet_override_ignite_players"):GetFloat() > 0 && tr.Entity:IsPlayer()
			|| GetConVar("bullet_override_ignite_npcs"):GetFloat() > 0 && tr.Entity:IsNPC()
			--The check for not player and not npc might be redundant, may change later
			|| GetConVar("bullet_override_ignite_misc"):GetFloat() > 0 && !tr.Entity:IsPlayer() && !tr.Entity:IsNPC() && tr.Entity
		)
		&&
		GetConVar("bullet_override_ignite_chance"):GetFloat() > 0 && (math.random() + GetConVar("bullet_override_ignite_chance"):GetFloat()) >= 1
	) then
	
		local fireTime = GetConVar("bullet_override_ignite_time"):GetFloat()
		if (GetConVar("bullet_override_ignite_time_based_on_dmg"):GetFloat() > 0) then
			fireTime = fireTime * dmginfo:GetDamage()
		end
		local igniteRadius = GetConVar("bullet_override_ignite_radius"):GetFloat()
		if (GetConVar("bullet_override_ignite_radius_based_on_dmg"):GetFloat() > 0) then
			igniteRadius = igniteRadius * dmginfo:GetDamage()
		end
		
		tr.Entity:Ignite(fireTime, igniteRadius)
	end
end

hook.Add("EntityFireBullets", "BulletOverride", function(ent, data)
	
	--PrintMessage(HUD_PRINTTALK, ent:GetName() .. ": " .. tostring(ent.WeaponSpread))
	
	-- Test that bullet override is enabled, and filter by players/npcs
	if (
		GetConVar("bullet_override_enabled"):GetFloat() == 0
		|| DefaultBulletsSkipForEnt(ent)
	) then return true end

	-- Tracer Frequency
	if (GetConVar("bullet_override_tracer_freq"):GetFloat() > 0) then
		data.Tracer = GetConVar("bullet_override_tracer_freq_val"):GetFloat()
	end
	
	-- Tracer Effect
	if (GetConVar("bullet_override_tracer"):GetFloat() > 0) then
		data.TracerName = GetConVar("bullet_override_tracer_value"):GetString()
	end
	
	-- Number of Bullets Per Shot
	if (GetConVar("bullet_override_numbullets"):GetFloat() > 0) then
		data.Num = GetConVar("bullet_override_numbullets_value"):GetFloat()
	end
	
	-- Force Scale
	data.Force = data.Force * GetConVar("bullet_override_force_scale"):GetFloat()
	
	-- Spread Scale
	data.Spread = data.Spread * GetConVar("bullet_override_spread_scale"):GetFloat()
	
	data.Callback = OnEntityFireBulletsPost
	return true
end)