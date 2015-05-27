
var i, _size, _id, _name, _needed, _totalsize=0;

with (all){
    if (sprite_index!=spr_ermDefault){
        ds_list_add(externalResourceManager.tempList,sprite_index);
    }
}

for(i=0;i<ds_list_size(spriteList);i++){
    _needed=0;
    _id=real(ermTokenGet(ds_list_find_value(spriteList,i),0));
    _name=ermTokenGet(ds_list_find_value(spriteList,i),1);
    if (sprite_exists(_id)){
        _size=sprite_get_width(_id)*sprite_get_height(_id)*4;
        if (ds_list_find_index(tempList,_id)!=-1){
            _needed=true;
        }
        if (_needed=0){
            ds_list_delete(spriteList,i);
            sprite_delete(_id);
            ermLog("onSpriteFlush: "+_name+"@"+string(_id)+" successful, memory cleared: "+string(_size)+" bytes");
            _totalsize+=_size;
        }   else    {
            ermLog("onSpriteFlush: "+_name+"@"+string(_id)+" error, sprite is assigned to an existing instance");
        }
    }   else    {
        ermLog("onSpriteFlush: "+_name+"@"+string(_id)+" error, sprite is logged but not found in memory");
        ds_list_delete(spriteList,i);
    }
}
ermLog("onSpriteFlush: Total memory cleared "+string(_totalsize)+" bytes");
ds_list_clear(tempList);