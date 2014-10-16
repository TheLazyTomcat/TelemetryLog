{@html(<hr>)
@abstract(Information provider class (known telemetry events, channels, etc.).)
@author(František Milt <fmilt@seznam.cz>)
@created(2013-10-07)
@lastmod(2014-05-04)

  @bold(@NoAutoLink(TelemetryInfoProvider))

  ©František Milt, all rights reserved.

  This unit contains TTelemetryInfoProvider class (see class declaration for
  details).

  Included files:@preformatted(
    .\Inc\TTelemetryInfoProvider.Prepare_Telemetry_1_0.pas
      Contains body of method TTelemetryInfoProvider.Prepare_Telemetry_1_0.)

  Last change:  2014-05-04

  Change List:@unorderedList(
    @item(2013-10-07 - First stable version.)
    @item(2014-04-15 - Type of parameter @code(Name) in method
                       TTelemetryInfoProvider.ChannelGetValueType changed to
                       @code(TelemetryString).)
    @item(2014-04-18 - Result type of method TTelemetryInfoProvider.EventGetName
                       changed to @code(TelemetryString).)
    @item(2014-04-27 - Added constructor mehod
                       TTelemetryInfoProvider.CreateCurrent.)
    @item(2014-05-04 - Following callback functions were added:@unorderedList(
                         @itemSpacing(Compact)
                         @item(InfoProviderGetChannelIDFromName)
                         @item(InfoProviderGetChannelNameFromID)
                         @item(InfoProviderGetConfigIDFromName)
                         @item(InfoProviderGetConfigNameFromID))))

  ToDo:@unorderedList(
  @item(Add capability for loading information from file (text or ini).))    

@html(<hr>)}
unit TelemetryInfoProvider;

interface

{$INCLUDE '.\Telemetry_defs.inc'}

uses
  TelemetryIDs,
  TelemetryLists,
  TelemetryVersionObjects,  
{$IFDEF Documentation}
  TelemetryCommon,
{$ENDIF}
{$IFDEF UseCondensedHeader}
  SCS_Telemetry_Condensed;
{$ELSE}
  scssdk,
  scssdk_value,
  scssdk_telemetry,
  scssdk_telemetry_event,
  scssdk_telemetry_common_configs,
  scssdk_telemetry_common_channels,
  scssdk_telemetry_trailer_common_channels,
  scssdk_telemetry_truck_common_channels,
  scssdk_eut2,
  scssdk_telemetry_eut2;
{$ENDIF}

{==============================================================================}
{------------------------------------------------------------------------------}
{                            TTelemetryInfoProvider                            }
{------------------------------------------------------------------------------}
{==============================================================================}

type
{
  Used to distinguish which value type should method
  TTelemetryInfoProvider.ChannelGetValueType return for given channel.
  @value(cvtpPrimary   Basic value type.)
  @value(cvtpSecondary Second used type (e.g. double for float types, u64 for
                       u32, ...).)
  @value(cvtpTertiary  Third type (e.g. euler for [f/d]placement).)
}
  TChannelValueTypePriority = (cvtpPrimary, cvtpSecondary, cvtpTertiary);

