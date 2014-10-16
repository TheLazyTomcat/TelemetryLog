{@html(<hr>)
@abstract(Types, constants, routines, etc. used troughout the Telemetry library.)
@author(František Milt <fmilt@seznam.cz>)
@created(2013-10-04)
@lastmod(2014-05-05)

  @bold(@NoAutoLink(TelemetryCommon))

  ©František Milt, all rights reserved.

  This file is intended to provide types, constants, routines, etc. used
  throughout the Telemetry library (that is, in more than one unit).

  Last change:  2014-05-05

  Change List:@unorderedList(
    @item(2013-10-04 - First stable version.)
    @item(2014-04-06 - TGameSupportInfo.GameID and
                       scs_value_localized_t.StringData fields type changed to
                       @code(TelemetryString).)
    @item(2014-04-18 - cConfigFieldsSeparator constant moved to TelemetryIDs
                       unit.)
    @item(2014-04-20 - Added following types:@unorderedList(
                         @itemSpacing(Compact)
                         @item(scs_named_value_localized_t)
                         @item(p_scs_named_value_localized_t)
                         @item(scs_telemetry_configuration_localized_t)
                         @item(p_scs_telemetry_configuration_localized_t)))                          
    @item(2014-04-20 - Functions scs_value_localized and scs_value moved to
                       TelemetryStreaming unit.)
    @item(2014-05-05 - TMulticastEvent placeholder added.))

@html(<hr>)}
unit TelemetryCommon;

interface

{$INCLUDE '.\Telemetry_defs.inc'}

uses
{$IFDEF UseCondensedHeader}
  SCS_Telemetry_Condensed;
{$ELSE}
  scssdk,
  scssdk_value;
{$ENDIF}

type
{$IFDEF MulticastEvents}
  {$IFDEF Documentation}
    // @abstract(Placeholder intended to complete the classes hierarchy tree in
    // documentation.)
    // Actual class is defined in unit MulticastEvent and is not included in
    // documentation of telemetry library. Refer to mentioned unit located in
    // folder @italic(Source\Libs) for details.
    TMulticastEvent = class(TObject);
  {$ENDIF}
{$ENDIF}

{
  @abstract(Structure used internally in tables that keeps informations about
  supported games and their versions.)

  @member GameID       Internal game identificator (not a game name).
  @member(GameVersion  Internal game version (API-specific value - not equal
                       to actual game version).)
}
  TGameSupportInfo = record
    GameID:       TelemetryString;
    GameVersion:  scs_u32_t;
  end;
  // Pointer to TGameSupportInfo structure.
  PGameSupportInfo = ^TGameSupportInfo;


{
  @abstract(Structure used to store content of @code(scs_value_t) variable.)
  @code(scs_value_t) is using pointers for some values, so it cannot be stored
  directly, as only reference and no actual data would be stored.@br
  Use this structure along with call to scs_value_localized function to store
  content of a variable of type @code(scs_value_t).

  @member ValueType  Type of stored value.
  @member BinaryData Stored binary data (eg. integers, floats).
  @member(StringData Stored string data (used only when string data are stored,
                     empty otherwise).)
}
  scs_value_localized_t = record
    ValueType:  scs_value_type_t;
    BinaryData: scs_value_t;
    StringData: TelemetryString;
  end;
  // Pointer to scs_value_localized_t structure.
  p_scs_value_localized_t = ^scs_value_localized_t;


{
  @abstract(Structure used to store content of @code(scs_named_value_t)
            variable.)
  @code(scs_named_value_t) is using pointers for some values, so it cannot be
  stored directly, as only reference and no actual data would be stored.@br
  Use this structure along with call to scs_named_value_localized function to
  store content of a variable of type @code(scs_named_value_t).

  @member Name  @NoAutoLink(Name) of the @NoAutoLink(value).
  @member Index @NoAutoLink(Index) of the @NoAutoLink(value).
  @member Value Named @NoAutoLink(value) itself.
}  
  scs_named_value_localized_t = record
    Name:   TelemetryString;
    Index:  scs_u32_t;
    Value:  scs_value_localized_t;
  end;
  // Pointer to scs_named_value_localized_t structure.
  p_scs_named_value_localized_t = ^scs_named_value_localized_t;


{
  @abstract(Structure used to store content of
  @code(scs_telemetry_configuration_t) variable.)
  @code(scs_telemetry_configuration_t) is using pointers for some values, so it
  cannot be stored directly, as only reference and no actual data would be
  stored.@br
  Use this structure along with call to scs_telemetry_configuration_localized
  function to store content of a variable of type
  @code(scs_telemetry_configuration_t).

  @member ID         Configuration identifier.
  @member(Attributes Array of named values (@NoAutoLink(attributes)) this
                     configuration contains.)
}
  scs_telemetry_configuration_localized_t = record
    ID:         TelemetryString;
    Attributes: Array of scs_named_value_localized_t
  end;
  // Pointer to scs_telemetry_configuration_localized_t structure.
  p_scs_telemetry_configuration_localized_t = ^scs_telemetry_configuration_localized_t;

const
  // Constant containing an empty @code(scs_value_t) structure, or, more
  // precisely, structure with invalid value type.
  cEmptySCSValue: scs_value_t = (_type: SCS_VALUE_TYPE_INVALID);

  // Constant containing an empty scs_value_localized_t structure (invalid value
  // type).
  cEmptySCSValueLocalized: scs_value_localized_t = (ValueType: SCS_VALUE_TYPE_INVALID);


implementation

end.
