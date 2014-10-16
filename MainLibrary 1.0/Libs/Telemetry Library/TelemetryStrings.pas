{@html(<hr>)
@abstract(Unit providing routines operating on @code(TelemetryString) type and
          routines converting selected binary types to text.)
@author(František Milt <fmilt@seznam.cz>)
@created(2014-04-30)
@lastmod(2014-04-30)

  @bold(@NoAutoLink(TelemetryStrings))

  ©František Milt, all rights reserved.

  This unit is intended to provide some basic routines for manipulation and
  processing of @code(TelemetryString) type (UTF8 encoded string) and also
  routines designed to return human readable (i.e. textual) representation of
  binary data stored in variables of selected types.

  Last change:  2014-04-30

  Change List:@unorderedList(
    @item(2014-04-30 - First stable version.)
    @item(2014-04-30 - Unit @code(TelemetryRecipientAux) was completely merged
                       into this unit.))

@html(<hr>)}
unit TelemetryStrings;

interface

{$INCLUDE '.\Telemetry_defs.inc'}

uses
  TelemetryCommon,
{$IFDEF UseCondensedHeader}
  SCS_Telemetry_Condensed;
{$ELSE}
  scssdk,
  scssdk_value,
  scssdk_telemetry_event;
{$ENDIF}

{==============================================================================}
{    Unit Functions and procedures declarations                                }
{==============================================================================}

{
  @abstract(Compares strings based on the current locale with case sensitivity.)
  Since the @code(TelemetryString) is UTF8-encoded and there is no function
  for comparison of such strings, both strings are converted to WideString
  before actual comparison takes place.@br
  This function can be slow, so if performance is important, consider using
  TelemetrySameStrNoConv instead.

  @param S1 First string to compare.
  @param S2 Second string to compare.

  @returns @True when the strings have the same value, @false otherwise.
}
Function TelemetrySameStr(const S1, S2: TelemetryString): Boolean;

{
  @abstract(Compares strings based on the current locale without case
  sensitivity.)
  Since the @code(TelemetryString) is UTF8-encoded and there is no function
  for comparison of such strings, both strings are converted to WideString
  before actual comparison takes place.@br
  This function can be slow, so if performance is important, consider using
  TelemetrySameTextNoConv instead.

  @param S1 First string to compare.
  @param S2 Second string to compare.

  @returns @True when the strings have the same value, @false otherwise.
}
Function TelemetrySameText(const S1, S2: TelemetryString): Boolean;

