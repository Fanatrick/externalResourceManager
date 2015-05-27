///ermListGetId(listid:pointer, resourcename:string)
var i;
for(i=0;i<ds_list_size(argument0);i++){
    _str=ermTokenGet(ds_list_find_value(argument0,i),1)
    if (_str==argument1){
        return real(ermTokenGet(ds_list_find_value(argument0,1),0));
    }
}
return -1;