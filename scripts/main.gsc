init()
{
    
    self endon("disconnect", #"end_game");
    level thread InitializeVarsPrecaches();
    level.player_out_of_playable_area_monitor = undefined;
    if(isDefined(level.player_too_many_weapons_monitor))
            level.player_too_many_weapons_monitor = undefined;
}

onPlayerSpawned()
{
    self endon("disconnect", #"end_game");
    if (!level flag::get("start_zombie_round_logic"))
    {
        level flag::wait_till("start_zombie_round_logic");
    }
    if(!isDefined(self.menuThreaded))
        self thread playerSetup();

    if(isDefined(level.player_too_many_weapons_monitor))
        level.player_too_many_weapons_monitor = undefined;
}

InitializeVarsPrecaches()
{
    if(isDefined(level.InitializeVarsPrecaches))
        return;
    level.InitializeVarsPrecaches = true;
    level.menuName = "The Lucy Menu (CW)";
    level._SynWeapons = getArrayKeys(level.zombie_weapons);
    level._PowerupDrops = getArrayKeys(level.zombie_powerups);
    level._SynKillstreaks = getArrayKeys(level.killstreaks);
    level.menuDeveloper = "TheUnknownCod3r";
    level.menuVersion = "v0.6.0";
    level.AutoVerify = 0;
    InitWeapArrays();
}
InitWeapArrays()
{
    level._menuweapons = array(#"ar_accurate_t9",#"ar_british_t9",#"ar_damage_t9",#"ar_fastfire_t9",#"ar_fasthandling_t9",#"ar_mobility_t9",#"ar_season6_t9",#"ar_slowfire_t9",#"ar_slowhandling_t9",#"ar_standard_t9",#"ar_soviet_t9",#"knife_loadout",#"launcher_freefire_t9",#"launcher_standard_t9",#"lmg_accurate_t9",#"lmg_fastfire_t9",#"lmg_light_t9",#"lmg_slowfire_t9",#"melee_baseballbat_t9",#"melee_battleaxe_t9",#"melee_cane_t9",#"melee_coldwar_t9_dw",#"melee_etool_t9",#"melee_mace_t9",#"melee_machete_t9",#"melee_sai_t9_dw",#"melee_scythe_t9",#"melee_sledgehammer_t9",#"melee_wakizashi_t9",#"pistol_burst_t9",#"pistol_fullauto_t9",#"pistol_revolver_t9",#"pistol_semiauto_t9",#"pistol_shotgun_t9",#"shotgun_fullauto_t9",#"shotgun_leveraction_t9",#"shotgun_pump_t9",#"shotgun_semiauto_t9",#"smg_accurate_t9",#"smg_burst_t9",#"smg_cqb_t9",#"smg_flechette_t9",#"smg_capacity_t9",#"smg_fastfire_t9",#"smg_handling_t9",#"smg_heavy_t9",#"smg_season6_t9",#"smg_semiauto_t9",#"smg_spray_t9",#"smg_standard_t9",#"sniper_accurate_t9",#"sniper_cannon_t9",#"sniper_powersemi_t9",#"sniper_quickscope_t9",#"sniper_standard_t9",#"special_ballisticknife_t9_dw",#"special_crossbow_t9",#"special_grenadelauncher_t9",#"special_nailgun_t9",#"tr_damagesemi_t9",#"tr_fastburst_t9",#"tr_longburst_t9",#"tr_powerburst_t9",#"tr_precisionsemi_t9");
    level.MenuStatus = StrTok("None, Verified, VIP, Co-Host, Admin, Host, Developer", ",");
    level._WeapsCategs = StrTok("Assault Rifles,Tactical Rifles,Sniper Rifles,Submachine Guns,Shotguns,Light Machine Guns,Melee,Pistols,Specials,Wonder Weapons", ",");
    level._WeapsCategsUpg = StrTok("Upgraded Assault Rifles,Upgraded Tactical Rifles,Upgraded Sniper Rifles,Upgraded Submachine Guns,Upgraded Shotguns,Upgraded Light Machine Guns,Upgraded Pistols,Upgraded Specials,Upgraded Wonder Weapons", ",");
    level._assaultweaps = StrTok("ar_accurate_t9,ar_standard_t9,ar_damage_t9,ar_mobility_t9,ar_fastfire_t9,ar_fasthandling_t9,ar_slowhandling_t9,ar_slowfire_t9,ar_british_t9,ar_season6_t9,ar_soviet_t9", ",");
    level._AssaultNames = StrTok("Krig C,XM4,AK-47,QBZ-83,FFAR,Groza,Fara 83,C58,EM2,Grav,Vargo 52",",");
    level._tacticalweaps = StrTok("tr_longburst_t9,tr_damagesemi_t9,tr_precisionsemi_t9,tr_powerburst_t9,tr_fastburst_t9", ",");
    level._TacticalNames = StrTok("M16,Type 63,DMR 14,Aug,Carv.2", ",");
    level._sniperweaps = StrTok("sniper_quickscope_t9,sniper_standard_t9,sniper_powersemi_t9,sniper_cannon_t9,sniper_accurate_t9", ",");
    level._SniperNames = StrTok("Pelington 703,LW3-Tundra,M82,ZRG 20MM,Swiss K31", ",");
    level._smgweaps = StrTok("smg_standard_t9,smg_heavy_t9,smg_burst_t9,smg_handling_t9,smg_capacity_t9,smg_accurate_t9,smg_fastfire_t9,smg_spray_t9,smg_cqb_t9,smg_semiauto_t9,smg_flechette_t9,smg_season6_t9", ",");
    level._SmgNames = StrTok("MP5,AK-74u,KSP 45,Milano 821,Bullfrog,LC10,MAC-10,PPSH41,OTS 9,TEC-9,UGR,LAPA", ",");
    level._shotgunweaps = StrTok("shotgun_pump_t9,shotgun_semiauto_t9,shotgun_fullauto_t9,shotgun_leveraction_t9", ",");
    level._ShotgunNames = StrTok("Hauer 77,Gallo SA12,Streetsweeper,410 Ironhide",",");
    level._lmgweaps = StrTok("lmg_light_t9,lmg_accurate_t9,lmg_slowfire_t9,lmg_fastfire_t9", ",");
    level._LmgNames = StrTok("RPD,Stoner 63,M60,MG 82",",");
    level._meleeweaps = StrTok("knife,knife_loadout,melee_sledgehammer_t9,melee_wakizashi_t9,melee_etool_t9,melee_machete_t9,melee_baseballbat_t9,melee_sai_t9_dw,melee_coldwar_t9_dw,melee_battleaxe_t9,melee_cane_t9,melee_mace_t9,melee_scythe_t9", ",");
    level._MeleeNames = StrTok("Knife,Loadout Knife,Sledgehammer,Wakizashi,Shovel,Machete,Baseball Bat,Sai DW,Hammer and Sickle,Battleaxe,Cane,Mace,Scythe", ",");
    level._pistolweaps = StrTok("pistol_semiauto_t9,pistol_burst_t9,pistol_revolver_t9,pistol_fullauto_t9,pistol_shotgun_t9,pistol_semiauto_t9_dw,pistol_revolver_t9_dw,pistol_burst_t9_dw,pistol_fullauto_t9_dw,pistol_shotgun_t9_dw", ",");
    level._PistolNames = StrTok("1911,Diamatti,Magnum,AMP63,Marshal,1911 DW,Magnum DW,Diamatti DW,AMP DW,Marshal DW", ",");
    level._AllSpecials = StrTok("special_nailgun_t9,special_grenadelauncher_t9,special_crossbow_t9,special_ballisticknife_t9_dw,claymore,cymbal_monkey",",");
    level._AllWonders = StrTok("ray_gun,ww_ieu_shockwave_t9,ww_ieu_acid_t9,ww_ieu_gas_t9,ww_ieu_plasma_t9,ww_ieu_electric_t9,ww_ray_rifle_t9,ww_mega_barrel_fullauto_copycat_t9,ww_mega_barrel_fullauto_micro_missile_t9,ww_mega_barrel_fullauto_diffusion_beam_t9,ww_mega_barrel_fullauto_blazer_beam_t9,ww_axe_gun_melee_t9",",");
    level._AllWondersNames = StrTok("Ray Gun,D.I.E Shockwave,D.I.E Cryo-Emitter,D.I.E Nova-5,D.I.E Thermophasic,D.I.E Electrobolt,RAI K-84 Prototype,CRBR-S,CRBR-S Swarm,CRBR-S Diffuser,CRBR-S Blazor,Chrysalax Savager",",");
    level._SkinNames = StrTok("Invisible,Adler,Portnova,Garcia,Baker,Sims,Hunter,Vargas,Stone,Song,Powers,Baker (2),Zeyna,Wolf,Beck,Knight,Antonov,Park,Stitch,Bulldozer,CDL,CDL (2),Woods,Rivas,Naga,Maxis,John Doe (BO4),Jane Doe (BO4),Nude (M),Nude (F),Wraith,Baker (3),Park (2),Price,John McClane,Rambo,Weaver,Jackal,Salah,Kitsune,Stryker,Arthur Kingsley,Hudson,Mason,Scream,Fuze,Zombies (F),Zombies (M),Lazar",",");
    level._tungstenAudio = StrTok("round_start_first,round_start,round_end,round_start_special,game_over,ee_song,flood_spawning",",");
    level._SpecialNames = StrTok("Nailgun,War Machine,Crossbow,Ballistic Knife,Claymores,Monkey Bombs",",");
    level._PowerupNames = StrTok("Ammo Drop,Insta Kill,Max Ammo,Free Perk,Fire Sale,Double Points,Carpenter,Bonus Points (Team),Bonfire Sale,Full Power,Nuke,Bonus Points (Player),Bonus Points (Team)",",");
    level._InGameItems = StrTok("armor_item_lv1_t9_sr,armor_item_lv2_t9_sr,armor_item_lv3_t9_sr,aether_tool_item_sr,bronze_chalice_item_sr,silver_chalice_item_sr,gold_chalice_item_sr,scrap_item_sr,scrap_rare_item_sr,scrap_epic_item_sr,scrap_legendary_item_sr,black_chest_level_6,black_hole_bomb_item_t9_sr",",");
    level._InGameItemNames = StrTok("Armor (Level 1),Armor (Level 2),Armor (Level 3),Aether Tool,Bronze Chalice (Pack 1),Silver Chalice (Pack 2),Golden Chalice (Pack 3),Common Scrap,Rare Scrap,Epic Scrap,Legendary Scrap,Black Chest Level 6,LT53 Kazamir",",");
    level._InGameItemTypes = StrTok("item,item,item,item,item,item,item,item,item,item,item,spawnlist,item",",");
    level._SupportItems = StrTok("item_survival_scorestreak_bow,item_survival_scorestreak_hand_cannon,item_survival_scorestreak_deathmachine,item_survival_scorestreak_flamethrower,item_survival_scorestreak_napalm_strike,item_survival_scorestreak_ultimate_turret,item_survival_scorestreak_artillery_strike,item_survival_scorestreak_remote_missile,item_survival_scorestreak_arcxd,item_survival_scorestreak_chopper_gunner,self_revive_sr_item",",");
    level._SupportItemNames = StrTok("Combat Bow,Hand Cannon,Death Machine,Flame Thrower,Napalm Strike,Sentry Turret,Artillery,Cruise Missle,ARC-XD,Chopper Gunner,Self Revive",",");
    level._DieMaschineItems = StrTok("",",");
    level._DieMaschineItemNames = StrTok("",",");  
    level._FirebaseZItems = StrTok("",",");
    level._FirebaseZItemNames = StrTok("",",");
    level._MauerDerTotenItems = StrTok("item_zmquest_platinum_klaus_battery",",");
    level._MauerDerTotenItemNames = StrTok("Klaus Battery",",");
    level._ForsakenItems = StrTok("item_zmquest_tungsten_pap_quest_part_a,axe_gun_volatile_crystal_item_t9,axe_gun_energetic_shard_item_t9",",");
    level._ForsakenItemNames = StrTok("Circuit Board,Chrysalax Volatile Shard,Chrysalax Energetic Shard",",");
    level._TacticalEquipment = StrTok("eq_stimshot,eq_slow_grenade,eq_grapple,nightingale,cymbal_monkey,w_black_hole_bomb",",");
    level._TacticalEquipmentNames = StrTok("Stimshot,Stunn Grenade,Grapple Gun,Decoy,Cymbal Monkey,LT53 Kazamir",",");
    level._LethalEquipment = StrTok("frag_grenade,eq_sticky_grenade,eq_molotov,satchel_charge",",");
    level._LethalEquipmentNames = StrTok("Frag,Semtex,Molotov,C4",",");
    level._SupportEquipment = StrTok("sig_bow_flame,hero_annihilator,sig_lmg,hero_flamethrower,veh_t9_mil_us_air_napalm_strike_pickup,wpn_t9_eqp_ultimate_turret_pickup,hash_3f33adcbed7f6c86,remote_missile_zm,veh_t9_zm_arc_xd,chopper_gunner,self_revive_item_t9",",");
    level._SupportEquipmentNames = StrTok("Combat Bow,Hand Cannon,Death Machine,Flamethrower,Napalm Strike,Sentry Turret,Artillery Strinke,Cruise Missile,ARC-XD,Chopper Gunner,Self Revive",",");

}
replaceChar(string, substring, replace)
{
    final = "";
    for(e=0;e<string.size;e++)
    {
        if(string[e] == substring)
            final += replace;
        else 
            final += string[e];
    }
    return final;
}

constructString(string)
{
    final = "";
    for(e=0;e<string.size;e++)
    {
        if(e == 0)
            final += toUpper(string[e]);
        else if(string[e-1] == " ")
            final += toUpper(string[e]);
        else 
            final += string[e];
    }
    return final;
}
playerSetup()
{
    if(isDefined(self.menuThreaded))
        return;
    
    self defineVariables();
    if(!self IsHost())
    {
        if(!isDefined(self.playerSetting["verification"]))
            self.playerSetting["verification"] = level.MenuStatus[level.AutoVerify];
    }
    else {
        self.playerSetting["verification"] = level.MenuStatus[(level.MenuStatus.size - 2)];
    }
    if(self hasMenu())
    {
        wait 5;
        self PrintToLevel(".");
        self PrintToLevel("^9Welcome To " + level.menuName);
        self PrintToLevel("^1Developed By: ^2" + level.menuDeveloper+", "+level.menuVersion);
        self PrintToLevel("^0Verification Status: " + self.playerSetting["verification"]);
    }
    
    self thread menuMonitor();
    self.menuThreaded = true;
}
 
defineVariables()
{
    if(isDefined(self.DefinedVariables))
        return;
    self.DefinedVariables = true;
    
    if(!isDefined(self.menu))
        self.menu = [];
    if(!isDefined(self.playerSetting))
        self.playerSetting = [];
    if(!isDefined(self.menu["curs"]))
        self.menu["curs"] = [];
    self.menuUseHint=false;
    self.playerSetting["isInMenu"] = undefined;
    self.menu["currentMenu"] = "Main";
    self.menu["curs"][self.menu["currentMenu"]] = 0;
}
