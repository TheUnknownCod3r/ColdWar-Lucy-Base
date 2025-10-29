GiveClientWeapon(WeaponName, player)//needs work, as some things don't work well
{
    Weapon = getweapon(ishash(WeaponName) ? WeaponName : hash(WeaponName));
    if(!isDefined(Weapon)) return;
    if(zm_loadout::is_melee_weapon(Weapon)) slotIndex = 2;
    else slotIndex = 0;
    player zm_weapons::weapon_give(
    Weapon,      
    0,           
    1,           
    slotIndex,           
    1,       
    #"orange",   
    [],          
    1            
    );

    if(!zm_loadout::is_tactical_grenade( Weapon ) || !zm_loadout::is_lethal_grenade( Weapon ) || !zm_equipment::is_equipment(WeaponName) || !killstreaks::is_killstreak_weapon( Weapon ))
    {
        player switchtoweapon(Weapon);
        player switchToWeapon(Weapon);
    }
    player giveMaxAmmo(Weapon);
}

GiveKillstreak(streakName)
{
    self killstreaks::give( streakName );
}
UpgradeWeaponRarity()
{
    weapon = self GetCurrentWeapon();
    weapon_item = item_inventory::function_230ceec4( weapon );
    if ( weapon_item.itementry.rarity != #"legendary" && weapon_item.itementry.rarity != #"ultra" )
    {
        self thread namespace_1cc7b406::give_item("aether_tool_item_sr");
        self playsound( "zmb_powerup_aethertool_pickup" );
        self PrintToLevel("^2Weapon Upgraded!");
    }
    else{
        self PrintToLevel("^1Weapon Upgraded To Max!");
    }
}
UpgradeWeapon()
{
    weapon = self GetCurrentWeapon();
    wait .1;
    if ( !isdefined( self.var_2843d3cc ) )
    {
        self.var_2843d3cc = [];
    }
    else if ( !isarray( self.var_2843d3cc ) )
    {
        self.var_2843d3cc = array( self.var_2843d3cc );
    }
    
    if ( !isdefined( self.var_2843d3cc[ weapon ] ) )
    {
        self.var_2843d3cc[ weapon ] = 0;
    }

    chalice_level = "";
    switch (self.var_2843d3cc[ weapon ])
    {
        case 0:
            chalice_level = "bronze_chalice_item_sr";
            break;
        case 1:
            chalice_level = "silver_chalice_item_sr";
            break;
        case 2:
            chalice_level = "gold_chalice_item_sr";
            break;
    }

    if(chalice_level != "")
    {
        if(chalice_level != "platinum_chalice_item_sr")
        {
            self thread namespace_1cc7b406::give_item( chalice_level );
        }
        self playsound( "zmb_powerup_chalice_gold_pickup" );
        wait .1;
        weapon = self GetCurrentWeapon();
        switch(chalice_level)
        {
            case "bronze_chalice_item_sr": self.var_2843d3cc[ weapon ] = 1; self PrintToLevel("^2Your weapon has been upgraded to PAP level 1!"); break;
            case "silver_chalice_item_sr": self.var_2843d3cc[ weapon ] = 2; self PrintToLevel("^2Your weapon has been upgraded to PAP level 2!"); break;
            case "gold_chalice_item_sr": self.var_2843d3cc[ weapon ] = 3; self PrintToLevel("^2Your weapon has been upgraded to PAP level 3!"); break;
        }
    }
    else 
    {
        if(self.var_2843d3cc[ weapon ] >= 3) self PrintToLevel("^1Your weapon is already at max PAP level!");
        else self PrintToLevel("^1Unable to PAP weapon!");
    }
}

acquireaat(id) {// works fine
    weapon = self getCurrentWeapon();
    self thread zm_weapons::function_e1fd87b0(weapon, id);
    self PrintToLevel("^5AAT ^2Enabled "+id);
}

RemoveAat()//works fine
{
    weapon = self getCurrentWeapon();
    self thread zm_weapons::function_51897592(weapon);
    self PrintToLevel("^5AAT ^1Removed");
}

magicbullets()
{
    self.magicBullets = isDefined(self.magicBullets) ? undefined : true;
    if(isDefined(self.magicBullets))
    {
        self.bulletEffectType = "ray_gun";
        self PrintToLevel("Magic Bullets Enabled, Effect: Ray Gun");
        while(isDefined(self.magicBullets))
        {
            self waittill(#"weapon_fired");
            MagicBullet(getWeapon(self.bulletEffectType), self getPlayerCameraPos(), BulletTrace(self getPlayerCameraPos(), self getPlayerCameraPos() + anglesToForward(self getPlayerAngles())  * 100000, false, self)["position"], self);
            wait .1;
        }
    }
    else 
    {
        self PrintToLevel("Magic Bullets ^1Disabled");
        self.bulletEffectType=undefined;
    }
}

changeBulletType(val)
{
    if(isDefined(self.bulletEffectType))
    {
        switch(val)
        {
            case 0: self.bulletEffectType=  "chopper_gunner"; self PrintToLevel("Bullet Effect Set To: Chopper Gunner"); break;
            case 1: self.bulletEffectType = "special_ballisticknife_t9_dw_upgraded"; self PrintToLevel("Bullet Effect Set To: Ballistic Knife"); break;
            case 2: self.bulletEffectType = "launcher_standard_t9_upgraded"; self PrintToLevel("Bullet Effect Set To: Rocket Launcher"); break;
            case 3: self.bulletEffectType = "ray_gun"; self PrintToLevel("Bullet Effect Set To: Ray Gun"); break;
        }
    }
    else
    {
        self PrintToLevel("Custom Bullet Effects are not Enabled");
    }
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