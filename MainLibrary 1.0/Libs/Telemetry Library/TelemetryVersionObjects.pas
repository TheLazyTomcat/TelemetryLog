{@html(<hr>)
@abstract(Base classes for objects that are checked for telemetry and game
          version support.)
@author(František Milt <fmilt@seznam.cz>)
@created(2013-10-17)
@lastmod(2014-05-01)

  @bold(@NoAutoLink(TelemetryVersionObjects))

  ©František Milt, all rights reserved.
  
  Classes in this unit (for details, refer to declaration of individual class):
@preformatted(
  TTelemetryAbstractVersionObject
   |- TTelemetryVersionObject
       |- TTelemetryVersionPrepareObject
)

  Last change:  2014-05-01

  Change List:@unorderedList(
    @item(2013-10-17 - First stable version.)
    @item(2014-04-06 - Type of parameters @code(GameName) and @code(GameID) in
                       method TTelemetryVersionPrepareObject.PrepareForGameVersion
                       changed to @code(TelemetryString).)
    @item(2014-04-06 - Added support for eut2 1.8.)
    @item(2014-05-01 - Added method
                       TTelemetryAbstractVersionObject.HighestSupportedGameVersion
                       and its variants in descendant classes.))    

@html(<hr>)}
unit TelemetryVersionObjects;

interface

{$INCLUDE '.\Telemetry_defs.inc'}

uses
{$IFDEF Documentation}
  TelemetryCommon,
  TelemetryStrings,
{$ENDIF}
{$IFDEF UseCondensedHeader}
  SCS_Telemetry_Condensed;
{$ELSE}
  scssdk,
  scssdk_telemetry,
  scssdk_eut2,
  scssdk_telemetry_eut2;
{$ENDIF}

type
{==============================================================================}
{------------------------------------------------------------------------------}
{                       TTelemetryAbstractVersionObject                        }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TTelemetryAbstractVersionObject // Class declaration                      }
{==============================================================================}
{
  @abstract(Common, fully abstract ancestor for all classes that needs to be
  checked for version support before creation of an instance.)

  This class defines set of methods used to check version support. Use it as an
  ancestor for classes where you want to fully control methods implementation or
  for classes that supports different set of versions than is defined for
  TTelemetryVersionObject.@br
  All methods must be called directly on class. They are intended to be used to
  check whether the class supports required telemetry and game version before
  instantiation (creation of class instance).

@member(HighestSupportedTelemetryVersion

    @returns Highest supported telemetry version.)

@member(HighestSupportedGameVersion

    @param GameID Game identifier.

    @returns Highest supported version of passed game.)

@member(SupportsTelemetryVersion

    @param TelemetryVersion Version of telemetry.

    @returns @True when given telemetry version is supported, otherwise @false.)

@member(SupportsTelemetryMajorVersion

    @param TelemetryVersion Version of telemetry.

    @returns(@True when given telemetry major version is supported (minor part
             is ignored), otherwise @false.))

@member(SupportsGameVersion

    @param GameID       Game identifier.
    @param GameVersion  Version of game.

    @returns(@True when given game and its version are supported, otherwise
             @false.))

@member(SupportsTelemetryAndGameVersion

    @param TelemetryVersion Version of telemetry.
    @param GameID           Game identifier.
    @param GameVersion      Version of game.

    @returns(@True when given telemetry, game and its version are supported,
             otherwise @false.))

@member(SupportsTelemetryAndGameVersionParam
    @param TelemetryVersion Version of telemetry.
    @param Parameters       Structure containing other version informations.

    @returns(@True when given telemetry, game and its version are supported,
             otherwise @false.))
}
  TTelemetryAbstractVersionObject = class(TObject)
  public
    class Function HighestSupportedTelemetryVersion: scs_u32_t; virtual; abstract;
    class Function HighestSupportedGameVersion(GameID: scs_string_t): scs_u32_t; virtual; abstract;
    class Function SupportsTelemetryVersion(TelemetryVersion: scs_u32_t): Boolean; virtual; abstract;
    class Function SupportsTelemetryMajorVersion(TelemetryVersion: scs_u32_t): Boolean; virtual; abstract;
    class Function SupportsGameVersion(GameID: scs_string_t; GameVersion: scs_u32_t): Boolean; virtual; abstract;
    class Function SupportsTelemetryAndGameVersion(TelemetryVersion: scs_u32_t; GameID: scs_string_t; GameVersion: scs_u32_t): Boolean; virtual; abstract;
    class Function SupportsTelemetryAndGameVersionParam(TelemetryVersion: scs_u32_t; Parameters: scs_telemetry_init_params_t): Boolean; virtual; abstract;
  end;

