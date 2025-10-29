function get_lookat_origin( player )
{
    angles = player getplayerangles();
    forward = anglestoforward( angles );
    dir = vectorscale( forward, 8000 );
    eye = player geteye();
    trace = bullettrace( eye, eye + dir, 0, undefined );
    return trace[ #"position" ];
}

function get_spawn_list_items( MainItem )
{
    arrItems = [];
    index = 0;
    itemspawnlist = getscriptbundle( MainItem );
    if(isdefined(itemspawnlist))
    {
        foreach ( item in itemspawnlist.itemlist )
        {
            if (IsSubStr(item.itementry, "item_sr")) {
                index = arrItems.size;
                arrItems[index] = item.itementry;
            }
            if (IsSubStr(item.itementry, "_list")) {
                childspawnlist = getscriptbundle( item.itementry );
                foreach ( itemchild in childspawnlist.itemlist )
                {
                    if (IsSubStr(itemchild.itementry, "item_sr")) {
                        index = arrItems.size;
                        arrItems[index] = itemchild;
                    }
                    if (IsSubStr(itemchild.itementry, "_list")) {
                        childtwospanlist = getscriptbundle( itemchild.itementry );
                        foreach ( itemchildtwo in childtwospanlist.itemlist )
                        {
                            if (IsSubStr(itemchildtwo.itementry, "item_sr")) {
                                index = arrItems.size;
                                arrItems[index] = itemchildtwo;
                            }
                            if (IsSubStr(itemchildtwo.itementry, "_list")) {
                                childthreespawnlist = getscriptbundle( itemchildtwo.itementry );
                                foreach ( itemchildthree in childthreespawnlist.itemlist )
                                {
                                    if (IsSubStr(itemchildthree.itementry, "item_sr")) {
                                        index = arrItems.size;
                                        arrItems[index] = itemchildthree;
                                    }
                                    if (IsSubStr(itemchildthree.itementry, "_list"))
                                    {
                                        childfourspawnlist = getscriptbundle( itemchildthree.itementry );
                                        foreach ( itemchildfour in childfourspawnlist.itemlist )
                                        {
                                            if (IsSubStr(itemchildfour.itementry, "item_sr")) {  
                                                index = arrItems.size;
                                                arrItems[index] = itemchildfour;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return arrItems;
}