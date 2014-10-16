{@html(<hr>)
@abstract(Unit providing constans with precalculated IDs a others stuff around
          IDs generally.)
@author(František Milt <fmilt@seznam.cz>)
@created(2014-04-15)
@lastmod(2014-04-27)

  @bold(@NoAutoLink(TelemetryIDs))

  ©František Milt, all rights reserved.

  This unit contains definitions of identification number types, set of
  constants containing full configuration names, constants with IDs for
  individual configs and channel, as well as function used to obtain those IDs.

  Last change:  2014-04-27

  Change List:@unorderedList(
    @item(2014-04-15 - First stable version.)
    @item(2014-04-15 - Function GetItemID was moved to this unit.)
    @item(2014-04-18 - Constant cConfigFieldsSeparator was moved to this unit.))
    
@html(<hr>)

  Table of precomputed IDs for channels names.@br
  IDs are stored in constans whose identifiers corresponds to indetifiers of
  constants containing string value. For example, for name stored in constant
  @code(SCS_TELEMETRY_CHANNEL_local_scale), the ID is stored in constant
  SCS_TELEMETRY_CHANNEL_ID_local_scale.
  @table(
  @rowHead(@cell(Channel name constant identifier)                            @cell(String value)                               @cell(Precomputed ID (hexadecimal)))
  @row(@cell(@code(SCS_TELEMETRY_CHANNEL_local_scale))                        @cell(@code(local.scale))                         @cell(@code(33DE67E4)))
  @row(@cell(@code(SCS_TELEMETRY_TRAILER_CHANNEL_connected))                  @cell(@code(trailer.connected))                   @cell(@code(7007CCEE)))
  @row(@cell(@code(SCS_TELEMETRY_TRAILER_CHANNEL_world_placement))            @cell(@code(trailer.world.placement))             @cell(@code(3A729370)))
  @row(@cell(@code(SCS_TELEMETRY_TRAILER_CHANNEL_local_linear_velocity))      @cell(@code(trailer.velocity.linear))             @cell(@code(AE80C1D0)))
  @row(@cell(@code(SCS_TELEMETRY_TRAILER_CHANNEL_local_angular_velocity))     @cell(@code(trailer.velocity.angular))            @cell(@code(A2981BDF)))
  @row(@cell(@code(SCS_TELEMETRY_TRAILER_CHANNEL_local_linear_acceleration))  @cell(@code(trailer.acceleration.linear))         @cell(@code(99A57FA9)))
  @row(@cell(@code(SCS_TELEMETRY_TRAILER_CHANNEL_local_angular_acceleration)) @cell(@code(trailer.acceleration.angular))        @cell(@code(8B76F7F9)))
  @row(@cell(@code(SCS_TELEMETRY_TRAILER_CHANNEL_wear_chassis))               @cell(@code(trailer.wear.chassis))                @cell(@code(E071BE1A)))
  @row(@cell(@code(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_susp_deflection))      @cell(@code(trailer.wheel.suspension.deflection)) @cell(@code(1E44DA91)))
  @row(@cell(@code(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_on_ground))            @cell(@code(trailer.wheel.on_ground))             @cell(@code(9A68642F)))
  @row(@cell(@code(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_substance))            @cell(@code(trailer.wheel.substance))             @cell(@code(1DFBFCF1)))
  @row(@cell(@code(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_velocity))             @cell(@code(trailer.wheel.angular_velocity))      @cell(@code(C387243E)))
  @row(@cell(@code(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_steering))             @cell(@code(trailer.wheel.steering))              @cell(@code(3B417600)))
  @row(@cell(@code(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_rotation))             @cell(@code(trailer.wheel.rotation))              @cell(@code(EA941F6D)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_world_placement))              @cell(@code(truck.world.placement))               @cell(@code(6B48D06B)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_local_linear_velocity))        @cell(@code(truck.local.velocity.linear))         @cell(@code(5D9D7AB3)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_local_angular_velocity))       @cell(@code(truck.local.velocity.angular))        @cell(@code(76D03686)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_local_linear_acceleration))    @cell(@code(truck.local.acceleration.linear))     @cell(@code(A2E5F90F)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_local_angular_acceleration))   @cell(@code(truck.local.acceleration.angular))    @cell(@code(B4F8B1A2)))
  @row(@cell(@code(*SCS_TELEMETRY_TRUCK_CHANNEL_cabin_orientation))           @cell(@code(truck.cabin.orientation))             @cell(@code(36F3F15D)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_cabin_offset))                 @cell(@code(truck.cabin.offset))                  @cell(@code(303DEF2A)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_cabin_angular_velocity))       @cell(@code(truck.cabin.velocity.angular))        @cell(@code(10976F36)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_cabin_angular_acceleration))   @cell(@code(truck.cabin.acceleration.angular))    @cell(@code(D10EF7A8)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_head_offset))                  @cell(@code(truck.head.offset))                   @cell(@code(EEE287E8)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_speed))                        @cell(@code(truck.speed))                         @cell(@code(4E839148)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_engine_rpm))                   @cell(@code(truck.engine.rpm))                    @cell(@code(160E7B38)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_engine_gear))                  @cell(@code(truck.engine.gear))                   @cell(@code(9582C042)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_input_steering))               @cell(@code(truck.input.steering))                @cell(@code(DCFA7E3B)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_input_throttle))               @cell(@code(truck.input.throttle))                @cell(@code(CF8FC74B)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_input_brake))                  @cell(@code(truck.input.brake))                   @cell(@code(5EEDB702)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_input_clutch))                 @cell(@code(truck.input.clutch))                  @cell(@code(F5ECF339)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_effective_steering))           @cell(@code(truck.effective.steering))            @cell(@code(94181EAB)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_effective_throttle))           @cell(@code(truck.effective.throttle))            @cell(@code(876DA7DB)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_effective_brake))              @cell(@code(truck.effective.brake))               @cell(@code(47E5F7F0)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_effective_clutch))             @cell(@code(truck.effective.clutch))              @cell(@code(A6466849)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_cruise_control))               @cell(@code(truck.cruise_control))                @cell(@code(C31E2094)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_hshifter_slot))                @cell(@code(truck.hshifter.slot))                 @cell(@code(36C98B9D)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_hshifter_selector))            @cell(@code(truck.hshifter.select))               @cell(@code(E4A50350)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_parking_brake))                @cell(@code(truck.brake.parking))                 @cell(@code(5664B035)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_motor_brake))                  @cell(@code(truck.brake.motor))                   @cell(@code(8E0C8ABA)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_retarder_level))               @cell(@code(truck.brake.retarder))                @cell(@code(A8D6B016)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_brake_air_pressure))           @cell(@code(truck.brake.air.pressure))            @cell(@code(9384DD05)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_brake_air_pressure_warning))   @cell(@code(truck.brake.air.pressure.warning))    @cell(@code(C58F8B5A)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_brake_air_pressure_emergency)) @cell(@code(truck.brake.air.pressure.emergency))  @cell(@code(78FAD40D)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_brake_temperature))            @cell(@code(truck.brake.temperature))             @cell(@code(E1AE4E3F)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_fuel))                         @cell(@code(truck.fuel.amount))                   @cell(@code(C298DD2D)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_fuel_warning))                 @cell(@code(truck.fuel.warning))                  @cell(@code(9D0FD9A2)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_fuel_average_consumption))     @cell(@code(truck.fuel.consumption.average))      @cell(@code(013149D4)))
  @row(@cell(@code(**SCS_TELEMETRY_TRUCK_CHANNEL_adblue))                     @cell(@code(truck.adblue))                        @cell(@code(8D32829D)))
  @row(@cell(@code(**SCS_TELEMETRY_TRUCK_CHANNEL_adblue_warning))             @cell(@code(truck.adblue.warning))                @cell(@code(FF3464CB)))
  @row(@cell(@code(**SCS_TELEMETRY_TRUCK_CHANNEL_adblue_average_consumption)) @cell(@code(truck.adblue.consumption.average))    @cell(@code(C253FC24)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_oil_pressure))                 @cell(@code(truck.oil.pressure))                  @cell(@code(A368F9A6)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_oil_pressure_warning))         @cell(@code(truck.oil.pressure.warning))          @cell(@code(1A1815C5)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_oil_temperature))              @cell(@code(truck.oil.temperature))               @cell(@code(405A67E9)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_water_temperature))            @cell(@code(truck.water.temperature))             @cell(@code(B8B46564)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_water_temperature_warning))    @cell(@code(truck.water.temperature.warning))     @cell(@code(783F3300)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_battery_voltage))              @cell(@code(truck.battery.voltage))               @cell(@code(91BB0105)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_battery_voltage_warning))      @cell(@code(truck.battery.voltage.warning))       @cell(@code(26000473)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_electric_enabled))             @cell(@code(truck.electric.enabled))              @cell(@code(9D4D7843)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_engine_enabled))               @cell(@code(truck.engine.enabled))                @cell(@code(FACA0BF9)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_lblinker))                     @cell(@code(truck.lblinker))                      @cell(@code(A7B8351B)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_rblinker))                     @cell(@code(truck.rblinker))                      @cell(@code(CE891602)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_light_lblinker))               @cell(@code(truck.light.lblinker))                @cell(@code(ECC0AC62)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_light_rblinker))               @cell(@code(truck.light.rblinker))                @cell(@code(85F18F7B)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_light_parking))                @cell(@code(truck.light.parking))                 @cell(@code(6931D205)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_light_low_beam))               @cell(@code(truck.light.beam.low))                @cell(@code(612D677D)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_light_high_beam))              @cell(@code(truck.light.beam.high))               @cell(@code(7E93DFB5)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_light_aux_front))              @cell(@code(truck.light.aux.front))               @cell(@code(D6464C43)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_light_aux_roof))               @cell(@code(truck.light.aux.roof))                @cell(@code(5ADBA32B)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_light_beacon))                 @cell(@code(truck.light.beacon))                  @cell(@code(990180CD)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_light_brake))                  @cell(@code(truck.light.brake))                   @cell(@code(E2790B7B)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_light_reverse))                @cell(@code(truck.light.reverse))                 @cell(@code(71711168)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_wipers))                       @cell(@code(truck.wipers))                        @cell(@code(EE7920A7)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_dashboard_backlight))          @cell(@code(truck.dashboard.backlight))           @cell(@code(91DA5D6D)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_wear_engine))                  @cell(@code(truck.wear.engine))                   @cell(@code(D89A5F14)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_wear_transmission))            @cell(@code(truck.wear.transmission))             @cell(@code(ABB45C97)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_wear_cabin))                   @cell(@code(truck.wear.cabin))                    @cell(@code(49F699F6)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_wear_chassis))                 @cell(@code(truck.wear.chassis))                  @cell(@code(BC2A6A7A)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_wear_wheels))                  @cell(@code(truck.wear.wheels))                   @cell(@code(7C35EF18)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_odometer))                     @cell(@code(truck.odometer))                      @cell(@code(F988B0E0)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_susp_deflection))        @cell(@code(truck.wheel.suspension.deflection))   @cell(@code(369CAB49)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_on_ground))              @cell(@code(truck.wheel.on_ground))               @cell(@code(CB522734)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_substance))              @cell(@code(truck.wheel.substance))               @cell(@code(4CC1BFEA)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_velocit))                @cell(@code(truck.wheel.angular_velocity))        @cell(@code(B7B25C28)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_steering))               @cell(@code(truck.wheel.steering))                @cell(@code(DF025731)))
  @row(@cell(@code(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_rotation))               @cell(@code(truck.wheel.rotation))                @cell(@code(0ED73E5C)))
  )
  @code(*) - This constant does not actually exist (it was removed from
  telemetry SDK and replaced by @code(SCS_TELEMETRY_TRUCK_CHANNEL_cabin_offset)
  ).@br
  @code(**) - These channels does not work in current SDK.@br
  @br
  Table of precomputed IDs for configs names.@br
  IDs are stored in constans whose identifiers corresponds to indetifiers of
  constants containing string value. For example, for name stored in constant
  SCS_TELEMETRY_CONFIG_substances_ATTRIBUTE_id, the ID is stored in constant
  SCS_TELEMETRY_CONFIG_ID_substances_ATTRIBUTE_id.
  @table(
  @rowHead(@cell(Config name constant identifier)                            @cell(String value)                              @cell(Precomputed ID (hexadecimal)))
  @row(@cell(SCS_TELEMETRY_CONFIG_substances_ATTRIBUTE_id)                   @cell(@code(substances.id))                      @cell(@code(A1E920F4)))
  @row(@cell(SCS_TELEMETRY_CONFIG_controls_ATTRIBUTE_shifter_type)           @cell(@code(controls.shifter.type))              @cell(@code(37BA5313)))
  @row(@cell(SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_selector_count)         @cell(@code(hshifter.selector.count))            @cell(@code(AA57ECAD)))
  @row(@cell(SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_slot_gear)              @cell(@code(hshifter.slot.gear))                 @cell(@code(601E49BB)))
  @row(@cell(SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_slot_handle_position)   @cell(@code(hshifter.slot.handle.position))      @cell(@code(4C2725D0)))
  @row(@cell(SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_slot_selectors)         @cell(@code(hshifter.slot.selectors))            @cell(@code(1705F155)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_brand_id)                  @cell(@code(truck.brand_id))                     @cell(@code(CFEC235C)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_brand)                     @cell(@code(truck.brand))                        @cell(@code(5DF796E6)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_id)                        @cell(@code(truck.id))                           @cell(@code(93A67EA9)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_name)                      @cell(@code(truck.name))                         @cell(@code(FF36A0AD)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_fuel_capacity)             @cell(@code(truck.fuel.capacity))                @cell(@code(FFEA5570)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_fuel_warning_factor)       @cell(@code(truck.fuel.warning.factor))          @cell(@code(766BF114)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_adblue_capacity)           @cell(@code(truck.adblue.capacity))              @cell(@code(CBE6B731)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_air_pressure_warning)      @cell(@code(truck.brake.air.pressure.warning))   @cell(@code(C58F8B5A)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_air_pressure_emergency)    @cell(@code(truck.brake.air.pressure.emergency)) @cell(@code(78FAD40D)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_oil_pressure_warning)      @cell(@code(truck.oil.pressure.warning))         @cell(@code(1A1815C5)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_water_temperature_warning) @cell(@code(truck.water.temperature.warning))    @cell(@code(783F3300)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_battery_voltage_warning)   @cell(@code(truck.battery.voltage.warning))      @cell(@code(26000473)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_rpm_limit)                 @cell(@code(truck.rpm.limit))                    @cell(@code(96F2B46D)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_forward_gear_count)        @cell(@code(truck.gears.forward))                @cell(@code(620CEB70)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_reverse_gear_count)        @cell(@code(truck.gears.reverse))                @cell(@code(2FEA55E1)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_retarder_step_count)       @cell(@code(truck.retarder.steps))               @cell(@code(F8E36BF0)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_cabin_position)            @cell(@code(truck.cabin.position))               @cell(@code(E37B50B2)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_head_position)             @cell(@code(truck.head.position))                @cell(@code(59DED2CB)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_hook_position)             @cell(@code(truck.hook.position))                @cell(@code(10944A21)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_count)               @cell(@code(truck.wheels.count))                 @cell(@code(D634DC01)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_position)            @cell(@code(truck.wheel.position))               @cell(@code(61874258)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_steerable)           @cell(@code(truck.wheel.steerable))              @cell(@code(91817077)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_simulated)           @cell(@code(truck.wheel.simulated))              @cell(@code(27B8658F)))
  @row(@cell(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_radius)              @cell(@code(truck.wheel.radius))                 @cell(@code(60D54CB6)))
  @row(@cell(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_id)                      @cell(@code(trailer.id))                         @cell(@code(E3F34E9A)))
  @row(@cell(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_cargo_accessory_id)      @cell(@code(trailer.cargo.accessory.id))         @cell(@code(7E792A8A)))
  @row(@cell(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_hook_position)           @cell(@code(trailer.hook.position))              @cell(@code(5D7A70AD)))
  @row(@cell(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_count)             @cell(@code(trailer.wheels.count))               @cell(@code(8A6F0861)))
  @row(@cell(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_position)          @cell(@code(trailer.wheel.position))             @cell(@code(85C46369)))
  @row(@cell(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_steerable)         @cell(@code(trailer.wheel.steerable))            @cell(@code(C0BB336C)))
  @row(@cell(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_simulated)         @cell(@code(trailer.wheel.simulated))            @cell(@code(76822694)))
  @row(@cell(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_radius)            @cell(@code(trailer.wheel.radius))               @cell(@code(3C8E98D6)))
  )

