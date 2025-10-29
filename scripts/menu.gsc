runMenuIndex(menu)
{
    self endon("disconnect");

    if(!isDefined(menu))
        menu = "Main";
    
    switch(menu)
    {
        case "Main":
            self addMenu(menu, level.menuName);
            if(self getVerification() > 0)
            {
                self addOpt("Personal Menu", &newMenu, "Personal Menu");
                if(self getVerification() > 1)
                {
                    self addOpt("Weapon Options", &newMenu, "Weapon Options");
                    self addOpt("Item Drops", &newMenu, "Item Drops");
                    self addOpt("Skin Selection", &newMenu, "Skin Selection");
                    self addOpt("Rank / Unlocks", &newMenu, "Rank / Unlocks");
                    if(self getVerification() > 2)
                    {
                        self addOpt("Zombies Options", &newMenu, "Zombies Options");
                        self addOpt("Fun Options", &newMenu, "Fun Options");
                        self addOpt("Powerups Menu", &newMenu, "Powerups");
                        self addOpt("Lobby Manipulation", &newMenu, "Lobby Manipulation");
                        if(self getVerification() > 3)
                        {
                            if(self IsHost() || self getVerification() > 3)
                                self addOpt("Host Menu", &newMenu, "Host Menu");
                                self addOpt("Map Selection", &newMenu, "Map Selection");
                                self addOpt("Player Menu", &newMenu, "Players");
                                self addOpt("All Players Options", &newMenu, "AllClient");
                        }
                    }
                }
            }
            break;
        case "AllClient":
            self addMenu(menu, "All Client Options");
                self addOpt("God Mode", &AllClientOpts, 1);
                self addOpt("Unlimited Ammo", &AllClientOpts, 2);
        break;
        case "Host Menu":
            self addMenu(menu, "Host Menu");
                self addOpt("Fast Restart", &FastRestart);
                self addOpt("Give Chopper Gunner", &GiveKillstreak, "chopper_gunner");
                self addOptIncSlider("Self Revive Count", &SetSelfRevives,0,0,999,1);
                self addOptBool(self.zombiemodels, "Default Actor Zombies", &ZombieModelChanger);
            break;
        case "Map Selection":
            self addMenu(menu, "Map Selection");
                self addOpt("Die Maschine", &ChangeMap, "zm_silver");
                self addOpt("Firebase Z", &ChangeMap, "zm_Gold");
                self addOpt("Mauer Der Toten", &ChangeMap, "zm_platinum");
                self addOpt("Forsaken", &ChangeMap, "zm_tungsten");
            break;
        case "Personal Menu":
            self addMenu(menu, "Personal Menu");
                self addOptBool(self.godmode, "God Mode", &Godmode);
                self addOptBool(self.DrawWithHint, "Switch Menu draw Method", &ToggleDrawMethod);
                self addOptBool(self.Noclip, "No Clip", &ToggleNoClip,self);
                self addOptBool(self.UnlimitedAmmo, "Unlimited Ammo", &UnlimitedAmmo);
                self addOpt("Score Menu", &newMenu, "Score Menu");
                self addOpt("Give All Perks", &GiveAllPerksZM);
                self addOptBool(self.KillAura, "KillAura", &ToggleKillAura);
                self addOptIncSlider("Change Kill Aura Target Point", &ChangeKillAuraPos,1,1,13,1);
        break;
        case "Score Menu":
            self addMenu(menu, "Score Menu");
                self addOpt("Max Out Score", &EditPlayerScore, 99999,self, 1);
                self addOpt("Take All Score", &EditPlayerScore, 0, self, 2);
                self addOptIncSlider("Add to Player Score", &EditPlayerScore, 0, self.score, 99999, 1000, self, 3);
                self addOptIncSlider("Take from Player Score", &EditPlayerScore, 0, self.score, 99999, 1000, self, 4);
        break;
        case "Weapon Options":
            self addMenu(menu, "Weapon Options");
                self addOpt("Weapon Selection", &newMenu, "Weapon Selection");
                self addOpt("Upgrade Weapon Rarity", &UpgradeWeaponRarity);
                self addOpt("Pack a Punch Weapon", &UpgradeWeapon);
                self addOpt("Pack Effects", &newMenu, "Pack Effects");
                self addOptBool(self.magicBullets, "Magic Bullets", &magicbullets);
                self addOptIncSlider("Set Bullet Effect", &changeBulletType, 0,0,4,1);
        break;
        case "Pack Effects":
            self addMenu(menu, "PAP Effects");
                self addOpt("Cryofreeze", &acquireaat, "ammomod_cryofreeze");
                self addOpt("Napalm Burst", &acquireaat, "ammomod_napalmburst");
                self addOpt("Dead Wire", &acquireaat, "ammomod_deadwire");
                self addOpt("Shatter Blast", &acquireaat, "ammomod_shatterblast");
                self addOpt("Electric Cherry", &acquireaat, "ammomod_electriccherry");
                self addOpt("Brain Rot", &acquireaat, "ammomod_brainrot");
        break;
        case "Weapon Selection":
            self addMenu(menu, "Weapon Selection");
                self addOpt("Normal Weapons", &newMenu, "Normal Weapons");
                self addOpt("Upgraded Weapons", &newMenu, "Upgraded Weapons");
        break;
        case "Normal Weapons":
            self addMenu(menu, "Normal Weapons");
                for(i=0;i<level._WeapsCategs.size;i++)
                    self addOpt(level._WeapsCategs[i], &newMenu, level._WeapsCategs[i]);
        break;
        case "Upgraded Weapons":
            self addMenu(menu, "Upgraded Weapons");
                for(z=0;z<level._WeapsCategsUpg.size;z++)
                    self addOpt(level._WeapsCategsUpg[z], &newMenu, level._WeapsCategsUpg[z]);
        break;
        case "Upgraded Assault Rifles":
            self addMenu(menu, "Upgraded Assault Rifles");
                for(z=0;z<level._assaultweaps.size;z++)
                    self addOpt(level._AssaultNames[z], &GiveClientWeapon, level._assaultweaps[z]+"_upgraded", self);
        break;
        case "Assault Rifles":
            self addMenu(menu, "Assault Rifles");
                for(z = 0; z < level._assaultweaps.size; z++)
                    self addOpt(level._AssaultNames[z], &GiveClientWeapon, level._assaultweaps[z], self);
            break;
        case "Tactical Rifles":
            self addMenu(menu, "Tactical Rifles");
                for(z = 0; z < level._tacticalweaps.size; z++)
                    self addOpt(level._TacticalNames[z], &GiveClientWeapon, level._tacticalweaps[z], self);
        break;
        case "Upgraded Tactical Rifles":
            self addMenu(menu, "Upgraded Tactical Rifles");
                for(z = 0; z < level._tacticalweaps.size; z++)
                    self addOpt(level._TacticalNames[z], &GiveClientWeapon, level._tacticalweaps[z]+"_upgraded", self);
        break;
        case "Sniper Rifles":
            self addMenu(menu, "Sniper Rifles");
                for(z = 0; z < level._sniperweaps.size; z++)
                    self addOpt(level._SniperNames[z], &GiveClientWeapon, level._sniperweaps[z], self);
        break;
        case "Upgraded Sniper Rifles":
            self addMenu(menu, "Upgraded Sniper Rifles");
                for(z = 0; z < level._sniperweaps.size; z++)
                    self addOpt(level._SniperNames[z], &GiveClientWeapon, level._sniperweaps[z]+"_upgraded", self);
        break;

        case "Submachine Guns":
            self addMenu(menu, "Submachine Guns");
                for(z = 0; z < level._smgweaps.size; z++)
                    self addOpt(level._SmgNames[z], &GiveClientWeapon, level._smgweaps[z], self);
        break;
        case "Upgraded Submachine Guns":
            self addMenu(menu, "Upgraded Submachine Guns");
                for(z = 0; z < level._smgweaps.size; z++)
                    self addOpt(level._SmgNames[z], &GiveClientWeapon, level._smgweaps[z]+"_upgraded", self);
        break;
        case "Shotguns":
            self addMenu(menu, "Shotguns");
                for(z = 0; z < level._shotgunweaps.size; z++)
                    self addOpt(level._ShotgunNames[z], &GiveClientWeapon, level._shotgunweaps[z], self);
        break;
        case "Upgraded Shotguns":
            self addMenu(menu, "Upgraded Shotguns");
                for(z = 0; z < level._shotgunweaps.size; z++)
                    self addOpt(level._ShotgunNames[z], &GiveClientWeapon, level._shotgunweaps[z]+"_upgraded", self);
        break;

        case "Light Machine Guns":
            self addMenu(menu, "Light Machine Guns");
                for(z = 0; z < level._lmgweaps.size; z++)
                    self addOpt(level._LmgNames[z], &GiveClientWeapon, level._lmgweaps[z], self);
        break;
        
        case "Upgraded Light Machine Guns":
            self addMenu(menu, "Upgraded Light Machine Guns");
                for(z = 0; z < level._lmgweaps.size; z++)
                    self addOpt(level._LmgNames[z], &GiveClientWeapon, level._lmgweaps[z]+"_upgraded", self);
        break;
        case "Melee":
            self addMenu(menu, "Melee");
                for(z = 0; z < level._meleeweaps.size; z++)
                    self addOpt(level._MeleeNames[z], &GiveClientWeapon, level._meleeweaps[z], self);
        break;

        case "Pistols":
            self addMenu(menu, "Pistols");
                for(z = 0; z < level._pistolweaps.size; z++)
                    self addOpt(level._PistolNames[z], &GiveClientWeapon, level._pistolweaps[z], self);
        break;
        case "Upgraded Pistols":
            self addMenu(menu, "Upgraded Pistols");
                for(z = 0; z < level._pistolweaps.size; z++)
                    self addOpt(level._PistolNames[z], &GiveClientWeapon, level._pistolweaps[z]+"_upgraded", self);
        break;
        case "Specials":
            self addMenu(menu, "Special Weapons");
            for(z=0;z<level._AllSpecials.size;z++)
                self addOpt(level._SpecialNames[z], &GiveClientWeapon, level._AllSpecials[z], self);
        break;
        case "Upgraded Specials":
            self addMenu(menu, "Upgraded Special Weapons");
            for(z=0;z<level._AllSpecials.size - 2;z++)//-2 since Claymores and Monkeys can't be upgraded normally
                self addOpt(level._SpecialNames[z], &GiveClientWeapon, level._AllSpecials[z]+"_upgraded", self);
        break;
        case "Wonder Weapons":
            self addMenu(menu, "Wonder Weapons");
            for(z=0;z<level._AllWonders.size;z++)
                self addOpt(level._AllWondersNames[z], &GiveClientWeapon, level._AllWonders[z], self);
        break;
        case "Upgraded Wonder Weapons":
            self addMenu(menu, "Upgraded Wonder Weapons");
            for(z=0;z<level._AllWonders.size;z++)
                self addOpt(level._AllWondersNames[z], &GiveClientWeapon, level._AllWonders[z]+"_upgraded", self);
        break;
        case "Skin Selection":
            self addMenu(menu, "Skin Selection");
                for(t=0;t<49;t++)
                    self addOpt("Skin: "+level._SkinNames[t], &SetPlayerSkin,t);
        break;
        case "Rank / Unlocks":
            self addMenu(menu, "Rank / Unlocks");
                self addOpt("1k Crystals", &GiveCrystals, self);
                self addOpt("Unlock All", &UnlockAll);
                self addOpt("Add 2m XP", &Level55, self);
                self addOpt("Unlock Dark Aether", &UnlockDarkAether, self);
                self addOpt("Unlock Achievs", &UnlockAchievs, self);
                self addOpt("Unlock All Weapons", &UnlockAllWeapons);
                self addOptIncSlider("Change Prestige", &SetCustomPrestige, 0,0,27,1);
                self addOpt("Complete All Contracts", &CompleteActiveContracts, self);
        break;
        case "Zombies Options":
            self addMenu(menu, "Zombies Options");
                self addOptIncSlider("Spawn Zombies: ", &spawn_zombies,1,1,999,1);
                self addOpt("Spawn Elite", &newMenu, "Spawn Elite");
                self addOpt("Kill All Zombies", &KillAllZombies);
                self addOptBool(self.ZombiePos, "Teleport to Crosshair Loop", &StartZombiePosition);
                self addOptBool(self.oneHPZombs, "One Hit Zombies", &OneHPZombs);
        break;
        case "Fun Options":
            self addMenu(menu, "Fun Options");
                self addOptBool(self.ForgeModeON, "Toggle Forge Mode", &ToggleForgeON);
                self addOptBool(self.aimbot, "Toggle Zombies Aimbot", &CW_ToggleAimbot);
                self addOptSlider("Set Box Price", &SetBoxPrice, "0;250;500;900;1500;2500;9999");
                self addOpt("Freeze Box", &FreezeBox);
        break;
        case "Lobby Manipulation":
            self addMenu(menu, "Lobby Manipulation");
                self addOpt("Turn on Power", &TurnOnPower);
                self addOpt("Open All Doors", &OpenAllDoors);
                self addOptBool(level.SuperJump, "Toggle Super Jump", &SuperJump);
                self addOptBool(level.newGrav, "Low Gravity", &LowGrav);
                self addOptIncSlider("Edit Round: ", &EditRound, 0,0,999,1);
                self addOptBool(self.ForcingTheHost, "Force Host", &ForceHostToggle);
                self addOpt("Trigger Exfil", &TriggerExfil);
                self addOpt("Play EE Song", &PlayAudioOnPlayers, "ee_song");
                self addOptIncSlider("Set XP Scale", &SetCustomXPMultiplier, 0,0,100,1);
        break;
        case "Powerups":
            self addMenu(menu, "Powerups");
                for(i=0;i<level._PowerupDrops.size;i++)
                {
                    self addOpt("Give "+level._PowerupNames[i], &GivePowerup, level._PowerupDrops[i]);
                }
        break;
        case "Spawn Elite":
            self addMenu(menu, "Spawn Elite");
                switch(level.script)
                {
                    case "zm_silver":
                        self addOpt("Spawn Plague Hound", &spawn_elite, "spawner_bo5_zombie_dog_plague");
                        self addOpt("Chungus", &spawn_elite, "spawner_zm_steiner");
                        self addOpt("Chungus (Red)", &spawn_elite, "spawner_zm_steiner_hvt_zm_silver");
                        self addOpt("Chungus (Steiner)", &spawn_elite, "spawner_zm_steiner_f");
                    break;
                    case "zm_gold": 
                        self addOpt("Spawn Fire Hound", &spawn_elite, "spawner_bo5_zombie_dog_molotov");
                        self addOpt("Spawn Mimic", &spawn_elite, "spawner_bo5_mimic");
                        self addOpt("Spawn Mangler", &spawn_elite, "spawner_bo5_raz_sr");
                    break;
                    case "zm_platinum":
                        self addOpt("Spawn Tempest", &spawn_elite, "spawner_bo5_avogadro_sr");
                        self addOpt("Spawn Mimic", &spawn_elite, "spawner_bo5_mimic");
                        self addOpt("Spawn Mangler", &spawn_elite, "spawner_bo5_raz_sr");
                        self addOpt("Spawn Disciple", &spawn_elite, "spawner_bo5_soa");
                        self addOpt("Spawn Mech", &spawn_elite, "spawner_bo5_mechz_sr");
                    break;
                    case "zm_tungsten":
                        self addOpt("Spawn Ronnie Raygun", &spawn_elite, "spawner_bo5_zombie_sr_ronnie_raygun");
                        self addOpt("Spawn Plague Hound", &spawn_elite, "spawner_bo5_zombie_dog_plague");
                        self addOpt("Spawn Fire Hound", &spawn_elite, "spawner_bo5_zombie_dog_molotov");
                        self addOpt("Spawn Tormentor", &spawn_elite, "spawner_zm_tormentor");
                        self addOpt("Spawn Tempest", &spawn_elite, "spawner_bo5_avogadro_sr");
                        self addOpt("Spawn Mimic", &spawn_elite, "spawner_bo5_mimic");
                        self addOpt("Spawn Disciple", &spawn_elite, "spawner_bo5_soa");
                        self addOpt("Spawn Mangler", &spawn_elite, "spawner_bo5_raz_sr");
                        self addOpt("Spawn Mech", &spawn_elite, "spawner_bo5_mechz_sr");
                        self addOpt("Spawn Abomination", &spawn_elite, "spawner_bo5_abom");
                    break;
                    default:
                        self addOpt("Spawn Plague Hound", &spawn_elite, "spawner_bo5_zombie_dog_plague");
                        self addOpt("Spawn Fire Hound", &spawn_elite, "spawner_bo5_zombie_dog_molotov");
                        self addOpt("Spawn Tormentor", &spawn_elite, "spawner_zm_tormentor");
                        self addOpt("Spawn Tempest", &spawn_elite, "spawner_bo5_avogadro_sr");
                        self addOpt("Spawn Mimic", &spawn_elite, "spawner_bo5_mimic");
                        self addOpt("Spawn Mimic(hvt)", &spawn_elite, "spawner_bo5_mimic_hvt");
                        self addOpt("Spawn Disciple", &spawn_elite, "spawner_bo5_soa");
                        self addOpt("Spawn Mangler", &spawn_elite, "spawner_bo5_raz_sr");
                        self addOpt("Spawn Mangler(hvt)", &spawn_elite, "spawner_bo5_raz_sr_hvt");
                        self addOpt("Split Chunges Blast", &spawn_elite, "spawner_zm_steiner_split_radiation_blast");
                        self addOpt("Split Chunges Blast(hvt)", &spawn_elite, "spawner_zm_steiner_split_radiation_blast_hvt");
                        self addOpt("Split Chunges Bomb", &spawn_elite, "spawner_zm_steiner_split_radiation_bomb_hvt");
                        self addOpt("Split Chunges Bomb(hvt)", &spawn_elite, "spawner_zm_steiner_split_radiation_bomb");
                        self addOpt("Chungus", &spawn_elite, "spawner_zm_steiner");
                        self addOpt("Chungus(hvt)", &spawn_elite, "spawner_zm_steiner_hvt");
                        self addOpt("Chungus (Red)", &spawn_elite, "spawner_zm_steiner_hvt_zm_silver");
                        self addOpt("Chungus (Steiner)", &spawn_elite, "spawner_zm_steiner_f");
                        self addOpt("Spawn Mech", &spawn_elite, "spawner_bo5_mechz_sr");
                        self addOpt("Spawn Mech(hvt)", &spawn_elite, "spawner_bo5_mechz_sr_hvt");
                        self addOpt("Spawn Abomination", &spawn_elite, "spawner_bo5_abom");
                        self addOpt("Spawn Abomination(hvt)", &spawn_elite, "spawner_bo5_abom_hvt");
                        self addOpt("Spawn Hulk", &spawn_elite,"spawner_bo5_hulk");
                    break;
                }
        break;
        case "Item Drops":
            self addMenu(menu, "Item Drops");
                self addOpt("In-Game", &newMenu, "In-Game");
                self addOpt("Weapons", &newMenu, "Weapons");
                self addOpt("Support", &newMenu, "Support");
                self addOpt("Easter Eggs", &newMenu, "Easter Eggs");
                //self addOpt("Super Drop", &SuperDrop);
        break;
        case "In-Game":
            self addMenu(menu, "In-Game");
                for(z=0;z<level._InGameItems.size;z++)
                    self addOpt(level._InGameItemNames[z], &DropItem, level._InGameItems[z], level._InGameItemTypes[z], 1, self);
        break;
        case "Weapons":
            self addMenu(menu, "Weapons");
                self addOpt("Normal Weapons Drops", &newMenu, "Normal Weapons Drops");
                self addOpt("Upgraded Weapons Drops", &newMenu, "Upgraded Weapons Drops");
        break;
        case "Support":
            self addMenu(menu, "Support");
                for(z=0;z<level._SupportItems.size;z++)
                    self addOpt(level._SupportItemNames[z], &DropItem, level._SupportItems[z], 1, "item", self);
        break;
        case "Normal Weapons Drops":
            self addMenu(menu, "Normal Weapons Drops");
                for(i=0;i<level._WeapsCategs.size;i++)
                    self addOpt(level._WeapsCategs[i], &newMenu, level._WeapsCategs[i] + " Drops");
        break;
        case "Upgraded Weapons Drops":
            self addMenu(menu, "Upgraded Weapons Drops");
                for(z=0;z<level._WeapsCategsUpg.size;z++)
                    self addOpt(level._WeapsCategsUpg[z], &newMenu, level._WeapsCategsUpg[z] + " Drops");
        break;
        case "Assault Rifles Drops":
            self addMenu(menu, "Assault Rifles Drops");
                for(z = 0; z < level._assaultweaps.size; z++)
                    self addOpt(level._AssaultNames[z], &DropItem, level._assaultweaps[z] + "_orange_item_sr", "weapon", 1, self);
        break;
        case "Tactical Rifles Drops":
            self addMenu(menu, "Tactical Rifles Drops");
                for(z = 0; z < level._tacticalweaps.size; z++)
                    self addOpt(level._TacticalNames[z], &DropItem, level._tacticalweaps[z] + "_orange_item_sr", "weapon", 1, self);
        break;
        case "Sniper Rifles Drops":
            self addMenu(menu, "Sniper Rifles Drops");
                for(z = 0; z < level._sniperweaps.size; z++)
                    self addOpt(level._SniperNames[z], &DropItem, level._sniperweaps[z] + "_orange_item_sr", "weapon", 1, self);
        break;
        case "Submachine Guns Drops":
            self addMenu(menu, "Submachine Guns Drops");
                for(z = 0; z < level._smgweaps.size; z++)
                    self addOpt(level._SmgNames[z], &DropItem, level._smgweaps[z] + "_orange_item_sr", "weapon", 1, self);
        break;
        case "Shotguns Drops":
            self addMenu(menu, "Shotguns Drops");
                for(z = 0; z < level._shotgunweaps.size; z++)
                    self addOpt(level._ShotgunNames[z], &DropItem, level._shotgunweaps[z] + "_orange_item_sr", "weapon", 1, self);
        break;
        case "Light Machine Guns Drops":
            self addMenu(menu, "Light Machine Guns Drops");
                for(z = 0; z < level._lmgweaps.size; z++)
                    self addOpt(level._LmgNames[z], &DropItem, level._lmgweaps[z] + "_orange_item_sr", "weapon", 1, self);
        break;
        case "Melee Drops":
            self addMenu(menu, "Melee Drops");
                for(z = 0; z < level._meleeweaps.size; z++)
                    self addOpt(level._MeleeNames[z], &DropItem, level._meleeweaps[z] + "_orange_item_sr", "weapon", 1, self);
        break;
        case "Pistols Drops":
            self addMenu(menu, "Pistols Drops");
                for(z = 0; z < level._pistolweaps.size; z++)
                    self addOpt(level._PistolNames[z], &DropItem, level._pistolweaps[z] + "_orange_item_sr", "weapon", 1, self);
        break;
        case "Specials Drops":
            self addMenu(menu, "Special Weapons Drops");
                for(z=0;z<level._AllWonders.size;z++)
                    self addOpt(level._AllWonders[z], &DropItem, level._AllWonders[z] + "_orange_item_sr", "weapon", 1, self);
        break;
        case "Wonder Weapons Drops":
            self addMenu(menu, "Wonder Weapons Drops");
                for(z=0;z<level._PlatinumWonders.size;z++)
                    self addOpt(level._PlatinumWondersNames[z], &DropItem, level._PlatinumWonders[z] + "_item_sr", "weapon", 1, self);
        break;
        case "Upgraded Assault Rifles Drops":
            self addMenu(menu, "Upgraded Assault Rifles Drops");
                for(z=0;z<level._assaultweaps.size;z++)
                    self addOpt(level._AssaultNames[z], &DropItem, level._assaultweaps[z] + "_orange_upgraded_item_sr", "weapon", 1, self);
        break;
        case "Upgraded Tactical Rifles Drops":
            self addMenu(menu, "Upgraded Tactical Rifles Drops");
                for(z = 0; z < level._tacticalweaps.size; z++)
                    self addOpt(level._TacticalNames[z], &DropItem, level._tacticalweaps[z] + "_orange_upgraded_item_sr", "weapon", 1, self);
        break;
        case "Upgraded Sniper Rifles Drops":
            self addMenu(menu, "Upgraded Sniper Rifles Drops");
                for(z = 0; z < level._sniperweaps.size; z++)
                    self addOpt(level._SniperNames[z], &DropItem, level._sniperweaps[z] + "_orange_upgraded_item_sr", "weapon", 1, self);
        break;
        case "Upgraded Submachine Guns Drops":
            self addMenu(menu, "Upgraded Submachine Guns Drops");
                for(z = 0; z < level._smgweaps.size; z++)
                    self addOpt(level._SmgNames[z], &DropItem, level._smgweaps[z] + "_orange_upgraded_item_sr", "weapon", 1, self);
        break;
        case "Upgraded Shotguns Drops":
            self addMenu(menu, "Upgraded Shotguns Drops");
                for(z = 0; z < level._shotgunweaps.size; z++)
                    self addOpt(level._ShotgunNames[z], &DropItem, level._shotgunweaps[z] + "_orange_upgraded_item_sr", "weapon", 1, self);
        break;
        case "Upgraded Light Machine Guns Drops":
            self addMenu(menu, "Upgraded Light Machine Guns Drops");
                for(z = 0; z < level._lmgweaps.size; z++)
                    self addOpt(level._LmgNames[z], &DropItem, level._lmgweaps[z] + "_orange_upgraded_item_sr", "weapon", 1, self);
        break;
        case "Upgraded Pistols Drops":
            self addMenu(menu, "Upgraded Pistols Drops");
                for(z = 0; z < level._pistolweaps.size; z++)
                    self addOpt(level._PistolNames[z], &DropItem, level._pistolweaps[z] + "_orange_upgraded_item_sr", "weapon", 1, self);
        break;
        case "Upgraded Specials Drops":
            self addMenu(menu, "Upgraded Special Weapons Drops");
                for(z=0;z<level._AllWonders.size;z++)
                    self addOpt(level._AllWonders[z], &DropItem, level._AllWonders[z] + "_orange_upgraded_item_sr", "weapon", 1, self);
        break;
        case "Upgraded Wonder Weapons Drops":
            self addMenu(menu, "Upgraded Wonder Weapons Drops");
                for(z=0;z<level._PlatinumWonders.size;z++)
                    self addOpt(level._PlatinumWondersNames[z], &DropItem, level._PlatinumWonders[z] + "_upgraded_item_sr", "weapon", 1, self);
        break;
        case "Easter Eggs":
            self addMenu(menu, "Easter Eggs");
                self addOpt("Die Maschine Items", &newMenu, "Die Maschine Items");
                self addOpt("Firebase Z Items", &newMenu, "Firebase Z Items");
                self addOpt("Mauer der Toten Items", &newMenu, "Mauer der Toten Items");
                self addOpt("Forsaken Items", &newMenu, "Forsaken Items");
        break;
        case "Die Maschine Items":
            self addMenu(menu, "Die Maschine Items");
                for(z=0;z<level._DieMaschineItems.size;z++)
                    self addOpt(level._DieMaschineItemNames[z], &DropItem, level._DieMaschineItems[z], "item", 1, self);
        break;
        case "Firebase Z Items":
            self addMenu(menu, "Firebase Z Items");
                for(z=0;z<level._FirebaseZItems.size;z++)
                    self addOpt(level._FirebaseZItemNames[z], &DropItem, level._FirebaseZItems[z], "item", 1, self);
        break;
        case "Mauer der Toten Items":
            self addMenu(menu, "Mauer der Toten Items");
                for(z=0;z<level._MauerDerTotenItems.size;z++)
                    self addOpt(level._MauerDerTotenItemNames[z], &DropItem, level._MauerDerTotenItems[z], "item", 1, self);
        break;
        case "Forsaken Items":
            self addMenu(menu, "Forsaken Items");
                for(z=0;z<level._ForsakenItems.size;z++)
                    self addOpt(level._ForsakenItemNames[z], &DropItem, level._ForsakenItems[z], "item", 1, self);
        break;
        case "Tactical Equipment":
            self addMenu(menu, "Tactical Equipment");
                for(z=0;z<level._TacticalEquipment.size;z++)
                    self addOpt(level._TacticalEquipmentNames[z], &GiveClientWeapon, level._TacticalEquipment[z], self);
        break;
        case "Lethal Equipment":
            self addMenu(menu, "Lethal Equipment");
                for(z=0;z<level._LethalEquipment.size;z++)
                    self addOpt(level._LethalEquipmentNames[z], &GiveClientWeapon, level._LethalEquipment[z], self);
        break;
        case "Support Equipment":
            self addMenu(menu, "Support Equipment");
                for(z=0;z<level._SupportEquipment.size;z++)
                    self addOpt(level._SupportEquipmentNames[z], &GiveClientWeapon, level._SupportEquipment[z], self);
        break;
        case "Players":
            self addMenu(menu, "Players");
                foreach(player in level.players)
                {
                    if(!isDefined(player.playerSetting["verification"]))
                        player.playerSetting["verification"] = level.MenuStatus[level.AutoVerify];
                    
                    self addOpt("[^5" + player.playerSetting["verification"] + "^6]" + player getName(), &newMenu, "Options " + player GetEntityNumber());
                }
        break;
        default:
            foundplayer = false;
            for(a=0;a<level.players.size;a++)
            {
                sepmenu = StrTok(menu, " ");
                if(int(sepmenu[(sepmenu.size - 1)]) == level.players[a] GetEntityNumber())
                {
                    foundplayer = true;
                    self MenuOptionsPlayer(menu, level.players[a]);
                }
            }
            
            if(!foundplayer)
            {
                self addMenu(menu, "404 ERROR");
                    self addOpt("Page Not Found");
            }
            break;
    }
}

