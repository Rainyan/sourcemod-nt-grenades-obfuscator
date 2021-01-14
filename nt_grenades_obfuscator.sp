#pragma semicolon 1

#include <sourcemod>
#include <sdkhooks>
#include <sdktools>

#define PLUGIN_VERSION "1.1"

new const String:weaponModel[] = "models/weapons/w_smokenade.mdl";

public Plugin myinfo = {
	name = "NT Grenade Obfuscator",
	description = "Make frags and smokes indistinguishable by using the same model for both",
	author = "Rain",
	version = PLUGIN_VERSION,
	url = "https://github.com/Rainyan/sourcemod-nt-grenades-obfuscator"
};

public void OnMapStart()
{
	// Model needs to be precached to avoid server crash.
	if (PrecacheModel(weaponModel, true) == 0)
	{
		SetFailState("OnMapStart: Failed precaching model: \"%s\"", weaponModel);
	}
}

public void OnEntityCreated(int entity, const String:classname[])
{
	if (StrEqual(classname, "grenade_projectile"))
	{
		SDKHook(entity, SDKHook_SpawnPost, SpawnPost_Grenade);
	}
}

void SpawnPost_Grenade(int entity)
{
	// Checking validity just in case this got removed before SpawnPost.
	if (IsValidEntity(entity))
	{
		SetEntityModel(entity, weaponModel);
	}
}
