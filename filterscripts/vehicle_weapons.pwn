#define FILTERSCRIPT

#include <open.mp>
#include <ColAndreas>
#include <streamer>

// COLORS

#define PASTEL_PINK       0xFFF5B7C7 // Пастельно-розовый
#define PASTEL_ORANGE     0xFFFFE4B5 // Пастельно-оранжевый
#define PASTEL_YELLOW     0xFFFFFFF0 // Пастельно-желтый
#define PASTEL_GREEN      0xFFB0E0E6 // Пастельно-зеленый
#define PASTEL_BLUE       0xFFADD8E6 // Пастельно-голубой
#define PASTEL_PURPLE     0xFFD8BFD8 // Пастельно-фиолетовый
#define PASTEL_GRAY       0xFFD3D3D3 // Пастельно-серый

#define PASTEL_LIGHT_PINK  0xFFF0F0F5 // Очень светло-розовый
#define PASTEL_LIGHT_ORANGE 0xFFFFF8E7 // Очень светло-оранжевый
#define PASTEL_LIGHT_YELLOW 0xFFFFFFFA // Очень светло-желтый
#define PASTEL_LIGHT_GREEN  0xFFE0FFFF // Очень светло-зеленый
#define PASTEL_LIGHT_BLUE  0xFFE0FFFF // Очень светло-голубой
#define PASTEL_LIGHT_PURPLE 0xFFF0F0FF // Очень светло-фиолетовый
#define PASTEL_LIGHT_GRAY  0xFFF5F5F5 // Очень светло-серый

#define PASTEL_DEEP_PINK    0xFFF08080 // Более насыщенный пастельно-розовый
#define PASTEL_DEEP_ORANGE  0xFFFFA07A // Более насыщенный пастельно-оранжевый
#define PASTEL_DEEP_YELLOW  0xFFFFFFC0 // Более насыщенный пастельно-желтый
#define PASTEL_DEEP_GREEN   0xFF98FB98 // Более насыщенный пастельно-зеленый
#define PASTEL_DEEP_BLUE    0xFF87CEEB // Более насыщенный пастельно-голубой
#define PASTEL_DEEP_PURPLE  0xFFC71585 // Более насыщенный пастельно-фиолетовый
#define PASTEL_DEEP_GRAY    0xFFA9A9A9 // Более насыщенный пастельно-серый
#define PASTEL_DEEP_BROWN   0xFFA0522D // Более насыщенный пастельно-коричневый

#define MAX_MISSILES 50
#define MISSILE_EX_ID_OFFSET 300001
#define MISSILE_VELOCITY 50
#define MISSILE_HEIGHT 100
#define MISSILE_CONTACT 2
#define MISSILE_STEP 5
#define MISSILE_EXPLOSION_RADIUS 20.0

#define MAX_STATVEHS 16
#define STATVEH_EX_ID_OFFSET 400001

// PLAYERS INFO

enum EPlayerInfo {
	bool:player_aim,
	player_last_damagerid
}

new PlayerInfo[MAX_PLAYERS][EPlayerInfo];

// VEHICLES INFO 

enum EVehicleInfo {
	vehid,
	veh_modelid,
	Float:vehX,
	Float:vehY,
	Float:vehZ,
	Float:vehA,
	veh_objectid,
	Float:veh_oX,
	Float:veh_oY,
	Float:veh_oZ
}

new VehicleInfo[MAX_STATVEHS][EVehicleInfo];

// WHOOPIE MISSILE INFO

enum EWMInfo {
	wm_type,
	wm_targetid,
	wm_playerid,
	wm_objectid,
	bool:wm_faced_obstacle
};

new WMInfo[MAX_MISSILES][EWMInfo];

