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
