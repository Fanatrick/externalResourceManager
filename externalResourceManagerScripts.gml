#define ermStart
spriteList=ds_list_create();
backgroundList=ds_list_create();
soundList=ds_list_create();
tempList=ds_list_create();
version="1.0";

log=file_text_open_append("ermLog.txt");
file_text_writeln(log);
file_text_write_string(log,"  ["+date_datetime_string(date_current_datetime())+"]");
file_text_writeln(log);
file_text_write_string(log,"ExternalResourceManager v"+version+" loaded");
file_text_writeln(log);

#define ermTokenGet
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
#define ermLog
///ermLog(text:string)
file_text_write_string(log,"["+date_time_string(date_current_datetime())+"] "+argument0);
file_text_writeln(log);
show_debug_message(argument0);

#define ermListGetId
///ermListGetId(listid:pointer, resourcename:string)
var i;
for(i=0;i<ds_list_size(argument0);i++){
    _str=ermTokenGet(ds_list_find_value(argument0,i),1)
    if (_str==argument1){
        return real(ermTokenGet(ds_list_find_value(argument0,1),0));
    }
}
return -1;
#define ermSpriteLoad
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
#define ermSpriteUnload
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

#define ermSpriteGet
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
#define ermSpriteFlush

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
#define ermDestroy
ermSpriteFlush();
ds_list_destroy(spriteList);
ds_list_destroy(backgroundList);
ds_list_destroy(soundList);
ds_list_destroy(tempList);


file_text_write_string(log,"ExternalResourceManager v"+version+" unloaded");
file_text_writeln(log);
file_text_close(log);

#define ermDocumentation
/***************************************************
  externalResourceManager Documentation
  --------------
  erm serves a purpose of externally loading files
  and keeping them in memory as needed. The system
  offers an easy and understandable way of managing
  sounds, images and files. It also appends to a log
  file throughout its runtime for debugging
  purposes.
  --------------
  FUNCTIONS:
  
    ermStart - initialization script, shouldn't be
  used apart from provided externalResourceManager
  object's creation event. Loads all data structures
  and opens a log file.
  
    ermTokenGet - erm uses tokenized string
  structure that follows value1:value2:value3:
  format. This allows lists of resources to have
  all the information kept inside a single vector
  value. This function retrieves a value (token)
  inside this single string. Returns a token as
  a string.
  
    ermLog - writes to the log file, also shows
  a debug message of what was written inside the
  compile form.
  
    ermListGetId - retrieves a pointer from a list
  of resources from a given name. Returns an ID
  which is a natural number.
  
    ermSpriteLoad - loads an image to serve as a
  sprite from a filename, makes an entry with a
  given sprite name in the spriteList and returns
  a sprite index or default sprite if file was 
  not found.
  
    ermSpriteUnload - removes a sprite from
  memory, returns true if successful or false
  if a sprite with the given name was not found
  or if another instance is currently using the
  sprite.
  
    ermSpriteGet - returns a sprite index from a
  list of sprites with a given name. If the sprite
  with the given name doesn't exist, returns a 
  default index.
  
    ermSpriteFlush - frees all unused sprites
  from memory. Keep in mind only instances with
  sprite_index matching the sprite in memory will
  report it as being used. Drawing functions that
  require a sprite input besides sprite_index won't
  trigger the in-use event. After flushing sprites
  this function shows their information and memory
  freed.
  
    ermDestroy - clears every resource used by erm,
  closes the log and ends the session. This should
  only be used in externalResourceManager's game end
  event.
 ***************************************************/