public OnFilterScriptInit()
{
	for(new i=0; i < MAX_MISSILES; i++)
	{
		WMInfo[i][wm_objectid] = -1;
		WMInfo[i][wm_targetid] = -1;
		WMInfo[i][wm_playerid] = -1;
		WMInfo[i][wm_faced_obstacle] = false;
	}
	
	// VEHICLES
	
	VehicleInfo[0][veh_modelid] = 401;
	VehicleInfo[0][vehX] = 1252.3234;
	VehicleInfo[0][vehY] = 247.3649;
	VehicleInfo[0][vehZ] = 19.5547;
	VehicleInfo[0][vehA] = 68.4121;
	
	VehicleInfo[1][veh_modelid] = 404;
	VehicleInfo[1][vehX] = 1204.5350;
	VehicleInfo[1][vehY] = 267.3818;
	VehicleInfo[1][vehZ] = 19.5547;
	VehicleInfo[1][vehA] = 336.2913;
	
	VehicleInfo[2][veh_modelid] = 413;
	VehicleInfo[2][vehX] = 1228.4899;
	VehicleInfo[2][vehY] = 299.6678;
	VehicleInfo[2][vehZ] = 19.5547;
	VehicleInfo[2][vehA] = 157.2198;
	
	VehicleInfo[3][veh_modelid] = 415;
	VehicleInfo[3][vehX] = 1221.7859;
	VehicleInfo[3][vehY] = 301.9800;
	VehicleInfo[3][vehZ] = 19.5547;
	VehicleInfo[3][vehA] = 157.2198;
	
	VehicleInfo[4][veh_modelid] = 423;
	VehicleInfo[4][vehX] = 1341.4185;
	VehicleInfo[4][vehY] = 332.9185;
	VehicleInfo[4][vehZ] = 20.0376;
	VehicleInfo[4][vehA] = 66.1840;
	
	VehicleInfo[5][veh_modelid] = 429;
	VehicleInfo[5][vehX] = 1355.1538;
	VehicleInfo[5][vehY] = 364.0742;
	VehicleInfo[5][vehZ] = 20.0255;
	VehicleInfo[5][vehA] = 65.7257;
	
	VehicleInfo[6][veh_modelid] = 434;
	VehicleInfo[6][vehX] = 1415.2637;
	VehicleInfo[6][vehY] = 377.1012;
	VehicleInfo[6][vehZ] = 19.3042;
	VehicleInfo[6][vehA] = 76.3792;
	
	VehicleInfo[7][veh_modelid] = 442;
	VehicleInfo[7][vehX] = 1420.0203;
	VehicleInfo[7][vehY] = 367.5028;
	VehicleInfo[7][vehZ] = 19.0526;
	VehicleInfo[7][vehA] = 162.1000;
	
	VehicleInfo[8][veh_modelid] = 456;
	VehicleInfo[8][vehX] = 1409.5997;
	VehicleInfo[8][vehY] = 320.1427;
	VehicleInfo[8][vehZ] = 18.9372;
	VehicleInfo[8][vehA] = 226.8040;
	
	VehicleInfo[9][veh_modelid] = 462;
	VehicleInfo[9][vehX] = 1425.1090;
	VehicleInfo[9][vehY] = 275.1043;
	VehicleInfo[9][vehZ] = 19.5547;
	VehicleInfo[9][vehA] = 68.4127;
	
	VehicleInfo[10][veh_modelid] = 470;
	VehicleInfo[10][vehX] = 1391.0519;
	VehicleInfo[10][vehY] = 265.4253;
	VehicleInfo[10][vehZ] = 19.5669;
	VehicleInfo[10][vehA] = 157.7136;
	
	VehicleInfo[11][veh_modelid] = 477;
	VehicleInfo[11][vehX] = 1337.6892;
	VehicleInfo[11][vehY] = 285.5739;
	VehicleInfo[11][vehZ] = 19.5615;
	VehicleInfo[11][vehA] = 248.4245;
	
	VehicleInfo[12][veh_modelid] = 486;
	VehicleInfo[12][vehX] = 1294.9200;
	VehicleInfo[12][vehY] = 218.1724;
	VehicleInfo[12][vehZ] = 19.5547;
	VehicleInfo[12][vehA] = 69.1963;
	
	VehicleInfo[13][veh_modelid] = 503;
	VehicleInfo[13][vehX] = 1288.4561;
	VehicleInfo[13][vehY] = 188.6687;
	VehicleInfo[13][vehZ] = 20.2564;
	VehicleInfo[13][vehA] = 129.3569;
	
	VehicleInfo[14][veh_modelid] = 506;
	VehicleInfo[14][vehX] = 1288.8064;
	VehicleInfo[14][vehY] = 162.4481;
	VehicleInfo[14][vehZ] = 20.4670;
	VehicleInfo[14][vehA] = 11.0725;
	
	VehicleInfo[15][veh_modelid] = 535;
	VehicleInfo[15][vehX] = 1239.2605;
	VehicleInfo[15][vehY] = 181.1548;
	VehicleInfo[15][vehZ] = 19.8765;
	VehicleInfo[15][vehA] = 334.2556;
	
	for(new i = 0; i < MAX_STATVEHS; i++) {
		VehicleInfo[i][vehid] = AddStaticVehicle(
			VehicleInfo[i][veh_modelid],
			VehicleInfo[i][vehX],
			VehicleInfo[i][vehY],
			VehicleInfo[i][vehZ],
			VehicleInfo[i][vehA],
			-1,
			-1
		);
	}
}