{
  @abstract(Compares strings based on the current locale with case sensitivity
  and without internal conversions.)
  Unlike TelemetrySameStr, this function does not convert input strings to
  WideString before comparison. Instead, both strings are treated as normal
  AnsiString. This requires that both strings contains only ASCII characters
  (that is, up to #126), otherwise the function can, and probably will, return
  wrong result.

  @param S1 First string to compare.
  @param S2 Second string to compare.

  @returns @True when the strings have the same value, @false otherwise.
}
Function TelemetrySameStrNoConv(const S1, S2: TelemetryString): Boolean;

{
  @abstract(Compares strings based on the current locale without case
  sensitivity and without internal conversions.)
  Unlike TelemetrySameText, this function does not convert input strings to
  WideString before comparison. Instead, both strings are treated as normal
  AnsiString. This requires that both strings contains only ASCII characters
  (that is, up to #126), otherwise the function can, and probably will, return
  wrong result.

  @param S1 First string to compare.
  @param S2 Second string to compare.

  @returns @True when the strings have the same value, @false otherwise.
}
Function TelemetrySameTextNoConv(const S1, S2: TelemetryString): Boolean;

//==============================================================================

{
  @abstract(Returns identifier of given SCS value type.)
  Identifiers are not defined by the API, for details about naming individual
  types refer to function implementation.

  @param SCSValueType Value type.

  @returns Textual identifier of given value type.
}
Function SCSValueTypeToStr(SCSValueType: scs_value_type_t): String;

//------------------------------------------------------------------------------

{
  @abstract(Returns value type given by identifier.)
  If identifier is not recognized, then @code(SCS_VALUE_TYPE_INVALID) is
  returned.@br
  Function is case-insensitive.@br
  Identifiers are not defined by the API, for details about naming individual
  types refer to function implementation.

  @param Str Textual identifier of value type.

  @returns Value type with name corresponding to passed textual identifier.
}
Function SCSValueTypeFromStr(Str: String): scs_value_type_t;

//------------------------------------------------------------------------------

{
  @abstract(Returns textual representation of @code(scs_value_t) structure.)
  When type of the value is not known, an empty string is returned.

  @param Value           Actual value to be converted to text.
  @param(TypeName        When set, value type identifier is added to output
                         string.)
  @param(ShowDescriptors When set, fileds descriptors are shown for composite
                         values.)

  @returns Textual representation of given value.
}
Function SCSValueToStr(const Value: scs_value_t; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String;

//------------------------------------------------------------------------------

{
  @abstract(Returns textual representation of scs_value_localized_t structure.)

  @param Value           Actual value to be converted to text.
  @param(TypeName        When set, value type identifier is added to output
                         string.)
  @param(ShowDescriptors When set, fileds descriptors are shown for composite
                         values.)

  @returns Textual representation of given value.
}
Function SCSValueLocalizedToStr(Value: scs_value_localized_t; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String;

//------------------------------------------------------------------------------

{
  @abstract(Returns textual representation of @code(scs_named_value_t)
            structure.)

  @param Value           Actual value to be converted to text.
  @param(TypeName        When set, value type identifier is added to output
                         string.)
  @param(ShowDescriptors When set, fileds descriptors are shown for composite
                         values.)

  @returns Textual representation of given value.
}
Function SCSNamedValueToStr(Value: scs_named_value_t; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String;

//------------------------------------------------------------------------------

{
  @abstract(Returns textual representation of scs_named_value_localized_t
            structure.)

  @param Value           Actual value to be converted to text.
  @param(TypeName        When set, value type identifier is added to output
                         string.)
  @param(ShowDescriptors When set, fileds descriptors are shown for composite
                         values.)

  @returns Textual representation of given value.
}
Function SCSNamedValueLocalizedToStr(Value: scs_named_value_localized_t; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String;

//------------------------------------------------------------------------------

{
  @abstract(Returns textual representation of @code(scs_telemetry_frame_start_t)
            structure.)

  @param Data     Structure to be converted to text.
  @param(TypeName When set, value type identifiers for individual fields are
                  added to output string.)

  @returns Textual representation of given structure.
}
Function TelemetryEventFrameStartToStr(const Data: scs_telemetry_frame_start_t; TypeName: Boolean = False): String;

//------------------------------------------------------------------------------

{
  @abstract(Returns textual representation of
            @code(scs_telemetry_configuration_t) structure.)

  @param Data            Structure to be converted to text.
  @param(TypeName        When set, value type identifiers for individual
                         attribute values are added to output.)
  @param(ShowDescriptors When set, fields descriptors are shown for composite
                         values.)

  @returns Textual representation of given structure.                          
}
Function TelemetryEventConfigurationToStr(const Data: scs_telemetry_configuration_t; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String;

//------------------------------------------------------------------------------

{
  @abstract(Returns textual representation of
            scs_telemetry_configuration_localized_t structure.)

  @param Data            Structure to be converted to text.
  @param(TypeName        When set, value type identifiers for individual
                         attribute values are added to output.)
  @param(ShowDescriptors When set, fields descriptors are shown for composite
                         values.)

  @returns Textual representation of given structure.                          
}
Function TelemetryEventConfigurationLocalizedToStr(const Data: scs_telemetry_configuration_localized_t; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String;

implementation

uses
  Windows, SysUtils;

{==============================================================================}
{    Constants, types, variables, etc...                                       }
{==============================================================================}

const
  // Table of identifiers for individual value types (scs_value_type_t).
  // Index of each string corresponds to value type number this string is
  // identifying.
  cSCSValueTypeIdentifiers: Array[0..12] of String =
    ('none','bool','s32','u32','u64','float','double','fvector','dvector',
     'euler','fplacement','dplacement','string');

var
  // Used for thread safety in conversions dependent on LocaleID.
  // Initialized in Initialization section of this unit (with id set to
  // LOCALE_USER_DEFAULT).
  FormatSettings: TFormatSettings;

{==============================================================================}
{    Unit Functions and procedures implementation                              }
{==============================================================================}

Function TelemetrySameStr(const S1, S2: TelemetryString): Boolean;
begin
{$IFDEF Unicode}
Result := AnsiSameStr(UTF8Decode(S1),UTF8Decode(S2));
{$ELSE}
Result := WideSameStr(UTF8Decode(S1),UTF8Decode(S2));
{$ENDIF}
end;

//------------------------------------------------------------------------------

Function TelemetrySameText(const S1, S2: TelemetryString): Boolean;
begin
{$IFDEF Unicode}
Result := AnsiSameText(UTF8Decode(S1),UTF8Decode(S2));
{$ELSE}
Result := WideSameText(UTF8Decode(S1),UTF8Decode(S2));
{$ENDIF}
end;

//------------------------------------------------------------------------------

Function TelemetrySameStrNoConv(const S1, S2: TelemetryString): Boolean;
begin
Result := AnsiSameStr(S1,S2);
end;

//------------------------------------------------------------------------------

Function TelemetrySameTextNoConv(const S1, S2: TelemetryString): Boolean;
begin
Result := AnsiSameText(S1,S2);
end;

//==============================================================================

Function SCSValueTypeToStr(SCSValueType: scs_value_type_t): String;
begin
If (Integer(SCSValueType) >= Low(cSCSValueTypeIdentifiers)) and
   (Integer(SCSValueType) <= High(cSCSValueTypeIdentifiers)) then
  Result := cSCSValueTypeIdentifiers[Integer(SCSValueType)]
else
  Result := 'unknown';
end;

//------------------------------------------------------------------------------

Function SCSValueTypeFromStr(Str: String): scs_value_type_t;
var
  i:  Integer;
begin
Result := SCS_VALUE_TYPE_INVALID;
For i := Low(cSCSValueTypeIdentifiers) to High(cSCSValueTypeIdentifiers) do
  If AnsiSameText(cSCSValueTypeIdentifiers[i],Str) then
    begin
      Result := scs_value_type_t(i);
      Break;
    end;
end;

//------------------------------------------------------------------------------

Function SCSValueToStr(const Value: scs_value_t; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String;
type
  TDescriptorsArray = Array[0..5] of String;
const
  cFullDescriptors:  TDescriptorsArray = ('X: ','Y: ','Z: ','Heading: ','Pitch: ','Roll: ');
  cEmptyDescriptors: TDescriptorsArray = ('','','','','','');
var
  Descriptors:  TDescriptorsArray;
begin
If ShowDescriptors then Descriptors := cFullDescriptors
  else Descriptors := cEmptyDescriptors;
case Value._type of
  SCS_VALUE_TYPE_INVALID:
    Result := '';
  SCS_VALUE_TYPE_bool:
    Result := BoolToStr(Value.value_bool.value <> 0,True);
  SCS_VALUE_TYPE_s32:
    Result := IntToStr(Value.value_s32.value);
  SCS_VALUE_TYPE_u32:
    Result := IntToStr(Value.value_u32.value);
  SCS_VALUE_TYPE_u64:
    Result := IntToStr(Value.value_u64.value);
  SCS_VALUE_TYPE_float:
    Result := FloatToStr(Value.value_float.value,FormatSettings);
  SCS_VALUE_TYPE_double:
    Result := FloatToStr(Value.value_double.value,FormatSettings);
  SCS_VALUE_TYPE_fvector:
    Result := '[' + Descriptors[0] + FloatToStr(Value.value_fvector.x,FormatSettings) +
             ', ' + Descriptors[1] + FloatToStr(Value.value_fvector.y,FormatSettings) +
             ', ' + Descriptors[2] + FloatToStr(Value.value_fvector.z,FormatSettings) + ']';
  SCS_VALUE_TYPE_dvector:
    Result := '[' + Descriptors[0] + FloatToStr(Value.value_dvector.x,FormatSettings) +
             ', ' + Descriptors[1] + FloatToStr(Value.value_dvector.y,FormatSettings) +
             ', ' + Descriptors[2] + FloatToStr(Value.value_dvector.z,FormatSettings) + ']';
  SCS_VALUE_TYPE_euler:
    Result := '[' + Descriptors[3] + FloatToStr(Value.value_euler.heading,FormatSettings) +
             ', ' + Descriptors[4] + FloatToStr(Value.value_euler.pitch,FormatSettings) +
             ', ' + Descriptors[5] + FloatToStr(Value.value_euler.roll,FormatSettings) + ']';
  SCS_VALUE_TYPE_fplacement:
    Result := '[' + Descriptors[0] + FloatToStr(Value.value_fplacement.position.x,FormatSettings) +
             ', ' + Descriptors[1] + FloatToStr(Value.value_fplacement.position.y,FormatSettings) +
             ', ' + Descriptors[2] + FloatToStr(Value.value_fplacement.position.z,FormatSettings) +
            '] [' + Descriptors[3] + FloatToStr(Value.value_fplacement.orientation.heading,FormatSettings) +
             ', ' + Descriptors[4] + FloatToStr(Value.value_fplacement.orientation.pitch,FormatSettings) +
             ', ' + Descriptors[5] + FloatToStr(Value.value_fplacement.orientation.roll,FormatSettings) + ']';
  SCS_VALUE_TYPE_dplacement:
    Result := '[' + Descriptors[0] + FloatToStr(Value.value_dplacement.position.x,FormatSettings) +
             ', ' + Descriptors[1] + FloatToStr(Value.value_dplacement.position.y,FormatSettings) +
             ', ' + Descriptors[2] + FloatToStr(Value.value_dplacement.position.z,FormatSettings) +
            '] [' + Descriptors[3] + FloatToStr(Value.value_dplacement.orientation.heading,FormatSettings) +
             ', ' + Descriptors[4] + FloatToStr(Value.value_dplacement.orientation.pitch,FormatSettings) +
             ', ' + Descriptors[5] + FloatToStr(Value.value_dplacement.orientation.roll,FormatSettings) + ']';
  SCS_VALUE_TYPE_string:
    Result := TelemetryStringDecode(APIStringToTelemetryString(Value.value_string.value));
else
  Result := '';
end;
If TypeName then Result := '(' + SCSValueTypeToStr(Value._type) + ') ' + Result;
end;

//------------------------------------------------------------------------------

Function SCSValueLocalizedToStr(Value: scs_value_localized_t; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String;
begin
case Value.ValueType of
  SCS_VALUE_TYPE_string:
    If TypeName then Result := '(' + SCSValueTypeToStr(Value.ValueType) + ') ' + TelemetryStringDecode(Value.StringData)
      else Result := TelemetryStringDecode(Value.StringData);
else
  Value.BinaryData._type := Value.ValueType;
  Result := SCSValueToStr(Value.BinaryData,TypeName,ShowDescriptors);
end;
end;

//------------------------------------------------------------------------------

Function SCSNamedValueToStr(Value: scs_named_value_t; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String;
begin
Result := TelemetryStringDecode(APIStringToTelemetryString(Value.name));
If Value.index <> SCS_U32_NIL then Result := Result + '[' + IntToStr(Value.index) + ']';
Result := Result + ': ' + SCSValueToStr(Value.value,TypeName,ShowDescriptors);
end;

//------------------------------------------------------------------------------

Function SCSNamedValueLocalizedToStr(Value: scs_named_value_localized_t; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String;
begin
Result := Value.Name;
If Value.Index <> SCS_U32_NIL then Result := Result + '[' + IntToStr(Value.Index) + ']';
Result := Result + ': ' + SCSValueLocalizedToStr(Value.Value,TypeName,ShowDescriptors);
end;

//------------------------------------------------------------------------------

Function TelemetryEventFrameStartToStr(const Data: scs_telemetry_frame_start_t; TypeName: Boolean = False): String;
begin
If TypeName then
  Result := 'Flags: (u32) ' + IntToHex(Data.flags,SizeOf(Data.flags) * 2) + sLineBreak +
            'Render time: (u64) ' + IntToStr(Data.render_time) + sLineBreak +
            'Simulation time: (u64) ' + IntToStr(Data.simulation_time) + sLineBreak +
            'Pause simulation time: (u64) ' + IntToStr(Data.paused_simulation_time)
else
  Result := 'Flags: ' + IntToHex(Data.flags,SizeOf(Data.flags) * 2) + sLineBreak +
            'Render time: ' + IntToStr(Data.render_time) + sLineBreak +
            'Simulation time: ' + IntToStr(Data.simulation_time) + sLineBreak +
            'Pause simulation time: ' + IntToStr(Data.paused_simulation_time);
end;

//------------------------------------------------------------------------------

Function TelemetryEventConfigurationToStr(const Data: scs_telemetry_configuration_t; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String;
var
  TempAttr: p_scs_named_value_t;
begin
Result := TelemetryStringDecode(APIStringToTelemetryString(Data.id));
TempAttr := Data.attributes;
while Assigned(TempAttr^.name) do
  begin
    Result := Result + sLineBreak + SCSNamedValueToStr(TempAttr^,TypeName,ShowDescriptors);
    Inc(TempAttr);
  end;
end;

//------------------------------------------------------------------------------

Function TelemetryEventConfigurationLocalizedToStr(const Data: scs_telemetry_configuration_localized_t; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String;
var
  i:  Integer;
begin
Result := TelemetryStringDecode(Data.ID);
For i := Low(Data.Attributes) to High(Data.Attributes) do
  Result := Result + sLineBreak + SCSNamedValueLocalizedToStr(Data.Attributes[i],TypeName,ShowDescriptors);
end;

//------------------------------------------------------------------------------

initialization
  GetLocaleFormatSettings(LOCALE_USER_DEFAULT,FormatSettings);
  FormatSettings.DecimalSeparator := '.';

end.
