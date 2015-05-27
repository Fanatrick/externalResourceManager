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