//=== Adding Events ============================================================
// Adding known events to internal list.

with fKnownEvents do
  begin
    Add(SCS_TELEMETRY_EVENT_invalid,       'Invalid',       False, False);
    Add(SCS_TELEMETRY_EVENT_frame_start,   'Frame start',   True,  False);
    Add(SCS_TELEMETRY_EVENT_frame_end,     'Frame end',     True,  True);
    Add(SCS_TELEMETRY_EVENT_paused,        'Paused',        True,  False);
    Add(SCS_TELEMETRY_EVENT_started,       'Started',       True,  False);
    Add(SCS_TELEMETRY_EVENT_configuration, 'Configuration', True,  False);
  end;

//=== Adding Channels ==========================================================
// Adding known channels to internal list.

with fKnownChannels do
  begin
    //--- Global ---------------------------------------------------------------
    Add(SCS_TELEMETRY_CHANNEL_local_scale,                        SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);

    //--- Trailer specific -----------------------------------------------------
    Add(SCS_TELEMETRY_TRAILER_CHANNEL_connected,                  SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    // Movement
    Add(SCS_TELEMETRY_TRAILER_CHANNEL_world_placement,            SCS_VALUE_TYPE_dplacement, SCS_VALUE_TYPE_fplacement, SCS_VALUE_TYPE_euler,   False);
    Add(SCS_TELEMETRY_TRAILER_CHANNEL_local_linear_velocity,      SCS_VALUE_TYPE_fvector,    SCS_VALUE_TYPE_dvector,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRAILER_CHANNEL_local_angular_velocity,     SCS_VALUE_TYPE_fvector,    SCS_VALUE_TYPE_dvector,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRAILER_CHANNEL_local_linear_acceleration,  SCS_VALUE_TYPE_fvector,    SCS_VALUE_TYPE_dvector,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRAILER_CHANNEL_local_angular_acceleration, SCS_VALUE_TYPE_fvector,    SCS_VALUE_TYPE_dvector,    SCS_VALUE_TYPE_INVALID, False);
    // Damage
    Add(SCS_TELEMETRY_TRAILER_CHANNEL_wear_chassis,               SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    // Wheels
    Add(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_susp_deflection,      SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, True, SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_count,7);
    Add(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_on_ground,            SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, True, SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_count,7);
    Add(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_substance,            SCS_VALUE_TYPE_u32,        SCS_VALUE_TYPE_u64,        SCS_VALUE_TYPE_INVALID, True, SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_count,7);
    Add(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_velocity,             SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, True, SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_count,7);
    Add(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_steering,             SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, True, SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_count,7);
    Add(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_rotation,             SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, True, SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_count,7);

    //--- Truck specific -------------------------------------------------------
    // Movement
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_world_placement,              SCS_VALUE_TYPE_dplacement, SCS_VALUE_TYPE_fplacement, SCS_VALUE_TYPE_euler,   False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_local_linear_velocity,        SCS_VALUE_TYPE_fvector,    SCS_VALUE_TYPE_dvector,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_local_angular_velocity,       SCS_VALUE_TYPE_fvector,    SCS_VALUE_TYPE_dvector,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_local_linear_acceleration,    SCS_VALUE_TYPE_fvector,    SCS_VALUE_TYPE_dvector,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_local_angular_acceleration,   SCS_VALUE_TYPE_fvector,    SCS_VALUE_TYPE_dvector,    SCS_VALUE_TYPE_INVALID, False);
    Add('truck.cabin.orientation',                                SCS_VALUE_TYPE_fplacement, SCS_VALUE_TYPE_dplacement, SCS_VALUE_TYPE_euler,   False); // later replaced with cabin_offset
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_cabin_angular_velocity,       SCS_VALUE_TYPE_fvector,    SCS_VALUE_TYPE_dvector,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_cabin_angular_acceleration,   SCS_VALUE_TYPE_fvector,    SCS_VALUE_TYPE_dvector,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_head_offset,                  SCS_VALUE_TYPE_fplacement, SCS_VALUE_TYPE_dplacement, SCS_VALUE_TYPE_euler,   False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_speed,                        SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    // Engine
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_engine_rpm,                   SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_engine_gear,                  SCS_VALUE_TYPE_s32,        SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    // Driving
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_input_steering,               SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_input_throttle,               SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_input_brake,                  SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_input_clutch,                 SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_effective_steering,           SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_effective_throttle,           SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_effective_brake,              SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_effective_clutch,             SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_cruise_control,               SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    // Gearbox
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_hshifter_slot,                SCS_VALUE_TYPE_u32,        SCS_VALUE_TYPE_u64,        SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_hshifter_selector,            SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, True, SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_selector_count,1);
    // Brakes
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_parking_brake,                SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_motor_brake,                  SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_retarder_level,               SCS_VALUE_TYPE_u32,        SCS_VALUE_TYPE_u64,        SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_brake_air_pressure,           SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_brake_air_pressure_warning,   SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_brake_temperature,            SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    // Consumables
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_fuel,                         SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_fuel_warning,                 SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_fuel_average_consumption,     SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_adblue,                       SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_adblue_warning,               SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_adblue_average_consumption,   SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    // Oil
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_oil_pressure,                 SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_oil_pressure_warning,         SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_oil_temperature,              SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    // Temperature
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_water_temperature,            SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_water_temperature_warning,    SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    // Battery
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_battery_voltage,              SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_battery_voltage_warning,      SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    // Enabled state of various elements
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_electric_enabled,             SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_engine_enabled,               SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_lblinker,                     SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_rblinker,                     SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_light_parking,                SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_light_low_beam,               SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_light_high_beam,              SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_light_aux_front,              SCS_VALUE_TYPE_u32,        SCS_VALUE_TYPE_u64,        SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_light_aux_roof,               SCS_VALUE_TYPE_u32,        SCS_VALUE_TYPE_u64,        SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_light_beacon,                 SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_light_brake,                  SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_light_reverse,                SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_wipers,                       SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_dashboard_backlight,          SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    // Wear
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_wear_engine,                  SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_wear_transmission,            SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_wear_cabin,                   SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_wear_chassis,                 SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_wear_wheels,                  SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    // Odometer
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_odometer,                     SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, False);
    // Wheels
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_susp_deflection,        SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, True, SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_count,7);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_on_ground,              SCS_VALUE_TYPE_bool,       SCS_VALUE_TYPE_INVALID,    SCS_VALUE_TYPE_INVALID, True, SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_count,7);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_substance,              SCS_VALUE_TYPE_u32,        SCS_VALUE_TYPE_u64,        SCS_VALUE_TYPE_INVALID, True, SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_count,7);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_velocity,               SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, True, SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_count,7);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_steering,               SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, True, SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_count,7);
    Add(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_rotation,               SCS_VALUE_TYPE_float,      SCS_VALUE_TYPE_double,     SCS_VALUE_TYPE_INVALID, True, SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_count,7);
  end;