@html(<hr>)}
unit TelemetryIDs;

interface

{$INCLUDE '.\Telemetry_defs.inc'}

uses
  CRC32,
  TelemetryCommon,
{$IFDEF UseCondensedHeader}
  SCS_Telemetry_Condensed;
{$ELSE}
  scssdk,
  scssdk_telemetry_common_configs,
  scssdk_telemetry_common_channels,
  scssdk_telemetry_trailer_common_channels,
  scssdk_telemetry_truck_common_channels;
{$ENDIF}

{==============================================================================}
{    Types and general constants                                               }
{==============================================================================}

const
  // Character used as a separator for config + config_attribute conglomerate.
  cConfigFieldsSeparator = '.';

type
  // General item identificator. All other item identifiers are of this type.
  TItemID = TCRC32;
  // Pointer to a variable of type TItemID
  PItemID = ^TITemID;

  // Channel identificator obtained from its name.
  TChannelID = TItemID;
  // Pointer to a variable of type TChannelID.
  PChannelID = ^TChannelID;

  // Configuration identificator obtained from full config name.
  TConfigID = TItemID;
  // Pointer to a variable of type TConfigID.
  PConfigID = ^TConfigID;

{==============================================================================}
{    Full config names                                                         }
{==============================================================================}

const
  // Full name of config attribute @code(id) in @code(substances) configuration.
  SCS_TELEMETRY_CONFIG_substances_ATTRIBUTE_id                   = TelemetryString(SCS_TELEMETRY_CONFIG_substances + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_id);

  // Full name of config attribute @code(shifter_type) in @code(controls) configuration.
  SCS_TELEMETRY_CONFIG_controls_ATTRIBUTE_shifter_type           = TelemetryString(SCS_TELEMETRY_CONFIG_controls + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_shifter_type);

  // Full name of config attribute @code(selector_count) in @code(hshifter) configuration.
  SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_selector_count         = TelemetryString(SCS_TELEMETRY_CONFIG_hshifter + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_selector_count);
  // Full name of config attribute @code(slot_gear) in @code(hshifter) configuration.
  SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_slot_gear              = TelemetryString(SCS_TELEMETRY_CONFIG_hshifter + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_slot_gear);
  // Full name of config attribute @code(slot_handle_position) in @code(hshifter) configuration.
  SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_slot_handle_position   = TelemetryString(SCS_TELEMETRY_CONFIG_hshifter + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_slot_handle_position);
  // Full name of config attribute @code(slot_selectors) in @code(hshifter) configuration.
  SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_slot_selectors         = TelemetryString(SCS_TELEMETRY_CONFIG_hshifter + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_slot_selectors);

  // Full name of config attribute @code(brand_id) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_brand_id                  = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_brand_id);
  // Full name of config attribute @code(brand) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_brand                     = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_brand);
  // Full name of config attribute @code(id) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_id                        = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_id);
  // Full name of config attribute @code(name) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_name                      = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_name);
  // Full name of config attribute @code(fuel_capacity) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_fuel_capacity             = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_fuel_capacity);
  // Full name of config attribute @code(fuel_warning_factor) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_fuel_warning_factor       = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_fuel_warning_factor);
  // Full name of config attribute @code(adblue_capacity ) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_adblue_capacity           = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_adblue_capacity);
  // Full name of config attribute @code(air_pressure_warning ) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_air_pressure_warning      = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_air_pressure_warning);
  // Full name of config attribute @code(air_pressure_emergency) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_air_pressure_emergency    = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_air_pressure_emergency);
  // Full name of config attribute @code(oil_pressure_warning) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_oil_pressure_warning      = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_oil_pressure_warning);
  // Full name of config attribute @code(water_temperature_warning) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_water_temperature_warning = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_water_temperature_warning);
  // Full name of config attribute @code(battery_voltage_warning) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_battery_voltage_warning   = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_battery_voltage_warning);
  // Full name of config attribute @code(rpm_limit) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_rpm_limit                 = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_rpm_limit);
  // Full name of config attribute @code(forward_gear_count) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_forward_gear_count        = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_forward_gear_count);
  // Full name of config attribute @code(reverse_gear_count) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_reverse_gear_count        = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_reverse_gear_count);
  // Full name of config attribute @code(retarder_step_count) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_retarder_step_count       = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_retarder_step_count);
  // Full name of config attribute @code(cabin_position) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_cabin_position            = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_cabin_position);
  // Full name of config attribute @code(head_position) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_head_position             = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_head_position);
  // Full name of config attribute @code(hook_position) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_hook_position             = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_hook_position);
  // Full name of config attribute @code(wheel_count) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_count               = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_wheel_count);
  // Full name of config attribute @code(wheel_position) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_position            = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_wheel_position);
  // Full name of config attribute @code(wheel_steerable) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_steerable           = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_wheel_steerable);
  // Full name of config attribute @code(wheel_simulated) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_simulated           = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_wheel_simulated);
  // Full name of config attribute @code(wheel_radius) in @code(truck) configuration.
  SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_radius              = TelemetryString(SCS_TELEMETRY_CONFIG_truck + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_wheel_radius);

  // Full name of config attribute @code(id) in @code(trailer) configuration.
  SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_id                      = TelemetryString(SCS_TELEMETRY_CONFIG_trailer + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_id);
  // Full name of config attribute @code(cargo_accessory_id) in @code(trailer) configuration.
  SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_cargo_accessory_id      = TelemetryString(SCS_TELEMETRY_CONFIG_trailer + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_cargo_accessory_id);
  // Full name of config attribute @code(hook_position) in @code(trailer) configuration.
  SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_hook_position           = TelemetryString(SCS_TELEMETRY_CONFIG_trailer + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_hook_position);
  // Full name of config attribute @code(wheel_count) in @code(trailer) configuration.
  SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_count             = TelemetryString(SCS_TELEMETRY_CONFIG_trailer + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_wheel_count);
  // Full name of config attribute @code(wheel_position) in @code(trailer) configuration.
  SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_position          = TelemetryString(SCS_TELEMETRY_CONFIG_trailer + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_wheel_position);
  // Full name of config attribute @code(wheel_steerable) in @code(trailer) configuration.
  SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_steerable         = TelemetryString(SCS_TELEMETRY_CONFIG_trailer + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_wheel_steerable);
  // Full name of config attribute @code(wheel_simulated) in @code(trailer) configuration.
  SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_simulated         = TelemetryString(SCS_TELEMETRY_CONFIG_trailer + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_wheel_simulated);
  // Full name of config attribute @code(wheel_radius) in @code(trailer) configuration.
  SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_radius            = TelemetryString(SCS_TELEMETRY_CONFIG_trailer + cConfigFieldsSeparator + SCS_TELEMETRY_CONFIG_ATTRIBUTE_wheel_radius);