MenuOptionsPlayer(menu, player)
{
    self endon("disconnect");
    
    sepmenu = StrTok(menu, " " + player GetEntityNumber());
    newmenu = "";
    for(a=0;a<sepmenu.size;a++)
    {
        newmenu += sepmenu[a];
        if(a != (sepmenu.size - 1))
            newmenu += " ";
    }
    
    switch(newmenu)
    {
        case "Options":       
            self addMenu(menu, "[" + player.playerSetting["verification"] + "]" + player getName());
                self addOpt("Verification", &newMenu, "Verification " + player GetEntityNumber());
                self addOpt("Personal Mods", &newMenu, "ClientPMods " + player GetEntityNumber());
                self addOpt("Client Stat Manipulation", &newMenu, "ClientStats " + player GetEntityNumber());
                self addOpt("Trolling Options", &newMenu, "Trolling " + player GetEntityNumber());
        break;
         case "Verification":
            self addMenu(menu, "Verification");
                for(a=0;a<(level.MenuStatus.size - 2);a++)
                    self addOptBool(player getVerification() == a, level.MenuStatus[a], &setVerification, a, player, true);
            break;
        case "ClientPMods":
            self addMenu(menu, "Client Modifications");
                self addOptBool(player.godmode, "God Mode", &ClientOpts, 1, player);
                self addOptBool(player.UnlimitedAmmo, "Unlimited Ammo", &ClientOpts, 2, player);
        break;
        case "ClientStats":
            self addMenu(menu, "ClientStats");
                self addOpt("Unlock Dark Aether", &ClientOpts, 4, player);
                self addOpt("Unlock All Achievements", &ClientOpts,5,player);
                self addOpt("Give 5.5k Crystals", &ClientOpts,5,player);
        break;
            self addMenu(menu, "Trolling Options");
                self addOpt("Kick Them", &ClientOpts,3, player);
                self addOpt("Test", &TestOption);
        break;
        default:
            self addMenu(menu, "404 ERROR");
                self addOpt("Page Not Found");
            break;
    }
}