public OnFilterScriptExit()
{
	return 1;
}


public OnPlayerConnect(playerid)
{
	PlayerInfo[playerid][player_aim] = false;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	PlayerInfo[playerid][player_aim] = false;
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	PlayerInfo[playerid][player_last_damagerid] = INVALID_PLAYER_ID;
	return 1;
}

public OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
	if(killerid == INVALID_PLAYER_ID && PlayerInfo[playerid][player_last_damagerid] != INVALID_PLAYER_ID)
	{
		SendDeathMessage(PlayerInfo[playerid][player_last_damagerid], playerid, 47);
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(GetVehicleModel(vehicleid) == 423 && ispassenger == 0) {
		EnablePlayerCameraTarget(playerid, true);
	}
	return 0;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(GetVehicleModel(vehicleid) == 423) {
		EnablePlayerCameraTarget(playerid, false);
	}
	return 0;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnGameModeInit()
{
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	// called on shooting
	if((newkeys & KEY_FIRE) && !(oldkeys & KEY_FIRE)) {
		new vehicleid = GetPlayerVehicleID(playerid);
		switch(GetVehicleModel(vehicleid)) {
			case 476: {
				// rustler coords
				new Float:fX, Float:fY, Float:fZ;
		        GetVehiclePos(vehicleid, fX, fY, fZ);
				// rustler rotation matrix
		        new
				Float:rightX, Float:rightY, Float:rightZ,
				Float:upX, Float:upY, Float:upZ,
				Float:atX, Float:atY, Float:atZ;
				// change missile velocity
				new missile_velocity = 100;			
				
		        GetVehicleMatrix(vehicleid, rightX, rightY, rightZ, upX, upY, upZ, atX, atY, atZ);
				
				new Float:distance = 300.0;			
				
				new Float:flX, Float:flY, Float:flZ,
					Float:frX, Float:frY, Float:frZ,
					Float:dflX, Float:dflY, Float:dflZ,
					Float:dfrX, Float:dfrY, Float:dfrZ;	
				// origin coords of left missile
				flX = fX + upX * 5 - rightX * 2;
				flY = fY + upY * 5 - rightY * 2;
				flZ = fZ + upZ * 5 - rightZ * 2;
				// destination coords of left missile
				dflX = fX + upX * distance - rightX * 2;
				dflY = fY + upY * distance - rightY * 2;
				dflZ = fZ + upZ * distance - rightZ * 2;
				// origin coords of right missile
				frX = fX + upX * 5 + rightX * 2;
				frY = fY + upY * 5 + rightY * 2;
				frZ = fZ + upZ * 5 + rightZ * 2;
				// destination coords of right missile
				dfrX = fX + upX * distance + rightX * 2;
				dfrY = fY + upY * distance + rightY * 2;
				dfrZ = fZ + upZ * distance + rightZ * 2;
				// create objects
				new Float:temp_X, Float:temp_Y, Float:temp_Z;
				new l_obstacle = CA_RayCastLine(flX, flY, flZ, dflX, dflY, dflZ, temp_X, temp_Y, temp_Z);
				if(l_obstacle != 0) {
					dflX = temp_X;
					dflY = temp_Y;
					dflZ = temp_Z;		
				}
				
				new r_obstacle = CA_RayCastLine(frX, frY, frZ, dfrX, dfrY, dfrZ, temp_X, temp_Y, temp_Z);
				if(r_obstacle != 0) {
					dfrX = temp_X;
					dfrY = temp_Y;
					dfrZ = temp_Z;		
				}
	
		        new l_obj = CreateObject(345, flX, flY, flZ, 0.0, 0.0, 0.0);
				// calculate absolute length from origin to destination 
				new Float:l_length = floatsqroot(floatpower(dflX - flX, 2) + floatpower(dflY - flY, 2) + floatpower(dflZ - flZ, 2));
				new r_obj = CreateObject(345, frX, frY, frZ, 0.0, 0.0, 0.0);
				new Float:r_length = floatsqroot(floatpower(dfrX - frX, 2) + floatpower(dfrY - frY, 2) + floatpower(dfrZ - frZ, 2));
				// calculate time for destroying object
				SetTimerEx("DestroyDeagleObject", floatround(l_length / missile_velocity * 1000), false, "ii", playerid, l_obj);
				// move missile
				MoveObject(l_obj, dflX, dflY, dflZ, missile_velocity);
				SetTimerEx("DestroyDeagleObject", floatround(r_length / missile_velocity * 1000), false, "ii", playerid, r_obj);
				MoveObject(r_obj, dfrX, dfrY, dfrZ, missile_velocity);
			}
		}
	}
	return 1;
}

forward DestroyDeagleObject(playerid, objectid);
public DestroyDeagleObject(playerid, objectid)
{
	new Float:fX, Float:fY, Float:fZ;
	GetObjectPos(objectid, fX, fY, fZ);
	DestroyObject(objectid);
	CreateCustomExplosion(playerid, fX, fY, fZ, 0, MISSILE_EXPLOSION_RADIUS);
}

forward CreateCustomExplosion(playerid, Float:fX, Float:fY, Float:fZ, type, Float:radius);
public CreateCustomExplosion(playerid, Float:fX, Float:fY, Float:fZ, type, Float:radius)
{
	CreateExplosion(fX, fY, fZ, type, radius);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(i, pX, pY, pZ);
			
			new Float:length = floatsqroot(floatpower(pX - fX, 2) + floatpower(pY - fY, 2) + floatpower(pZ - fZ, 2));
			if(length < radius) PlayerInfo[i][player_last_damagerid] = playerid;
		}
	}
}

public OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnActorStreamIn(actorid, forplayerid)
{
	return 1;
}

public OnActorStreamOut(actorid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerEnterGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerLeaveGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerEnterPlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerLeavePlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerClickGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerClickPlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
	return 1;
}

public OnPlayerRequestDownload(playerid, DOWNLOAD_REQUEST:type, crc)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 0;
}

public OnPlayerSelectObject(playerid, SELECT_OBJECT:type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, EDIT_RESPONSE:response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	return 1;
}

public OnPlayerEditAttachedObject(playerid, EDIT_RESPONSE:response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerPickUpPlayerPickup(playerid, pickupid)
{
	return 1;
}

public OnPickupStreamIn(pickupid, playerid)
{
	return 1;
}

public OnPickupStreamOut(pickupid, playerid)
{
	return 1;
}

public OnPlayerPickupStreamIn(pickupid, playerid)
{
	return 1;
}

public OnPlayerPickupStreamOut(pickupid, playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, CLICK_SOURCE:source)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	switch(GetVehicleModel(vehicleid)) {
		case 423: LaunchPlayerMissile(playerid, clickedplayerid, 1);
		case 413: LaunchPlayerMissile(playerid, clickedplayerid, 2);
	}
	return 0;
}

stock LaunchPlayerMissile(playerid, victimid, type) {
	PlayerInfo[victimid][player_aim] = true;
	new Float:oX, Float:oY, Float:oZ,
		Float:dX, Float:dY, Float:dZ,
		Float:tX, Float:tY, Float:tZ;
		
	GetPlayerPos(playerid, oX, oY, oZ);
	dX = oX;
	dY = oY;
	dZ = oZ + MISSILE_HEIGHT;
	new upper_obstacle = CA_RayCastLine(oX, oY, oZ, dX, dY, dZ, tX, tY, tZ);
	if(upper_obstacle != 0) {
		return -1;
	}
	
	new missileid = FindEmptyMissileSlot();
	new objectid = CreateDynamicObject(345, oX, oY, oZ, 0, 0, 0);
	
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_EXTRA_ID, missileid + MISSILE_EX_ID_OFFSET);
	
	WMInfo[missileid][wm_playerid] = playerid;
	WMInfo[missileid][wm_targetid] = victimid;
	WMInfo[missileid][wm_objectid] = objectid;
	WMInfo[missileid][wm_type] = type;

	MoveDynamicObject(objectid, dX, dY, dZ, MISSILE_VELOCITY, 0, 0, 0);
	SendClientMessage(playerid, PASTEL_DEEP_ORANGE, "Missile Launched!");
	
	return missileid;
}

