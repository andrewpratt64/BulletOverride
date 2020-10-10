CreateConVar(
	"bullet_override_enabled",
	1,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	nil
)
CreateConVar(
	"bullet_override_players_enabled",
	1,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"When enabled, bullets fired by players are overriden"
)
CreateConVar(
	"bullet_override_npcs_enabled",
	1,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"When enabled, bullets fired by npcs are overriden"
)
-- OBSELETE
-- CreateConVar(
	-- "bullet_override_sparks",
	-- 0,
	-- {FCVAR_REPLICATED, FCVAR_ARCHIVE},
	-- "When enabled, bullet impacts create sparks"
-- )
CreateConVar(
	"bullet_override_explode",
	0,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"When enabled, bullet impacts create explosions"
)
CreateConVar(
	"bullet_override_explode_dmg",
	50,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"Amount of damage explosions from bullet impacts deal"
)
CreateConVar(
	"bullet_override_dmg_type",
	0,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"When enabled, bullet damage type is overriden"
)
CreateConVar(
	"bullet_override_dmg_type_value",
	4,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"Damage type to override bullets with. See https://wiki.facepunch.com/gmod/Enums/DMG for a list of DMG types",
	0, 2147483648
)
CreateConVar(
	"bullet_override_tracer_freq",
	0,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"When enabled, the frequency of bullet tracers are overriden"
)
CreateConVar(
	"bullet_override_tracer_freq_val",
	1,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"When bullet_override_tracer_freq is enabled, a tracer will be shown for every x bullets"
)
CreateConVar(
	"bullet_override_tracer",
	0,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"When enabled, bullet tracers are overriden"
)
CreateConVar(
	"bullet_override_tracer_value",
	"Tracer",
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"Type of effect to override bullet tracers with. See https://wiki.facepunch.com/gmod/Effects for a list of effects"
)
CreateConVar(
	"bullet_override_impact",
	0,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"When enabled, bullet impact effects are overriden"
)
CreateConVar(
	"bullet_override_impact_value",
	"Impact",
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"Type of effect to override bullet impact with. This effect is created IN ADDITION to what the bullet would normally do it dosen't replace the old effect.\n     Effects prepended with \"Basic_\" are engine effects (ex. Basic_Impact)\n     Effects prepended with \"BasicBack_\" are engine effects spawned backwards\n     Effects prepended with \"BasicEnt_\" are engine effects that require a hit entity\n     (See https://wiki.facepunch.com/gmod/Effects for a list of these effects)\n     Effects prepended with \"Cust_\" are custom effects, defined in lua"
)
CreateConVar(
	"bullet_override_numbullets",
	0,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"When enabled, number of bullets per shot is overriden"
)
CreateConVar(
	"bullet_override_numbullets_value",
	1,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"How many bullets to create per shot"
)
CreateConVar(
	"bullet_override_ignite_players",
	0,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"When enabled, bullets may ignite players"
)
CreateConVar(
	"bullet_override_ignite_npcs",
	0,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"When enabled, bullets may ignite npcs"
)
CreateConVar(
	"bullet_override_ignite_misc",
	0,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"When enabled, bullets may ignite entities other than players and npcs"
)
CreateConVar(
	"bullet_override_ignite_time_based_on_dmg",
	0,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"When enabled, bullet damage affects the lifetime of fire it creates. Multiplied with bullet_override_ignite_time"
)
CreateConVar(
	"bullet_override_ignite_time",
	5,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"How long fire created by bullets lasts in seconds"
)
CreateConVar(
	"bullet_override_ignite_radius_based_on_dmg",
	0,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"When enabled, bullet damage affects the radius of fire it creates that will ignite other entities. Multiplied with bullet_override_ignite_radius"
)
CreateConVar(
	"bullet_override_ignite_radius",
	0,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"Radius of fire created from bullets will ignite other entities"
)
CreateConVar(
	"bullet_override_ignite_chance",
	0,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"How likely it is for a bullet to ignite what it hit. Percentage; disable by assigning 0"
)
CreateConVar(
	"bullet_override_dmg_scale",
	1,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"Amount to scale bullet damage by"
)
CreateConVar(
	"bullet_override_force_scale",
	1,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"Amount to scale bullet force by"
)
CreateConVar(
	"bullet_override_spread_scale",
	1,
	{FCVAR_REPLICATED, FCVAR_ARCHIVE},
	"Amount to scale bullet spread by"
)