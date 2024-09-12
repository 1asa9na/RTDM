#include <open.mp>
#include <Pawn.CMD>
#include <ColAndreas>
#include <streamer>

/*
     ___      _
    / __| ___| |_ _  _ _ __
    \__ \/ -_)  _| || | '_ \
    |___/\___|\__|\_,_| .__/
                      |_|
*/

// COLORS

#define PASTEL_PINK       0xFFF5B7C7 // ���������-�������
#define PASTEL_ORANGE     0xFFFFE4B5 // ���������-���������
#define PASTEL_YELLOW     0xFFFFFFF0 // ���������-������
#define PASTEL_GREEN      0xFFB0E0E6 // ���������-�������
#define PASTEL_BLUE       0xFFADD8E6 // ���������-�������
#define PASTEL_PURPLE     0xFFD8BFD8 // ���������-����������
#define PASTEL_GRAY       0xFFD3D3D3 // ���������-�����

#define PASTEL_LIGHT_PINK  0xFFF0F0F5 // ����� ������-�������
#define PASTEL_LIGHT_ORANGE 0xFFFFF8E7 // ����� ������-���������
#define PASTEL_LIGHT_YELLOW 0xFFFFFFFA // ����� ������-������
#define PASTEL_LIGHT_GREEN  0xFFE0FFFF // ����� ������-�������
#define PASTEL_LIGHT_BLUE  0xFFE0FFFF // ����� ������-�������
#define PASTEL_LIGHT_PURPLE 0xFFF0F0FF // ����� ������-����������
#define PASTEL_LIGHT_GRAY  0xFFF5F5F5 // ����� ������-�����

#define PASTEL_DEEP_PINK    0xFFF08080 // ����� ���������� ���������-�������
#define PASTEL_DEEP_ORANGE  0xFFFFA07A // ����� ���������� ���������-���������
#define PASTEL_DEEP_YELLOW  0xFFFFFFC0 // ����� ���������� ���������-������
#define PASTEL_DEEP_GREEN   0xFF98FB98 // ����� ���������� ���������-�������
#define PASTEL_DEEP_BLUE    0xFF87CEEB // ����� ���������� ���������-�������
#define PASTEL_DEEP_PURPLE  0xFFC71585 // ����� ���������� ���������-����������
#define PASTEL_DEEP_GRAY    0xFFA9A9A9 // ����� ���������� ���������-�����
#define PASTEL_DEEP_BROWN   0xFFA0522D // ����� ���������� ���������-����������

#define N_CLASSES 2
#define N_PICKUPS 1
#define N_CPS 3
#define N_PERKS 3
#define MAX_PERK_NAME 10

// CLASS INFO

enum EClassInfo {
	Float:x,
	Float:y,
	Float:z,
	Float:a,
	title[32],
	skin,
	color
};

new ClassInfo[N_CLASSES][EClassInfo];

// PLAYER INFO

enum EPlayerInfo {
	bool:is_player_spawned,
	kills,
	deaths,
	bool:is_carrying_bomb,
	PlayerText:current_textdraw,
	player_vehicle,
	player_perk,
	bool:player_change_team,
	bool:player_change_class
};

new PlayerInfo[MAX_PLAYERS][EPlayerInfo];

// PERK INFO

enum EPerkInfo {
	perk_health,
	perk_armour,
	perk_weapons[3],
	perk_weapon_ammo[3],
	perk_title[MAX_PERK_NAME]
}

new PerkInfo[N_PERKS][EPerkInfo];

// PICKUP INFO

enum EPickupInfo {
	bool:is_picked_up,
	picked_up_by_team,
	Float:pickup_x,
	Float:pickup_y,
	Float:pickup_z,
	pickup_object,
	pickup_mapicon,
	pickup_timer
}

new PickupInfo[N_PICKUPS][EPickupInfo];

// CP INFO