menuMonitor()
{
    self endon("disconnect");
    
    while(true)
    {
        if(self getVerification() > 0)
        {
            if(!self isInMenu())
            {
                if(self AdsButtonPressed() && self MeleeButtonPressed() && !isDefined(self.menu["DisableMenuControls"]))
                {
                    if(isDefined(self.menu["currentMenu"]) && self.menu["currentMenu"] != "")
                        menu = self.menu["currentMenu"];
                    else
                        menu = "Main";
                    
                    self openMenu1(menu);
                    wait .25;
                }
            }
            else if(self isInMenu() && !isDefined(self.menu["DisableMenuControls"]))
            {
                if(self AdsButtonPressed() || self AttackButtonPressed())
                {
                    if(!self AdsButtonPressed() || !self AttackButtonPressed())
                    {
                        curs = self getCursor();
                        menu = self getCurrent();
                        
                        self.menu["curs"][menu] += self AttackButtonPressed();
                        self.menu["curs"][menu] -= self AdsButtonPressed();
                        
                        arry = self.menu["items"][self getCurrent()].name;
                        curs = self getCursor();

                        if(curs < 0 || curs > (arry.size - 1))
                            self setCursor((curs < 0) ? (arry.size - 1) : 0);

                        self drawTextNew();
                        wait .13;
                    }
                }
                else if(self UseButtonPressed())
                {
                    menu = self getCurrent();
                    curs = self getCursor();
                    
                    if(isDefined(self.menu["items"][menu].func[curs]))
                    {
                        if(isDefined(self.menu["items"][menu].slider[curs]) || isDefined(self.menu["items"][menu].incslider[curs]))
                            self thread ExecuteFunction(self.menu["items"][menu].func[curs], isDefined(self.menu["items"][menu].slider[curs]) ? self.menu_S[menu][curs][self.menu_SS[menu][curs]] : int(self.menu_SS[menu][curs]), self.menu["items"][menu].input1[curs], self.menu["items"][menu].input2[curs], self.menu["items"][menu].input3[curs], self.menu["items"][menu].input4[curs]);
                        else
                            self thread ExecuteFunction(self.menu["items"][menu].func[curs], self.menu["items"][menu].input1[curs], self.menu["items"][menu].input2[curs], self.menu["items"][menu].input3[curs], self.menu["items"][menu].input4[curs]);
                        if(isDefined(isDefined(self.menu["items"][menu].bool[curs])))
                            self RefreshMenu();
                        wait .25;
                    }
                }
                else if(self SecondaryOffhandButtonPressed() || self FragButtonPressed())
                {
                    if(!self SecondaryOffhandButtonPressed() || !self FragButtonPressed())
                    {
                        menu = self getCurrent();
                        curs = self getCursor();
                        
                        if(isDefined(self.menu["items"][menu].slider[curs]) || isDefined(self.menu["items"][menu].incslider[curs]))
                        {
                            inc = isDefined(self.menu["items"][menu].incslider[curs]) ? self.menu["items"][menu].intincrement[curs] : 1;
                            self.menu_SS[menu][curs] += self FragButtonPressed() ? inc : (inc * -1);
                            
                            if(isDefined(self.menu["items"][menu].slider[curs]))
                                self SetSlider(self.menu_SS[menu][curs]);
                            else
                                self SetIncSlider(self.menu_SS[menu][curs]);
                            self RefreshMenu();
                            wait .15;
                        }
                    }
                }
                else if(self MeleeButtonPressed())
                {
                    if(self getCurrent() == "Main")
                        self closeMenu1();
                    else
                        self newMenu();
                    wait .2;
                }
            }
        }
        wait .05;
    }
}