//=== Adding Configs ===========================================================
// Adding known configurations to internal list.

with fKnownConfigs do
  begin
    Add(SCS_TELEMETRY_CONFIG_substances_ATTRIBUTE_id,                   SCS_VALUE_TYPE_string,  False);
    Add(SCS_TELEMETRY_CONFIG_controls_ATTRIBUTE_shifter_type,           SCS_VALUE_TYPE_string,  False);
    Add(SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_selector_count,         SCS_VALUE_TYPE_u32,     False, True);
    Add(SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_slot_gear,              SCS_VALUE_TYPE_s32,     True);
    Add(SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_slot_handle_position,   SCS_VALUE_TYPE_u32,     True);
    Add(SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_slot_selectors,         SCS_VALUE_TYPE_u32,     True);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_brand_id,                  SCS_VALUE_TYPE_string,  False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_brand,                     SCS_VALUE_TYPE_string,  False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_id,                        SCS_VALUE_TYPE_string,  False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_name,                      SCS_VALUE_TYPE_string,  False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_fuel_capacity,             SCS_VALUE_TYPE_float,   False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_fuel_warning_factor,       SCS_VALUE_TYPE_float,   False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_adblue_capacity,           SCS_VALUE_TYPE_float,   False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_air_pressure_warning,      SCS_VALUE_TYPE_float,   False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_oil_pressure_warning,      SCS_VALUE_TYPE_float,   False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_water_temperature_warning, SCS_VALUE_TYPE_float,   False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_battery_voltage_warning,   SCS_VALUE_TYPE_float,   False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_rpm_limit,                 SCS_VALUE_TYPE_float,   False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_forward_gear_count,        SCS_VALUE_TYPE_u32,     False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_reverse_gear_count,        SCS_VALUE_TYPE_u32,     False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_retarder_step_count,       SCS_VALUE_TYPE_u32,     False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_cabin_position,            SCS_VALUE_TYPE_fvector, False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_head_position,             SCS_VALUE_TYPE_fvector, False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_hook_position,             SCS_VALUE_TYPE_fvector, False);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_count,               SCS_VALUE_TYPE_u32,     False, True);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_position,            SCS_VALUE_TYPE_fvector, True);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_steerable,           SCS_VALUE_TYPE_bool,    True);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_simulated,           SCS_VALUE_TYPE_bool,    True);
    Add(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_radius,              SCS_VALUE_TYPE_float,   True);
    Add(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_id,                      SCS_VALUE_TYPE_string,  False);
    Add(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_cargo_accessory_id,      SCS_VALUE_TYPE_string,  False);
    Add(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_hook_position,           SCS_VALUE_TYPE_fvector, False); 
    Add(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_count,             SCS_VALUE_TYPE_u32,     False, True);
    Add(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_position,          SCS_VALUE_TYPE_fvector, True);
    Add(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_steerable,         SCS_VALUE_TYPE_bool,    True);
    Add(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_simulated,         SCS_VALUE_TYPE_bool,    True);
    Add(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_radius,            SCS_VALUE_TYPE_float,   True);
  end;