enum ECPInfo {
	cp_player,
	cp_team,
	bool:occupied,
	Float:cp_x,
	Float:cp_y,
	Float:cp_z,
	cp_mapicon,
	cp_bomb_timer,
	cp_defuse_timer,
	bool:is_active
}

new CPInfo[N_CPS][ECPInfo];

main() {}

public OnGameModeInit()
{
	ClassInfo[0][x] = 1446.9613;
	ClassInfo[0][y] = 349.7412;
	ClassInfo[0][z] = 18.8417;
	ClassInfo[0][a] = 117.9194;
	strcopy(ClassInfo[0][title], "BLYADS");
	ClassInfo[0][skin] = 29;
	ClassInfo[0][color] = 0xFFFF0404;
	
	ClassInfo[1][x] = 1238.5229;
	ClassInfo[1][y] = 213.6815;
	ClassInfo[1][z] = 19.5547;
	ClassInfo[1][a] = 115.0993;
	strcopy(ClassInfo[1][title], "GRIBS");
	ClassInfo[1][skin] = 73;
	ClassInfo[1][color] = 0xFF0404FF;
	
	CA_Init();
	
	SetGameModeText("My first open.mp gamemode!");
	UsePlayerPedAnims();
	DisableInteriorEnterExits();
	LimitPlayerMarkerRadius(100.0);
	
	
	for(new class = 0; class < N_CLASSES; class++) {
		AddPlayerClassEx(
			class,
			ClassInfo[class][skin],
			ClassInfo[class][x],
			ClassInfo[class][y],
			ClassInfo[class][z],
			ClassInfo[class][a],
			WEAPON_FIST, 1,
			WEAPON_FIST, 1,
			WEAPON_FIST, 1
		);
	}
	
	// PERKS
	
	PerkInfo[0][perk_health] = 100;
	PerkInfo[0][perk_armour] = 0;
	PerkInfo[0][perk_weapons] = { WEAPON_DEAGLE, WEAPON_MP5, WEAPON_GRENADE };
	PerkInfo[0][perk_weapon_ammo] = { 100, 500, 20 };
	strcopy(PerkInfo[0][perk_title], "Pawn");
	
	PerkInfo[1][perk_health] = 75;
	PerkInfo[1][perk_armour] = 0;
	PerkInfo[1][perk_weapons] = { WEAPON_SILENCED, WEAPON_KNIFE, WEAPON_SNIPER };
	PerkInfo[1][perk_weapon_ammo] = { 100, 1, 50 };
	strcopy(PerkInfo[1][perk_title], "Bishop");
	
	PerkInfo[2][perk_health] = 50;
	PerkInfo[2][perk_armour] = 50;
	PerkInfo[2][perk_weapons] = { WEAPON_KATANA, WEAPON_M4, WEAPON_SHOTGSPA };
	PerkInfo[2][perk_weapon_ammo] = { 1, 500, 100 };
	strcopy(PerkInfo[2][perk_title], "Rook");
	
	// OBJECTS
	CreateObject(3279,	1228.10315, 353.25989,	18.44100,	0.00000,	0.00000,	157.00000);
	CreateObject(13638, 1361.86523, 401.67441,	20.85201,	0.00000,	0.00000,	246.53470);
	CreateObject(18609,	1290.63513,	261.70557,	19.49440,	0.00000,	0.00000,	69.74204);
	CreateObject(1457,	1294.49634,	295.10037,	28.11846,   0.00000,	0.00000,	332.40698);
	CA_CreateObject(3279,	1228.10315, 353.25989,	18.44100,	0.00000,	0.00000,	157.00000, true);
	CA_CreateObject(13638, 1361.86523, 401.67441,	20.85201,	0.00000,	0.00000,	246.53470, true);
	CA_CreateObject(18609,	1290.63513,	261.70557,	19.49440,	0.00000,	0.00000,	69.74204, true);
	CA_CreateObject(1457,	1294.49634,	295.10037,	28.11846,   0.00000,	0.00000,	332.40698, true);
	
	// PICKUPS
	
	PickupInfo[0][is_picked_up] = false;
	PickupInfo[0][pickup_x] = 1306.4250;
	PickupInfo[0][pickup_y] = 351.7848;
	PickupInfo[0][pickup_z] = 19.5547;
	PickupInfo[0][pickup_object] = 1654;
	PickupInfo[0][picked_up_by_team] = 255;
	
	for(new i = 0; i < N_PICKUPS; i++) {	
		CreatePickup(PickupInfo[i][pickup_object], 1, PickupInfo[i][pickup_x], PickupInfo[i][pickup_y], PickupInfo[i][pickup_z], -1);
	}
	
	// CHECKPOINTS
	
	CPInfo[1][cp_team] = -1;
	CPInfo[1][cp_player] = -1;
	CPInfo[1][occupied] = false;
	CPInfo[1][cp_x] = 1271.5677;
	CPInfo[1][cp_y] = 295.0919;
	CPInfo[1][cp_z] = 20.6563;
	CPInfo[1][cp_mapicon] = 19;
	CPInfo[1][cp_bomb_timer] = -1;
	CPInfo[1][cp_defuse_timer] = -1;
	CPInfo[1][is_active] = false;
	
	CPInfo[2][cp_team] = -1;
	CPInfo[2][cp_player] = -1;
	CPInfo[2][occupied] = false;
	CPInfo[2][cp_x] = 1362.3979;
	CPInfo[2][cp_y] = 321.5292;
	CPInfo[2][cp_z] = 19.5547;
	CPInfo[2][cp_mapicon] = 19;
	CPInfo[2][cp_bomb_timer] = -1;
	CPInfo[2][cp_defuse_timer] = -1;
	CPInfo[2][is_active] = false;
	
	for(new i = 1; i < N_CPS; i++) {
		CreateDynamicCP(CPInfo[i][cp_x], CPInfo[i][cp_y], CPInfo[i][cp_z], 1);
		CreateDynamicMapIcon(CPInfo[i][cp_x], CPInfo[i][cp_y], CPInfo[i][cp_z], CPInfo[i][cp_mapicon], 0);
	}
	
	// VEHICLES
	
	AddStaticVehicle(401, 1252.3234,247.3649,19.5547,68.4121, -1, -1);
	AddStaticVehicle(404, 1204.5350,267.3818,19.5547,336.2913, -1, -1);
	AddStaticVehicle(413, 1228.4899,299.6678,19.5547,157.2198, -1, -1);
	AddStaticVehicle(415, 1221.7859,301.9800,19.5547,157.2198, -1, -1);
	AddStaticVehicle(423, 1341.4185,332.9185,20.0376,66.1840, -1, -1);
	AddStaticVehicle(429, 1355.1538,364.0742,20.0255,65.7257, -1, -1);
	AddStaticVehicle(434, 1415.2637,377.1012,19.3042,76.3792, -1, -1);
	AddStaticVehicle(442, 1420.0203,367.5028,19.0526,162.1000, -1, -1);
	AddStaticVehicle(456, 1409.5997,320.1427,18.9372,226.8040, -1, -1);
	AddStaticVehicle(462, 1425.1090,275.1043,19.5547,68.4127, -1, -1);
	AddStaticVehicle(470, 1391.0519,265.4253,19.5669,157.7136, -1, -1);
	AddStaticVehicle(477, 1337.6892,285.5739,19.5615,248.4245, -1, -1);
	AddStaticVehicle(486, 1294.9200,218.1724,19.5547,69.1963, -1, -1);
	AddStaticVehicle(503, 1288.4561,188.6687,20.2564,129.3569, -1, -1);
	AddStaticVehicle(506, 1288.8064,162.4481,20.4670,11.0725, -1, -1);
	AddStaticVehicle(535, 1239.2605,181.1548,19.8765,334.2556, -1, -1);
	
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

/*
      ___
     / __|___ _ __  _ __  ___ _ _
    | (__/ _ \ '  \| '  \/ _ \ ' \
     \___\___/_|_|_|_|_|_\___/_||_|

*/

// COMMANDS

CMD:rustler(playerid, params[])
{
	new Float:fX, Float:fY, Float:fZ, Float:fangle;
	GetPlayerPos(playerid, fX, fY, fZ);
	GetPlayerFacingAngle(playerid, fangle);
	DestroyPlayerVehicle(playerid);
	PlayerInfo[playerid][player_vehicle] = CreateVehicle(476, fX, fY, fZ, fangle, random(256), random(256), -1);
	PutPlayerInVehicle(playerid, PlayerInfo[playerid][player_vehicle], 0);
}

CMD:sc(playerid, params[])
{
	SendClientMessage(playerid, PASTEL_DEEP_GRAY, "Sending to class selection in 5 seconds!");
	SetTimerEx("SwitchPlayerClass", 5000, false, "i", playerid);
}

forward SwitchPlayerClass(playerid);
public SwitchPlayerClass(playerid)
{
	PlayerInfo[playerid][player_change_class] = true;
	SetPlayerHealth(playerid, 0);

}

CMD:st(playerid, params[])
{
	SendClientMessage(playerid, PASTEL_DEEP_GRAY, "Sending to team selection in 5 seconds!");
	SetTimerEx("SwitchPlayerTeam", 5000, false, "i", playerid);
}

forward SwitchPlayerTeam(playerid);
public SwitchPlayerTeam(playerid)
{
	PlayerInfo[playerid][player_change_team] = true;
	SetPlayerHealth(playerid, 0);
}

forward DestroyPlayerVehicle(playerid);
public DestroyPlayerVehicle(playerid) {
	DestroyVehicle(PlayerInfo[playerid][player_vehicle]);
}

public OnPlayerConnect(playerid)
{
	PlayerInfo[playerid][kills] = 0;
	PlayerInfo[playerid][deaths] = 0;
	PlayerInfo[playerid][is_player_spawned] = false;
	PlayerInfo[playerid][is_carrying_bomb] = false;
	PlayerInfo[playerid][player_change_team] = true;
	PlayerInfo[playerid][player_change_class] = true;
	PlayerInfo[playerid][current_textdraw] = CreatePlayerTextDraw(playerid, 0, 0, "initial textdraw");
	SetPlayerColor(playerid, 0xFF808080);
	
	GivePlayerMoney(playerid, 50);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	for(new i = 0; i < N_PICKUPS; i++) {	
		RemovePlayerMapIcon(playerid, i);
	}
	PlayerTextDrawDestroy(playerid, PlayerInfo[playerid][current_textdraw]);
	new PlayerText:class_textdraw = CreatePlayerTextDraw(playerid, 320, 200, ClassInfo[classid][title]);
	PlayerTextDrawAlignment(playerid, class_textdraw, TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawFont(playerid, class_textdraw, TEXT_DRAW_FONT_2);
	PlayerTextDrawShow(playerid, class_textdraw);
	PlayerInfo[playerid][current_textdraw] = class_textdraw;
	SetPlayerPos(playerid, ClassInfo[classid][x],	ClassInfo[classid][y],	ClassInfo[classid][z]);
	SetPlayerFacingAngle(playerid, ClassInfo[classid][a]);
	SetPlayerCameraPos(playerid, ClassInfo[classid][x] - 4 * floatcos(117.9194 - 90.0, degrees), ClassInfo[classid][y] - 4 * floatsin(117.9194 - 90.0, degrees), ClassInfo[classid][z] + 1);
	SetPlayerCameraLookAt(playerid, ClassInfo[classid][x],	ClassInfo[classid][y],	ClassInfo[classid][z]);
	InterpolateCameraPos(
		playerid,
		ClassInfo[(classid - 1) % N_CLASSES][x] - 4 * floatcos(117.9194 - 90.0, degrees),
		ClassInfo[(classid - 1) % N_CLASSES][y] - 4 * floatsin(117.9194 - 90.0, degrees),
		ClassInfo[(classid - 1) % N_CLASSES][z] + 1,
		ClassInfo[classid][x] - 4 * floatcos(117.9194 - 90.0, degrees),
		ClassInfo[classid][y] - 4 * floatsin(117.9194 - 90.0, degrees),
		ClassInfo[classid][z] + 1,
		1000,
		CAMERA_MOVE
	);
	InterpolateCameraLookAt(
		playerid,
		ClassInfo[(classid - 1) % N_CLASSES][x],
		ClassInfo[(classid - 1) % N_CLASSES][y],
		ClassInfo[(classid - 1) % N_CLASSES][z],
		ClassInfo[classid][x],
		ClassInfo[classid][y],
		ClassInfo[classid][z],
		1000,
		CAMERA_MOVE
	);

	ApplyAnimation(playerid, "benchpress", "gym_bp_celebrate", 4.1, true, false, false, false, 0, SYNC_NONE);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerInterior(playerid, 0);
	SetPlayerWorldBounds(playerid, 1455.7026, 1166.9702, 417.8921, 177.7630);
	
	new classid = GetPlayerTeam(playerid);
	SetPlayerColor(playerid, ClassInfo[classid][color]);
	PlayerTextDrawDestroy(playerid, PlayerInfo[playerid][current_textdraw]);
	if(PlayerInfo[playerid][player_change_team] || PlayerInfo[playerid][player_change_class])
	{
		if(PlayerInfo[playerid][player_change_team]) {
			ForceClassSelection(playerid);
			return 0;
		}
		if(PlayerInfo[playerid][player_change_class]) {
			ForcePerkSelection(playerid);
			return 0;
		}
	}
	
	new perkid = PlayerInfo[playerid][player_perk];
	for(new i = 0; i < 3; i++) GivePlayerWeapon(playerid, PerkInfo[perkid][perk_weapons][i], PerkInfo[perkid][perk_weapon_ammo][i]);
	
	
	PlayerInfo[playerid][is_player_spawned] = true;
	return 1;
}

public OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
	PlayerInfo[playerid][is_player_spawned] = false;
	SetPlayerColor(playerid, 0xFF808080);
	
	if (PlayerInfo[playerid][is_carrying_bomb] == true) {
		PlayerInfo[playerid][is_carrying_bomb] = false;
		PickupInfo[0][is_picked_up] = false;
		PickupInfo[0][picked_up_by_team] = 255;
		SendClientMessage(playerid, 0xFFFF0000, "You have lost the bomb!");
	}
	
	if(PlayerInfo[playerid][player_change_team] == false && PlayerInfo[playerid][player_change_class] == false) PlayerInfo[playerid][deaths] ++;
	
	if (killerid != INVALID_PLAYER_ID)
    {
        PlayerInfo[killerid][kills] ++;
    }
	return 1;
}

stock ForcePerkSelection(playerid)
{
	TogglePlayerSpectating(playerid, true);
	InterpolateCameraPos(playerid, 366.1500, 1762.8300, 158.9100, 366.1500, 1762.8300, 158.9100, 1000);
	InterpolateCameraLookAt(playerid, 365.3100, 1763.3800, 158.0600, 365.3100, 1763.3800, 158.0600, 1000);
	new string[(MAX_PERK_NAME + 1) * N_PERKS - 1];
	strcopy(string, PerkInfo[0][perk_title]);
	for(new i = 1; i < N_PERKS; i++) {
		strcat(string, "\n");
		strcat(string, PerkInfo[i][perk_title]);
	}
	ShowPlayerDialog(playerid, 1001, DIALOG_STYLE_LIST, "Perk Selection", string, "Continue", "Back");
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 0;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{	
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

/*
     ___              _      _ _    _
    / __|_ __  ___ __(_)__ _| (_)__| |_
    \__ \ '_ \/ -_) _| / _` | | (_-<  _|
    |___/ .__/\___\__|_\__,_|_|_/__/\__|
        |_|
*/

public OnFilterScriptInit()
{
	printf(" ");
	printf("  -----------------------------------------");
	printf("  |  Error: Script was loaded incorrectly |");
	printf("  -----------------------------------------");
	printf(" ");
	return 1;
}

public OnFilterScriptExit()
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
	return 1;
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
	switch(dialogid) {
		case 1001: {
			if(response == 1) {
				PlayerInfo[playerid][player_perk] = listitem;
				TogglePlayerSpectating(playerid, false);
				PlayerInfo[playerid][player_change_team] = false;
				PlayerInfo[playerid][player_change_class] = false;
			} else {
				ForcePerkSelection(playerid);
			}
		}
	}
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
	switch(pickupid) {
		case 0: {
			if(PickupInfo[pickupid][is_picked_up] == false) {
				SendClientMessage(playerid, -1, "Bomb was picked up");
				PlayerInfo[playerid][is_carrying_bomb] = true;
				PickupInfo[pickupid][is_picked_up] = true;
			}
			else {
				SendClientMessage(playerid, 0xFFFF0000, "Bomb was already picked up");	
			}
		}
	}
	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	new string[28];
	format(string, sizeof(string), "You've entered checkpoint %d", checkpointid);
	SendClientMessage(playerid, 0xFFFF0000, string);
	switch(checkpointid) {
		case 1..2: {
			if(CPInfo[checkpointid][occupied]) {
				SendClientMessage(playerid, 0xFFFF00FF, "Checkpoint is occupied by other player!");
			}
			else {
				CPInfo[checkpointid][occupied] = true;
				if(PlayerInfo[playerid][is_carrying_bomb] && CPInfo[checkpointid][is_active] == false) {
					CPInfo[checkpointid][cp_player] = playerid;
					CPInfo[checkpointid][cp_team] = GetPlayerTeam(playerid);
					ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, false, false, false, true, 2670, SYNC_ALL);
					SendClientMessageToAll(0xFFFF00FF, "Bomb has been planted!");
					CPInfo[checkpointid][cp_bomb_timer] = SetTimerEx("DestroyPickupBomb", 40*1000, false, "ii",	checkpointid, playerid);
					CPInfo[checkpointid][is_active] = true;
					PlayerInfo[playerid][is_carrying_bomb] = false;
				}
				if(CPInfo[checkpointid][cp_team] != GetPlayerTeam(playerid) && CPInfo[checkpointid][is_active])
				{
					CPInfo[checkpointid][cp_player] = playerid;
					ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, false, false, false, true, 2670, SYNC_ALL);
					SendClientMessageToAll(0xFFFF00FF, "Bomb is being defused!");
					CPInfo[checkpointid][cp_defuse_timer] = SetTimerEx("DefusePickupBomb", 10*1000, false, "ii", checkpointid, playerid);
				}
			}	
		}	
	}
}

public OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
	CPInfo[checkpointid][occupied] = false;
	switch(checkpointid) {
		case 1..2: {
			if(CPInfo[checkpointid][cp_player] == playerid && CPInfo[checkpointid][cp_defuse_timer] != -1)
			{
				SendClientMessage(playerid, 0xFFFF00FF, "Bomb defusing has been interrupted!");
				KillTimer(CPInfo[checkpointid][cp_defuse_timer]);
				CPInfo[checkpointid][cp_defuse_timer] = -1;
				
			}
		}	
	}
}

forward DestroyPickupBomb(checkpointid, playerid);
public DestroyPickupBomb(checkpointid, playerid)
{
	SendClientMessageToAll(0xFFFF00FF, "Bomb has been exploded!");
	CreateExplosion(CPInfo[checkpointid][cp_x], CPInfo[checkpointid][cp_y], CPInfo[checkpointid][cp_z], 6, 50);
	
	KillTimer(CPInfo[checkpointid][cp_bomb_timer]);
	KillTimer(CPInfo[checkpointid][cp_defuse_timer]);
	CPInfo[checkpointid][cp_bomb_timer] = -1;
	CPInfo[checkpointid][cp_defuse_timer] = -1;
	
	CPInfo[checkpointid][is_active] = false;
	CPInfo[checkpointid][cp_team] = -1;
	PickupInfo[0][is_picked_up] = false;
	PickupInfo[0][picked_up_by_team] = -1;
	new player_score = GetPlayerScore(playerid);
	SetPlayerScore(playerid, player_score + 10);
}

