/*
###########################################
Basic Modifications
###########################################
*/

Godmode()//works fine
{
    self.godmode = isDefined(self.godmode) ? undefined : true;
 
    if(isDefined(self.godmode))
    {
        self endon("disconnect");
        self PrintToLevel("^5God Mode ^2ON");
        while(isDefined(self.godmode)) 
        {
            self EnableInvulnerability();
            wait 0.1;
        }
    }
    else
    {
        self PrintToLevel("^5God Mode ^1OFF");
        self DisableInvulnerability();
    }
}

ToggleNoClip(player)
{
    player.Noclip = isDefined(player.Noclip) ? undefined : true;
    
    if(isDefined(player.Noclip))
    {
        player endon("disconnect");
        self iPrintLn("Noclip ^2Enabled");
        if(player hasMenu() && player isInMenu())
            player closeMenu1();
        player DisableWeapons();
        player DisableOffHandWeapons();
        player.nocliplinker = spawnSM(player.origin, "tag_origin");
        player PlayerLinkTo(player.nocliplinker, "tag_origin");
        
        while(isDefined(player.Noclip) && isAlive(player))
        {
            if(player AttackButtonPressed())
                player.nocliplinker.origin = (player.nocliplinker.origin + (AnglesToForward(player GetPlayerAngles()) * 60));
            else if(player AdsButtonPressed())
                player.nocliplinker.origin = (player.nocliplinker.origin - (AnglesToForward(player GetPlayerAngles()) * 60));
            if(player MeleeButtonPressed())
                break;
            
            wait 0.01;
        }

        if(isDefined(player.Noclip))
            player ToggleNoClip(player);
    }
    else
    {
        player Unlink();
        player.nocliplinker delete();
        player EnableWeapons();
        player EnableOffHandWeapons();
        self PrintToLevel("Noclip ^1Disabled");
    }
}

EditPlayerScore(val, player, which)//works fine
{
    switch (which)
    {
        case 1: self zm_score::add_to_player_score(400000000);self.var_595a11bc = 9999; self.var_72d64cfd = 9999;self clientfield::set_player_uimodel("hudItems.scrap", self.var_595a11bc);self clientfield::set_player_uimodel("hudItems.rareScrap", self.var_72d64cfd); self PrintToLevel("^5Score Maxed Out");break;
        case 2: self zm_score::minus_to_player_score(self.score); oldcommon = self.var_595a11bc; oldrare = self.var_72d64cfd; self.var_595a11bc = 0; self.var_72d64cfd = 0;self clientfield::set_player_uimodel("hudItems.scrap", self.var_595a11bc); self clientfield::set_player_uimodel("hudItems.rareScrap", self.var_72d64cfd); self PrintToLevel("Score Set To ^10"); break;
        case 3: self zm_score::add_to_player_score(val); self.var_595a11bc += val; self.var_72d64cfd += val; self PrintToLevel("^5Added ^2"+val+" ^5To Score"); break;
        case 4: self zm_score::minus_to_player_score(val); if(self.var_595a11bc >= val) self.var_595a11bc -= val; if(self.var_72d64cfd >= val)self.var_72d64cfd -= val; self PrintToLevel("^5Taken ^2"+val+" ^5from Score"); break;
    }
}

UnlimitedAmmo()
{
    self.UnlimitedAmmo = isDefined(self.UnlimitedAmmo) ? undefined : true;
    if(isDefined(self.UnlimitedAmmo))
    {
        self PrintToLevel("^5Unlimited Ammo ^2On");   
        self endon("disconnect");

        while(isDefined(self.UnlimitedAmmo))
        {
            weapons = self getweaponslist();
            foreach(weapon in weapons)
            {
                if(weapon.isgadget){
                    slot = self gadgetgetslot(weapon);
                    if(self gadgetpowerget(slot) < 100 && !self getcurrentweapon().isgadget || self gadgetpowerget(slot) < 10){
                        self gadgetpowerset(slot,100);
                    }
                }
                else{
                    self givemaxammo(weapon);
                    self setweaponammoclip(weapon,weapon.clipsize);
                }
            }

            //Set the gaget ammo
            self thread zm_powerup_hero_weapon_power::hero_weapon_power(self);
            wait .05;
        }
    }
    else self PrintToLevel("^5Unlimited Ammo ^1Off");
}

GivePowerup(Powerup)//works
{
    self zm_powerups::specific_powerup_drop(Powerup, get_lookat_origin(self), undefined, undefined, undefined, 1);
    self PrintToLevel("^5Spawned Powerup: "+powerup);
}

GiveAllPerksZM()//works
{
	a_str_perks = getarraykeys( level._custom_perks );
	foreach(str_perk in a_str_perks)
	{
		if(!self hasperk(str_perk))
		{
			self zm_perks::wait_give_perk(str_perk);
			if(isdefined(level.perk_bought_func))
			{
				self [[level.perk_bought_func]](str_perk);
			}
		}
        wait .1;
	}
    self PrintToLevel("All Perks ^2Given");
}

DropItem(Item, Type, Total)
{
    
    switch (Type) {
        case "spawnlist":
            arrSpawnItems = get_spawn_list_items(Item);
            if(arrSpawnItems.size > 0) 
            {
                spawnItemsFinal = [];
                if (arrSpawnItems.size > 20) 
                { 
                    for(e=0;e<10;e++) 
                    {
                        spawnItemsFinal[e] = arrSpawnItems[randomint(arrSpawnItems.size-1)];
                    }
                }
                else{
                    spawnItemsFinal = arrSpawnItems;
                }
                foreach(spawnItem in spawnItemsFinal)
                {
                    point = getscriptbundle( spawnItem.itementry );
                    if(isdefined(point)) DropItem(spawnItem.itementry, isdefined(point.weapon) ? "weapon" :"item", IsSubStr(point.itementry, "scrap") ? randomint(5) : 1);
                }
            }
            break;
        default:
            scpBundle = getscriptbundle( Item );
            point = function_4ba8fde( Item );
            weap = isdefined( scpBundle.weapon ) ? getweapon(Item) : undefined;
            if (isdefined(point))
            {
                Item = StrReplace(Item, "_item_sr", "");
                Item = StrReplace(Item, "_orange", "");
                Item = StrReplace(Item, "_purple", "");
                Item = StrReplace(Item, "_blue", "");
                Item = StrReplace(Item, "_white", "");
                for(i=0;i<Total;i++)
                {
                    angle = self getangles();
                    origin = get_lookat_origin(self);
                    self item_drop::drop_item( 0, (isdefined( scpBundle.weapon ) ? weap : undefined), 1, (isdefined( scpBundle.weapon ) ? weap.maxammo : 0), point.id, origin, angle, 3 );
                    playsoundatposition( "zmb_powerup_eqp_spawn",  origin );
                    self PrintToLevel("^5Item Dropped: ^2" + Item);
                    wait .1;
                }
            }
            else self PrintToLevel("Item Not Found: ^1"+ Item);
        break;
    }
}