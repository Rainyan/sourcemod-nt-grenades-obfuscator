#pragma semicolon 1

#include <sourcemod>
#include <sdkhooks>
#include <sdktools>

#define PLUGIN_VERSION "1.0"

new const String:weaponModel[] = "models/weapons/w_smokenade.mdl";
//const char message = "foo";

public Plugin:myinfo = {
	name = "NT Grenade Obfuscator",
	description = "Make frags and smokes indistinguishable by using the same model for both",
	author = "Rain",
	version = PLUGIN_VERSION,
	url = ""
};

public OnMapStart()
{
	PrecacheModel(weaponModel, true); // Model needs to be precached to avoid server crash
}

public OnEntityCreated(entity, const String:classname[])
{
	if(StrEqual(classname, "grenade_projectile"))
		SDKHook(entity, SDKHook_SpawnPost, SpawnPost_Grenade);
}

public SpawnPost_Grenade(entity)
{
	if (!IsModelPrecached(weaponModel))
	{
		LogError("Failed precaching model %s at map start", weaponModel);
		PrecacheModel(weaponModel);
	}
	
	SetEntityModel(entity, weaponModel);
}