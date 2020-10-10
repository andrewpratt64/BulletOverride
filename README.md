# BulletOverride
A utility for modifying your bullet properties, appearance, and more

READ LICENSE.txt FOR LICENSING INFORMATION

Addon by Andrew Pratt
  SteamID: STEAM_0:1:196732213
  Github: andrewpratt64
  Addon Workshop page: https://steamcommunity.com/sharedfiles/filedetails/?id=2029144480
  Author Steam page: https://steamcommunity.com/profiles/76561198353730155/
  Author github: https://github.com/andrewpratt64
  Addon github repository: https://github.com/andrewpratt64/BulletOverride/


CURRENT FEATURES:
- Usable in both singleplayer and multiplayer
- Enable/disable addon functionality from spawnmenu
- Filter overrides by players and npcs
- Create explosions from bullets with custom damage
- Override damage type
- Change bullet tracer frequency and effects
- Create effects from bullet impacts
- Scale bullet damage
- Change how many bullets are created per shot
- Scale bullet damage
- Scale bullet force
- Scale bullet spread


>Use the discussion for reporting bugs<


* This addon may conflict with other addons that modify the behavior of bullets (Physical bullets, Weaponry stats, etc.)


Customization is available under the options tab in the spawnmenu


===Feel free to decompile/modify, just don't reupload.===


Console Vars:
- bullet_override_enabled
- bullet_override_players_enabled:
When enabled bullets fired by players are overriden
- bullet_override_npcs_enabled
When enabled bullets fired by npcs are overriden
- bullet_override_explode
When enabled bullet impacts create explosions
- bullet_override_explode_dmg
Amount of damage explosions from bullet impacts deal
- bullet_override_dmg_type
When enabled bullet damage type is overriden
- bullet_override_dmg_type_value
Damage type to override bullets with. See https://wiki.facepunch.com/gmod/Enums/DMG for a list of DMG types
- bullet_override_tracer_freq
When enabled the frequency of bullet tracers are overriden
- bullet_override_tracer_freq_val
When bullet_override_tracer_freq is enabled a tracer will be shown for every x bullets
- bullet_override_tracer
When enabled bullet tracers are overriden
- bullet_override_tracer_value
Type of effect to override bullet tracers with. See https://wiki.facepunch.com/gmod/Effects for a list of effects
- bullet_override_impact
When enabled bullet impact effects are overriden
- bullet_override_impact_value
Type of effect to override bullet impact with. This effect is created IN ADDITION to what the bullet would normally do it dosen't replace the old effect.
Effects prepended with "Basic_" are engine effects (ex. Basic_Impact)
Effects prepended with "BasicBack_" are engine effects spawned backwards
Effects prepended with "BasicEnt_" are engine effects that require a hit entity
(See https://wiki.facepunch.com/gmod/Effects for a list of these effects)
Effects prepended with "Cust_" are custom effects, defined in lua
- bullet_override_dmg_scale
Amount to scale bullet damage by
- bullet_override_numbullets
When enabled, number of bullets per shot is overriden
- bullet_override_numbullets_value
How many bullets to create per shot
- bullet_override_dmg_scale
Amount to scale bullet damage by
- bullet_override_force_scale
Amount to scale bullet force by
- bullet_override_spread_scale
Amount to scale bullet spread by
- bullet_override_ignite_players
When enabled, bullets may ignite players
- bullet_override_ignite_npcs
When enabled, bullets may ignite npcs
- bullet_override_ignite_misc
When enabled, bullets may ignite entities other than players and npcs
- bullet_override_ignite_time_based_on_dmg
When enabled, bullet damage affects the lifetime of fire it creates. Multiplied with bullet_override_ignite_time
- bullet_override_ignite_time
How long fire created by bullets lasts in seconds
- bullet_override_ignite_radius_based_on_dmg
When enabled, bullet damage affects the radius of fire it creates that will ignite other entities. Multiplied with bullet_override_ignite_radius
- bullet_override_ignite_radius
Radius of fire created from bullets will ignite other entities
- bullet_override_ignite_chance
How likely it is for a bullet to ignite what it hit. Percentage; disable by assigning 0
