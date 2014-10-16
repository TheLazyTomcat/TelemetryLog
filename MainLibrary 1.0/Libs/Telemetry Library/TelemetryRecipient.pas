{@html(<hr>)
@abstract(Telemetry recipient class (API control and data receiver).)
@author(František Milt <fmilt@seznam.cz>)
@created(2013-10-07)
@lastmod(2014-05-04)

  @bold(@NoAutoLink(TelemetryRecipient))

  ©František Milt, all rights reserved.

  This unit contains TTelemetryRecipient class used to control the telmetry API
  (see class declaration for details) and few classes used to manage multicast
  events for the recipient, namely:
@preformatted(
  TMulticastLogEvent
  TMulticastEventRegisterEvent
  TMulticastEventEvent
  TMulticastChannelRegisterEvent
  TMulticastChannelUnregisterEvent
  TMulticastChannelEvent
  TMulticastConfigEvent
)
  Included files:@preformatted(
    .\Inc\TelemetryRecipient_MulticastEvents.pas
      Contains declarations and implementations of multicast event classes.)

  Last change:  2014-05-04

  Change List:@unorderedList(
    @item(2013-10-07 - First stable version.)
    @item(2013-04-18 - Following parameters in event types were changed to
                       @code(TelemetryString):@unorderedList(
                         @itemSpacing(Compact)
                         @item(TChannelRegisterEvent - parameter @code(Name))
                         @item(TChannelUnregisterEvent - parameter @code(Name))
                         @item(TChannelEvent - parameter @code(Name))
                         @item(TConfigEvent - parameter @code(Name))))
    @item(2014-04-18 - Type of parameters @code(Name) changed to
                       @code(TelemetryString) in following methods:
                       @unorderedList(
                         @itemSpacing(Compact)
                         @item(TTelemetryRecipient.ChannelHandler)
                         @item(TTelemetryRecipient.ChannelRegistered)
                         @item(TTelemetryRecipient.ChannelRegister)
                         @item(TTelemetryRecipient.ChannelUnregister)
                         @item(TTelemetryRecipient.ConfigStored)
                         @item(TTelemetryRecipient.ChannelStored)))
    @item(2014-04-18 - Type of following fields and properties changed to
                       @code(TelemetryString):@unorderedList(
                         @itemSpacing(Compact)
                         @item(TTelemetryRecipient.fGameName)
                         @item(TTelemetryRecipient.fGameID)
                         @item(TTelemetryRecipient.GameName)
                         @item(TTelemetryRecipient.GameID)))
    @item(2014-04-19 - Following multicast event classes were added:
                       @unorderedList(
                         @itemSpacing(Compact)
                         @item(TMulticastLogEvent)
                         @item(TMulticastEventRegisterEvent)
                         @item(TMulticastEventEvent)
                         @item(TMulticastChannelRegisterEvent)
                         @item(TMulticastChannelUnregisterEvent)
                         @item(TMulticastChannelEvent)
                         @item(TMulticastConfigEvent)))
    @item(2014-04-19 - Added following multicast events:@unorderedList(
                         @itemSpacing(Compact)
                         @item(TTelemetryRecipient.OnDestroyMulti)
                         @item(TTelemetryRecipient.OnLogMulti)
                         @item(TTelemetryRecipient.OnEventRegisterMulti)
                         @item(TTelemetryRecipient.OnEventUnregisterMulti)
                         @item(TTelemetryRecipient.OnEventMulti)
                         @item(TTelemetryRecipient.OnChannelRegisterMulti)
                         @item(TTelemetryRecipient.OnChannelUnregisterMulti)
                         @item(TTelemetryRecipient.OnChannelMulti)
                         @item(TTelemetryRecipient.OnConfigMulti)))
    @item(2014-04-19 - Added following methods:@unorderedList(
                         @itemSpacing(Compact)
                         @item(TTelemetryRecipient.DoOnDestroy)
                         @item(TTelemetryRecipient.DoOnLog)
                         @item(TTelemetryRecipient.DoOnEventRegister)
                         @item(TTelemetryRecipient.DoOnEventUnregister)
                         @item(TTelemetryRecipient.DoOnEvent)
                         @item(TTelemetryRecipient.DoOnChannelRegister)
                         @item(TTelemetryRecipient.DoOnChannelUnregister)
                         @item(TTelemetryRecipient.DoOnChannel)
                         @item(TTelemetryRecipient.DoOnConfig)
                         @item(TTelemetryRecipient.EventRegisterByIndex)
                         @item(TTelemetryRecipient.EventUnregisterIndex)
                         @item(TTelemetryRecipient.EventUnregisterByIndex)
                         @item(TTelemetryRecipient.ChannelRegisterByIndex)
                         @item(TTelemetryRecipient.ChannelRegisterByName)
                         @item(TTelemetryRecipient.ChannelUnregisterIndex)
                         @item(TTelemetryRecipient.ChannelUnregisterByIndex)
                         @item(TTelemetryRecipient.ChannelUnregisterByName)))
    @item(2014-04-27 - Added parameter @code(ShowDescriptors) to methods
                       TTelemetryRecipient.EventGetDataAsString and
                       TTelemetryRecipient.ChannelGetValueAsString.)
    @item(2014-05-01 - Added method
                       TTelemetryRecipient.HighestSupportedGameVersion.)
    @item(2014-05-04 - Following callback functions were added:@unorderedList(
                         @itemSpacing(Compact)
                         @item(RecipientGetChannelIDFromName)
                         @item(RecipientGetChannelNameFromID)
                         @item(RecipientGetConfigIDFromName)
                         @item(RecipientGetConfigNameFromID))))

@html(<hr>)}
unit TelemetryRecipient;

interface

{$INCLUDE '.\Telemetry_defs.inc'}

uses
  Classes,
{$IFDEF MulticastEvents}
  MulticastEvent,
{$ENDIF}  
  TelemetryCommon,
  TelemetryIDs,
  TelemetryLists,
  TelemetryVersionObjects,  
  TelemetryInfoProvider,
{$IFDEF Documentation}
  TelemetryConversions,
  TelemetryStrings,
{$ENDIF}
{$IFDEF UseCondensedHeader}
  SCS_Telemetry_Condensed;
{$ELSE}
  scssdk,
  scssdk_value,
  scssdk_telemetry,
  scssdk_telemetry_event,
  scssdk_telemetry_channel;
{$ENDIF}

{==============================================================================}
{------------------------------------------------------------------------------}
{                                Declarations                                  }
{------------------------------------------------------------------------------}
{==============================================================================}

const
  // Maximum allowed channel index, see TTelemetryRecipient.ChannelRegisterAll
  // method for details.
{$IFDEF MaxIndexedChannelCount8}
  cMaxChannelIndex = 7;
{$ELSE}
  cMaxChannelIndex = 99;
{$ENDIF}

type
  // Enumerated type used in method TTelemetryRecipient.SetGameCallback to set
  // one particular game callback.
  TGameCallback = (gcbLog, gcbEventReg, gcbEventUnreg, gcbChannelReg, gcbChannelUnreg);

  // Event type used when recipient writes to game log.
  TLogEvent = procedure(Sender: TObject; LogType: scs_log_type_t; const LogText: String) of object;
  // Event type used when telemetry event is registered or unregistered.
  TEventRegisterEvent = procedure(Sender: TObject; Event: scs_event_t) of object;
  // Event type used when telemetery event occurs.
  TEventEvent = procedure(Sender: TObject; Event: scs_event_t; Data: Pointer) of object;
  // Event type used when telemetry channel is registered.
  TChannelRegisterEvent = procedure(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t) of Object;
  // Event type used when telemetry channel is unregistered.
  TChannelUnregisterEvent = procedure(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t) of Object;
  // Event type used when telemetery channel callback occurs.
  TChannelEvent = procedure(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; Value: p_scs_value_t) of Object;
  // Event type used when config is parsed from configuration telemetry event.
  TConfigEvent = procedure(Sender: TObject; const Name: TelemetryString; ID: TConfigID; Index: scs_u32_t; Value: scs_value_localized_t) of object;

{$IFDEF MulticastEvents}
  {$DEFINE DeclarationPart}
    {$INCLUDE '.\Inc\TelemetryRecipient_MulticastEvents.pas'}
  {$UNDEF DeclarationPart}
{$ENDIF}

