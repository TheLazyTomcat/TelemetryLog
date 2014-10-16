{@html(<hr>)
@abstract(Unit providing routines for variables conversions.)
@author(František Milt <fmilt@seznam.cz>)
@created(2014-04-30)
@lastmod(2014-04-30)

  @bold(@NoAutoLink(TelemetryConversions))

  ©František Milt, all rights reserved.

  This unit contains routines used for conversions between selected
  non-localized SDK types and their no-pointer alternatives.

  Last change:  2014-04-30

  Change List:@unorderedList(
    @item(2014-04-30 - First stable version.)
    @item(2014-04-30 - Functions scs_value_localized and scs_value were moved to
                       this unit.))

@html(<hr>)}
unit TelemetryConversions;

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
  Function converting normal @code(scs_value_t) structure to its no-pointers
  version (scs_value_localized_t).

  @param Value Value that has to be converted.

  @returns Converted value.
}
Function scs_value_localized(Value: scs_value_t): scs_value_localized_t;

//------------------------------------------------------------------------------

{
  @abstract(Function converting no-pointers alternative to normal
            @code(scs_value_t) structure.)
  @bold(Warning) - you have to manually free memory allocated for some fields
  when you are done with result of this function! Use function scs_value_free
  for this purpose.

  @param Value Value that has to be converted.

  @returns Converted value.
}
Function scs_value(Value: scs_value_localized_t): scs_value_t;

//------------------------------------------------------------------------------

{
  @abstract(Frees resources allocated for variable of type @code(scs_value_t).)
  @bold(Warning) - do not use on variables returned from the API!

  @param Value Value whose resources has to be freed.
}
procedure scs_value_free(var Value: scs_value_t);

//==============================================================================

{
  Function converting normal @code(scs_named_value_t) structure to its
  no-pointers version (scs_named_value_localized_t).

  @param Value Value that has to be converted.

  @returns Converted value.
}
Function scs_named_value_localized(Value: scs_named_value_t): scs_named_value_localized_t;

//------------------------------------------------------------------------------

{
  @abstract(Function converting no-pointers alternative to normal
            @code(scs_named_value_t) structure.)
  @bold(Warning) - you have to manually free memory allocated for some fields
  when you are done with result of this function! Use function
  scs_named_value_free for this purpose.

  @param Value Value that has to be converted.

  @returns Converted value.
}
Function scs_named_value(Value: scs_named_value_localized_t): scs_named_value_t;

//------------------------------------------------------------------------------

{
  @abstract(Frees resources allocated for variable of type
            @code(scs_named_value_t).)
  @bold(Warning) - do not use on variables returned from the API!

  @param Value Value whose resources has to be freed.
}
procedure scs_named_value_free(var Value: scs_named_value_t);

//==============================================================================

{
  Function converting normal @code(scs_telemetry_configuration_t) structure to
  its no-pointers version (scs_telemetry_configuration_localized_t).

  @param Value Value that has to be converted.

  @returns Converted value.
}
Function scs_telemetry_configuration_localized(Value: scs_telemetry_configuration_t): scs_telemetry_configuration_localized_t;

//------------------------------------------------------------------------------

{
  @abstract(Function converting no-pointers alternative to normal
            @code(scs_telemetry_configuration_t) structure.)
  @bold(Warning) - you have to manually free memory allocated for some fields
  when you are done with result of this function! Use function
  scs_telemetry_configuration_free for this purpose.

  @param Value Value that has to be converted.

  @returns Converted value.
}
Function scs_telemetry_configuration(Value: scs_telemetry_configuration_localized_t): scs_telemetry_configuration_t;

//------------------------------------------------------------------------------

{
  @abstract(Frees resources allocated for variable of type
            @code(scs_telemetry_configuration_t).)
  @bold(Warning) - do not use on variables returned from the API!

  @param Value          Value whose resources has to be freed.
  @param(FreeAttributes When @true, attributes array is freed completely,
                        otherwise only attributes fields are freed.)
}
procedure scs_telemetry_configuration_free(var Value: scs_telemetry_configuration_t; FreeAttributes: Boolean = True);

implementation

uses
  SysUtils;

{==============================================================================}
{    Unit Functions and procedures implementation                              }
{==============================================================================}

Function scs_value_localized(Value: scs_value_t): scs_value_localized_t;
begin
Result.ValueType := Value._type;
case Value._type of
  SCS_VALUE_TYPE_string:
    begin
      Result.BinaryData._type := SCS_VALUE_TYPE_INVALID;
      Result.StringData := APIStringToTelemetryString(Value.value_string.value);
    end;