{==============================================================================}
{    Config IDs                                                                }
{==============================================================================}

{$IFNDEF PrecomputedItemIDs}
  {$WRITEABLECONST ON}
{$ENDIF}

  // Identification number for SCS_TELEMETRY_CONFIG_substances_ATTRIBUTE_id config.
  SCS_TELEMETRY_CONFIG_ID_substances_ATTRIBUTE_id:                   TConfigID = $A1E920F4;

  // Identification number for SCS_TELEMETRY_CONFIG_controls_ATTRIBUTE_shifter_type config.
  SCS_TELEMETRY_CONFIG_ID_controls_ATTRIBUTE_shifter_type:           TConfigID = $37BA5313;

  // Identification number for SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_selector_count config.
  SCS_TELEMETRY_CONFIG_ID_hshifter_ATTRIBUTE_selector_count:         TConfigID = $AA57ECAD;
  // Identification number for SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_slot_gear config.
  SCS_TELEMETRY_CONFIG_ID_hshifter_ATTRIBUTE_slot_gear:              TConfigID = $601E49BB;
  // Identification number for SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_slot_handle_position config.
  SCS_TELEMETRY_CONFIG_ID_hshifter_ATTRIBUTE_slot_handle_position:   TConfigID = $4C2725D0;
  // Identification number for SCS_TELEMETRY_CONFIG_shifter_ATTRIBUTE_slot_selectors config.
  SCS_TELEMETRY_CONFIG_ID_hshifter_ATTRIBUTE_slot_selectors:         TConfigID = $1705F155;

  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_brand_id config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_brand_id:                  TConfigID = $CFEC235C;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_brand config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_brand:                     TConfigID = $5DF796E6;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_id config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_id:                        TConfigID = $93A67EA9;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_name config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_name:                      TConfigID = $FF36A0AD;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_fuel_capacity config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_fuel_capacity:             TConfigID = $FFEA5570;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_fuel_warning_factor config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_fuel_warning_factor:       TConfigID = $766BF114;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_adblue_capacity config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_adblue_capacity:           TConfigID = $CBE6B731;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_air_pressure_warning config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_air_pressure_warning:      TConfigID = $C58F8B5A;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_air_pressure_emergency config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_air_pressure_emergency:    TConfigID = $78FAD40D;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_oil_pressure_warning config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_oil_pressure_warning:      TConfigID = $1A1815C5; 
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_water_temperature_warning config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_water_temperature_warning: TConfigID = $783F3300;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_battery_voltage_warning config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_battery_voltage_warning:   TConfigID = $26000473;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_rpm_limit config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_rpm_limit:                 TConfigID = $96F2B46D;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_forward_gear_count config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_forward_gear_count:        TConfigID = $620CEB70;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_reverse_gear_count config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_reverse_gear_count:        TConfigID = $2FEA55E1;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_retarder_step_count config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_retarder_step_count:       TConfigID = $F8E36BF0;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_cabin_position config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_cabin_position:            TConfigID = $E37B50B2;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_head_position config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_head_position:             TConfigID = $59DED2CB;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_hook_position config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_hook_position:             TConfigID = $10944A21;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_count config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_wheel_count:               TConfigID = $D634DC01;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_position config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_wheel_position:            TConfigID = $61874258;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_steerable config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_wheel_steerable:           TConfigID = $91817077;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_simulated config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_wheel_simulated:           TConfigID = $27B8658F;
  // Identification number for SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_radius config.
  SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_wheel_radius:              TConfigID = $60D54CB6;

  // Identification number for SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_id config.
  SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_id:                      TConfigID = $E3F34E9A;
  // Identification number for SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_cargo_accessory_id config.
  SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_cargo_accessory_id:      TConfigID = $7E792A8A;
  // Identification number for SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_hook_position config.
  SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_hook_position:           TConfigID = $5D7A70AD;
  // Identification number for SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_count config.
  SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_wheel_count:             TConfigID = $8A6F0861;
  // Identification number for SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_position config.
  SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_wheel_position:          TConfigID = $85C46369;
  // Identification number for SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_steerable config.
  SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_wheel_steerable:         TConfigID = $C0BB336C;
  // Identification number for SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_simulated config.
  SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_wheel_simulated:         TConfigID = $76822694;
  // Identification number for SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_radius config.
  SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_wheel_radius:            TConfigID = $3C8E98D6;