{==============================================================================}
{------------------------------------------------------------------------------}
{                             TTelemetryRecipient                              }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TTelemetryRecipient // Class declaration                                  }
{==============================================================================}
{
  @abstract(@NoAutoLink(TTelemetryRecipient) is used as a main way to control
  the telemetry API.)

  It provides methods for events and channels registration, unregistration and
  many others. It also provides object events that wraps API event and channel
  callbacks.@br
  Before instance of this class is created, a check if it supports required
  telemetry and game version must be performed. For that purpose, it has class
  methods that can be called on class itself (before creating class instance).
  If required versions are not supported, do not @noAutoLink(create) instance of
  this class!
   
  @bold(Note) - Because recipient internally creates instance of
  TTelemetryInfoProvider, the provider must support required versions of
  telemetry and game as well.

@member(fInfoProvider See TelemetryInfoProvider property.)

@member(fRegisteredEvents See RegisteredEvents property.)

@member(fRegisteredChannels See RegisteredChannels property.)

@member(fStoredConfigs See StoredConfigs property.)

@member(fStoredChannelsValues See StoredChannelsValues property.)

@member(fLastTelemetryResult See LastTelemetryResult property.)

@member(fTelemetryVersion See TelemetryVersion property.)

@member(fGameName See GameName property.)

@member(fGameID See GameID property.)

@member(fGameVersion See GameVersion property.)

@member(fKeepUtilityEvents See KeepUtilityEvents property.)

@member(fStoreConfigurations See StoreConfigurations property.)

@member(fManageIndexedChannels See ManageIndexedChannels property.)

@member(fStoreChannelsValues See StoreChannelsValues property.)

@member(cbLog
    Holds pointer to game callback routine intended for writing messages into
    game log.@br
    Assigned in constructor from passed parameters, or set to @nil.)

@member(cbRegisterEvent
    Holds pointer to game callback routine used for telemetry event
    registration.@br
    Assigned in constructor from passed parameters, or set to @nil.)

@member(cbUnregisterEvent
    Holds pointer to game callback routine used for telemetry event
    unregistration.@br
    Assigned in constructor from passed parameters, or set to @nil.)

@member(cbRegisterChannel
    Holds pointer to game callback routine used for telemetry channel
    registration.@br
    Assigned in constructor from passed parameters, or set to @nil.)

@member(cbUnregisterChannel
    Holds pointer to game callback routine used for telemetry channel
    unregistration.@br
    Assigned in constructor from passed parameters, or set to @nil.)

@member(fOnDestroy Holds referece to OnDestroy event handler.)

@member(fOnLog Holds referece to OnLog event handler.)

@member(fOnEventRegister Holds referece to OnEventRegister event handler.)

@member(fOnEventUnregister Holds referece to OnEventUnregister event handler.)

@member(fOnEvent Holds referece to OnEvent event handler.)

@member(fOnChannelRegister Holds referece to OnChannelRegister event handler.)

@member(fOnChannelUnregister Holds referece to OnChannelUnregister event
    handler.)

@member(fOnChannel Holds referece to OnChannel event handler.)

@member(fOnConfig Holds referece to OnConfig event handler.)

@member(fOnDestroyMulti Object managing multicast OnDestroyMulti event.)

@member(fOnLogMulti Object managing multicast OnLogMulti event.)

@member(fOnEventRegisterMulti Object managing multicast OnEventRegisterMulti
                              event.)

@member(fOnEventUnregisterMulti Object managing multicast OnEventUnregisterMulti
                                event.)

@member(fOnEventMulti Object managing multicast OnEventMulti event.)

@member(fOnChannelRegisterMulti Object managing multicast OnChannelRegisterMulti
                                event.)

@member(fOnChannelUnregisterMulti Object managing multicast OnChannelUnregister
                                  event.)

@member(fOnChannelMulti Object managing multicast OnChannelMulti event.)

@member(fOnConfigMulti Object managing multicast OnConfigMulti event.)

@member(SetKeepUtilityEvents
    Setter for KeepUtilityEvents property.

    @param Value New value to be stored in fKeepUtilityEvents.)
    
@member(SetStoreConfigurations
    Setter for StoreConfigurations property.

    @param Value New value to be stored in fStoreConfigurations.)

@member(SetStoreChannelsValues
    Setter for StoreChannelsValues property.

    @param Value New value to be stored in fStoreChannelsValues.)



@member(EventHandler
    Method called by plugin callback routine set to receive telemetry events.@br
    OnEvent event is called and received telemetry event is then processed.

    @param Event Telemetry event identification number.
    @param(Data  Pointer to data received alongside the telemetry event. Can be
                 @nil.))

@member(ChannelHandler
    Method called by plugin callback routine set to receive telemetry
    channels.@br

    @param Name  Name of received telemetry channel.
    @param ID    ID of received channel.
    @param Index Index of received channel.
    @param Value Pointer to actual value of received channel. Can be @nil.) 

@member(ProcessConfigurationEvent
    Method used for processing configuration events. It is called from
    EventHandler method when configuration event is received and
    StoreConfigurations is set to @true.@br
    Received data are parsed and configuration informations are extracted and
    stored in StoredConfigs list. OnConfig event is called for every extracted
    config (after it is stored / its stored value changed).@br
    When ManageIndexedChannels is set to @true, then indexed channels are too
    managed in this method (refer to source code for details).

    @param Data Structure holding actual configuration data.)

@member(PrepareForTelemetryVersion
    Performs any preparations necessary to support required telemetry
    version.@br
    TelemetryVersion property is set in this method when successful.

    @param(aTelemetryVersion Version of telemetry for which the object should be
                             prepared.)

    @returns(@True when preparation for given version were done successfully,
             otherwise @false.))

@member(PrepareForGameVersion
    Performs preparations necessary to support required game and its version.@br
    GameName, GameID and GameVersion properties are set in this method when
    successful.

    @param aGameName     Name of the game.
    @param aGameID       Game identifier.
    @param aGameVersion  Version of game.

    @returns(@True when preparation for given game and its version were done
             successfully, otherwise @false.))


    These methods: @preformatted(
    HighestSupportedTelemetryVersion
    SupportsTelemetryVersion
    SupportsTelemetryMajorVersion
    SupportsGameVersion
    SupportsTelemetryAndGameVersion)
    ...can and actually must be called directly on class.
    They should be used to check whether both this class and
    TTelemetryInfoProvider class supports required telemetry and game version
    before instantiation (creation of class instance).

@member(DoOnDestroy
    Calls hanler(s) of OnDestroy event.)

@member(DoOnLog
    Calls hanler(s) of OnLog event.)

@member(DoOnEventRegister
    Calls hanler(s) of OnEventRegister event.)

@member(DoOnEventUnregister
    Calls hanler(s) of OnEventUnregister event.)

@member(DoOnEvent
    Calls hanler(s) of OnEvent event.)

@member(DoOnChannelRegister
    Calls hanler(s) of OnChannelRegister event.)

@member(DoOnChannelUnregister
    Calls hanler(s) of OnChannelUnregister event.)

@member(DoOnChannel
    Calls hanler(s) of OnChannel event.)

@member(DoOnConfig
    Calls hanler(s) of OnConfig event.)             

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

@member(Create
    Object constructor.@br
    If passed telemetry/game versions are not supported then an exception is
    raised.

    @param(TelemetryVersion Version of telemetry for which the object should
                            prepare.)
    @param(Parameters       Structure containing other parameters used in
                            constructor (callbacks pointers, game version,
                            etc.).))

@member(Destroy
    Object destructor.@br
    Internal objects are automatically cleared in destructor, so it is
    unnecessary to free them explicitly.@br
    Also, all telemetry events and channels are unregistered.)

@member(SetGameCallbacks
    Use this method to set all game callbacks in one call.

    @param(Parameters Structure provided by telemetry API that contains all
                      necessary callback pointers.))

@member(SetGameCallback
    Use this method to set one specific game callback.@br
    Can be used to set specific callback to nil and thus disabling it (all
    calls to any callback are preceded by check for assignment).
    
    @bold(Warning) - @code(CallbackFunction) pointer is not checked for actual
                     type.

    @param(Callback         Indicates to which callback assign given function
                            pointer from second parameter.)
    @param CallbackFunction Pointer to be assigned.)

@member(EventRegistered
    Checks whether given event is present in RegisteredEvents list, when
    included, it is assumed that this event is registered in telemetry API.

    @param Event Event to be checked.

    @returns @True when given event is found in list, otherwise @false.)

@member(EventRegister
    Registers specific telemetry event.@br
    Works only when cbRegisterEvent callback is assigned, when it is not,
    function returns false and LastTelemetryResult is set to
    @code(SCS_RESULT_generic_error).

    @param Event Event to be registered.

    @returns(@True when registration was successful, otherwise @false (property
             LastTelemetryResult contains result code).))

@member(EventRegisterByIndex
    Registers telemetry event that is listed in known events list at position
    given by @code(Index) parameter. When index falls out of allowed boundaries,
    no event is registered and function returns @false.

    @param Index Index of requested event in known events list.

    @returns @True when requested event was registered, @false otherwise.)

@member(EventUnregister
    Unregisters specific telemetry event.@br
    Works only when cbUnregisterEvent callback is assigned, when it is not,
    function returns false and LastTelemetryResult is set to
    @code(SCS_RESULT_generic_error).

    @param Event Event to be unregistered.

    @returns(@True when unregistration was successful, otherwise @false
            (property LastTelemetryResult contains result code).))

@member(EventUnregisterIndex
    Unregister telemetry event that is listed in registered events list at
    position given by @code(Index) parameter.@br
    When index falls out of allowed boundaries, no channel is unregistered and
    function returns @false.

    @param Index Index of event in registered events list.

    @returns @True when requested event was unregistered, @false otherwise.)

@member(EventUnregisterByIndex
    Unregisters telemetry event that is listed in known events list at position
    given by @code(Index) parameter. When index falls out of allowed boundaries,
    no event is unregistered and function returns @false.

    @param Index Index of requested event in known events list.

    @returns @True when requested event was unregistered, @false otherwise.)

@member(EventRegisterAll
    Registers all events that TTelemetryInfoProvider class is aware of for
    current telemetry and game version.
    
    @returns Number of successfully registered events.)

@member(EventUnregisterAll
    Unregisters all events listed in RegisteredEvents list.

    @returns Number of successfully unregistered events.)

@member(EventGetDataAsString
    Returns textual representation of event data (e.g. for displaying to user).
    If no data can be converted to text, only name of event is returned.  When
    @code(TypeName) is set to true, all values are marked with type identifiers.

    @param Event           Type of event that is converted to text.
    @param Data            Data for given event. Can be @nil.
    @param(TypeName        Indicating whether type identifiers should be
                           included in resulting text.)
    @param(ShowDescriptors When set, fields descriptors are shown for composite
                           values.)

    @returns Textual representation of event (event name) and its data.)

@member(ChannelRegistered
    Checks whether given channel is present in RegisteredChannels list, when
    included, it is assumed that this channel is registered in telemetry API.

    @param Name      Name of channel to be checked.
    @param Index     Index of channel.
    @param ValueType Value type of checked channel.

    @returns @True when given channel is found in list, otherwise @false.)

@member(ChannelRegister
    Registers specific telemetry channel.@br
    Works only when cbRegisterChannel callback is assigned, when it is not,
    function returns false and LastTelemetryResult is set to
    @code(SCS_RESULT_generic_error).

    @param Name      Name of registered channel.
    @param Index     Index of registered channel.
    @param ValueType Value type of registered channel.
    @param Flags     Registration flags.

    @returns(@True when registration was successful, otherwise @false (property
             LastTelemetryResult contains result code).))

@member(ChannelRegisterByIndex
    Registers telemetry channel that is listed in known channels list at
    position given by @code(Index) parameter.@br
    When channel is marked as indexed then all index-versions of such channel
    are registered.@br
    Channel is registered only for its primary value type.@br
    When index falls out of allowed boundaries, no channel is registered and
    function returns @false.

    @param Index Index of requested channel in known channels list.

    @returns @True when requested channel was registered, @false otherwise.)

@member(ChannelRegisterByName
    Registers telemetry channel of given name. Channel of this name must be
    listed in known channels list as other informations required for
    registration are taken from there.@br
    When channel is marked as indexed then all index-versions of such channel
    are registered.@br
    Channel is registered only for its primary value type.@br
    When channel of given name is not listed between known channels, then no
    channel is registered and function returns @false.

    @param Name Name of channel to be registered.

    @returns @True when requested channel was registered, @false otherwise.)

@member(ChannelUnregister
    Unregister specific telemetry channel.
    Works only when cbUnregisterChannel callback is assigned, when it is not,
    function returns false and LastTelemetryResult is set to
    @code(SCS_RESULT_generic_error).

    @param Name      Name of channel to be unregistered.
    @param Index     Index of channel.
    @param ValueType Value type of channel.

    @returns(@True when unregistration was successful, otherwise @false
            (property LastTelemetryResult contains result code).))

@member(ChannelUnregisterIndex
    Unregister telemetry channel that is listed in registered channels list at
    position given by @code(Index) parameter.@br
    When index falls out of allowed boundaries, no channel is unregistered and
    function returns @false.

    @param Index Index of channel in registered channels list.

    @returns @True when requested channel was unregistered, @false otherwise.)

@member(ChannelUnregisterByIndex
    Unregisters all registered telemetry channels with the same name as channel
    that is listed in known channels list at position given by @code(Index)
    parameter.@br
    When index falls out of allowed boundaries, no channel is unregistered and
    function returns @false.

    @param Index Index of requested channel in known channels list.

    @returns @True when requested channel was unregistered, @false otherwise.)

@member(ChannelUnregisterByName
    Unregisters all registered telemetry channels with the given name.@br

    @param Name Name of channel(s) to be unregistered.

    @returns @True when requested channel was unregistered, @false otherwise.)

@member(ChannelRegisterAll
    This method registers all channels that the TTelemetryInfoProvider class is
    aware of for current telemetry and game version.@br
    When channel is marked as indexed, then all channel and index combinations
    are registered (see implementation of this method for details), otherwise
    only channels with index set to SCS_U32_NIL are registered. When
    ManageIndexedChannels and StoreConfigurations properties are both set to
    @true, then top index for indexed channel registration is taken from
    appropriate stored configuration value.@br
    Set RegPrimaryTypes, RegSecondaryTypes and RegTertiaryTypes to true to
    register respective channel value type. If all three parameters are set
    to false, the method executes but nothing is registered.

    @param RegPrimaryTypes   Register primary value type.
    @param RegSecondaryTypes Register secondary value type.
    @param RegTertiaryTypes  Register tertiary value type.

    @Returns Number of successfully registered channels.)

@member(ChannelUnregisterAll
    Unregisters all channels listed in RegisteredChannels list.

    @returns Number of successfully unregistered channels.)

@member(ChannelGetValueAsString
    Returns textual representation of channel value.
    When @code(TypeName) is set to true, all values are marked with type
    identifiers.

    @param Value           Pointer to actual channel value. Can be @nil.
    @param(TypeName        Indicating whether type identifiers should be
                           included in resulting text.)
    @param(ShowDescriptors When set, fields descriptors are shown for composite
                           values.)

    @returns(Textual representation of channel value, an empty string when
             value is not assigned.))

@member(ConfigStored
    Checks whether given config is stored in StoredConfigs list.

    @param Name  Name of checked configuration.
    @param Index Index of checked configuration.

    @returns @True when given config is found in list, otherwise @false.)

@member(ChannelStored
    Checks whether given channel is stored in StoredChannelValues list.

    @param Name      Name of checked channel.
    @param Index     Index of checked channel.
    @param ValueType Value type of checked channel.

    @returns @True when given channel is found in list, otherwise @false.)



@member(TelemetryInfoProvider
    This object provides lists of known events, channels and configs along with
    some methods around these lists/structures.@br
    Its main use is in registration of all known events and channels.@br
    It is created in constructor as automatically managed, so the lists are
    filled automatically accordingly to telemetry and game versions passed to
    it.)

@member(RegisteredEvents
    Internal list that stores contexts for registered events.@br
    Its content is manager automatically during telemetry events
    (un)registrations.)

@member(RegisteredChannels
    Internal list that stores contexts for registered channel.@br
    Its content is manager automatically during telemetry channels
    (un)registrations.)

@member(StoredConfigs
    Internal list used to store received configurations when StoreConfigurations
    switch is set to @true.)

@member(StoredChannelsValues
    Internal list used to store received channels values when
    StoreChannelsValues switch is set to @true.)

@member(LastTelemetryResult
    Result code of last executed API function.@br
    Initialized to SCS_RESULT_ok.)

@member(TelemetryVersion
    Telemetry version for which this object was created.@br
    Initialized to SCS_U32_NIL.)

@member(GameName
    Name of the game for which this object was created.@br
    Initialized to an empty string.)

@member(GameID
    ID of game for which this object was created.@br
    Initialized to an empty string.)

@member(GameVersion
    Version of game for which this object was created.@br
    Initialized to an SCS_U32_NIL.)

@member(KeepUtilityEvents
    When set to @true, the recipient automatically registers all known events
    marked as utility and refuses to unregister such events.@br
    This property is intended to ensure the recipient will stay responsive,
    because events and channels can be (un)registered only in events callbacks.
    If no event would be registered, then such call will not occur, rendering
    recipient unresponsive.@br
    Initialized to @true.)

@member(StoreConfigurations
    If @true, any configuration data passed from the game are parsed and
    stored.@br
    When set to @true, the configuration event is automatically registered.@br
    When set to @false, StoredConfigs list is cleared.@br
    Initialized to @true.)

@member(ManageIndexedChannels
    When @true, registration and unregistration of indexed channels that are
    index-binded to some configuration is automatically managed.@br
    Affected methods:
    @unorderedList(
    @item(ChannelRegisterAll - binded channels are registered up to index
      (count - 1) stored in appropriate config. If such config is not stored,
      they are registered in the same way as not binded channels.)
    @item(ProcessConfigurationEvent - when binded config is parsed, all
      registered channels are scanned and those binded to this config are
      proccessed in following way:@br
        New config value is greater than old value: channels with indices
          above new config value are unregistered.@br
        New config value is smaller than old value: when channels with all
          indices from old config value are registered, then new channels with
          indices up to the new value are registered.))
    Initialized to @false.)

@member(StoreChannelsValues
    When @true, all incoming channels along with their values are stored in
    StoredChannelsValues list.@br
    When set to @false, StoredChannelsValues list is cleared.@br
    Initialized to @false.)

@member(OnDestroy
    Event called before destruction of instance. It is called AFTER all
    registered channels and events are unregistered and KeepUtilityEvents is set
    to @false.)

@member(OnLog
    Event called when recipient attempts to write to game log.)

@member(OnEventRegister
    Event called on every @bold(successful) event registration.@br
    It can be called multiple times when method EventRegisterAll is executed.)

@member(OnEventUnregister
    Event called on every @bold(successful) event unregistration.@br
    It can be called multiple times when method EventUnregisterAll is executed.)

@member(OnEvent
    Event called whenever the recipient receives any event from telemetry API.)

@member(OnChannelRegister
    Event called on every @bold(successful) channel registration.@br
    It can be called multiple times when method ChannelRegisterAll is executed.)

@member(OnChannelUnregister
    Event called on every @bold(successful) channel unregistration.@br
    It can be called multiple times when method ChannelUnregisterAll is
    executed.)

@member(OnChannel
    Event called whenever the recipient receives any channel call from telemetry
    API.
    
    @bold(Warning) - this event can be called quite often (usually many times
    per frame).)

@member(OnConfig
    Event called when config is parsed from configuration telemetry event data
    (possible only when StoreConfigurations is set to true).)

@member(OnDestroyMulti
    Multicast event called before destruction of instance. It is called AFTER
    all registered channels and events are unregistered and KeepUtilityEvents is
    set to @false.)

@member(OnLogMulti
    Multicast event called when recipient attempts to write to game log.)

@member(OnEventRegisterMulti
    Multicast event called on every @bold(successful) event registration.@br
    It can be called multiple times when method EventRegisterAll is executed.)

@member(OnEventUnregisterMulti
    Multicast event called on every @bold(successful) event unregistration.@br
    It can be called multiple times when method EventUnregisterAll is executed.)

@member(OnEventMulti
    Multicast event called whenever the recipient receives any event from
    telemetry API.)

@member(OnChannelRegisterMulti
    Multicast event called on every @bold(successful) channel registration.@br
    It can be called multiple times when method ChannelRegisterAll is executed.)

@member(OnChannelUnregisterMulti
    Multicast event called on every @bold(successful) channel unregistration.@br
    It can be called multiple times when method ChannelUnregisterAll is
    executed.)

@member(OnChannelMulti
    Multicast event called whenever the recipient receives any channel call from
    telemetry API.
    
    @bold(Warning) - this event can be called quite often (usually many times
    per frame).)

@member(OnConfigMulti
    Multicast event called when config is parsed from configuration telemetry
    event data (possible only when StoreConfigurations is set to true).)
}
  TTelemetryRecipient = class(TTelemetryVersionPrepareObject)
  private
    fInfoProvider:              TTelemetryInfoProvider;
    fRegisteredEvents:          TRegisteredEventsList;
    fRegisteredChannels:        TRegisteredChannelsList;
    fStoredConfigs:             TStoredConfigsList;
    fStoredChannelsValues:      TStoredChannelsValuesList;
    fLastTelemetryResult:       scs_result_t;
    fTelemetryVersion:          scs_u32_t;
    fGameName:                  TelemetryString;
    fGameID:                    TelemetryString;
    fGameVersion:               scs_u32_t;
    fKeepUtilityEvents:         Boolean;
    fStoreConfigurations:       Boolean;
    fManageIndexedChannels:     Boolean;
    fStoreChannelsValues:       Boolean;
    cbLog:                      scs_log_t;
    cbRegisterEvent:            scs_telemetry_register_for_event_t;
    cbUnregisterEvent:          scs_telemetry_unregister_from_event_t;
    cbRegisterChannel:          scs_telemetry_register_for_channel_t;
    cbUnregisterChannel:        scs_telemetry_unregister_from_channel_t;
    fOnDestroy:                 TNotifyEvent;
    fOnLog:                     TLogEvent;
    fOnEventRegister:           TEventRegisterEvent;
    fOnEventUnregister:         TEventRegisterEvent;
    fOnEvent:                   TEventEvent;
    fOnChannelRegister:         TChannelRegisterEvent;
    fOnChannelUnregister:       TChannelUnregisterEvent;
    fOnChannel:                 TChannelEvent;
    fOnConfig:                  TConfigEvent;
  {$IFDEF MulticastEvents}
    fOnDestroyMulti:            TMulticastNotifyEvent;
    fOnLogMulti:                TMulticastLogEvent;
    fOnEventRegisterMulti:      TMulticastEventRegisterEvent;
    fOnEventUnregisterMulti:    TMulticastEventRegisterEvent;
    fOnEventMulti:              TMulticastEventEvent;
    fOnChannelRegisterMulti:    TMulticastChannelRegisterEvent;
    fOnChannelUnregisterMulti:  TMulticastChannelUnregisterEvent;
    fOnChannelMulti:            TMulticastChannelEvent;
    fOnConfigMulti:             TMulticastConfigEvent;
  {$ENDIF}
    procedure SetKeepUtilityEvents(Value: Boolean);
    procedure SetStoreConfigurations(Value: Boolean);
    procedure SetStoreChannelsValues(Value: Boolean);
  protected
    procedure EventHandler(Event: scs_event_t; Data: Pointer); virtual;
    procedure ChannelHandler(const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; Value: p_scs_value_t); virtual;
    procedure ProcessConfigurationEvent(const Data: scs_telemetry_configuration_t); virtual;
    Function PrepareForTelemetryVersion(TelemetryVersion: scs_u32_t): Boolean; override;
    Function PrepareForGameVersion(const GameName,GameID: TelemetryString; GameVersion: scs_u32_t): Boolean; override;
  public
    procedure DoOnDestroy(Sender: TObject); virtual;
    procedure DoOnLog(Sender: TObject; LogType: scs_log_type_t; const LogText: String); virtual;
    procedure DoOnEventRegister(Sender: TObject; Event: scs_event_t); virtual;
    procedure DoOnEventUnregister(Sender: TObject; Event: scs_event_t); virtual;
    procedure DoOnEvent(Sender: TObject; Event: scs_event_t; Data: Pointer); virtual;
    procedure DoOnChannelRegister(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t); virtual;
    procedure DoOnChannelUnregister(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t); virtual;
    procedure DoOnChannel(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; Value: p_scs_value_t); virtual;
    procedure DoOnConfig(Sender: TObject; const Name: TelemetryString; ID: TConfigID; Index: scs_u32_t; Value: scs_value_localized_t); virtual;
    class Function HighestSupportedTelemetryVersion: scs_u32_t; override;
    class Function HighestSupportedGameVersion(GameID: scs_string_t): scs_u32_t; override;
    class Function SupportsTelemetryVersion(TelemetryVersion: scs_u32_t): Boolean; override;
    class Function SupportsTelemetryMajorVersion(TelemetryVersion: scs_u32_t): Boolean; override;
    class Function SupportsGameVersion(GameID: scs_string_t; GameVersion: scs_u32_t): Boolean; override;
    class Function SupportsTelemetryAndGameVersion(TelemetryVersion: scs_u32_t; GameID: scs_string_t; GameVersion: scs_u32_t): Boolean; override;
    class Function SupportsTelemetryAndGameVersionParam(TelemetryVersion: scs_u32_t; Parameters: scs_telemetry_init_params_t): Boolean; override;
    constructor Create(TelemetryVersion: scs_u32_t; Parameters: scs_telemetry_init_params_t);
    destructor Destroy; override;
    procedure SetGameCallbacks(Parameters: scs_telemetry_init_params_t); virtual;
    procedure SetGameCallback(Callback: TGameCallback; CallbackFunction: Pointer); virtual;
  {
    Use this method to write typed message to game log.@br
    Works only when cbLog callback is assigned.

    @param(LogType Type of message (i.e. if it is error, warning or
                   normal message).)
    @param LogText Actual message text.
  }
    procedure Log(LogType: scs_log_type_t; const LogText: String); overload; virtual;
  {
    Use this method to write message to game log. Message will be written as
    normal text (LogType set to SCS_LOG_TYPE_message).@br
    Works only when cbLog callback is assigned.

    @param LogText Actual message text.
  }
    procedure Log(const LogText: String); overload; virtual;
    Function EventRegistered(Event: scs_event_t): Boolean; virtual;
    Function EventRegister(Event: scs_event_t): Boolean; virtual;
    Function EventRegisterByIndex(Index: Integer): Boolean; virtual;
    Function EventUnregister(Event: scs_event_t): Boolean; virtual;
    Function EventUnregisterIndex(Index: Integer): Boolean; virtual;
    Function EventUnregisterByIndex(Index: Integer): Boolean; virtual;
    Function EventRegisterAll: Integer; virtual;
    Function EventUnregisterAll: Integer; virtual;
    Function EventGetDataAsString(Event: scs_event_t; Data: Pointer; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String; virtual;
    Function ChannelRegistered(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t): Boolean; virtual;
    Function ChannelRegister(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t = SCS_TELEMETRY_CHANNEL_FLAG_none): Boolean; virtual;
    Function ChannelRegisterByIndex(Index: Integer): Boolean; virtual;
    Function ChannelRegisterByName(const Name: TelemetryString): Boolean; virtual;
    Function ChannelUnregister(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t): Boolean; virtual;
    Function ChannelUnregisterIndex(Index: Integer): Boolean; virtual;
    Function ChannelUnregisterByIndex(Index: Integer): Boolean; virtual;
    Function ChannelUnregisterByName(const Name: TelemetryString): Boolean; virtual;
    Function ChannelRegisterAll(RegPrimaryTypes: Boolean = True; RegSecondaryTypes: Boolean = False; RegTertiaryTypes: Boolean = False): Integer; virtual;
    Function ChannelUnregisterAll: Integer; virtual;
    Function ChannelGetValueAsString(Value: p_scs_value_t; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String; virtual;
    Function ConfigStored(const Name: TelemetryString; Index: scs_u32_t = SCS_U32_NIL): Boolean; virtual;
    Function ChannelStored(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t): Boolean; virtual;
  published
    property TelemetryInfoProvider: TTelemetryInfoProvider read fInfoProvider;
    property RegisteredEvents: TRegisteredEventsList read fRegisteredEvents;
    property RegisteredChannels: TRegisteredChannelsList read fRegisteredChannels;
    property StoredConfigs: TStoredconfigsList read fStoredConfigs; 
    property StoredChannelsValues: TStoredChannelsValuesList read fStoredChannelsValues write fStoredChannelsValues;
    property LastTelemetryResult: scs_result_t read fLastTelemetryResult;
    property TelemetryVersion: scs_u32_t read fTelemetryVersion;
    property GameName: TelemetryString read fGameName;
    property GameID: TelemetryString read fGameID;
    property GameVersion: scs_u32_t read fGameVersion;
    property KeepUtilityEvents: Boolean read fKeepUtilityEvents write SetKeepUtilityEvents;
    property StoreConfigurations: Boolean read fStoreConfigurations write SetStoreConfigurations;
    property ManageIndexedChannels: Boolean read fManageIndexedChannels write fManageIndexedChannels;
    property StoreChannelsValues: Boolean read fStoreChannelsValues write SetStoreChannelsValues;
    property OnDestroy: TNotifyEvent read fOnDestroy write fOnDestroy;
    property OnLog: TLogEvent read fOnLog write fOnLog;
    property OnEventRegister: TEventRegisterEvent read fOnEventRegister write fOnEventRegister;
    property OnEventUnregister: TEventRegisterEvent read fOnEventUnregister write fOnEventUnregister;
    property OnEvent: TEventEvent read fOnEvent write fOnEvent;
    property OnChannelRegister: TChannelRegisterEvent read fOnChannelRegister write fOnChannelRegister;
    property OnChannelUnregister: TChannelUnregisterEvent read fOnChannelUnregister write fOnChannelUnregister;
    property OnChannel: TChannelEvent read fOnChannel write fOnChannel;
    property OnConfig: TConfigEvent read fOnConfig write fOnConfig;
  {$IFDEF MulticastEvents}
    property OnDestroyMulti: TMulticastNotifyEvent read fOnDestroyMulti;
    property OnLogMulti: TMulticastLogEvent read fOnLogMulti;
    property OnEventRegisterMulti: TMulticastEventRegisterEvent read fOnEventRegisterMulti;
    property OnEventUnregisterMulti: TMulticastEventRegisterEvent read fOnEventUnregisterMulti;
    property OnEventMulti: TMulticastEventEvent read fOnEventMulti;
    property OnChannelRegisterMulti: TMulticastChannelRegisterEvent read fOnChannelRegisterMulti;
    property OnChannelUnregisterMulti: TMulticastChannelUnregisterEvent read fOnChannelUnregisterMulti;
    property OnChannelMulti: TMulticastChannelEvent read fOnChannelMulti;
    property OnConfigMulti: TMulticastConfigEvent read fOnConfigMulti;
  {$ENDIF}
  end;

{==============================================================================}
{    Unit Functions and procedures // Declaration                              }
{==============================================================================}

{
  @abstract(Function intended as callback for streaming functions, converting
            channel name to ID.)
  @code(UserData) passed to streaming function along with this callback must
  contain valid TTelemetryRecipient object.

  @param Name      Channel name to be converted to ID.
  @param(Recipient TTelemetryRecipient object that will be used for actual
                   conversion.)

  @returns Channel ID obtained from passed name.
}
Function RecipientGetChannelIDFromName(const Name: TelemetryString; Recipient: Pointer): TChannelID;

{
  @abstract(Function intended as callback for streaming functions, converting
            channel ID to name.)
  @code(UserData) passed to streaming function along with this callback must
  contain valid TTelemetryRecipient object.

  @param ID        Channel ID to be converted to name.
  @param(Recipient TTelemetryRecipient object that will be used for actual
                   conversion.)

  @returns Channel name obtained from passed ID.
}
Function RecipientGetChannelNameFromID(ID: TChannelID; Recipient: Pointer): TelemetryString;

{
  @abstract(Function intended as callback for streaming functions, converting
            config name to ID.)
  @code(UserData) passed to streaming function along with this callback must
  contain valid TTelemetryRecipient object.

  @param Name      Config name to be converted to ID.
  @param(Recipient TTelemetryRecipient object that will be used for actual
                   conversion.)

  @returns Config ID obtained from passed name.
}
Function RecipientGetConfigIDFromName(const Name: TelemetryString; Recipient: Pointer): TConfigID;

{
  @abstract(Function intended as callback for streaming functions, converting
            ID to config name.)
  @code(UserData) passed to streaming function along with this callback must
  contain valid TTelemetryRecipient object.

  @param ID        Config ID to be converted to name.
  @param(Recipient TTelemetryRecipient object that will be used for actual
                   conversion.)

  @returns Config name obtained from passed ID.  
}
Function RecipientGetConfigNameFromID(ID: TConfigID; Recipient: Pointer): TelemetryString;

implementation

uses
  SysUtils, Math,
  TelemetryConversions, TelemetryStrings;

{$IFDEF MulticastEvents}
  {$DEFINE ImplementationPart}
    {$INCLUDE '.\Inc\TelemetryRecipient_MulticastEvents.pas'}
  {$UNDEF ImplementationPart}
{$ENDIF}

{==============================================================================}
{    Unit Functions and procedures // Implementation                           }
{==============================================================================}

Function RecipientGetChannelIDFromName(const Name: TelemetryString; Recipient: Pointer): TChannelID;
begin
Result := TTelemetryRecipient(Recipient).TelemetryInfoProvider.KnownChannels.ChannelNameToID(Name);
end;

//------------------------------------------------------------------------------

Function RecipientGetChannelNameFromID(ID: TChannelID; Recipient: Pointer): TelemetryString;
begin
Result := TTelemetryRecipient(Recipient).TelemetryInfoProvider.KnownChannels.ChannelIDToName(ID);
end;

//------------------------------------------------------------------------------

Function RecipientGetConfigIDFromName(const Name: TelemetryString; Recipient: Pointer): TConfigID;
begin
Result := TTelemetryRecipient(Recipient).TelemetryInfoProvider.KnownConfigs.ConfigNameToID(Name);
end;

//------------------------------------------------------------------------------

Function RecipientGetConfigNameFromID(ID: TConfigID; Recipient: Pointer): TelemetryString;
begin
Result := TTelemetryRecipient(Recipient).TelemetryInfoProvider.KnownConfigs.ConfigIDToName(ID);
end;


{==============================================================================}
{------------------------------------------------------------------------------}
{                          Plugin (library) callbacks                          }
{------------------------------------------------------------------------------}
{==============================================================================}
{
Following two procedures are passed to game as plugin/library callbacks, because
methods (of the TTelemetryRecipient) cannot be passed to API (method pointers
and function/procedure pointers are fundamentally different - see
ObjectPascal/Delphi documentation).
They are implemented pretty much only as wrappers to recipient methods.
}

// Procedure used as library callback to receive events.
procedure EventReceiver(event: scs_event_t; event_info: Pointer; context: scs_context_t); stdcall;
begin
If Assigned(context) then
  If Assigned(PEventContext(context)^.Recipient) then
    TTelemetryRecipient(PEventContext(context)^.Recipient).EventHandler(event,event_info);
end;

//------------------------------------------------------------------------------

// Procedure used as library callback to receive channels.
procedure ChannelReceiver(name: scs_string_t; index: scs_u32_t; value: p_scs_value_t; context: scs_context_t); stdcall;
begin
If Assigned(context) then
  If Assigned(PChannelContext(context)^.Recipient) then
    with PChannelContext(context)^ do
      TTelemetryRecipient(Recipient).ChannelHandler(APIStringToTelemetryString(name),ChannelInfo.ID,index,value);
end;

{==============================================================================}
{------------------------------------------------------------------------------}
{                             TTelemetryRecipient                              }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TTelemetryRecipient // Class implementation                               }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TTelemetryRecipient // Constants, types, variables, etc...                }
{------------------------------------------------------------------------------}

const
  // Default (initial) values for TTelemeryRecipient properties.
  def_KeepUtilityEvents     = True;
  def_StoreConfigurations   = True;
  def_ManageIndexedChannels = False;
  def_StoreChannelsValues   = False;

{------------------------------------------------------------------------------}
{    TTelemetryRecipient // Private methods                                    }
{------------------------------------------------------------------------------}

procedure TTelemetryRecipient.SetKeepUtilityEvents(Value: Boolean);
var
  i:  Integer;
begin
If fKeepUtilityEvents <> Value then
  begin
    If Value then
      For i := 0 to (fInfoProvider.KnownEvents.Count - 1) do
        If fInfoProvider.KnownEvents[i].Utility and
        not EventRegistered(fInfoProvider.KnownEvents[i].Event) then
          EventRegister(fInfoProvider.KnownEvents[i].Event);
    fKeepUtilityEvents := Value;
  end;
end;

//------------------------------------------------------------------------------

procedure TTelemetryRecipient.SetStoreConfigurations(Value: Boolean);
begin
If fStoreConfigurations <> Value then
  begin
    If Value then
      begin
        If not EventRegistered(SCS_TELEMETRY_EVENT_configuration) then
          fStoreConfigurations := EventRegister(SCS_TELEMETRY_EVENT_configuration)
        else fStoreConfigurations := Value;
      end
    else fStoreConfigurations := Value;
  end;
end;

//------------------------------------------------------------------------------

procedure TTelemetryRecipient.SetStoreChannelsValues(Value: Boolean);
begin
If fStoreChannelsValues <> Value then
  begin
    If not Value then fStoredChannelsValues.Clear;
    fStoreChannelsValues := Value;
  end;
end;

{------------------------------------------------------------------------------}
{    TTelemetryRecipient // Protected methods                                  }
{------------------------------------------------------------------------------}

procedure TTelemetryRecipient.EventHandler(Event: scs_event_t; Data: Pointer);
begin
DoOnEvent(Self,Event,Data);
end;

//------------------------------------------------------------------------------

procedure TTelemetryRecipient.ChannelHandler(const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; Value: p_scs_value_t);
begin
DoOnChannel(Self,Name,Id,Index,Value);
end;

//------------------------------------------------------------------------------

procedure TTelemetryRecipient.ProcessConfigurationEvent(const Data: scs_telemetry_configuration_t);
var
  TempName:   TelemetryString;
  TempAttr:   p_scs_named_value_t;
  TempValue:  scs_value_localized_t;

  procedure ManageBindedChannels(ConfigID: TConfigID; NewMaxIndex: scs_u32_t);
  var
    i,j:          Integer;

    // New channels can be registered only if all old indexes were used (i.e.
    // all channels for given index were registered, and number of them was
    // greater than zero).
    Function CanRegisterNew(ChannelID: TChannelID): Boolean;
    var
      ii:           Integer;
      OldMaxIndex:  scs_u32_t;
      Counter:      LongWord;
    begin
      OldMaxIndex := 0;
      Counter := 0;
      ii := fStoredConfigs.IndexOf(ConfigID);
      If ii >= 0 then
        If fStoredConfigs[ii].Value.ValueType = SCS_VALUE_TYPE_u32 then
          OldMaxIndex := fStoredConfigs[ii].Value.BinaryData.value_u32.value - 1;
      For ii := 0 to OldMaxIndex do
        If fRegisteredChannels.IndexOf(ChannelID,ii) >= 0 then Inc(Counter);
      Result := Counter > OldMaxIndex;
    end;

  begin
    // Unregister all channels above current max index.
    For i := (fRegisteredChannels.Count - 1) downto 0 do
      If fRegisteredChannels[i].IndexConfigID = ConfigID then
        If fRegisteredChannels[i].Index > NewMaxIndex then
          ChannelUnregister(fRegisteredChannels[i].Name,fRegisteredChannels[i].Index,fRegisteredChannels[i].ValueType);
    // Register new channels up to current max index.      
    For i := 0 to (fInfoProvider.KnownChannels.Count - 1) do
      If fInfoProvider.KnownChannels[i].IndexConfigID = ConfigID then
        If CanRegisterNew(fInfoProvider.KnownChannels[i].ID) then
          For j := 0 to NewMaxIndex do
            If not ChannelRegistered(fInfoProvider.KnownChannels[i].Name,j,fInfoProvider.KnownChannels[i].PrimaryType) then
              ChannelRegister(fInfoProvider.KnownChannels[i].Name,j,fInfoProvider.KnownChannels[i].PrimaryType,SCS_TELEMETRY_CHANNEL_FLAG_none);
  end;

begin
TempAttr := Data.attributes;
while Assigned(TempAttr^.name) do
  begin
    TempName := APIStringToTelemetryString(Data.id) + cConfigFieldsSeparator + APIStringToTelemetryString(TempAttr^.name);
    TempValue := scs_value_localized(TempAttr^.value);
    If ManageIndexedChannels then
      If (TempAttr^.value._type = SCS_VALUE_TYPE_u32) and fInfoProvider.KnownConfigs.IsBinded(TempName) then
        ManageBindedChannels(GetItemID(TempName),TempAttr^.value.value_u32.value - 1);
    If fStoredConfigs.ChangeConfigValue(TempName,TempAttr^.index,TempValue) < 0 then
      fStoredConfigs.Add(TempName,TempAttr^.index,TempValue,fInfoProvider.KnownConfigs.IsBinded(TempName));
    DoOnConfig(Self,TempName,GetItemID(TempName),TempAttr^.index,TempValue);
    Inc(TempAttr);
  end;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.PrepareForTelemetryVersion(TelemetryVersion: scs_u32_t): Boolean;
begin
Result := inherited PrepareForTelemetryVersion(TelemetryVersion);
If Result then fTelemetryVersion := TelemetryVersion;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.PrepareForGameVersion(const GameName,GameID: TelemetryString; GameVersion: scs_u32_t): Boolean;
begin
Result := inherited PrepareForGameVersion(GameName,GameID,GameVersion);
If Result then
  begin
    fGameName := GameName;
    fGameID := GameID;
    fGameVersion := GameVersion;
  end;
end;

{------------------------------------------------------------------------------}
{    TTelemetryRecipient // Public methods                                     }
{------------------------------------------------------------------------------}

procedure TTelemetryRecipient.DoOnDestroy(Sender: TObject);
begin
If Assigned(fOnDestroy) then fOnDestroy(Sender);
{$IFDEF MulticastEvents}
fOnDestroyMulti.Call(Sender);
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure TTelemetryRecipient.DoOnLog(Sender: TObject; LogType: scs_log_type_t; const LogText: String);
begin
If Assigned(fOnLog) then fOnLog(Sender,LogType,LogText);
{$IFDEF MulticastEvents}
fOnLogMulti.Call(Sender,LogType,LogText);
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure TTelemetryRecipient.DoOnEventRegister(Sender: TObject; Event: scs_event_t);
begin
If Assigned(fOnEventRegister) then fOnEventRegister(Sender,Event);
{$IFDEF MulticastEvents}
fOnEventRegisterMulti.Call(Sender,Event);
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure TTelemetryRecipient.DoOnEventUnregister(Sender: TObject; Event: scs_event_t);
begin
If Assigned(fOnEventUnregister) then fOnEventUnregister(Sender,Event);
{$IFDEF MulticastEvents}
fOnEventUnregisterMulti.Call(Sender,Event);
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure TTelemetryRecipient.DoOnEvent(Sender: TObject; Event: scs_event_t; Data: Pointer);
begin
If (Event = SCS_TELEMETRY_EVENT_configuration) and StoreConfigurations then
  ProcessConfigurationEvent(p_scs_telemetry_configuration_t(Data)^);
If Assigned(fOnEvent) then fOnEvent(Sender,Event,Data);
{$IFDEF MulticastEvents}
fOnEventMulti.Call(Sender,Event,Data);
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure TTelemetryRecipient.DoOnChannelRegister(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t);
begin
If Assigned(fOnChannelRegister) then fOnChannelRegister(Sender,Name,ID,Index,ValueType,Flags);
{$IFDEF MulticastEvents}
fOnChannelRegisterMulti.Call(Sender,Name,ID,Index,ValueType,Flags);
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure TTelemetryRecipient.DoOnChannelUnregister(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t);
begin
If Assigned(fOnChannelUnregister) then fOnChannelUnregister(Sender,Name,ID,Index,ValueType);
{$IFDEF MulticastEvents}
fOnChannelUnregisterMulti.Call(Sender,Name,ID,Index,ValueType);
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure TTelemetryRecipient.DoOnChannel(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; Value: p_scs_value_t);
begin
If StoreChannelsValues then fStoredChannelsValues.StoreChannelValue(Name,ID,Index,Value);
If Assigned(fOnChannel) then fOnChannel(Sender,Name,ID,Index,Value);
{$IFDEF MulticastEvents}
fOnChannelMulti.Call(Sender,Name,ID,Index,Value);
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure TTelemetryRecipient.DoOnConfig(Sender: TObject; const Name: TelemetryString; ID: TConfigID; Index: scs_u32_t; Value: scs_value_localized_t);
begin
If Assigned(fOnConfig) then fOnConfig(Sender,Name,ID,Index,Value);
{$IFDEF MulticastEvents}
fOnConfigMulti.Call(Sender,Name,ID,Index,Value);
{$ENDIF}
end;

//------------------------------------------------------------------------------

class Function TTelemetryRecipient.HighestSupportedTelemetryVersion: scs_u32_t;
begin
Result := Min(inherited HighestSupportedTelemetryVersion,
              TTelemetryInfoProvider.HighestSupportedTelemetryVersion);
end;

//------------------------------------------------------------------------------

class Function TTelemetryRecipient.HighestSupportedGameVersion(GameID: scs_string_t): scs_u32_t;
begin
Result := Min(inherited HighestSupportedGameVersion(GameID),
              TTelemetryInfoProvider.HighestSupportedGameVersion(GameID));
end;

//------------------------------------------------------------------------------

class Function TTelemetryRecipient.SupportsTelemetryVersion(TelemetryVersion: scs_u32_t): Boolean;
begin
Result := inherited SupportsTelemetryVersion(TelemetryVersion) and
          TTelemetryInfoProvider.SupportsTelemetryVersion(TelemetryVersion);
end;

//------------------------------------------------------------------------------

class Function TTelemetryRecipient.SupportsTelemetryMajorVersion(TelemetryVersion: scs_u32_t): Boolean;
begin
Result := inherited SupportsTelemetryMajorVersion(TelemetryVersion) and
          TTelemetryInfoProvider.SupportsTelemetryMajorVersion(TelemetryVersion);
end;

//------------------------------------------------------------------------------

class Function TTelemetryRecipient.SupportsGameVersion(GameID: scs_string_t; GameVersion: scs_u32_t): Boolean;
begin
Result := inherited SupportsGameVersion(GameID,GameVersion) and
          TTelemetryInfoProvider.SupportsGameVersion(GameID,GameVersion);
end;

//------------------------------------------------------------------------------

class Function TTelemetryRecipient.SupportsTelemetryAndGameVersion(TelemetryVersion: scs_u32_t; GameID: scs_string_t; GameVersion: scs_u32_t): Boolean;
begin
Result := inherited SupportsTelemetryAndGameVersion(TelemetryVersion,GameID,GameVersion) and
          TTelemetryInfoProvider.SupportsTelemetryAndGameVersion(TelemetryVersion,GameID,GameVersion);
end;

//------------------------------------------------------------------------------

class Function TTelemetryRecipient.SupportsTelemetryAndGameVersionParam(TelemetryVersion: scs_u32_t; Parameters: scs_telemetry_init_params_t): Boolean;
begin
Result := inherited SupportsTelemetryAndGameVersionParam(TelemetryVersion,Parameters) and
          TTelemetryInfoProvider.SupportsTelemetryAndGameVersionParam(TelemetryVersion,Parameters);
end;

//------------------------------------------------------------------------------

constructor TTelemetryRecipient.Create(TelemetryVersion: scs_u32_t; Parameters: scs_telemetry_init_params_t);
begin
inherited Create;
// These fields are filled in preparation routines, so they must be initialized
// before these routines are called.
fTelemetryVersion := SCS_U32_NIL;
fGameName := '';
fGameID := '';
fGameVersion := SCS_U32_NIL;
// Prepare support for selected game and telemetry versions.
// Raise exception for unsupported telemetry/game.
If not PrepareForTelemetryVersion(TelemetryVersion) then
  raise Exception.Create('TTelemetryRecipient.Create: Telemetry version (' +
    SCSGetVersionAsString(TelemetryVersion) + ') not supported');
If not PrepareForGameVersion(APIStringToTelemetryString(Parameters.common.game_name),
                             APIStringToTelemetryString(Parameters.common.game_id),
                             Parameters.common.game_version) then
  raise Exception.Create('TTelemetryRecipient.Create: Game version (' +
    TelemetryStringDecode(APIStringToTelemetryString(Parameters.common.game_id)) + '; ' +
    SCSGetVersionAsString(Parameters.common.game_version) + ') not supported');
// Create telemetry info provider (list of known event, channels, etc.).
fInfoProvider := TTelemetryInfoProvider.Create(TelemetryVersion,
                                               Parameters.common.game_id,
                                               Parameters.common.game_version);
// Set game callbacks from passed prameters.
cbLog := nil;
cbRegisterEvent := nil;
cbUnregisterEvent := nil;
cbRegisterChannel := nil;
cbUnregisterChannel := nil;
SetGameCallBacks(Parameters);
// Fields initialization.
fRegisteredEvents := TRegisteredEventsList.Create;
fRegisteredChannels := TRegisteredChannelsList.Create;
fStoredConfigs := TStoredConfigsList.Create;
fStoredChannelsValues := TStoredChannelsValuesList.Create;
{$IFDEF MulticastEvents}
fOnDestroyMulti := TMulticastNotifyEvent.Create(Self);
fOnLogMulti := TMulticastLogEvent.Create(Self);
fOnEventRegisterMulti := TMulticastEventRegisterEvent.Create(Self);
fOnEventUnregisterMulti := TMulticastEventRegisterEvent.Create(Self);
fOnEventMulti := TMulticastEventEvent.Create(Self);
fOnChannelRegisterMulti := TMulticastChannelRegisterEvent.Create(Self);
fOnChannelUnregisterMulti := TMulticastChannelUnregisterEvent.Create(Self);
fOnChannelMulti := TMulticastChannelEvent.Create(Self);
fOnConfigMulti := TMulticastConfigEvent.Create(Self);
{$ENDIF}
fLastTelemetryResult := SCS_RESULT_ok;
KeepUtilityEvents := def_KeepUtilityEvents;
StoreConfigurations := def_StoreConfigurations;
ManageIndexedChannels := def_ManageIndexedChannels;
StoreChannelsValues := def_StoreChannelsValues;
end;

//------------------------------------------------------------------------------

destructor TTelemetryRecipient.Destroy;
begin
{$IFDEF MulticastEvents}
// Free all multicast events handling objects.
fOnDestroyMulti.Free;
fOnLogMulti.Free;
fOnEventRegisterMulti.Free;
fOnEventUnregisterMulti.Free;
fOnEventMulti.Free;
fOnChannelRegisterMulti.Free;
fOnChannelUnregisterMulti.Free;
fOnChannelMulti.Free;
fOnConfigMulti.Free;
{$ENDIF}
// Set KeepUtilityEvents to false to allow unregistration of all events.
KeepUtilityEvents := False;
ChannelUnregisterAll;
EventUnregisterAll;
DoOnDestroy(Self);
// Free all contexts and stored configurations.
fStoredChannelsValues.Free;
fStoredConfigs.Free;
fRegisteredChannels.Free;
fRegisteredEvents.Free;
// Free information provider object.
fInfoProvider.Free;
inherited;
end;

//------------------------------------------------------------------------------

procedure TTelemetryRecipient.SetGameCallbacks(Parameters: scs_telemetry_init_params_t);
begin
cbLog := Parameters.common.log;
cbRegisterEvent := Parameters.register_for_event;
cbUnregisterEvent := Parameters.unregister_from_event;
cbRegisterChannel := Parameters.register_for_channel;
cbUnregisterChannel := Parameters.unregister_from_channel;
end;

//------------------------------------------------------------------------------

procedure TTelemetryRecipient.SetGameCallback(Callback: TGameCallback; CallbackFunction: Pointer);
begin
case Callback of
  gcbLog:           cbLog := CallbackFunction;
  gcbEventReg:      cbRegisterEvent := CallbackFunction;
  gcbEventUnreg:    cbUnregisterEvent := CallbackFunction;
  gcbChannelReg:    cbRegisterChannel := CallbackFunction;
  gcbChannelUnreg:  cbUnregisterChannel := CallbackFunction;
else
  // No action.
end;
end;

//------------------------------------------------------------------------------

procedure TTelemetryRecipient.Log(LogType: scs_log_type_t; const LogText: String);
var
  TempStr:  TelemetryString;
begin
TempStr := TelemetryStringEncode(LogText);
If Assigned(cbLog) then cbLog(LogType,scs_string_t(TempStr));
DoOnLog(Self,LogType,LogText);
end;

procedure TTelemetryRecipient.Log(const LogText: String);
begin
Log(SCS_LOG_TYPE_message,LogText);
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.EventRegistered(Event: scs_event_t): Boolean;
begin
Result := fRegisteredEvents.IndexOf(Event) >= 0;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.EventRegister(Event: scs_event_t): Boolean;
var
  NewEventContext:  PEventContext;
begin
Result := False;
If Assigned(cbRegisterEvent) then
  begin
    NewEventContext := fRegisteredEvents.CreateContext(Self,Event,fInfoProvider.KnownEvents.IsUtility(Event));
    fLastTelemetryResult := cbRegisterEvent(Event,EventReceiver,NewEventContext);
    If LastTelemetryResult = SCS_RESULT_ok then
      begin
        If fRegisteredEvents.Add(NewEventContext) >= 0 then
          begin
            DoOnEventRegister(Self,Event);
            Result := True;
          end
        else fRegisteredEvents.FreeContext(NewEventContext);
      end
    else fRegisteredEvents.FreeContext(NewEventContext);
  end
else fLastTelemetryResult := SCS_RESULT_generic_error;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.EventRegisterByIndex(Index: Integer): Boolean;
begin
Result := False;
If (Index >=0) and (Index < fInfoProvider.KnownEvents.Count) then
  Result := EventRegister(fInfoProvider.KnownEvents[Index].Event)
else fLastTelemetryResult := SCS_RESULT_generic_error;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.EventUnregister(Event: scs_event_t): Boolean;
begin
Result := False;
If Assigned(cbUnregisterEvent) and
  not (KeepUtilityEvents and fInfoProvider.KnownEvents.IsUtility(Event)) then
  begin
    fLastTelemetryResult := cbUnregisterEvent(Event);
    If LastTelemetryResult = SCS_RESULT_ok then
      begin
        fRegisteredEvents.Remove(Event);
        DoOnEventUnregister(Self,Event);
        Result := True;
      end;
  end
else fLastTelemetryResult := SCS_RESULT_generic_error;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.EventRegisterAll: Integer;
var
  i:  Integer;
begin
Result := 0;
If Assigned(cbRegisterEvent) then
  For i := 0 to (fInfoProvider.KnownEvents.Count - 1) do
    If not EventRegistered(fInfoProvider.KnownEvents[i].Event) then
      If fInfoProvider.KnownEvents[i].Valid then
        If EventRegister(fInfoProvider.KnownEvents[i].Event) then Inc(Result);
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.EventUnregisterByIndex(Index: Integer): Boolean;
begin
Result := False;
If (Index >=0) and (Index < fInfoProvider.KnownEvents.Count) then
  Result := EventUnregister(fInfoProvider.KnownEvents[Index].Event)
else fLastTelemetryResult := SCS_RESULT_generic_error;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.EventUnregisterIndex(Index: Integer): Boolean;
begin
Result := False;
If Assigned(cbUnregisterEvent) and (Index >= 0) and (Index < fRegisteredEvents.Count) then
  Result := EventUnregister(fRegisteredEvents[Index].Event)
else
  fLastTelemetryResult := SCS_RESULT_generic_error;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.EventUnregisterAll: Integer;
var
  i:  Integer;
begin
Result := 0;
If Assigned(cbUnregisterEvent) then
  For i := (fRegisteredEvents.Count - 1) downto 0 do
    If EventUnregister(fRegisteredEvents[i].Event) then Inc(Result);
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.EventGetDataAsString(Event: scs_event_t; Data: Pointer; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String;
begin
If Assigned(Data) then
  case Event of
    SCS_TELEMETRY_EVENT_frame_start:
      Result := TelemetryEventFrameStartToStr(p_scs_telemetry_frame_start_t(Data)^,TypeName);
    SCS_TELEMETRY_EVENT_configuration:
      Result := TelemetryEventConfigurationToStr(p_scs_telemetry_configuration_t(Data)^,TypeName,ShowDescriptors);
  else
    Result := '';
  end;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.ChannelRegistered(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t): Boolean;
begin
Result := fRegisteredChannels.IndexOf(Name,Index,ValueType) >= 0;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.ChannelRegister(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t = SCS_TELEMETRY_CHANNEL_FLAG_none): Boolean;
var
  NewChannelContext:  PChannelContext;
begin
Result := False;
If Assigned(cbRegisterChannel) then
  begin
    NewChannelContext := fRegisteredChannels.CreateContext(Self,Name,Index,ValueType,Flags,
      fInfoProvider.KnownChannels.ChannelIndexConfigID(Name));
    fLastTelemetryResult := cbRegisterChannel(scs_string_t(Name),Index,ValueType,Flags,ChannelReceiver,NewChannelContext);
    If LastTelemetryResult  = SCS_RESULT_ok then
      begin
        If fRegisteredChannels.Add(NewChannelContext) >= 0 then
          begin
            DoOnChannelRegister(Self,Name,GetItemID(Name),Index,ValueType,Flags);
            Result := True;
          end
        else fRegisteredChannels.FreeContext(NewChannelContext);
      end
    else fRegisteredChannels.FreeContext(NewChannelContext);
  end
else fLastTelemetryResult := SCS_RESULT_generic_error;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.ChannelRegisterByIndex(Index: Integer): Boolean;
var
  i,Counter:        Integer;
  KnownChannelInfo: TKnownChannel;
  MaxIndex:         Integer;
begin
Result := False;
If Assigned(cbRegisterChannel) and (Index >= 0) and (Index < fInfoProvider.KnownChannels.Count) then
  begin
    KnownChannelInfo := fInfoProvider.KnownChannels[Index];
    If KnownChannelInfo.Indexed then
      begin
        If KnownChannelInfo.MaxIndex <> SCS_U32_NIL then MaxIndex := KnownChannelInfo.MaxIndex
          else MaxIndex := cMaxChannelIndex;
        If ManageIndexedChannels and StoreConfigurations and (KnownChannelInfo.IndexConfigID <> 0) then
          begin
            Index := fStoredConfigs.IndexOf(KnownChannelInfo.IndexConfigID);
            If Index >= 0 then
              If fStoredConfigs[Index].Value.ValueType = SCS_VALUE_TYPE_u32 then
                MaxIndex := fStoredConfigs[Index].Value.BinaryData.value_u32.value - 1;
          end;
        Counter := 0;
        For i := 0 to MaxIndex do
          If ChannelRegister(KnownChannelInfo.Name,i,KnownChannelInfo.PrimaryType) then Inc(Counter);
        Result := Counter > 0;
      end
    else Result := ChannelRegister(KnownChannelInfo.Name,SCS_U32_NIL,KnownChannelInfo.PrimaryType);
  end
else fLastTelemetryResult := SCS_RESULT_generic_error;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.ChannelRegisterByName(const Name: TelemetryString): Boolean;
begin
Result := ChannelRegisterByIndex(fInfoProvider.KnownChannels.IndexOf(Name));
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.ChannelUnregister(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t): Boolean;
begin
Result := False;
If Assigned(cbUnregisterChannel) then
  begin
    fLastTelemetryResult := cbUnregisterChannel(scs_string_t(Name),Index,ValueType);
    If LastTelemetryResult = SCS_RESULT_ok then
      begin
        fRegisteredChannels.Remove(Name,Index,ValueType);
        DoOnChannelUnregister(Self,Name,GetItemID(Name),Index,ValueType);
        Result := True;
      end;
  end
else fLastTelemetryResult := SCS_RESULT_generic_error;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.ChannelUnregisterIndex(Index: Integer): Boolean;
begin
Result := False;
If Assigned(cbUnregisterChannel) and (Index >= 0) and (Index < fRegisteredChannels.Count) then
  begin
    Result := ChannelUnregister(fRegisteredChannels[Index].Name,
                                fRegisteredChannels[Index].Index,
                                fRegisteredChannels[Index].ValueType);
  end
else fLastTelemetryResult := SCS_RESULT_generic_error;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.ChannelUnregisterByIndex(Index: Integer): Boolean;
begin
Result := False;
If (Index >= 0) and (Index < fInfoProvider.KnownChannels.Count) then
  Result := ChannelUnregisterByName(fInfoProvider.KnownChannels[Index].Name)
else fLastTelemetryResult := SCS_RESULT_generic_error;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.ChannelUnregisterByName(const Name: TelemetryString): Boolean;
var
  i,Counter:  Integer;
begin
Counter := 0;
If Assigned(cbUnregisterEvent) then
  For i := (fRegisteredChannels.Count - 1) downto 0 do
  {$IFDEF AssumeASCIIString}
    If TelemetrySameStrNoConv(fRegisteredChannels[i].Name,Name) then
  {$ELSE}
    If TelemetrySameStr(fRegisteredChannels[i].Name,Name) then
  {$ENDIF}
      If ChannelUnregister(fRegisteredChannels[i].Name,
                           fRegisteredChannels[i].Index,
                           fRegisteredChannels[i].ValueType) then Inc(Counter);
Result := Counter > 0;
end;


//------------------------------------------------------------------------------

Function TTelemetryRecipient.ChannelRegisterAll(RegPrimaryTypes: Boolean = True; RegSecondaryTypes: Boolean = False; RegTertiaryTypes: Boolean = False): Integer;
var
  i,j:              Integer;
  KnownChannelInfo: TKnownChannel;
  MaxIndex:         Integer;

  Function CheckAndRegister(Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t): Boolean;
  begin
    Result := False;
    If ValueType <> SCS_VALUE_TYPE_INVALID then
      begin
        If not ChannelRegistered(Name,Index,ValueType) then
          Result := ChannelRegister(Name,Index,ValueType,SCS_TELEMETRY_CHANNEL_FLAG_none)
        else Result := True;
      end;
  end;

begin
Result := 0;
If Assigned(cbRegisterChannel) then
  For i := 0 to (fInfoProvider.KnownChannels.Count - 1) do
    begin
      KnownChannelInfo := fInfoProvider.KnownChannels[i];
      If fInfoProvider.KnownChannels[i].Indexed then
        begin
          // Channel is indexed.
          // If channel is binded to some configuration, and this config is found,
          // then value from config is used as upper index limit, otherwise
          // MaxIndex for given channel is used (cMaxChannelIndex constant is used
          // if MaxIndex for given channel is not properly set).
          If KnownChannelInfo.MaxIndex <> SCS_U32_NIL then MaxIndex := KnownChannelInfo.MaxIndex
            else MaxIndex := cMaxChannelIndex;
          If ManageIndexedChannels and StoreConfigurations and (KnownChannelInfo.IndexConfigID <> 0) then
            begin
              j := fStoredConfigs.IndexOf(KnownChannelInfo.IndexConfigID);
              If j >= 0 then
                If fStoredConfigs[j].Value.ValueType = SCS_VALUE_TYPE_u32 then
                  MaxIndex := fStoredConfigs[j].Value.BinaryData.value_u32.value - 1;
            end;
          // The recipient tries to register all indexes from 0 to upper index
          // limit until the first failed registration.
          For j := 0 to MaxIndex do
            begin
              If RegPrimaryTypes then
                begin
                  If CheckAndRegister(KnownChannelInfo.Name,j,
                      KnownChannelInfo.PrimaryType) then Inc(Result) else Break;
                end;
              If RegSecondaryTypes then
                begin
                  If CheckAndRegister(KnownChannelInfo.Name,j,
                      KnownChannelInfo.SecondaryType) then Inc(Result) else Break;
                end;
              If RegTertiaryTypes then
                begin
                  If CheckAndRegister(KnownChannelInfo.Name,j,
                      KnownChannelInfo.TertiaryType) then Inc(Result) else Break;
                end;
            end;
        end
      else
        begin
          // Channel is not indexed.
          If RegPrimaryTypes then
            begin
              If CheckAndRegister(KnownChannelInfo.Name,SCS_U32_NIL,
                  KnownChannelInfo.PrimaryType) then Inc(Result);
            end;
          If RegSecondaryTypes then
            begin
              If CheckAndRegister(KnownChannelInfo.Name,SCS_U32_NIL,
                  KnownChannelInfo.SecondaryType) then Inc(Result);
            end;
          If RegTertiaryTypes then
            begin
              If CheckAndRegister(KnownChannelInfo.Name,SCS_U32_NIL,
                  KnownChannelInfo.TertiaryType) then Inc(Result);
            end;
        end;
    end;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.ChannelUnregisterAll: Integer;
var
  i:  Integer;
begin
Result := 0;
If Assigned(cbUnregisterEvent) then
  For i := (fRegisteredChannels.Count - 1) downto 0 do
    with fRegisteredChannels[i] do
      If ChannelUnregister(Name,Index,ValueType) then Inc(Result);
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.ChannelGetValueAsString(Value: p_scs_value_t; TypeName: Boolean = False; ShowDescriptors: Boolean = False): String;
begin
If Assigned(Value) then Result := SCSValueToStr(Value^,TypeName,ShowDescriptors)
  else Result := '';
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.ConfigStored(const Name: TelemetryString; Index: scs_u32_t = SCS_U32_NIL): Boolean;
begin
Result := fStoredConfigs.IndexOf(Name,Index) >= 0;
end;

//------------------------------------------------------------------------------

Function TTelemetryRecipient.ChannelStored(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t): Boolean;
begin
Result := fStoredChannelsValues.IndexOf(Name,Index,ValueType) >= 0;
end;

end.
