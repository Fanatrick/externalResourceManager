///ermTokenGet(string:string, token:natural)
var _str, _count, _hit;

_str=argument0;
_count=argument1;
while (_count>0){
    _hit=string_pos(":",_str);
    _str=string_delete(_str,1,_hit);
    _count--;
}
_hit=string_pos(":",_str);
_str=string_copy(_str,1,_hit-1);

return (_str);