{==============================================================================}
{    Channel IDs                                                               }
{==============================================================================}

  // Identification number for @code(SCS_TELEMETRY_CHANNEL_local_scale) channel.
  SCS_TELEMETRY_CHANNEL_ID_local_scale:                        TChannelID = $33DE67E4;

  // Identification number for @code(SCS_TELEMETRY_TRAILER_CHANNEL_connected) channel.
  SCS_TELEMETRY_TRAILER_CHANNEL_ID_connected:                  TChannelID = $7007CCEE;

  // Identification number for @code(SCS_TELEMETRY_TRAILER_CHANNEL_world_placement) channel.
  SCS_TELEMETRY_TRAILER_CHANNEL_ID_world_placement:            TChannelID = $3A729370;
  // Identification number for @code(SCS_TELEMETRY_TRAILER_CHANNEL_local_linear_velocity) channel.
  SCS_TELEMETRY_TRAILER_CHANNEL_ID_local_linear_velocity:      TChannelID = $AE80C1D0;
  // Identification number for @code(SCS_TELEMETRY_TRAILER_CHANNEL_local_angular_velocity) channel.
  SCS_TELEMETRY_TRAILER_CHANNEL_ID_local_angular_velocity:     TChannelID = $A2981BDF;
  // Identification number for @code(SCS_TELEMETRY_TRAILER_CHANNEL_local_linear_acceleration) channel.
  SCS_TELEMETRY_TRAILER_CHANNEL_ID_local_linear_acceleration:  TChannelID = $99A57FA9;
  // Identification number for @code(SCS_TELEMETRY_TRAILER_CHANNEL_local_angular_acceleration) channel.
  SCS_TELEMETRY_TRAILER_CHANNEL_ID_local_angular_acceleration: TChannelID = $8B76F7F9;

  // Identification number for @code(SCS_TELEMETRY_TRAILER_CHANNEL_wear_chassis) channel.
  SCS_TELEMETRY_TRAILER_CHANNEL_ID_wear_chassis:               TChannelID = $E071BE1A;

  // Identification number for @code(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_susp_deflection) channel.
  SCS_TELEMETRY_TRAILER_CHANNEL_ID_wheel_susp_deflection:      TChannelID = $1E44DA91;
  // Identification number for @code(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_on_ground) channel.
  SCS_TELEMETRY_TRAILER_CHANNEL_ID_wheel_on_ground:            TChannelID = $9A68642F;
  // Identification number for @code(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_substance) channel.
  SCS_TELEMETRY_TRAILER_CHANNEL_ID_wheel_substance:            TChannelID = $1DFBFCF1;
  // Identification number for @code(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_velocity) channel.
  SCS_TELEMETRY_TRAILER_CHANNEL_ID_wheel_velocity:             TChannelID = $C387243E;
  // Identification number for @code(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_steering) channel.
  SCS_TELEMETRY_TRAILER_CHANNEL_ID_wheel_steering:             TChannelID = $3B417600;
  // Identification number for @code(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_rotation) channel.
  SCS_TELEMETRY_TRAILER_CHANNEL_ID_wheel_rotation:             TChannelID = $EA941F6D;

  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_world_placement) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_world_placement:              TChannelID = $6B48D06B;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_local_linear_velocity) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_local_linear_velocity:        TChannelID = $5D9D7AB3;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_local_angular_velocity) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_local_angular_velocity:       TChannelID = $76D03686;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_local_linear_acceleration) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_local_linear_acceleration:    TChannelID = $A2E5F90F;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_local_angular_acceleration) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_local_angular_acceleration:   TChannelID = $B4F8B1A2;

  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_cabin_orientation) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_cabin_orientation:            TChannelID = $36F3F15D;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_cabin_offset) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_cabin_offset:                 TChannelID = $303DEF2A;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_cabin_angular_velocity) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_cabin_angular_velocity:       TChannelID = $10976F36;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_cabin_angular_acceleration) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_cabin_angular_acceleration:   TChannelID = $D10EF7A8;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_head_offset) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_head_offset:                  TChannelID = $EEE287E8;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_speed) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_speed:                        TChannelID = $4E839148;

  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_engine_rpm) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_engine_rpm:                   TChannelID = $160E7B38;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_engine_gear) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_engine_gear:                  TChannelID = $9582C042;

  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_input_steering) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_input_steering:               TChannelID = $DCFA7E3B;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_input_throttle) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_input_throttle:               TChannelID = $CF8FC74B;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_input_brake) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_input_brake:                  TChannelID = $5EEDB702;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_input_clutch) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_input_clutch:                 TChannelID = $F5ECF339;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_effective_steering) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_effective_steering:           TChannelID = $94181EAB;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_effective_throttle) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_effective_throttle:           TChannelID = $876DA7DB;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_effective_brake) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_effective_brake:              TChannelID = $47E5F7F0;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_effective_clutch) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_effective_clutch:             TChannelID = $A6466849;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_cruise_control) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_cruise_control:               TChannelID = $C31E2094;

  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_hshifter_slot) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_hshifter_slot:                TChannelID = $36C98B9D;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_hshifter_selector) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_hshifter_selector:            TChannelID = $E4A50350;

  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_parking_brake) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_parking_brake:                TChannelID = $5664B035;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_motor_brake) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_motor_brake:                  TChannelID = $8E0C8ABA;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_retarder_level) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_retarder_level:               TChannelID = $A8D6B016;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_brake_air_pressure) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_brake_air_pressure:           TChannelID = $9384DD05;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_brake_air_pressure_warning) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_brake_air_pressure_warning:   TChannelID = $C58F8B5A;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_brake_temperature) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_brake_temperature:            TChannelID = $E1AE4E3F;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_brake_air_pressure_emergency) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_brake_air_pressure_emergency: TChannelID = $78FAD40D;

  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_fuel) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_fuel:                         TChannelID = $C298DD2D;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_fuel_warning) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_fuel_warning:                 TChannelID = $9D0FD9A2;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_fuel_average_consumption) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_fuel_average_consumption:     TChannelID = $013149D4;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_adblue) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_adblue:                       TChannelID = $8D32829D;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_adblue_warning) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_adblue_warning:               TChannelID = $FF3464CB;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_adblue_average_consumption) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_adblue_average_consumption:   TChannelID = $C253FC24;

  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_oil_pressure) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_oil_pressure:                 TChannelID = $A368F9A6;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_oil_pressure_warning) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_oil_pressure_warning:         TChannelID = $1A1815C5;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_oil_temperature) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_oil_temperature:              TChannelID = $405A67E9;

  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_water_temperature) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_water_temperature:            TChannelID = $B8B46564;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_water_temperature_warning) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_water_temperature_warning:    TChannelID = $783F3300;

  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_battery_voltage) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_battery_voltage:              TChannelID = $91BB0105;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_battery_voltage_warning) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_battery_voltage_warning:      TChannelID = $26000473;

  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_electric_enabled) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_electric_enabled:             TChannelID = $9D4D7843;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_engine_enabled) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_engine_enabled:               TChannelID = $FACA0BF9;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_lblinker) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_lblinker:                     TChannelID = $A7B8351B;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_rblinker) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_rblinker:                     TChannelID = $CE891602;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_light_parking) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_parking:                TChannelID = $6931D205;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_light_rblinker) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_rblinker:               TChannelID = $85F18F7B;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_light_lblinker) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_lblinker:               TChannelID = $ECC0AC62;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_light_low_beam) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_low_beam:               TChannelID = $612D677D;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_light_high_beam) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_high_beam:              TChannelID = $7E93DFB5;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_light_aux_front) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_aux_front:              TChannelID = $D6464C43;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_light_aux_roof) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_aux_roof:               TChannelID = $5ADBA32B;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_light_beacon) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_beacon:                 TChannelID = $990180CD;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_light_brake) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_brake:                  TChannelID = $E2790B7B;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_light_reverse) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_reverse:                TChannelID = $71711168;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_wipers) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_wipers:                       TChannelID = $EE7920A7;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_dashboard_backlight) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_dashboard_backlight:          TChannelID = $91DA5D6D;

  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_wear_engine) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_wear_engine:                  TChannelID = $D89A5F14;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_wear_transmission) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_wear_transmission:            TChannelID = $ABB45C97;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_wear_cabin) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_wear_cabin:                   TChannelID = $49F699F6;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_wear_chassis) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_wear_chassis:                 TChannelID = $BC2A6A7A;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_wear_wheels) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_wear_wheels:                  TChannelID = $7C35EF18;

  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_odometer) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_odometer:                     TChannelID = $F988B0E0;

  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_susp_deflection) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_wheel_susp_deflection:        TChannelID = $369CAB49;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_on_ground) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_wheel_on_ground:              TChannelID = $CB522734;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_substance) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_wheel_substance:              TChannelID = $4CC1BFEA;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_velocity) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_wheel_velocity:               TChannelID = $B7B25C28;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_steering) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_wheel_steering:               TChannelID = $DF025731;
  // Identification number for @code(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_rotation) channel.
  SCS_TELEMETRY_TRUCK_CHANNEL_ID_wheel_rotation:               TChannelID = $0ED73E5C;