{==============================================================================}
{------------------------------------------------------------------------------}
{                           TTelemetryVersionObject                            }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TTelemetryVersionObject // Class declaration                              }
{==============================================================================}
{
  @abstract(Common ancestor for all classes that needs to be checked for version
  support before creation of an instance.)

  This class implements all methods from TTelemetryAbstractVersionObject. Used
  as an ancestor for classes that supports exactly the same versions set as this
  class.@br
  All methods must be called directly on class. They are intended to be used to
  check whether the class supports required telemetry  and game version before
  instantiation (creation of class instance).

  Supported versions as of 2014-04-06:
@unorderedList(
  @itemSpacing(Compact)
  @item(Telemetry 1.0)
  @item(eut2 1.0)
  @item(eut2 1.1)
  @item(eut2 1.2)
  @item(eut2 1.3)
  @item(eut2 1.4)
  @item(eut2 1.5)
  @item(eut2 1.6)
  @item(eut2 1.7)
  @item(eut2 1.8)
)

@member(HighestSupportedTelemetryVersion See @inherited.)
@member(HighestSupportedGameVersion See @inherited.)
@member(SupportsTelemetryVersion See @inherited.)
@member(SupportsTelemetryMajorVersion See @inherited.)
@member(SupportsGameVersion See @inherited.)
@member(SupportsTelemetryAndGameVersion See @inherited.)
@member(SupportsTelemetryAndGameVersionParam See @inherited.)
}
  TTelemetryVersionObject = class(TTelemetryAbstractVersionObject)
  public
    class Function HighestSupportedTelemetryVersion: scs_u32_t; override;
    class Function HighestSupportedGameVersion(GameID: scs_string_t): scs_u32_t; override;
    class Function SupportsTelemetryVersion(TelemetryVersion: scs_u32_t): Boolean; override;
    class Function SupportsTelemetryMajorVersion(TelemetryVersion: scs_u32_t): Boolean; override;
    class Function SupportsGameVersion(GameID: scs_string_t; GameVersion: scs_u32_t): Boolean; override;
    class Function SupportsTelemetryAndGameVersion(TelemetryVersion: scs_u32_t; GameID: scs_string_t; GameVersion: scs_u32_t): Boolean; override;
    class Function SupportsTelemetryAndGameVersionParam(TelemetryVersion: scs_u32_t; Parameters: scs_telemetry_init_params_t): Boolean; override;
  end;