{==============================================================================}
{    TTelemetryInfoProvider // Class declaration                               }
{==============================================================================}
{
  @abstract(@NoAutoLink(TTelemetryInfoProvider) class provide lists of all known
  game events, channels and configurations along with some methods operating on
  them.)

  It can be created in two ways, user managed or automatically managed.@br
  When created as user managed (using no-paramater constructor), the object is
  created with empty lists and it is up to the user to fill them (use methods of
  individual lists to do so).@br
  When automatically managed (object is created using parametrized constructor),
  the telemetry and game versions are passed to the constructor and it checks
  whether they are supported or not. If they are, the lists are filled
  accordingly to them, if they are not supported, the constructor raises an
  exception.@br


@member(fUserManaged
    Holds state indicationg whether current instance is user managed (when not,
    it is managed automatically).@br
    This field is set automatically in constructor(s).)

@member(fKnownEvents See KnownEvents property.)

@member(fKnownChannels See KnownChannels property.)

@member(fKnownConfigs See KnownConfigs property.)



@member(Prepare_Telemetry_1_0 Preparation for telemetry 1.0.)

@member(Prepare_Game_eut2_1_0 Preparation for eut2 1.0.)

@member(Prepare_Game_eut2_1_1 Preparation for eut2 1.1.)

@member(Prepare_Game_eut2_1_2 Preparation for eut2 1.2.)

@member(Prepare_Game_eut2_1_4 Preparation for eut2 1.4.)



@member(Destroy
    Object destructor.@br
    Internal lists are automatically cleared in destructor, so it is unnecessary
    to @noAutoLink(clear) them explicitly.)

@member(Clear
    When current instance is created as user managed, calling this procedure
    will clear all internal lists. When it is called on automatically managed
    object, it does nothing.)

@member(EventGetName
    Returns internal (i.e. not defined by the API) name of passed event.

    @param Event Event whose name is requested.

    @returns(Name of given event or an empty string when no such event is
             known.))

@member(ChannelGetValueType
    Returns type of value for given channel and selected priority.

    @param Name         Name of requested channel.
    @param TypePriority Priority of value type that should be returned.

    @returns(Type of value for selected channel and priority. When requested
             channel is not found, @code(SCS_VALUE_TYPE_INVALID) is returned.))

@member(KnownEvents
    List containing informations about known telemetry events.)

@member(KnownChannels
    List containing informations about known telemetry channels.)

@member(KnownConfigs
    List containing informations about known telemetry configs.)

@member(UserManaged
    @True when current instance is user managed, @false when it is managed
    automatically.)
}
  TTelemetryInfoProvider = class(TTelemetryVersionPrepareObject)
  private
    fUserManaged:   Boolean;
    fKnownEvents:   TKnownEventsList;
    fKnownChannels: TKnownChannelsList;
    fKnownConfigs:  TKnownConfigsList;
  protected
    procedure Prepare_Telemetry_1_0; override;
    procedure Prepare_Game_eut2_1_0; override;
    procedure Prepare_Game_eut2_1_1; override;
    procedure Prepare_Game_eut2_1_2; override;
    procedure Prepare_Game_eut2_1_4; override;
  public
  {
    Basic object constructor.@br

    Call this no-parameter constructor when creating user managed info provider.
    Lists of known items are created empty.
  }
    constructor Create; overload;
  {
    Parameterized object constructor.@br

    Call this constructor when creating automatically managed info provider.
    Lists of known items are filled automatically in this constructor
    accordingly to passed telemetry and game versions.@br
    If passed telemetry/game versions are not supported then an exception is
    raised.

    @param TelemetryVersion Version of telemetry.
    @param GameID           Game identifier.
    @param GameVersion      Version of game.
  }
    constructor Create(TelemetryVersion: scs_u32_t; GameID: scs_string_t; GameVersion: scs_u32_t); overload;
  {
    Specialized object constructor.@br

    This constructor is designed to automatically fill lists with latest data
    available for passed game. It actually calls parametrized constructor with
    parameter @code(TelemetryVersion) set to value returned by function
    HighestSupportedTelemetryVersion, @code(GameID) set to passed game id and
    @code(GameVersion) set to value returned by function
    HighestSupportedGameVersion.

    @param GameID Game identifier.
  }
    constructor CreateCurrent(GameID: TelemetryString); virtual;
    destructor Destroy; override;
    procedure Clear;
    Function EventGetName(Event: scs_event_t): TelemetryString; virtual;
    Function ChannelGetValueType(const Name: TelemetryString; TypePriority: TChannelValueTypePriority = cvtpPrimary): scs_value_type_t; virtual;
  published
    property KnownEvents: TKnownEventsList read fKnownEvents;
    property KnownChannels: TKnownChannelsList read fKnownChannels;
    property KnownConfigs: TKnownConfigsList read fKnownConfigs;
    property UserManaged: Boolean read fUserManaged;
  end;

{==============================================================================}
{    Unit Functions and procedures // Declaration                              }
{==============================================================================}

{
  @abstract(Function intended as callback for streaming functions, converting
            channel name to ID.)
  @code(UserData) passed to streaming function along with this callback must
  contain valid TTelemetryInfoProvider object.

  @param Name                  Channel name to be converted to ID.
  @param(TelemetryInfoProvider TTelemetryInfoProvider object that will be used
                               for actual conversion.)

  @returns Channel ID obtained from passed name.
}
Function InfoProviderGetChannelIDFromName(const Name: TelemetryString; TelemetryInfoProvider: Pointer): TChannelID;

{
  @abstract(Function intended as callback for streaming functions, converting
            channel ID to name.)
  @code(UserData) passed to streaming function along with this callback must
  contain valid TTelemetryInfoProvider object.

  @param ID                    Channel ID to be converted to name.
  @param(TelemetryInfoProvider TTelemetryInfoProvider object that will be used
                               for actual conversion.)

  @returns Channel name obtained from passed ID.
}
Function InfoProviderGetChannelNameFromID(ID: TChannelID; TelemetryInfoProvider: Pointer): TelemetryString;

{
  @abstract(Function intended as callback for streaming functions, converting
            config name to ID.)
  @code(UserData) passed to streaming function along with this callback must
  contain valid TTelemetryInfoProvider object.

  @param Name                  Config name to be converted to ID.
  @param(TelemetryInfoProvider TTelemetryInfoProvider object that will be used
                               for actual conversion.)

  @returns Config ID obtained from passed name.
}
Function InfoProviderGetConfigIDFromName(const Name: TelemetryString; TelemetryInfoProvider: Pointer): TConfigID;

{
  @abstract(Function intended as callback for streaming functions, converting
            ID to config name.)
  @code(UserData) passed to streaming function along with this callback must
  contain valid TTelemetryInfoProvider object.

  @param ID                    Config ID to be converted to name.
  @param(TelemetryInfoProvider TTelemetryInfoProvider object that will be used
                               for actual conversion.)

  @returns Config name obtained from passed ID.
}
Function InfoProviderGetConfigNameFromID(ID: TConfigID; TelemetryInfoProvider: Pointer): TelemetryString;


implementation

uses
  SysUtils,
  TelemetryCommon;

{==============================================================================}
{    Unit Functions and procedures // Implementation                           }
{==============================================================================}

Function InfoProviderGetChannelIDFromName(const Name: TelemetryString; TelemetryInfoProvider: Pointer): TChannelID;
begin
Result := TTelemetryInfoProvider(TelemetryInfoProvider).KnownChannels.ChannelNameToID(Name);
end;

//------------------------------------------------------------------------------

Function InfoProviderGetChannelNameFromID(ID: TChannelID; TelemetryInfoProvider: Pointer): TelemetryString;
begin
Result := TTelemetryInfoProvider(TelemetryInfoProvider).KnownChannels.ChannelIDToName(ID);
end;

//------------------------------------------------------------------------------

Function InfoProviderGetConfigIDFromName(const Name: TelemetryString; TelemetryInfoProvider: Pointer): TConfigID;
begin
Result := TTelemetryInfoProvider(TelemetryInfoProvider).KnownConfigs.ConfigNameToID(Name);
end;

//------------------------------------------------------------------------------

Function InfoProviderGetConfigNameFromID(ID: TConfigID; TelemetryInfoProvider: Pointer): TelemetryString;
begin
Result := TTelemetryInfoProvider(TelemetryInfoProvider).KnownConfigs.ConfigIDToName(ID);
end;

{==============================================================================}
{------------------------------------------------------------------------------}
{                            TTelemetryInfoProvider                            }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TTelemetryInfoProvider // Class implementation                            }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TTelemetryInfoProvider // Protected methods                               }
{------------------------------------------------------------------------------}

procedure TTelemetryInfoProvider.Prepare_Telemetry_1_0;
begin
inherited;
// As content of this function is rather monstrous, it is, for the sake of
// clarity, separated in its own file.
{$INCLUDE '.\Inc\TTelemetryInfoProvider.Prepare_Telemetry_1_0.pas'}
end;

//------------------------------------------------------------------------------

procedure TTelemetryInfoProvider.Prepare_Game_eut2_1_0;
begin
inherited;
fKnownChannels.Remove(SCS_TELEMETRY_TRUCK_CHANNEL_adblue);
fKnownChannels.Remove(SCS_TELEMETRY_TRUCK_CHANNEL_adblue_warning);
fKnownChannels.Remove(SCS_TELEMETRY_TRUCK_CHANNEL_adblue_average_consumption);
end;

//------------------------------------------------------------------------------

procedure TTelemetryInfoProvider.Prepare_Game_eut2_1_1;
begin
inherited;
fKnownChannels.Insert(fKnownChannels.IndexOf(SCS_TELEMETRY_TRUCK_CHANNEL_brake_temperature),
                      SCS_TELEMETRY_TRUCK_CHANNEL_brake_air_pressure_emergency,
                      SCS_VALUE_TYPE_bool,
                      SCS_VALUE_TYPE_invalid,
                      SCS_VALUE_TYPE_invalid,
                      False);
fKnownConfigs.Insert(fKnownConfigs.IndexOf(SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_oil_pressure_warning),
                     SCS_TELEMETRY_CONFIG_truck_ATTRIBUTE_air_pressure_emergency,
                     SCS_VALUE_TYPE_float,
                     False);
end;

//------------------------------------------------------------------------------

procedure TTelemetryInfoProvider.Prepare_Game_eut2_1_2;
begin
inherited;
fKnownChannels.Replace('truck.cabin.orientation',
                       SCS_TELEMETRY_TRUCK_CHANNEL_cabin_offset,
                       SCS_VALUE_TYPE_fplacement,
                       SCS_VALUE_TYPE_dplacement,
                       SCS_VALUE_TYPE_euler,
                       False);
end;

//------------------------------------------------------------------------------

procedure TTelemetryInfoProvider.Prepare_Game_eut2_1_4;
begin
inherited;
fKnownChannels.Insert(fKnownChannels.IndexOf(SCS_TELEMETRY_TRUCK_CHANNEL_light_parking),
                      SCS_TELEMETRY_TRUCK_CHANNEL_light_lblinker,
                      SCS_VALUE_TYPE_bool,
                      SCS_VALUE_TYPE_invalid,
                      SCS_VALUE_TYPE_invalid,
                      False);
fKnownChannels.Insert(fKnownChannels.IndexOf(SCS_TELEMETRY_TRUCK_CHANNEL_light_parking),
                      SCS_TELEMETRY_TRUCK_CHANNEL_light_rblinker,
                      SCS_VALUE_TYPE_bool,
                      SCS_VALUE_TYPE_invalid,
                      SCS_VALUE_TYPE_invalid,
                      False);
end;



{------------------------------------------------------------------------------}
{    TTelemetryInfoProvider // Public methods                                  }
{------------------------------------------------------------------------------}

constructor TTelemetryInfoProvider.Create;
begin
inherited Create;
// User managed instance.
fUserManaged := True;
// Create lists.
fKnownEvents := TKnownEventsList.Create;
fKnownChannels := TKnownChannelsList.Create;
fKnownConfigs := TKnownConfigsList.Create;
end;

constructor TTelemetryInfoProvider.Create(TelemetryVersion: scs_u32_t; GameID: scs_string_t; GameVersion: scs_u32_t);
begin
// Call basic constructor to initialize lists.
Create;
// Automatically managed instance.
fUserManaged := False;
// Prepare for required telemetry/game version, raise exception on unsupported
// versions.
If not PrepareForTelemetryVersion(TelemetryVersion) then
  raise Exception.Create('TTelemetryInfoProvider.Create(...): Telemetry version (' +
    SCSGetVersionAsString(TelemetryVersion) + ') is not supported');
If not PrepareForGameVersion('',APIStringToTelemetryString(GameID),GameVersion) then
  raise Exception.Create('TTelemetryInfoProvider.Create(...): Game version (' +
    TelemetryStringDecode(APIStringToTelemetryString(GameID)) + ' ' +
    SCSGetVersionAsString(GameVersion) + ') is not supported');
end;

constructor TTelemetryInfoProvider.CreateCurrent(GameID: TelemetryString);
begin
Create(HighestSupportedTelemetryVersion,scs_string_t(GameID),HighestSupportedGameVersion(scs_string_t(GameID)));
end;

//------------------------------------------------------------------------------

destructor TTelemetryInfoProvider.Destroy;
begin
fKnownConfigs.Free;
fKnownChannels.Free;
fKnownEvents.Free;
inherited;
end;

//------------------------------------------------------------------------------

procedure TTelemetryInfoProvider.Clear;
begin
If UserManaged then
  begin
    fKnownEvents.Clear;
    fKnownChannels.Clear;
    fKnownConfigs.Clear;
  end;
end;

//------------------------------------------------------------------------------

Function TTelemetryInfoProvider.EventGetName(Event: scs_event_t): TelemetryString;
var
  Index: Integer;
begin
Index := fKnownEvents.IndexOf(Event);
If Index >= 0 then Result := fKnownEvents[Index].Name
  else Result := '';
end;

//------------------------------------------------------------------------------

Function TTelemetryInfoProvider.ChannelGetValueType(const Name: TelemetryString; TypePriority: TChannelValueTypePriority = cvtpPrimary): scs_value_type_t;
var
  Index: Integer;
begin
Index := fKnownChannels.IndexOf(Name);
If Index >= 0 then
  begin
    case TypePriority of
      cvtpPrimary:    Result := fKnownChannels[Index].PrimaryType;
      cvtpSecondary:  Result := fKnownChannels[Index].SecondaryType;
      cvtpTertiary:   Result := fKnownChannels[Index].TertiaryType;
    else
      Result := SCS_VALUE_TYPE_invalid;
    end;
  end
else Result := SCS_VALUE_TYPE_invalid;
end;

end.
