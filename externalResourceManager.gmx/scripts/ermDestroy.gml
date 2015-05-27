ermSpriteFlush();
ds_list_destroy(spriteList);
ds_list_destroy(backgroundList);
ds_list_destroy(soundList);
ds_list_destroy(tempList);


file_text_write_string(log,"ExternalResourceManager v"+version+" unloaded");
file_text_writeln(log);
file_text_close(log);
