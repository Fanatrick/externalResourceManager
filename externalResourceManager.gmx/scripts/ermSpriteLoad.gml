///ermSpriteLoad(filename:string, spritename:string, imgnub:bool, removeback:bool, smooth:bool, xorig:real, yorig:real)
with externalResourceManager{
    var _exists, _spr, _size;
    
    if (!file_exists(argument0)){
        ermLog("onSpriteLoad: "+argument0+" File doesn't exist");
        return spr_ermDefault;
    }
    _exists=ermListGetId(spriteList,argument1);
    if (_exists!=-1){
        ermLog("onSpriteLoad: "+argument0+" Sprite defined as "+argument1+" already exists on position "+string(_exists));
        return ds_list_find_value(spriteList,_exists);
    }
    _spr=sprite_add(argument0,argument2,argument3,argument4,argument5,argument6);
    if (_spr=-1){
        ermLog("onSpriteLoad: "+argument0+" Failed to load sprite");
        return spr_ermDefault;
    }
    _size=sprite_get_width(_spr)*sprite_get_height(_spr)*4;
    ermLog("onSpriteLoad: "+argument0+" defined as "+argument1+" loaded successfuly @"+string(ds_list_size(spriteList))+" size "+string(_size)+" bytes");
    ds_list_add(spriteList,string(_spr)+":"+argument1+":");
    return _spr;
}