{$IFNDEF PrecomputedItemIDs}
  {$WRITEABLECONST OFF}
{$ENDIF}

{==============================================================================}
{    Unit Functions and procedures declarations                                }
{==============================================================================}

{
  @abstract(Function used to get identifier of passed item name.)
  At the moment, identifiers are implemented as CRC32 checksum of given item
  name (string).

  @param Item Item name.

  @returns Item identificator.
}
  Function GetItemID(const Item: TelemetryString): TItemID;

//------------------------------------------------------------------------------

{
  @abstract(Returns textual representation of item ID.)

  @param ID Item ID to be converted to text.

  @returns Textual representation of passed ID.
}
  Function ItemIDToStr(ID: TItemID): String;

//------------------------------------------------------------------------------

{$IFNDEF PrecomputedItemIDs}
{
  @abstract(Procedure calculating identification numbers for channels and
  configs.)
  When you call this routine, it recalculates all ID constants. Use it only when
  you truly need this recalculation.@br
  It is called automatically in initialization section of this unit when neither
  of @code(PrecomputedItemIDs) and @code(ManualItemIDsCompute) switches is
  defined.
}
  procedure InitializeItemsIDs;
{$ENDIF}

//------------------------------------------------------------------------------

{
  Returns full config name composed from config id and attribute name separated
  by cConfigFieldsSeparator.

  @param ConfigID      ID of configuration.
  @param AttributeName Name of attribute.

  @returns Full config name.
}
  Function ConfigMergeIDAndAttribute(const ConfigID, AttributeName: TelemetryString): TelemetryString;