forward DefusePickupBomb(checkpointid, playerid);
public DefusePickupBomb(checkpointid, playerid)
{
	SendClientMessageToAll(0xFFFF00FF, "Bomb has been defused!");
	
	KillTimer(CPInfo[checkpointid][cp_bomb_timer]);
	KillTimer(CPInfo[checkpointid][cp_defuse_timer]);
	CPInfo[checkpointid][cp_bomb_timer] = -1;
	CPInfo[checkpointid][cp_defuse_timer] = -1;
	
	CPInfo[checkpointid][is_active] = false;
	CPInfo[checkpointid][cp_team] = -1;
	PickupInfo[0][is_picked_up] = false;
	PickupInfo[0][picked_up_by_team] = -1;
	PlayerInfo[playerid][is_carrying_bomb] = false;
	new player_score = GetPlayerScore(playerid);
	SetPlayerScore(playerid, player_score + 10);
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
	return 0;
}

public OnPlayerWeaponShot(playerid, WEAPON:weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	switch(weaponid) {
		case WEAPON_SILENCED: {
			if(fX != 0 || fY != 0 || fZ != 0) {
				CreateExplosion(fX, fY, fZ, 1, 3);
			}
			return 0;
		}
		case WEAPON_DEAGLE: {
			new Float:hX, Float:hY, Float:hZ,
				Float:oX, Float:oY, Float:oZ,
				Float:nX, Float:nY, Float:nZ,
				Float:angular_velocity = 1,
				Float:linear_velocity = 1,
				Float:player_velocity = 10;
			switch(hittype) {
				case BULLET_HIT_TYPE_PLAYER: {
					GetPlayerPos(playerid, oX, oY, oZ);
					GetPlayerPos(hitid, hX, hY, hZ);
					new Float:dist = floatsqroot(floatpower(hX - oX, 2) + floatpower(hY - oY, 2) + floatpower(hZ - oZ, 2));
					nX = (hX - oX) / dist;
					nY = (hY - oY) / dist;
					nZ = (hZ - oZ) / dist;
					SetPlayerVelocity(hitid, nX * player_velocity, nY * player_velocity, floatabs(nZ * player_velocity));
				}
				case BULLET_HIT_TYPE_VEHICLE: {
					if(IsVehicleOccupied(hitid)) {
						GetPlayerPos(playerid, oX, oY, oZ);
						GetVehiclePos(hitid, hX, hY, hZ);
						new Float:dist = floatsqroot(floatpower(hX - oX, 2) + floatpower(hY - oY, 2) + floatpower(hZ - oZ, 2));
						nX = (hX - oX) / dist;
						nY = (hY - oY) / dist;
						nZ = (hZ - oZ) / dist;
						SetVehicleVelocity(hitid, nX * linear_velocity, nY * linear_velocity, floatabs(nZ * linear_velocity));
						SetVehicleAngularVelocity(hitid, nX * angular_velocity, nY * angular_velocity, nZ * angular_velocity);
					}
				}			
			}
			return 0;
		}
	}
	return 1;
}

forward DestroyDeagleObject(objectid);
public DestroyDeagleObject(objectid) {
	new
    Float:fX, Float:fY, Float:fZ;
	GetObjectPos(objectid, fX, fY, fZ);
	DestroyObject(objectid);
	CreateExplosion(fX, fY, fZ, 0, 5);
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