{==============================================================================}
{------------------------------------------------------------------------------}
{                        TTelemetryVersionPrepareObject                        }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TTelemetryVersionPrepareObject // Class declaration                       }
{==============================================================================}
{
  @abstract(Common ancestor for all classes that needs to be prepared for
  selected telemetry and/or game version.)

  Methods beginning with @code(Prepare_) are called to prepare created object
  for specific telemetry/game version.@br
  Each telemetry/game version has its own method, even if no action is needed.
  For each version, all lower or equal version methods are called in ascending
  order (every method calls its predecessor at the beginning of its own code).
  For example, for version 1.2, methods 1_0, 1_1 and 1_2 would be called.
  
@member(PrepareForTelemetryVersion
    Performs any preparations necessary to support required telemetry version.

    @param(TelemetryVersion Version of telemetry for which the object should be
                            prepared.)

    @returns(@True when preparation for given version were done successfully,
             otherwise @false.))

@member(PrepareForGameVersion
    Performs preparations necessary to support required game and its version.

    @param GameName     Name of the game.
    @param GameID       Game identifier.
    @param GameVersion  Version of game.

    @returns(@True when preparation for given game and its version were done
             successfully, otherwise @false.))

@member(Prepare_Telemetry_1_0 Preparation for telemetry 1.0.)

@member(Prepare_Game_eut2_1_0 Preparation for eut2 1.0.)

@member(Prepare_Game_eut2_1_1 Preparation for eut2 1.1.@br
        Calls Prepare_Game_eut2_1_0.)

@member(Prepare_Game_eut2_1_2 Preparation for eut2 1.2.@br
        Calls Prepare_Game_eut2_1_1.)

@member(Prepare_Game_eut2_1_3 Preparation for eut2 1.3.@br
        Calls Prepare_Game_eut2_1_2.)

@member(Prepare_Game_eut2_1_4 Preparation for eut2 1.4.@br
        Calls Prepare_Game_eut2_1_3.)

@member(Prepare_Game_eut2_1_5 Preparation for eut2 1.5.@br
        Calls Prepare_Game_eut2_1_4.)

@member(Prepare_Game_eut2_1_6 Preparation for eut2 1.6.@br
        Calls Prepare_Game_eut2_1_5.)

@member(Prepare_Game_eut2_1_7 Preparation for eut2 1.7.@br
        Calls Prepare_Game_eut2_1_6.)

@member(Prepare_Game_eut2_1_8 Preparation for eut2 1.8.@br
        Calls Prepare_Game_eut2_1_7.)
}
  TTelemetryVersionPrepareObject = class(TTelemetryVersionObject)
  protected
    Function PrepareForTelemetryVersion(TelemetryVersion: scs_u32_t): Boolean; virtual;
    Function PrepareForGameVersion(const GameName, GameID: TelemetryString; GameVersion: scs_u32_t): Boolean; virtual;
    procedure Prepare_Telemetry_1_0; virtual;
    procedure Prepare_Game_eut2_1_0; virtual;
    procedure Prepare_Game_eut2_1_1; virtual;
    procedure Prepare_Game_eut2_1_2; virtual;
    procedure Prepare_Game_eut2_1_3; virtual;
    procedure Prepare_Game_eut2_1_4; virtual;
    procedure Prepare_Game_eut2_1_5; virtual;
    procedure Prepare_Game_eut2_1_6; virtual;
    procedure Prepare_Game_eut2_1_7; virtual;
    procedure Prepare_Game_eut2_1_8; virtual;
  end;

implementation

uses
  TelemetryCommon, TelemetryStrings;

{==============================================================================}
{------------------------------------------------------------------------------}
{                           TTelemetryVersionObject                            }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TTelemetryVersionObject // Class implementation                           }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TTelemetryVersionObject // Constants, types, variables, etc...            }
{------------------------------------------------------------------------------}

const
{$IFDEF DevelopmentHints}
  {$MESSAGE HINT 'Development hint: Remember to update.'}
{$ENDIF}
  // These constants can change with telemetry development, remember to update
  // them if you add support for new telemetry version.
  cSupportedTelemetryVersions: Array[0..0] of scs_u32_t =
   (SCS_TELEMETRY_VERSION_1_00 {1.0});

  cSupportedGameVersions: Array[0..8] of TGameSupportInfo =
   ((GameID: SCS_GAME_ID_EUT2; GameVersion: SCS_TELEMETRY_EUT2_GAME_VERSION_1_00 {ETS2 1.0}),
    (GameID: SCS_GAME_ID_EUT2; GameVersion: SCS_TELEMETRY_EUT2_GAME_VERSION_1_01 {ETS2 1.1}),
    (GameID: SCS_GAME_ID_EUT2; GameVersion: SCS_TELEMETRY_EUT2_GAME_VERSION_1_02 {ETS2 1.2}),
    (GameID: SCS_GAME_ID_EUT2; GameVersion: SCS_TELEMETRY_EUT2_GAME_VERSION_1_03 {ETS2 1.3}),
    (GameID: SCS_GAME_ID_EUT2; GameVersion: SCS_TELEMETRY_EUT2_GAME_VERSION_1_04 {ETS2 1.4}),
    (GameID: SCS_GAME_ID_EUT2; GameVersion: SCS_TELEMETRY_EUT2_GAME_VERSION_1_05 {ETS2 1.5}),
    (GameID: SCS_GAME_ID_EUT2; GameVersion: SCS_TELEMETRY_EUT2_GAME_VERSION_1_06 {ETS2 1.6}),
    (GameID: SCS_GAME_ID_EUT2; GameVersion: SCS_TELEMETRY_EUT2_GAME_VERSION_1_07 {ETS2 1.7}),
    (GameID: SCS_GAME_ID_EUT2; GameVersion: SCS_TELEMETRY_EUT2_GAME_VERSION_1_08 {ETS2 1.8}));