else
  Result.BinaryData := Value;
  Result.StringData := '';
end;
end;

//------------------------------------------------------------------------------

Function scs_value(Value: scs_value_localized_t): scs_value_t;
begin
case Value.ValueType of
  SCS_VALUE_TYPE_string:
    begin
      Result._type := SCS_VALUE_TYPE_string;
      Result.value_string.value := TelemetryStringToAPIString(Value.StringData);
    end;
else
  Result := Value.BinaryData;
  Result._type := Value.ValueType;
end;
end;

//------------------------------------------------------------------------------

procedure scs_value_free(var Value: scs_value_t);
begin
If Value._type = SCS_VALUE_TYPE_string then
  APIStringFree(Value.value_string.value);
end;

//==============================================================================

Function scs_named_value_localized(Value: scs_named_value_t): scs_named_value_localized_t;
begin
Result.Name := APIStringToTelemetryString(Value.name);
Result.Index := Value.index;
Result.Value := scs_value_localized(Value.value);
end;

//------------------------------------------------------------------------------

Function scs_named_value(Value: scs_named_value_localized_t): scs_named_value_t;
begin
Result.name := TelemetryStringToAPIString(Value.Name);
Result.index := Value.Index;
Result.value := scs_value(Value.Value);
end;

//------------------------------------------------------------------------------

procedure scs_named_value_free(var Value: scs_named_value_t);
begin
APIStringFree(Value.name);
scs_value_free(Value.value);
end;

//==============================================================================

Function scs_telemetry_configuration_localized(Value: scs_telemetry_configuration_t): scs_telemetry_configuration_localized_t;
var
  CurrAttrPtr:  p_scs_named_value_t;
  TempAttrLoc:  scs_named_value_localized_t;

  procedure AddAttributeToResult(Attribute: scs_named_value_localized_t);
  begin
    SetLength(Result.Attributes,Length(Result.Attributes) + 1);
    Result.Attributes[High(Result.Attributes)] := Attribute;
  end;

begin
Result.ID := APIStringToTelemetryString(Value.id);
SetLength(Result.Attributes,0);
CurrAttrPtr := Value.attributes;
while Assigned(CurrAttrPtr^.name) do
  begin
    TempAttrLoc.Name := APIStringToTelemetryString(CurrAttrPtr^.name);
    TempAttrLoc.Index := CurrAttrPtr^.index;
    TempAttrLoc.Value := scs_value_localized(CurrAttrPtr^.value);
    AddAttributeToResult(TempAttrLoc);
    Inc(CurrAttrPtr);
  end;
end;

//------------------------------------------------------------------------------

Function scs_telemetry_configuration(Value: scs_telemetry_configuration_localized_t): scs_telemetry_configuration_t;
var
  i:            Integer;
  CurrAttrPtr:  p_scs_named_value_t;
begin
Result.id := TelemetryStringToAPIString(Value.ID);
Result.attributes := AllocMem((Length(Value.Attributes) + 1) * SizeOf(scs_named_value_t));
CurrAttrPtr := Result.attributes;
For i := Low(Value.Attributes) to High(Value.Attributes) do
  begin
    CurrAttrPtr^.name := TelemetryStringToAPIString(Value.Attributes[i].Name);
    CurrAttrPtr^.index := Value.Attributes[i].Index;
    CurrAttrPtr^.value := scs_value(Value.Attributes[i].Value);
    Inc(CurrAttrPtr);
  end;
CurrAttrPtr^.name := nil;
end;

//------------------------------------------------------------------------------

procedure scs_telemetry_configuration_free(var Value: scs_telemetry_configuration_t; FreeAttributes: Boolean = True);
var
  Counter:      Integer;
  CurrAttrPtr:  p_scs_named_value_t;
begin
APIStringFree(Value.id);
Counter := 0;
CurrAttrPtr := Value.attributes;
while Assigned(CurrAttrPtr^.name) do
  begin
    scs_named_value_free(CurrAttrPtr^);
    Inc(Counter);    
    Inc(CurrAttrPtr);
  end;
scs_named_value_free(CurrAttrPtr^);
Inc(Counter);
If FreeAttributes then
  FreeMem(Value.attributes,Counter * SizeOf(scs_named_value_t));
Value.attributes := nil;
end;

end.