///ermSpriteGet(spritename:string)
with externalResourceManager{
    var i;
    for(i=0;i<ds_list_size(spriteList);i++){
        _str=ermTokenGet(ds_list_find_value(spriteList,i),1)
        if (_str==argument0){
            return real(ermTokenGet(ds_list_find_value(spriteList,i),0));
        }
    }
    return spr_ermDefault;
}