//------------------------------------------------------------------------------

{
  @abstract(Removes passed config id from full config name.)
  @bold(Note) - function does not control whether passed name truly starts with
  given config id. It simply removes number of characters corresponding to
  length of config id from the start of config name.

  @param ConfigName Name of config from which id should be removed.
  @param ConfigID   Id that has be removed from passed config name.

  @returns Config name with removed id.
}
  Function ConfigRemoveIDFromName(const ConfigName, ConfigID: TelemetryString): TelemetryString;

implementation

{==============================================================================}
{    Unit Functions and procedures implementation                              }
{==============================================================================}

Function GetItemID(const Item: TelemetryString): TItemID;
begin
Result := BufferCRC32(InitialCRC32,PUTF8Char(Item)^,Length(Item) * SizeOf(TUTF8Char));
end;

//------------------------------------------------------------------------------

Function ItemIDToStr(ID: TItemID): String;
begin
Result := CRC32ToStr(ID);
end;

//------------------------------------------------------------------------------

{$IFNDEF PrecomputedItemIDs}
procedure InitializeItemsIDs;
begin
//---                              Configs IDs                               ---
SCS_TELEMETRY_CONFIG_ID_substances_ATTRIBUTE_id                   := GetItemID(SCS_TELEMETRY_CONFIG_substances_ATTRIBUTE_id);