public OnDynamicObjectMoved(objectid)
{
	new missileid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_EXTRA_ID) - MISSILE_EX_ID_OFFSET;
	if(PlayerInfo[WMInfo[missileid][wm_targetid]][player_aim]) {
		switch(WMInfo[missileid][wm_type]) {
			case 1: MoveCheckpointMissile(missileid);
			case 2: MoveStepMissile(missileid);
			
		}
	} else {
		DestroyMissile(missileid);
	}
}

stock MoveCheckpointMissile(missileid)
{
	new Float:oX, Float:oY, Float:oZ,
		Float:dX, Float:dY, Float:dZ;
		
	GetDynamicObjectPos(WMInfo[missileid][wm_objectid], oX, oY, oZ);
	GetPlayerPos(WMInfo[missileid][wm_targetid], dX, dY, dZ);
	if(floatsqroot(floatpower(dX - oX, 2) + floatpower(dY - oY, 2) + floatpower(dZ - oZ, 2)) < MISSILE_CONTACT)
	{
		DestroyMissile(missileid);
		return 1;
	}
	MoveDynamicObject(WMInfo[missileid][wm_objectid], dX, dY, dZ, MISSILE_VELOCITY, 0, 0, 0);
	return 0;
}

stock MoveStepMissile(missileid)
{
	new Float:oX, Float:oY, Float:oZ,
		Float:dX, Float:dY, Float:dZ,
		Float:sX, Float:sY, Float:sZ;
		
	GetDynamicObjectPos(WMInfo[missileid][wm_objectid], oX, oY, oZ);
	GetPlayerPos(WMInfo[missileid][wm_targetid], dX, dY, dZ);
	
	new Float:length = floatsqroot(floatpower(dX - oX, 2) + floatpower(dY - oY, 2) + floatpower(dZ - oZ, 2));
	
	if(length < MISSILE_CONTACT) 
	{
		DestroyMissile(missileid);
		return 1;
	}
	
	sX = (dX - oX) / length * MISSILE_STEP;
	sY = (dY - oY) / length * MISSILE_STEP;
	sZ = (dZ - oZ) / length * MISSILE_STEP;
	
	dX = oX + sX;
	dY = oY + sY;
	dZ = oZ + sZ;
	
	MoveDynamicObject(WMInfo[missileid][wm_objectid], dX, dY, dZ, MISSILE_VELOCITY, 0, 0, 0);
	return 0;
}

stock DestroyMissile(missileid)
{
	new Float:oX, Float:oY, Float:oZ;
	GetDynamicObjectPos(WMInfo[missileid][wm_objectid], oX, oY, oZ);
	WMInfo[missileid][wm_targetid] = -1;
	DestroyDynamicObject(WMInfo[missileid][wm_objectid]);
	CreateCustomExplosion(WMInfo[missileid][wm_playerid], oX, oY, oZ, 6, 20);
}

stock FindEmptyMissileSlot()
{
    new
        i = 0;
    while (i < MAX_MISSILES && WMInfo[i][wm_targetid] != -1)
    {
        i++;
    }
    if (i == MAX_MISSILES) return -1;
    return i;
}

public OnPlayerWeaponShot(playerid, WEAPON:weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnScriptCash(playerid, amount, source)
{
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnIncomingConnection(playerid, ip_address[], port)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	return 1;
}

public OnTrailerUpdate(playerid, vehicleid)
{
	return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnEnterExitModShop(playerid, enterexit, interiorid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	return 1;
}