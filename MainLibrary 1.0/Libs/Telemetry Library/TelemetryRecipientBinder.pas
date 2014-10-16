{@html(<hr>)
@abstract(Provides base class for classes binding itself to telemetry recipient
          events.)
@author(František Milt <fmilt@seznam.cz>)
@created(2014-05-03)
@lastmod(2014-05-03)

  @bold(@NoAutoLink(TelemetryRecipientBinder))

  ©František Milt, all rights reserved.

  This unit provides class TTelemetryRecipientBinder that is designed as a base
  for classes that are intended to bind itself to telemetry recipient events
  (eg. loggers, servers, ...).

  Last change:  2014-05-03

  Change List:@unorderedList(
    @item(2014-05-03 - First stable version.))

@html(<hr>)}
unit TelemetryRecipientBinder;

interface

{$INCLUDE '.\Telemetry_defs.inc'}

uses
  TelemetryCommon,
  TelemetryIDs,
  TelemetryRecipient,
{$IFDEF UseCondensedHeader}
  SCS_Telemetry_Condensed;
{$ELSE}
  scssdk,
  scssdk_value,
  scssdk_telemetry_event;
{$ENDIF}

{==============================================================================}
{------------------------------------------------------------------------------}
{                          TTelemetryRecipientBinder                           }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TTelemetryRecipientBinder // Class declaration                            }
{==============================================================================}
{
  @abstract(Class designed as a base for any class that is intended to bind
            itself to telemetry @noAutoLink(recipient) events.)
  It has predefined abstract methods that can be assigned as handlers to
  @noAutoLink(recipient) events one by one (when you want full control over what
  and when is called), or at once using AssignHandlers method (Recipient must
  be assigned for this to work).

  @member(fRecipient See Recipient for details.)


  @member(GetWorkingRecipient
    Method used to get valid telemetry @noAutoLink(recipient) for work.@br
    When Recipient property is assigned, then it is returned in output parameter
    @noAutoLink(@code(Recipient)), when not, check whether object passed in
    parameter @code(Sender) is of type TTelemetryRecipient (or its descendant)
    and when it is, then this object is returned, otherwise output parameter
    contains @nil.

    @param(Sender    Object suggested as working telemetry
                     @noAutoLink(recipient).)
    @param(Recipient Output variable containing either valid telemetry
                     @noAutoLink(recipient) or @nil.)

    @returns(@True when output parameter @noAutoLink(@code(Recipient)) contains
             valid telemetry @noAutoLink(recipient), @false otherwise.))

  @member(fDeassignHandlersOnDestroy
    See DeassignHandlersOnDestroy for details.)

  @member(Create
    Class constructor.

    @param(Recipient Telemetry @noAutoLink(recipient) that operates on API. When
                     you assign this parameter, it will be assigned to Recipient
                     property and handlers will be assigned to its events using
                     AssignHandlers method.))

  @member(Destroy
    Class destructor.

    Calls method DeassignHandlers when DeassignHandlersOnDestroy property is
    @true.)

  @member(AssignHandlers
    Assigns appropriate *Handler methods as handlers of Recipent events.

    @returns(@True when Recipient is assigned and all handlers were assigned to
             its event, @false otherwise.))

  @member(DeassignHandlers
    Deassigns handlers of Recipient events.

    @returns(@True when Recipient is assigned and all handlers were deassigned,
             @false otherwise.))

  @member(LogHandler
    Method that can be assigned to @noAutoLink(recipent) @link(
    TelemetryRecipient.TTelemetryRecipient.OnLog OnLog) event.

    @param Sender  Object that is calling this method.
    @param LogType Type of log written into game log.
    @param LogText Actual text written into game log.)

  @member(EventRegisterHandler
    Method that can be assigned to @noAutoLink(recipent) @link(
    TelemetryRecipient.TTelemetryRecipient.OnEventRegister OnEventRegister)
    event.

    @param Sender Object that is calling this method.
    @param Event  Game event identification number.)

  @member(EventUnregisterHandler
    Method that can be assigned to @noAutoLink(recipent) @link(
    TelemetryRecipient.TTelemetryRecipient.OnEventUnregister OnEventUnregister)
    event.

    @param Sender Object that is calling this method.
    @param Event  Game event identification number.)

  @member(EventHandler
    Method that can be assigned to @noAutoLink(recipent) @link(
    TelemetryRecipient.TTelemetryRecipient.OnEvent OnEvent) event.

    @param Sender Object that is calling this method.
    @param Event  Game event identification number.
    @param Data   Pointer to data accompanying the event. Can be @nil.)

  @member(ChannelRegisterHandler
    Method that can be assigned to @noAutoLink(recipent) @link(
    TelemetryRecipient.TTelemetryRecipient.OnChannelRegister OnChannelRegister)
    event.

    @param Sender    Object that is calling this method.
    @param Name      Name of registered channel.
    @param ID        ID of registered channel.
    @param Index     Index of registered channel.
    @param ValueType Value type of registered channel.
    @param Flags     Registration flags.)

  @member(ChannelUnregisterHandler
    Method that can be assigned to @noAutoLink(recipent) @link(
    TelemetryRecipient.TTelemetryRecipient.OnChannelUnregister
    OnChannelUnregister)
    event.

    @param Sender    Object that is calling called this method.
    @param Name      Name of unregistered channel.
    @param ID        ID of unregistered channel.
    @param Index     Index of unregistered channel.
    @param ValueType Value type of unregistered channel.)

  @member(ChannelHandler
    Method that can be assigned to @noAutoLink(recipent) @link(
    TelemetryRecipient.TTelemetryRecipient.OnChannel OnChannel) event.

    @param Sender Object that that is calling this method.
    @param Name   Name of the channel.
    @param ID     ID of the channel.
    @param Index  Index of the channel.
    @param Value  Actual value of the channel. Can be @nil.)

  @member(ConfigHandler
    Method that can be assigned to @noAutoLink(recipent) @link(
    TelemetryRecipient.TTelemetryRecipient.OnConfig OnConfig) event.

    @param Sender    Object that is calling called this method.
    @param Name      Name of the config.
    @param ID        ID of the config.
    @param Index     Index of the config.
    @param Value     Actual value of the config.)


  @member(Recipient
    Reference to @noAutoLink(recipient) that operates on telemetry API. Not
    initialized, it is assigned in constructor. Can be @nil.)

  @member(DeassignHandlersOnDestroy
    When @true, the destructor calls method DeassignHandlers.@br
    Initialized to @true.)
}
type
  TTelemetryRecipientBinder = class(TObject)
  private
    fRecipient:                 TTelemetryRecipient;
    fDeassignHandlersOnDestroy: Boolean;
  protected
    Function GetWorkingRecipient(Sender: TObject; out Recipient: TTelemetryRecipient): Boolean; virtual;
  public
    constructor Create(Recipient: TTelemetryRecipient = nil);
    destructor Destroy; override;
    Function AssignHandlers: Boolean; virtual;
    Function DeassignHandlers: Boolean; virtual;
    procedure LogHandler(Sender: TObject; LogType: scs_log_type_t; const LogText: String); virtual; abstract;
    procedure EventRegisterHandler(Sender: TObject; Event: scs_event_t); virtual; abstract;
    procedure EventUnregisterHandler(Sender: TObject; Event: scs_event_t); virtual; abstract;
    procedure EventHandler(Sender: TObject; Event: scs_event_t; Data: Pointer); virtual; abstract;
    procedure ChannelRegisterHandler(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t); virtual; abstract;
    procedure ChannelUnregisterHandler(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t); virtual; abstract;
    procedure ChannelHandler(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; Value: p_scs_value_t); virtual; abstract;
    procedure ConfigHandler(Sender: TObject; const Name: TelemetryString; ID: TConfigID; Index: scs_u32_t; Value: scs_value_localized_t); virtual; abstract;
  published
    property Recipient: TTelemetryRecipient read fRecipient write fRecipient;
    property DeassignHandlersOnDestroy: Boolean read fDeassignHandlersOnDestroy write fDeassignHandlersOnDestroy;
  end;