ExecuteFunction(function, i1, i2, i3, i4, i5, i6)
{
    if(!isDefined(function))
        return;
    
    if(isDefined(i6))
        return self thread [[ function ]](i1, i2, i3, i4, i5, i6);
    if(isDefined(i5))
        return self thread [[ function ]](i1, i2, i3, i4, i5);
    if(isDefined(i4))
        return self thread [[ function ]](i1, i2, i3, i4);
    if(isDefined(i3))
        return self thread [[ function ]](i1, i2, i3);
    if(isDefined(i2))
        return self thread [[ function ]](i1, i2);
    if(isDefined(i1))
        return self thread [[ function ]](i1);
    
    return self thread [[ function ]]();
}

drawTextPrint()
{
    self endon("menuClosed");
    self endon("disconnect");
    
    if(!isDefined(self.menu["curs"][self getCurrent()]))
        self.menu["curs"][self getCurrent()] = 0;
    
    menu = self getCurrent();
    text = self.menu["items"][self getCurrent()].name;
    curs = self getCursor();
    start = 0;

    if (curs > 2 && curs < (text.size - 3) && text.size > 5)
        start = curs - 2;
    if (curs > (text.size - 4) && text.size > 5)
        start = text.size - 5;
    
    if(text.size > 0)
    {
        if(isDefined(self.menu["items"][menu].title))
            self iPrintlnBold("^4[ " + self.menu["items"][menu].title + " ]");
        self.lastRefresh = getTime();

        numOpts = text.size;
        if(numOpts >= 5)
            numOpts = 5;
        
        for(a=0;a<numOpts;a++)
        {
            text = self.menu["items"][menu].name;
            str = text[(a + start)];
            if(isDefined(self.menu["items"][menu].bool[(a + start)]))
                str += (isDefined(self.menu_B[menu][(a + start)]) && self.menu_B[menu][(a + start)]) ? " ^2[ON]" : " ^1[OFF]";
            else if(isDefined(self.menu["items"][menu].incslider[(a + start)]))
                str += "^1 < " + self.menu_SS[menu][(a + start)] + " >";
            else if(isDefined(self.menu["items"][menu].slider[(a + start)]))
                str += " < " + self.menu_S[menu][(a + start)][self.menu_SS[menu][(a + start)]] + " >";
            
            if(curs == (a + start))
                self iPrintlnBold("^2   -> " + str + " ^0<-");
            else
                self iPrintlnBold("^." + str);
        }

        if(numOpts < 5)
        {
            printSize = 5 - numOpts;
            for(a=0;a<printSize;a++)
                self iPrintlnBold(".");
        }
    }
}