{------------------------------------------------------------------------------}
{    TTelemetryVersionObject // Public methods                                 }
{------------------------------------------------------------------------------}


class Function TTelemetryVersionObject.HighestSupportedTelemetryVersion: scs_u32_t;
begin
Result := cSupportedTelemetryVersions[High(cSupportedTelemetryVersions)];
end;

//------------------------------------------------------------------------------

class Function TTelemetryVersionObject.HighestSupportedGameVersion(GameID: scs_string_t): scs_u32_t;
var
  i:  Integer;
begin
Result := SCS_U32_NIL;
For i := High(cSupportedGameVersions) downto Low(cSupportedGameVersions) do
{$IFDEF AssumeASCIIString}
  If TelemetrySameStrNoConv(APIStringToTelemetryString(GameID),cSupportedGameVersions[i].GameID) then
{$ELSE}
  If TelemetrySameStr(APIStringToTelemetryString(GameID),cSupportedGameVersions[i].GameID) then
{$ENDIF}
    Result := cSupportedGameVersions[i].GameVersion;
end;

//------------------------------------------------------------------------------

class Function TTelemetryVersionObject.SupportsTelemetryVersion(TelemetryVersion: scs_u32_t): Boolean;
var
  i:  Integer;
begin
Result := False;
For i := Low(cSupportedTelemetryVersions) to High(cSupportedTelemetryVersions) do
  If TelemetryVersion = cSupportedTelemetryVersions[i] then
    begin
      Result := True;
      Break;
    end;
end;

//------------------------------------------------------------------------------

class Function TTelemetryVersionObject.SupportsTelemetryMajorVersion(TelemetryVersion: scs_u32_t): Boolean;
var
  i:  Integer;
begin
Result := False;
For i := Low(cSupportedTelemetryVersions) to High(cSupportedTelemetryVersions) do
  If (TelemetryVersion and $FFFF0000) = (cSupportedTelemetryVersions[i] and $FFFF0000) then
    begin
      Result := True;
      Break;
    end;
end;

//------------------------------------------------------------------------------

class Function TTelemetryVersionObject.SupportsGameVersion(GameID: scs_string_t; GameVersion: scs_u32_t): Boolean;
var
  i:  Integer;
begin
Result := False;
For i := Low(cSupportedGameVersions) to High(cSupportedGameVersions) do
{$IFDEF AssumeASCIIString}
  If TelemetrySameStrNoConv(APIStringToTelemetryString(GameID),cSupportedGameVersions[i].GameID) and
{$ELSE}
  If TelemetrySameStr(APIStringToTelemetryString(GameID),cSupportedGameVersions[i].GameID) and
{$ENDIF}
    (GameVersion = cSupportedGameVersions[i].GameVersion) then
    begin
      Result := True;
      Break;
    end;
end;

//------------------------------------------------------------------------------

class Function TTelemetryVersionObject.SupportsTelemetryAndGameVersion(TelemetryVersion: scs_u32_t; GameID: scs_string_t; GameVersion: scs_u32_t): Boolean;
begin
Result := SupportsTelemetryVersion(TelemetryVersion) and SupportsGameVersion(GameID,GameVersion);
end;

//------------------------------------------------------------------------------

class Function TTelemetryVersionObject.SupportsTelemetryAndGameVersionParam(TelemetryVersion: scs_u32_t; Parameters: scs_telemetry_init_params_t): Boolean;
begin
Result := SupportsTelemetryAndGameVersion(TelemetryVersion,Parameters.common.game_id,Parameters.common.game_version);
end;

{==============================================================================}
{------------------------------------------------------------------------------}
{                        TTelemetryVersionPrepareObject                        }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TTelemetryVersionPrepareObject // Class implementation                    }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TTelemetryVersionPrepareObject // Protected methods                       }
{------------------------------------------------------------------------------}

Function TTelemetryVersionPrepareObject.PrepareForTelemetryVersion(TelemetryVersion: scs_u32_t): Boolean;
begin
case TelemetryVersion of
  SCS_TELEMETRY_VERSION_1_00: begin Prepare_Telemetry_1_0; Result := True; end; {1.0}
else
  Result := False;
end;
end;

//------------------------------------------------------------------------------

Function TTelemetryVersionPrepareObject.PrepareForGameVersion(const GameName, GameID: TelemetryString; GameVersion: scs_u32_t): Boolean;
begin
Result := False;
{$IFDEF AssumeASCIIString}
If TelemetrySameStrNoConv(GameId,SCS_GAME_ID_EUT2) then  {eut2, Euro Truck Simulator 2}
{$ELSE}
If TelemetrySameStr(GameId,SCS_GAME_ID_EUT2) then  {eut2, Euro Truck Simulator 2}
{$ENDIF}
  begin
    case GameVersion of
      SCS_TELEMETRY_EUT2_GAME_VERSION_1_00: begin Prepare_Game_eut2_1_0; Result := True; end; {1.0}
      SCS_TELEMETRY_EUT2_GAME_VERSION_1_01: begin Prepare_Game_eut2_1_1; Result := True; end; {1.1}
      SCS_TELEMETRY_EUT2_GAME_VERSION_1_02: begin Prepare_Game_eut2_1_2; Result := True; end; {1.2}
      SCS_TELEMETRY_EUT2_GAME_VERSION_1_03: begin Prepare_Game_eut2_1_3; Result := True; end; {1.3}
      SCS_TELEMETRY_EUT2_GAME_VERSION_1_04: begin Prepare_Game_eut2_1_4; Result := True; end; {1.4}
      SCS_TELEMETRY_EUT2_GAME_VERSION_1_05: begin Prepare_Game_eut2_1_5; Result := True; end; {1.5}
      SCS_TELEMETRY_EUT2_GAME_VERSION_1_06: begin Prepare_Game_eut2_1_6; Result := True; end; {1.6}
      SCS_TELEMETRY_EUT2_GAME_VERSION_1_07: begin Prepare_Game_eut2_1_7; Result := True; end; {1.7}
      SCS_TELEMETRY_EUT2_GAME_VERSION_1_08: begin Prepare_Game_eut2_1_8; Result := True; end; {1.8}
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TTelemetryVersionPrepareObject.Prepare_Telemetry_1_0;
begin
// No action.
end;

//------------------------------------------------------------------------------

procedure TTelemetryVersionPrepareObject.Prepare_Game_eut2_1_0;
begin
// No action.
end;

//------------------------------------------------------------------------------

procedure TTelemetryVersionPrepareObject.Prepare_Game_eut2_1_1;
begin
Prepare_Game_eut2_1_0;
end;

//------------------------------------------------------------------------------

procedure TTelemetryVersionPrepareObject.Prepare_Game_eut2_1_2;
begin
Prepare_Game_eut2_1_1;
end;

//------------------------------------------------------------------------------

procedure TTelemetryVersionPrepareObject.Prepare_Game_eut2_1_3;
begin
Prepare_Game_eut2_1_2;
end;

//------------------------------------------------------------------------------

procedure TTelemetryVersionPrepareObject.Prepare_Game_eut2_1_4;
begin
Prepare_Game_eut2_1_3;
end;

//------------------------------------------------------------------------------

procedure TTelemetryVersionPrepareObject.Prepare_Game_eut2_1_5;
begin
Prepare_Game_eut2_1_4;
end;

//------------------------------------------------------------------------------

procedure TTelemetryVersionPrepareObject.Prepare_Game_eut2_1_6;
begin
Prepare_Game_eut2_1_5;
end;

//------------------------------------------------------------------------------

procedure TTelemetryVersionPrepareObject.Prepare_Game_eut2_1_7;
begin
Prepare_Game_eut2_1_6;
end;

//------------------------------------------------------------------------------

procedure TTelemetryVersionPrepareObject.Prepare_Game_eut2_1_8;
begin
Prepare_Game_eut2_1_7;
end;

end.
