ds_list_destroy(armarios_remedio_ids);
ds_list_destroy(armarios_remedio_tipos);
ds_list_destroy(armarios_abertos_ids);

if (surface_exists(vinheta_surface))
    surface_free(vinheta_surface);
	
	