drawTextNew()
{
    if(self.menuUseHint){ self DrawTextHint();}
    else self drawTextPrint();
}

drawTextHint()
{
    self endon("menuClosed");
    self endon("disconnect");

    if (!isDefined(self.menu["curs"][self getCurrent()]))
        self.menu["curs"][self getCurrent()] = 0;

    menu = self getCurrent();
    items = self.menu["items"][menu].name;
    curs = self getCursor();
    itemCount = items.size;

    if (itemCount <= 0)
        return;

    line = "";

    if (isDefined(self.menu["items"][menu].title))
        line += "^4[ " + self.menu["items"][menu].title + " ] | ";

    MAX_HINT_ITEMS = 8;
    page = int(curs / MAX_HINT_ITEMS);
    pageStart = page * MAX_HINT_ITEMS;
    pageEnd = pageStart + MAX_HINT_ITEMS;
    if (pageEnd > itemCount)
        pageEnd = itemCount;

    itemLine = "";
    for (a = pageStart; a < pageEnd; a++)
    {
        str = items[a];

        if (isDefined(self.menu["items"][menu].bool[a]))
            str += (isDefined(self.menu_B[menu]) && isDefined(self.menu_B[menu][a]) && self.menu_B[menu][a]) ? " ^2[ON]" : " ^1[OFF]";
        else if (isDefined(self.menu["items"][menu].incslider[a]))
            str += "^1 < " + self.menu_SS[menu][a] + " >";
        else if (isDefined(self.menu["items"][menu].slider[a]))
            str += " < " + self.menu_S[menu][a][self.menu_SS[menu][a]] + " >";

        if (curs == a)
            str = "^2-> " + str + " ^2<-";
        else
            str = "^7" + str;

        itemLine += str + "^7 | ";
    }

    line += itemLine;

    totalPages = int((itemCount - 1) / MAX_HINT_ITEMS) + 1;
    line += " Page " + (page + 1) + "/" + totalPages;

    self setHintString(line);
}

