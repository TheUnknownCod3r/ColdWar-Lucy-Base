#include scripts\zm_common\gametypes\dev.gsc;

/*
###########################################
Developer Modifications
Most of these are likely untested
###########################################
*/

SetCustomXPMultiplier(value)//seems to work? game is borky anyway
{
    if(!self isHost()){ self PrintToLevel("^1[ERROR]^5Only the Host can Change XP Rate"); level.players[0] printToLevel(self.name+" Just tried to change XP Rate"); return; }
    else {
    if(value > 0)
    {
        self PrintToLevel("Custom XP Rate Enabled at "+value+"x", true);
        level.customXPValue = value;
        level.var_3426461d = &GetXPMultiplier;
        
    }
    else
    {
        level.customXPValue = undefined;
        self PrintToLevel("^5XP Modifier ^1Disabled");
        level.var_3426461d = &GetXPMultiplier; 
    }
    }
}

TestOption()
{
    self PrintToLevel("Test");
}

AntiQuit()
{
    if(!isDefined(self.AntiQuit))
    {
        self.AntiQuit = true;
        SetMatchFlag("disableIngameMenu", 1);
        self iprintlnbold("Anti Quit: [^2On^7]");
        foreach(player in level.players)
        {
            self CloseInGameMenu();
        }
    }
    else 
    {
        self.AntiQuit = undefined;
        SetMatchFlag("disableIngameMenu", 0);
        self iprintlnbold("Anti Quit: [^1Off^7]");
    }
}

TurnOnPower()
{
    level flag::set("power_on");
    level clientfield::set("zombie_power_on", 1);
    power_trigs = getentarray("use_elec_switch", "targetname");
    foreach (trig in power_trigs) {
        if (isdefined(trig.script_int)) {
            level flag::set("power_on" + trig.script_int);
            level clientfield::set("zombie_power_on", trig.script_int + 1);
        }
    }
    self PrintToLevel("^5Power ^2Enabled");
}