SCS_TELEMETRY_CONFIG_ID_controls_ATTRIBUTE_shifter_type           := GetItemID(SCS_TELEMETRY_CONFIG_controls_ATTRIBUTE_shifter_type);

SCS_TELEMETRY_CONFIG_ID_hshifter_ATTRIBUTE_selector_count         := GetItemID(SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_selector_count);
SCS_TELEMETRY_CONFIG_ID_hshifter_ATTRIBUTE_slot_gear              := GetItemID(SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_slot_gear);
SCS_TELEMETRY_CONFIG_ID_hshifter_ATTRIBUTE_slot_handle_position   := GetItemID(SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_slot_handle_position);
SCS_TELEMETRY_CONFIG_ID_hshifter_ATTRIBUTE_slot_selectors         := GetItemID(SCS_TELEMETRY_CONFIG_hshifter_ATTRIBUTE_slot_selectors);

SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_brand_id                  := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_brand_id);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_brand                     := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_brand);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_id                        := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_id);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_name                      := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_name);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_fuel_capacity             := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_fuel_capacity);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_fuel_warning_factor       := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_fuel_warning_factor);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_adblue_capacity           := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_adblue_capacity);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_air_pressure_warning      := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_air_pressure_warning);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_air_pressure_emergency    := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_air_pressure_emergency);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_oil_pressure_warning      := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_oil_pressure_warning);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_water_temperature_warning := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_water_temperature_warning);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_battery_voltage_warning   := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_battery_voltage_warning);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_rpm_limit                 := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_rpm_limit);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_forward_gear_count        := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_forward_gear_count);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_reverse_gear_count        := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_reverse_gear_count);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_retarder_step_count       := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_retarder_step_count);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_cabin_position            := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_cabin_position);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_head_position             := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_head_position);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_hook_position             := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_hook_position);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_wheel_count               := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_count);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_wheel_position            := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_position);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_wheel_steerable           := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_steerable);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_wheel_simulated           := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_simulated);
SCS_TELEMETRY_CONFIG_ID_truck_ATTRIBUTE_wheel_radius              := GetItemID(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_wheel_radius);

SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_id                      := GetItemID(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_id);
SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_cargo_accessory_id      := GetItemID(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_cargo_accessory_id);
SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_hook_position           := GetItemID(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_hook_position);
SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_wheel_count             := GetItemID(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_count);
SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_wheel_position          := GetItemID(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_position);
SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_wheel_steerable         := GetItemID(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_steerable);
SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_wheel_simulated         := GetItemID(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_simulated);
SCS_TELEMETRY_CONFIG_ID_trailer_ATTRIBUTE_wheel_radius            := GetItemID(SCS_TELEMETRY_CONFIG_trailer_ATTRIBUTE_wheel_radius);

//---                              Channels IDs                              ---
SCS_TELEMETRY_CHANNEL_ID_local_scale                         := GetItemID(SCS_TELEMETRY_CHANNEL_local_scale);

SCS_TELEMETRY_TRAILER_CHANNEL_ID_connected                   := GetItemID(SCS_TELEMETRY_TRAILER_CHANNEL_connected);

SCS_TELEMETRY_TRAILER_CHANNEL_ID_world_placement             := GetItemID(SCS_TELEMETRY_TRAILER_CHANNEL_world_placement);
SCS_TELEMETRY_TRAILER_CHANNEL_ID_local_linear_velocity       := GetItemID(SCS_TELEMETRY_TRAILER_CHANNEL_local_linear_velocity);
SCS_TELEMETRY_TRAILER_CHANNEL_ID_local_angular_velocity      := GetItemID(SCS_TELEMETRY_TRAILER_CHANNEL_local_angular_velocity);
SCS_TELEMETRY_TRAILER_CHANNEL_ID_local_linear_acceleration   := GetItemID(SCS_TELEMETRY_TRAILER_CHANNEL_local_linear_acceleration);
SCS_TELEMETRY_TRAILER_CHANNEL_ID_local_angular_acceleration  := GetItemID(SCS_TELEMETRY_TRAILER_CHANNEL_local_angular_acceleration);

SCS_TELEMETRY_TRAILER_CHANNEL_ID_wear_chassis                := GetItemID(SCS_TELEMETRY_TRAILER_CHANNEL_wear_chassis);