ToggleDrawMethod()
{
    if (!self.menuUseHint)
    {
        self closeMenu1();
        self.menuUseHint = true;
        self PrintToLevel("Menu Draw Changed To: SetHintString");
    }
    else
    {
        self closeMenu1();
        self.menuUseHint = false;
        self PrintToLevel("Menu Draw Changed To: iPrintLn");
    }
}
RefreshMenu()
{
    if(self hasMenu() && self isInMenu())
    {
        self runMenuIndex(self getCurrent());
        if(self.menuUseHint)self drawTextHint();
        else self drawTextPrint();
    }
}

openMenu1(menu)
{
    if(!isDefined(menu))
        menu = "Main";
    if(!isDefined(self.menu["curs"][menu]))
        self.menu["curs"][menu] = 0;
    
    self.menu["currentMenu"] = menu;
    self runMenuIndex(menu);
    self.playerSetting["isInMenu"] = true;
    self thread MonitorMenuRefresh();
}

MonitorMenuRefresh()
{
    self endon("disconnect");
    self endon("menuClosed");


    if(self isInMenu())
    {
        if(self.menuUseHint) self drawTextHint();
        else
        {
            self drawTextPrint();
            while(self isInMenu())
            {
                if(self.lastRefresh < getTime() - 4000)
                    self drawTextPrint();
                if(self.menuUseHint)break;
                wait 1;
            }
        }
    }
}

closeMenu1()
{
    self notify("menuClosed");
    self DestroyOpts();
    self.playerSetting["isInMenu"] = undefined;
}

DestroyOpts()
{
    if (self.menuUseHint)
        self setHintString("");
    else
    {
        for (a = 0; a < 9; a++)
            self iPrintlnBold(".");
    }
}