implementation

{==============================================================================}
{------------------------------------------------------------------------------}
{                          TTelemetryRecipientBinder                           }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TTelemetryRecipientBinder // Class implementation                         }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TTelemetryRecipientBinder // Constants, types, variables, etc...          }
{------------------------------------------------------------------------------}

const
  // Default (initial) values for TTelemetryRecipientBinder properties.
  def_DeassignHandlersOnDestroy = True;

{------------------------------------------------------------------------------}
{    TTelemetryRecipientBinder // Protected methods                            }
{------------------------------------------------------------------------------}

Function TTelemetryRecipientBinder.GetWorkingRecipient(Sender: TObject; out Recipient: TTelemetryRecipient): Boolean;
begin
If Assigned(fRecipient) then Recipient := fRecipient
  else If Sender is TTelemetryRecipient then Recipient := TTelemetryRecipient(Sender)
    else Recipient := nil;
Result := Assigned(Recipient);
end;

{------------------------------------------------------------------------------}
{    TTelemetryRecipientBinder // Public methods                               }
{------------------------------------------------------------------------------}

constructor TTelemetryRecipientBinder.Create(Recipient: TTelemetryRecipient = nil);
begin
inherited Create;
fRecipient := Recipient;
If Assigned(Recipient) then AssignHandlers;
fDeassignHandlersOnDestroy := def_DeassignHandlersOnDestroy;
end;

//------------------------------------------------------------------------------

destructor TTelemetryRecipientBinder.Destroy;
begin
If DeassignHandlersOnDestroy then DeassignHandlers;
inherited;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipientBinder.AssignHandlers: Boolean;
begin
Result := False;
If Assigned(fRecipient) then
  begin
    {$IFDEF MulticastEvents}
    fRecipient.OnLogMulti.Add(LogHandler);
    fRecipient.OnEventRegisterMulti.Add(EventRegisterHandler);
    fRecipient.OnEventUnregisterMulti.Add(EventUnregisterHandler);
    fRecipient.OnEventMulti.Add(EventHandler);
    fRecipient.OnChannelRegisterMulti.Add(ChannelRegisterHandler);
    fRecipient.OnChannelUnregisterMulti.Add(ChannelUnregisterHandler);
    fRecipient.OnChannelMulti.Add(ChannelHandler);
    fRecipient.OnConfigMulti.Add(ConfigHandler);
    {$ELSE}
    fRecipient.OnLog := LogHandler;
    fRecipient.OnEventRegister := EventRegisterHandler;
    fRecipient.OnEventUnregister := EventUnregisterHandler;
    fRecipient.OnEvent := EventHandler;
    fRecipient.OnChannelRegister := ChannelRegisterHandler;
    fRecipient.OnChannelUnregister := ChannelUnregisterHandler;
    fRecipient.OnChannel := ChannelHandler;
    fRecipient.OnConfig := ConfigHandler;
    {$ENDIF}
    Result := True;
  end;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipientBinder.DeassignHandlers: Boolean;
begin
Result := False;
If Assigned(fRecipient) then
  begin
    {$IFDEF MulticastEvents}
    fRecipient.OnLogMulti.Remove(LogHandler);
    fRecipient.OnEventRegisterMulti.Remove(EventRegisterHandler);
    fRecipient.OnEventUnregisterMulti.Remove(EventUnregisterHandler);
    fRecipient.OnEventMulti.Remove(EventHandler);
    fRecipient.OnChannelRegisterMulti.Remove(ChannelRegisterHandler);
    fRecipient.OnChannelUnregisterMulti.Remove(ChannelUnregisterHandler);
    fRecipient.OnChannelMulti.Remove(ChannelHandler);
    fRecipient.OnConfigMulti.Remove(ConfigHandler);
    {$ELSE}
    fRecipient.OnLog := nil;
    fRecipient.OnEventRegister := nil;
    fRecipient.OnEventUnregister := nil;
    fRecipient.OnEvent := nil;
    fRecipient.OnChannelRegister := nil;
    fRecipient.OnChannelUnregister := nil;
    fRecipient.OnChannel := nil;
    fRecipient.OnConfig := nil;
    {$ENDIF}
    Result := True;
  end;
end;

end.