SCS_TELEMETRY_TRAILER_CHANNEL_ID_wheel_susp_deflection       := GetItemID(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_susp_deflection);
SCS_TELEMETRY_TRAILER_CHANNEL_ID_wheel_on_ground             := GetItemID(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_on_ground);
SCS_TELEMETRY_TRAILER_CHANNEL_ID_wheel_substance             := GetItemID(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_substance);
SCS_TELEMETRY_TRAILER_CHANNEL_ID_wheel_velocity              := GetItemID(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_velocity);
SCS_TELEMETRY_TRAILER_CHANNEL_ID_wheel_steering              := GetItemID(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_steering);
SCS_TELEMETRY_TRAILER_CHANNEL_ID_wheel_rotation              := GetItemID(SCS_TELEMETRY_TRAILER_CHANNEL_wheel_rotation);

SCS_TELEMETRY_TRUCK_CHANNEL_ID_world_placement               := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_world_placement);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_local_linear_velocity         := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_local_linear_velocity);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_local_angular_velocity        := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_local_angular_velocity);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_local_linear_acceleration     := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_local_linear_acceleration);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_local_angular_acceleration    := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_local_angular_acceleration);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_cabin_orientation             := GetItemID('truck.cabin.orientation');

SCS_TELEMETRY_TRUCK_CHANNEL_ID_cabin_offset                  := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_cabin_offset);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_cabin_angular_velocity        := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_cabin_angular_velocity);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_cabin_angular_acceleration    := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_cabin_angular_acceleration);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_head_offset                   := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_head_offset);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_speed                         := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_speed);

SCS_TELEMETRY_TRUCK_CHANNEL_ID_engine_rpm                    := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_engine_rpm);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_engine_gear                   := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_engine_gear);

SCS_TELEMETRY_TRUCK_CHANNEL_ID_input_steering                := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_input_steering);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_input_throttle                := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_input_throttle);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_input_brake                   := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_input_brake);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_input_clutch                  := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_input_clutch);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_effective_steering            := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_effective_steering);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_effective_throttle            := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_effective_throttle);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_effective_brake               := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_effective_brake);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_effective_clutch              := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_effective_clutch);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_cruise_control                := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_cruise_control);

SCS_TELEMETRY_TRUCK_CHANNEL_ID_hshifter_slot                 := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_hshifter_slot);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_hshifter_selector             := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_hshifter_selector);

SCS_TELEMETRY_TRUCK_CHANNEL_ID_parking_brake                 := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_parking_brake);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_motor_brake                   := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_motor_brake);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_retarder_level                := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_retarder_level);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_brake_air_pressure            := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_brake_air_pressure);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_brake_air_pressure_warning    := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_brake_air_pressure_warning);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_brake_temperature             := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_brake_temperature);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_brake_air_pressure_emergency  := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_brake_air_pressure_emergency);

SCS_TELEMETRY_TRUCK_CHANNEL_ID_fuel                          := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_fuel);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_fuel_warning                  := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_fuel_warning);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_fuel_average_consumption      := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_fuel_average_consumption);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_adblue                        := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_adblue);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_adblue_warning                := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_adblue_warning);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_adblue_average_consumption    := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_adblue_average_consumption);

SCS_TELEMETRY_TRUCK_CHANNEL_ID_oil_pressure                  := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_oil_pressure);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_oil_pressure_warning          := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_oil_pressure_warning);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_oil_temperature               := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_oil_temperature);

SCS_TELEMETRY_TRUCK_CHANNEL_ID_water_temperature             := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_water_temperature);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_water_temperature_warning     := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_water_temperature_warning);

SCS_TELEMETRY_TRUCK_CHANNEL_ID_battery_voltage               := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_battery_voltage);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_battery_voltage_warning       := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_battery_voltage_warning);

SCS_TELEMETRY_TRUCK_CHANNEL_ID_electric_enabled              := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_electric_enabled);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_engine_enabled                := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_engine_enabled);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_lblinker                      := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_lblinker);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_rblinker                      := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_rblinker);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_parking                 := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_light_parking);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_rblinker                := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_light_rblinker);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_lblinker                := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_light_lblinker);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_low_beam                := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_light_low_beam);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_high_beam               := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_light_high_beam);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_aux_front               := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_light_aux_front);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_aux_roof                := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_light_aux_roof);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_beacon                  := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_light_beacon);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_brake                   := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_light_brake);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_light_reverse                 := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_light_reverse);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_wipers                        := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_wipers);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_dashboard_backlight           := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_dashboard_backlight);

SCS_TELEMETRY_TRUCK_CHANNEL_ID_wear_engine                   := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_wear_engine);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_wear_transmission             := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_wear_transmission);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_wear_cabin                    := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_wear_cabin);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_wear_chassis                  := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_wear_chassis);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_wear_wheels                   := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_wear_wheels);

SCS_TELEMETRY_TRUCK_CHANNEL_ID_odometer                      := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_odometer);

SCS_TELEMETRY_TRUCK_CHANNEL_ID_wheel_susp_deflection         := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_susp_deflection);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_wheel_on_ground               := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_on_ground);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_wheel_substance               := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_substance);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_wheel_velocity                := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_velocity);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_wheel_steering                := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_steering);
SCS_TELEMETRY_TRUCK_CHANNEL_ID_wheel_rotation                := GetItemID(SCS_TELEMETRY_TRUCK_CHANNEL_wheel_rotation);
end;
{$ENDIF}

//------------------------------------------------------------------------------

Function ConfigMergeIDAndAttribute(const ConfigID, AttributeName: TelemetryString): TelemetryString;
begin
Result := ConfigID + cConfigFieldsSeparator + AttributeName;
end;

//------------------------------------------------------------------------------

Function ConfigRemoveIDFromName(const ConfigName,ConfigID: TelemetryString): TelemetryString;
begin
Result := Copy(ConfigName,Length(ConfigID) + Length(cConfigFieldsSeparator) + 1, Length(ConfigName));
end;

{==============================================================================}
{    Initialization section                                                    }
{==============================================================================}

{$IF not Defined(PrecomputedItemIDs) and not Defined(ManualItemIDsCompute)}
initialization 
  InitializeItemsIDs;
{$IFEND}

end.