OpenAllDoors() {//works fine, credit ate47, same as bo4
    setdvar(#"zombie_unlock_all", 1);
    players = getplayers();
    zombie_doors = getentarray("zombie_door", "targetname");
    for (i = 0; i < zombie_doors.size; i++) {
        if (!is_true(zombie_doors[i].has_been_opened)) {
            zombie_doors[i] notify(#"trigger", {#activator:players[0]});
        }
        if (is_true(zombie_doors[i].power_door_ignore_flag_wait)) {
            zombie_doors[i] notify(#"power_on");
        }
        waitframe(1);
    }
    zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
    for (i = 0; i < zombie_airlock_doors.size; i++) {
        zombie_airlock_doors[i] notify(#"trigger", {#activator:players[0]});
        waitframe(1);
    }
    zombie_debris = getentarray("zombie_debris", "targetname");
    for (i = 0; i < zombie_debris.size; i++) {
        if (isdefined(zombie_debris[i])) {
            zombie_debris[i] notify(#"trigger", {#activator:players[0]});
        }
        waitframe(1);
    }
    level notify(#"open_sesame");
    wait(1);
    setdvar(#"zombie_unlock_all", 0);
    self PrintToLevel("^5Doors ^2Opened");
}

ToggleKillAura()//working
{
    self.killAura = isDefined(self.killAura) ? undefined: true;
    if(isDefined(self.killAura))
    {
        self thread KillAura();
        self PrintToLevel("Kill Aura ^2Enabled");
    }
    else
    {
        self notify(#"end_kill_aura");
        self PrintToLevel("Kill Aura ^1Disabled");
    }
}

KillAura()//working
{
    self endon("disconnect", "end_game");
    self endon("end_kill_aura");

    for(;;)
    {
        if(!isDefined(self.KillAuraPos)) self.KillAuraPos = "head";
        zombies = GetAITeamArray(level.zombie_team);
        foreach (zombie in zombies)
        {
            if(distanceSquared(zombie.origin, self.origin) < 150 * 150)
            {
                zombie DoDamage( zombie.health+1, self.origin, self, undefined, self.KillAuraPos ,"MOD_EXPLOSIVE");
                playfx( "zm_weapons/fx9_aat_bul_impact_explosive", zombie.origin+ (0,0,30) );
            }
        }
        wait .05;
    }
}


SetSelfRevives(count)
{
    self zm_laststand::function_3a00302e(count,count);
    self PrintToLevel("^5You just got ^2"+count+" ^5Self Revives!");
}
ChangeKillAuraPos(which)
{
    if(!isDefined(self.killAura)){ self PrintToLevel("Error, Please Enable Kill Aura"); return;}
    switch(which){
        case 1: self.KillAuraPos="head";self PrintToLevel("KillAura Pos Set To: ^2HEAD"); break;
        case 2: self.KillAuraPos="torso_upper";self PrintToLevel("KillAura Pos Set To: ^2Upper Torso"); break;
        case 3: self.KillAuraPos="torso_lower";self PrintToLevel("KillAura Pos Set To: ^2Lower Torso"); break;
        case 4: self.KillAuraPos="right_arm_lower";self PrintToLevel("KillAura Pos Set To: ^2Lower Right Arm"); break;
        case 5: self.KillAuraPos="right_arm_upper";self PrintToLevel("KillAura Pos Set To: ^2Upper Right Arm"); break;
        case 6: self.KillAuraPos="right_hand";self PrintToLevel("KillAura Pos Set To: ^2Right Hand"); break;
        case 7: self.KillAuraPos="left_arm_lower";self PrintToLevel("KillAura Pos Set To: ^2Lower Left Arm"); break;
        case 8: self.KillAuraPos="left_arm_upper";self PrintToLevel("KillAura Pos Set To: ^2Upper Left Arm"); break;
        case 9: self.KillAuraPos="left_hand";self PrintToLevel("KillAura Pos Set To: ^2Left Hand"); break;
        case 10: self.KillAuraPos="left_leg_upper";self PrintToLevel("KillAura Pos Set To: ^2Upper Left Leg"); break;
        case 11: self.KillAuraPos="left_leg_lower";self PrintToLevel("KillAura Pos Set To: ^2Lower Left Leg"); break;
        case 12: self.KillAuraPos="right_leg_upper";self PrintToLevel("KillAura Pos Set To: ^2Upper Right Leg"); break;
        case 13: self.KillAuraPos="right_leg_lower";self PrintToLevel("KillAura Pos Set To: ^2Lower Right Leg"); break;
    }
}
ChangeMap(Mapname)
{
    self PrintToLevel("Map Changing To "+Mapname);
    wait 0.5;
    setDvar("ls_mapname", Mapname);
    setDvar("mapname", Mapname);
    setDvar("party_mapname", Mapname);
    setDvar("ui_mapname", Mapname);
    setDvar("ui_currentmap", Mapname);
    setDvar("ui_previewmap", Mapname);
    setDvar("ui_showmap", Mapname);
    map(Mapname);
    wait .1;
    switchmap_switch();
}


ForceHostToggle()
{
    // Toggle flag
    self.ForcingTheHost = isDefined(self.ForcingTheHost) ? undefined : true;

    if(isDefined(self.ForcingTheHost))
    {
        self PrintToLevel("Force Host ^2ON");

        // Start thread to apply Dvars repeatedly
        self thread ForceHostThread();
    }
    else
    {
        self PrintToLevel("Force Host ^1OFF");
        self notify("stop_forcing_host");
        // Reset Dvars to default safe values
        SetDvar("lobbySearchListenCountries", "");
        SetDvar("excellentPing", 30);
        SetDvar("goodPing", 100);
        SetDvar("terriblePing", 500);
        SetDvar("migration_forceHost", 0);
        SetDvar("migration_minclientcount", 2);
        SetDvar("party_connectToOthers", 1);
        SetDvar("party_dedicatedMergeMinPlayers", 2);
        SetDvar("party_forceMigrateAfterRound", 0);
        SetDvar("party_forceMigrateOnMatchStartRegression", 0);
        SetDvar("party_joinInProgressAllowed", 1);
        SetDvar("allowAllNAT", 1);
        SetDvar("party_keepPartyAliveWhileMatchmaking", 1);
        SetDvar("party_mergingEnabled", 1);
        SetDvar("party_neverJoinRecent", 0);
        SetDvar("partyMigrate_disabled", 0);
    }
}

ForceHostThread()
{
    self endon("stop_forcing_host"); // You can notify to stop

    for(;;)
    {
        if(!isDefined(self.ForcingTheHost))
            break;

        // Dvars to maximize host chance
        SetDvar("lobbySearchListenCountries", "0,103,6,5,8,13,16,23,25,32,34,24,37,42,44,50,71,74,76,75,82,84,88,31,90,18,35");
        SetDvar("excellentPing", 3);
        SetDvar("goodPing", 4);
        SetDvar("terriblePing", 5);
        SetDvar("migration_forceHost", 1);
        SetDvar("migration_minclientcount", 12);
        SetDvar("party_connectToOthers", 0);
        SetDvar("party_dedicatedOnly", 0);
        SetDvar("party_dedicatedMergeMinPlayers", 12);
        SetDvar("party_forceMigrateAfterRound", 0);
        SetDvar("party_forceMigrateOnMatchStartRegression", 0);
        SetDvar("party_joinInProgressAllowed", 1);
        SetDvar("allowAllNAT", 1);
        SetDvar("party_keepPartyAliveWhileMatchmaking", 1);
        SetDvar("party_mergingEnabled", 0);
        SetDvar("party_neverJoinRecent", 1);
        SetDvar("party_readyPercentRequired", .25);
        SetDvar("partyMigrate_disabled", 1);

        wait 1; // repeat every second
    }
}

PlayAudioOnPlayers(audioName)
{
    level thread zm_audio::sndmusicsystem_stopandflush();
	waitframe(1);
	level thread zm_audio::sndmusicsystem_playstate(audioName);
    self PrintToLevel("^5Now Playing: ^2"+audioName, true);
}

SetPlayerSkin(skinId)//int skinId
{
    self setspecialistindex(skinId);
    self setcharacteroutfit(0);
    self setcharacterwarpaintoutfit(0);
    self function_ab96a9b5("head", 0);
    self function_ab96a9b5("headgear", 0);
    self function_ab96a9b5("arms", 0);
    self function_ab96a9b5("torso", 0);
    self function_ab96a9b5("legs", 0);
    self function_ab96a9b5("palette", 0);
    self function_ab96a9b5("warpaint", 0);
    self function_ab96a9b5("decal", 0);
    self PrintToLevel("^5Skin Changed");
}

TriggerExfil()
{
    level flag::set(#"hash_3e765c26047c9f54" );
}



GetAllItems(itemspawnlist)
{
    list = "";
    for(i=0;i<itemspawnlist.size;i++)
    {
        if (IsSubStr(itemspawnlist[i].itementry, "item_sr"))
        {
            if(i < itemspawnlist.size - 1)
                list += itemspawnlist[i].itementry + ",";
            else
                list += itemspawnlist[i].itementry;
        }
    }
    self PrintToLevel("ITEM LIST: " + list);
    return StrTok(list, ",");
}

GetSpawnItems(itemspawnlist)
{
    list = "";
    for(i=0;i<itemspawnlist.size;i++)
    {
        if (IsSubStr(itemspawnlist[i].itementry, "_list"))
        {
            if(i < itemspawnlist.size - 1)
                list +=  itemspawnlist[i].itementry + ",";
            else
                list += itemspawnlist[i].itementry;
        }
    }
    self PrintToLevel("SPAWN LIST: " + list);
    return StrTok(list, ",");
}