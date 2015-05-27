///ermSpriteUnload(spritename:string)
with externalResourceManager{
with (all){
    if (sprite_index!=spr_ermDefault){
        ds_list_add(externalResourceManager.tempList,sprite_index);
    }
}
    var i, _needed;
    for(i=0;i<ds_list_size(spriteList);i++){
        _needed=false
        _str=ermTokenGet(ds_list_find_value(spriteList,i),1)
        if (_str==argument0){
        if (ds_list_find_index(tempList,_id)!=-1){
            _needed=true;
        }   if _needed=false{
            ds_list_delete(spriteList,i);
            sprite_delete(ermTokenGet(ds_list_find_value(spriteList,i),0));
            ermLog("onSpriteUnload: "+argument0+"@"+string(i)+" succesful");
            ds_list_clear(tempList);
            return true;}   else    {
                ermLog("onSpriteUnload: "+argument0+"@"+string(i)+" error, sprite is assigned to an existing instance");
                ds_list_clear(tempList);
                return false;
            }
        }
    }
    ermLog("onSpriteUnload: "+argument0+" not found");
    ds_list_clear(tempList);
    return false;
}
