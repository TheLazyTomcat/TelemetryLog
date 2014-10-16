{@html(<hr>)
@abstract(List classes used in Telemetry library.)
@author(František Milt <fmilt@seznam.cz>)
@created(2013-10-04)
@lastmod(2014-06-07)

  @bold(@NoAutoLink(TelemetryLists))

  ©František Milt, all rights reserved.

  Classes in this unit (for details, refer to declaration of individual class):
@preformatted(
  TCustomTelemetryList
   |- TKnownEventsList
   |- TKnownChannelsList
   |- TKnownConfigsList
   |- TRegisteredEventsList
   |- TRegisteredChannelsList
   |- TStoredConfigsList
   |- TStoredChannelsValuesList
)
  Last change:  2014-06-07

  Change List:@unorderedList(
    @item(2013-10-04 - First stable version.)
    @item(2014-04-07 - Type of parameter @code(Item) in function GetItemID
                       changed to @code(TelemetryString).)
    @item(2014-04-07 - Field type changed to @code(TelemetryString) in following
                       cases:@unorderedList(
                         @itemSpacing(Compact)
                         @item(TKnownEvent.Name)
                         @item(TKnownChannel.Name)
                         @item(TKnownChannel.IndexConfig)
                         @item(TKnownConfig.Name)
                         @item(TChannelInfo.Name)
                         @item(TStoredConfig.Name)
                         @item(TStoredChannel.Name)))
    @item(2014-04-07 - Type of parameters @code(Name) and @code(IndexConfig)
                       changed to @code(TelemetryString) in following methods:
                       @unorderedList(
                         @itemSpacing(Compact)
                         @item(TKnownEventsList.IndexOf)
                         @item(TKnownEventsList.Add)
                         @item(TKnownEventsList.ReplaceIndex)
                         @item(TKnownEventsList.Replace)
                         @item(TKnownEventsList.Insert)
                         @item(TKnownChannelsList.IndexOf)
                         @item(TKnownChannelsList.Add)
                         @item(TKnownChannelsList.ReplaceIndex)
                         @item(TKnownChannelsList.Replace)
                         @item(TKnownChannelsList.Insert)
                         @item(TKnownChannelsList.Remove)
                         @item(TKnownChannelsList.ChannelIndexConfigID)
                         @item(TKnownChannelsList.ChannelNameToID)
                         @item(TKnownConfigsList.IndexOf)
                         @item(TKnownConfigsList.Add)
                         @item(TKnownConfigsList.ReplaceIndex)
                         @item(TKnownConfigsList.Replace)
                         @item(TKnownConfigsList.Insert)
                         @item(TKnownConfigsList.Remove)
                         @item(TKnownConfigsList.IsBinded)
                         @item(TKnownConfigsList.IsIndexed)
                         @item(TKnownConfigsList.ConfigNameToID)
                         @item(TRegisteredChannelsList.IndexOf)
                         @item(TRegisteredChannelsList.Add)
                         @item(TRegisteredChannelsList.Remove)
                         @item(TRegisteredChannelsList.CreateContext)
                         @item(TStoredConfigsList.IndexOf)
                         @item(TStoredConfigsList.Add)
                         @item(TStoredConfigsList.Remove)
                         @item(TStoredConfigsList.ChangeConfigValue)
                         @item(TStoredChannelsValuesList.IndexOf)
                         @item(TStoredChannelsValuesList.StoreChannelValue)))
    @item(2014-04-07 - Result type changed to @code(TelemetryString) for
                       following methods:@unorderedList(
                         @itemSpacing(Compact)
                         @item(TKnownChannelsList.ChannelIDToName)
                         @item(TKnownConfigsList.ConfigIDToName)))
    @item(2014-04-11 - Added multicast event TCustomTelemetryList.OnChangeMulti.)
    @item(2014-04-13 - Name of the class @code(TStoredChannelValuesList) changed
                       to @code(@noAutoLink(TStoredChannelsValuesList)).)
    @item(2014-04-14 - TKnownConfigsList class now stores fully qualified
                       configuration value names instead of just attribute
                       names.)
    @item(2014-04-15 - Declarations of following types were moved to unit
                       TelemetryIDs:@unorderedList(
                         @itemSpacing(Compact)
                         @item(TItemID)
                         @item(PItemID)
                         @item(TChannelID)
                         @item(PChannelID)
                         @item(TConfigID)
                         @item(PConfigID)))
    @item(2014-04-15 - Function GetItemID was moved to unit TelemetryIDs.)
    @item(2014-05-04 - Following callback functions were added:@unorderedList(
                         @itemSpacing(Compact)
                         @item(GetChannelIDFromName)
                         @item(GetChannelNameFromID)
                         @item(GetConfigIDFromName)
                         @item(GetConfigNameFromID)))
    @item(2014-06-07 - Added field @code(MaxIndex) to TKnownChannel record.))

@html(<hr>)}
unit TelemetryLists;

interface

{$INCLUDE '.\Telemetry_defs.inc'}

uses
  Classes,
{$IFDEF MulticastEvents}
  MulticastEvent,
{$ENDIF}
  TelemetryCommon,
  TelemetryIDs,
{$IFDEF Documentation}
  TelemetryConversions,
  TelemetryStrings,
{$ENDIF}
{$IFDEF UseCondensedHeader}
  SCS_Telemetry_Condensed;
{$ELSE}
  scssdk,
  scssdk_value,
  scssdk_telemetry_event,
  scssdk_telemetry_channel;
{$ENDIF}

{==============================================================================}
{------------------------------------------------------------------------------}
{                             TCustomTelemetryList                             }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TCustomTelemetryList // Class declaration                                 }
{==============================================================================}
{ @abstract(Ancestor class for all other list classes in TelemetryLists unit.)

  TCustomTelemetryList serves as ancestor for all other list classes declared in
  this unit. It wrapps around TList class and adds methods used for easier list
  management in descendant classes.

@member(fMainList
    Internal list used to hold actual items. It is not publicly visible and is
    therefore managed automatically.)

@member(fUpdating
    When this variable is set to @true, it indicates that the list is updated
    from outside and OnChange event should not be called.@br
    It is set by methods BeginUpdate and EndUpdate.)

@member(fOnChange
    Holds reference to OnChange event handler.)

@member(fOnChangeMulti
    Object handling multicast OnChange event.)

@member(GetCount
    Getter for property Count.@br
    Returns number of items in list.)
    


@member(PtrGetItem
    Returns item (pointer) from internal list on position given by @code(Index)
    parameter.@br
    When index falls out of allowed boundary (<0,Count - 1>) an exception is
    raised.

    @param Index Index of requested item in list.

    @returns Item at position given by @code(Index).)

@member(PtrIndexOf
    Returns index at which the passed item (pointer) is located in the list.@br
    When passed pointer is not found in list, -1 is returned.

    @param Item Item (pointer) whose index is requested.

    @returns Index of passed item in the list, -1 when not found.)

@member(PtrAdd
    Method used to add new item into list. Added item can be @nil.@br
    Calls method DoChange when addition is successful.

    @param Item New item to be added to the list.

    @returns Index at which the new item was put, -1 when the operation failed.)

@member(PtrReplace
    Replaces item (change its value) at position given by @code(Index)
    parameter. Item can be @nil. When index falls out of allowed boundary
    (<0,Count - 1>), an exception is raised.@br
    Calls method DoChange when item is successfully replaced.

    @param Index Index of item that has to be replaced.
    @param Item  New walue of the replaced item.)

@member(PtrInsert
    Inserts new item at position given by @code(Index). List Count is increased
    by one and all existing items from given position (included) up are moved
    higher. @code(Item) can be @nil. When index falls out of allowed boundary
    (<0,Count> - passed index can be higher than current highest index, if so,
    item is added at the end of the list), and exception is raised.@br
    Calls method DoChange when item is successfully inserted.

    @param Index Index at which the new item should be added.
    @param Item  Inserted item.)

@member(PtrRemove
    Removes item passed in @code(Item) parameter. @code(Item) should not be, but
    can be @nil. When given item is not found in list, nothing is removed and
    the function fails with no error (-1 is returned). If the list contains more
    than one copy of the removed item, only the first occurence is removed.@br
    Calls method DoChange when item is successfully removed.

    @param Item Item that has to be removed.

    @returns(Index at which the removed item was place before removal, -1 whem
             given item was not found in the list.))

@member(PtrDelete
    Deletes item at position given by @code(Index) parameter. When index falls
    out of allowed boundary (<0,Count - 1>), an exception is raised.@br
    Calls method DoChange when item is successfully deleted.

    @param Index Index of item that has to be deleted.)



@member(Create
    Object constructor.)

@member(Destroy
    ObjectDestructor.@br
    Method Clear is called within destructor, so it is not necessary to
    explicitly call it when class instance is freed.
    
    @bold(Note:) OnChange event is not called.)

@member(BeginUpdate
    Sets fUpdating to @true.)

@member(EndUpdate
    Sets fUpdating to @false and calls DoChange method.)

@member(DoChange
    Calls handler of OnChange event (if assigned) - but only if fUpdating is set
    to @false, otherwise the handler is not called and method returns
    immediately.)

@member(Clear
    Deletes all items in the list. It only deletes stored pointers, allocated
    memory they are pointing to is not freed. Override this method in
    descendants to free memory used by items (put inherited code at the end).@br
    Calls method DoChange after all items are deleted.)



@member(Count
    Number of items stored in the list.)

@member(OnChange
    Event called whenever the list is changed. It can also be called manually by
    calling DoChange method. It is NOT called when fUpdating is set to @true
    (but can be still called directly if handler is assigned).)

@member(OnChangeMulti
    Multicast event called whenever the list is changed. It can also be called
    manually by calling DoChange method. It is NOT called when fUpdating is set
    to @true (but can be still called directly).@br
    Assigning handlers to this event does not interfere with normal OnChange
    event.@br
    Normal OnChange event is called first, handlers of this event are called
    afterwards.)
}
type
  TCustomTelemetryList = class(TObject)
  private
    fMainList:      TList;
    fUpdating:      Boolean;
    fOnChange:      TNotifyEvent;
  {$IFDEF MulticastEvents}
    fOnChangeMulti: TMulticastNotifyEvent;
  {$ENDIF}
    Function GetCount: Integer;
  protected
    Function PtrGetItem(Index: Integer): Pointer; virtual;
    Function PtrIndexOf(Item: Pointer): Integer; virtual;
    Function PtrAdd(Item: Pointer): Integer; virtual;
    procedure PtrReplace(Index: Integer; Item: Pointer); virtual;
    procedure PtrInsert(Index: Integer; Item: Pointer); virtual;
    Function PtrRemove(Item: Pointer): Integer; virtual;
    procedure PtrDelete(Index: Integer); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;
    procedure DoChange; virtual;
    procedure Clear; virtual;
  published
    property Count: Integer read GetCount;
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
  {$IFDEF MulticastEvents}
    property OnChangeMulti: TMulticastNotifyEvent read fOnChangeMulti;
  {$ENDIF}
  end;


{==============================================================================}
{------------------------------------------------------------------------------}
{                               TKnownEventsList                               }
{------------------------------------------------------------------------------}
{==============================================================================}

{
  Structure used as an item in TKnownEventsList class.

  @member(Event   @NoAutoLink(Event) identification number.)
  @member(Name    @NoAutoLink(Name) assigned to @NoAutoLink(event) (this
                  @NoAutoLink(name) is not defined by Telemetry SDK, do not
                  assume its value as it can change in the future).)
  @member(Valid   Denotes whether @NoAutoLink(event) is @NoAutoLink(valid)
                  (invalid events cannot be successfuly registered).)
  @member(Utility Denotes whether @NoAutoLink(event) is marked as
                  @NoAutoLink(utility) (such events cannot be unregistered
                  and/or are registered automatically at certain
                  circumstances).)
}
  TKnownEvent = record
    Event:    scs_event_t;
    Name:     TelemetryString;
    Valid:    Boolean;
    Utility:  Boolean;
  end;
  // Pointer to TKnownEvent structure.
  PKnownEvent = ^TKnownEvent;

const
  // Empty TKnownEvent structure.
  cEmptyKnownEvent: TKnownEvent =
   (Event:    SCS_TELEMETRY_EVENT_invalid;
    Name:     '';
    Valid:    False;
    Utility:  False);

{==============================================================================}
{    TKnownEventsList // Class declaration                                     }
{==============================================================================}
{
  @abstract(
  List used to store informations about known telemetry @noAutoLink(events).)

@member(GetKnownEventPointer
    Getter for Pointers[] property.@br
    When index falls out of allowed boundary (<0,Count - 1>), an exception is
    raised.

    @param Index Index of requested item.

    @returns Pointer to requested item.)

@member(GetKnownEvent
    Getter for Events[] property.@br
    When index falls out of allowed boundary (<0,Count - 1>), an exception is
    raised.

    @param Index Index of requested item.

    @returns Requested item.)



@member(Clear
    Deletes all items in the list.@br
    OnChange event is called after items deletion.)

@member(Add
    Adds new known game event into the list.@br
    OnChange event is called after successful addition.

    @param Event   Event identification number.
    @param Name    Name of added event.
    @param Valid   Flag denoting whether added event is marked as valid.
    @param Utility Flag denoting whether added event is marked as utility.

    @returns Index at which the new event was added, -1 when addition failed.)

@member(ReplaceIndex
    Replaces event at position given by @code(Index) parameter. When index falls
    out of allowed boundary (<0,Count - 1>), an exception is raised.@br
    OnChange event is called after successful replacement.

    @param Index   Index of item that has to be replaced.
    @param Event   Replacement event identification number.
    @param Name    Name of replacement event.
    @param Valid   Flag denoting whether replacement event is marked as valid.
    @param(Utility Flag denoting whether replacement event is marked as
                   utility.))

@member(Replace
    Replaces event given by @code(OldEvent) parameter. When this old event is
    not found in the list, nothing happens and the method returns -1.@br
    OnChange event is called after successful replacement.

    @param OldEvent   Identification number of event that has to be replaced.
    @param Event      Replacement event identification number.
    @param Name       Name of replacement event.
    @param(Valid      Flag denoting whether replacement event is marked as
                      valid.)
    @param(Utility    Flag denoting whether replacement event is marked as
                      utility.)

    @returns(Index of event that was replaced, -1 when such event was not
             found.))

@member(Insert
    Inserts new event at position given by @code(Index) parameter. Count is
    increased by one and all existing items from given position (included) up
    are moved higher. When index falls out of allowed boundary (<0,Count> -
    passed index can be higher than current highest index, if so, item is added
    at the end of the list), and exception is raised.@br
    OnChange event is called after successful insertion.

    @param Index   Position where the new event should be inserted.
    @param Event   Event identification number.
    @param Name    Name of event.
    @param Valid   Flag denoting whether event is marked as valid.
    @param Utility Flag denoting whether event is marked as utility.

    @returns Actual position where the new event was inserted.)

@member(Remove
    Removes given event from the list. When this event is not found in the list,
    method returns -1 and nothing is removed.@br
    OnChange event is called after successful removal.

    @param(Event Identification number of event that has to be removed from the
                 list.)

    @returns(Index of item that was removed, -1 when requested event was not
             found.))

@member(Delete
    Deletes event at position given by @code(Index) parameter. When index falls
    out of allowed boundary (<0,Count - 1>), an exception is raised.@br
    OnChange event is called after successful deletion.

    @param Index Index of item that has to be deleted.)

@member(IsValid
    Returns @true when given event is valid, @false when it is not valid or when
    that event is not in list.

    @param Event Identification number of requested event.

    @returns Validity of requested event.)

@member(IsUtility
    Returns @true when given event is marked as Utility, @false when it is not
    or when not found in the list.

    @param Event Identification number of requested event.

    @returns Utility state of requested event.)

@member(Pointers
    Array property mapped directly to internal list. Use it for direct access to
    individual stored items.@br
    Unlike Events[] property, you can use returned pointer to change values of
    stored items.)

@member(Events
    Array property mapped directly to internal list. Use it to obtain values of
    individual stored items.)
}
type
  TKnownEventsList = class(TCustomTelemetryList)
  private
    Function GetKnownEventPointer(Index: Integer): PKnownEvent;
    Function GetKnownEvent(Index: Integer): TKnownEvent;
  public
    procedure Clear; override;
  {
    Searches through list for given event. When the event is not found, -1 is
    returned.

    @param Event Event whose index is requested.

    @returns Index of requested event, -1 when not found.
  }
    Function IndexOf(Event: scs_event_t): Integer; overload; virtual;
  {
    Searches through list for event with given name (case-insensitive). When
    event with that name is not found, -1 is returned.

    @param Name Name of the event whose index is requested.

    @returns Index of event with requested name, -1 when not found.
  }
    Function IndexOf(const Name: TelemetryString): Integer; overload; virtual;
    Function Add(Event: scs_event_t; const Name: TelemetryString; Valid: Boolean = True; Utility: Boolean = False): Integer; virtual;
    procedure ReplaceIndex(Index: Integer; Event: scs_event_t; const Name: TelemetryString; Valid: Boolean = True; Utility: Boolean = False); virtual;
    Function Replace(OldEvent, Event: scs_event_t; const Name: TelemetryString; Valid: Boolean = True; Utility: Boolean = False): Integer; virtual;
    Function Insert(Index: Integer; Event: scs_event_t; const Name: TelemetryString; Valid: Boolean = True; Utility: Boolean = False): Integer; virtual;
    Function Remove(Event: scs_event_t): Integer; virtual;
    procedure Delete(Index: Integer); virtual;
    Function IsValid(Event: scs_event_t): Boolean; virtual;
    Function IsUtility(Event: scs_event_t): Boolean; virtual;
    property Pointers[Index: Integer]: PKnownEvent read GetKnownEventPointer;
    property Events[Index: Integer]: TKnownEvent read GetKnownEvent; default;
  end;


{==============================================================================}
{------------------------------------------------------------------------------}
{                              TKnownChannelsList                              }
{------------------------------------------------------------------------------}
{==============================================================================}

{
  Structure used as an item in TKnownChannelsList class.

  @member(Name          @NoAutoLink(Name) of the channel.)
  @member(ID            Identifier of the channel (calculated from
                        @noAutoLink(name)).)
  @member(PrimaryType   Primary value type of the channel.)
  @member(SecondaryType Secondary value type of the channel.)
  @member(TertiaryType  Tertiary value type of the channel.)
  @member(Indexed       Flag indicating whether the channel is
                        @NoAutoLink(indexed).)
  @member(IndexConfig   Full @NoAutoLink(name) of a config that should store
                        count (that is, maxindex + 1) for this channel (has
                        meaning only for @NoAutoLink(indexed) channels).)
  @member(IndexConfigID Identifier of config that stores count for this
                        channel (see IndexConfig field).)
  @member(MaxIndex      Maximum index for @NoAutoLink(indexed) channels.)
}
  TKnownChannel = record
    Name:           TelemetryString;
    ID:             TChannelID;
    PrimaryType:    scs_value_type_t;
    SecondaryType:  scs_value_type_t;
    TertiaryType:   scs_value_type_t;
    Indexed:        Boolean;
    IndexConfig:    TelemetryString;
    IndexConfigID:  TConfigID;
    MaxIndex:       scs_u32_t;
  end;
  // Pointer to TKnownChannel structure.
  PKnownChannel = ^TKnownChannel;

const
  // Empty TKnownChannel structure.
  cEmptyKnownChannel: TKnownChannel =
   (Name:           '';
    ID:             0;
    PrimaryType:    SCS_VALUE_TYPE_INVALID;
    SecondaryType:  SCS_VALUE_TYPE_INVALID;
    TertiaryType:   SCS_VALUE_TYPE_INVALID;
    Indexed:        False;
    IndexConfig:    '';
    IndexConfigID:  0;
    MaxIndex:       SCS_U32_NIL);


{==============================================================================}
{    TKnownChannelsList // Class declaration                                   }
{==============================================================================}
{
  @abstract(
  List used to store informations about known telemetry @noAutoLink(channels).)

@member(GetKnownChannelPointer
    Getter for Pointers[] property.@br
    When index falls out of allowed boundary (<0,Count - 1>), an exception is
    raised.

    @param Index Index of requested item.

    @returns Pointer to requested item.)

@member(GetKnownChannel
    Getter for Events[] property.@br
    When index falls out of allowed boundary (<0,Count - 1>), an exception is
    raised.

    @param Index Index of requested item.

    @returns Requested item.)



@member(Clear
    Deletes all items in the list.@br
    OnChange event is called after items deletion.)

@member(Add
    Adds new known channel into the list.@br
    OnChange event is called after successful addition.

    @param Name          Name of added channel (ID is calculated from it).
    @param PrimaryType   Primary type of value for this channel.
    @param SecondaryType Secondary type of value for this channel.
    @param TertiaryType  Tertiary type of value for this channel.
    @param Indexed       Flag denoting whether added channel is indexed.
    @param(IndexConfig   Fully qualified name (id + attribute name) of the
                         configuration containing @noAutoLink(count) for channel
                         indices. Has no meaning when the channel is not
                         indexed.)

    @returns Index at which the new channel was added, -1 when addition failed.)

@member(ReplaceIndex
    Replaces channel at position given by @code(Index) parameter. When index
    falls out of allowed boundary (<0,Count - 1>), an exception is raised.@br
    OnChange event is called after successful replacement.

    @param Index         Index of item that has to be replaced.
    @param Name          Name of replacement channel (ID is calculated from it).
    @param PrimaryType   Primary type of value for this channel.
    @param SecondaryType Secondary type of value for this channel.
    @param TertiaryType  Tertiary type of value for this channel.
    @param Indexed       Flag denoting whether channel is indexed.
    @param(IndexConfig   Fully qualified name (id + attribute name) of the
                         configuration containing @noAutoLink(count) for channel
                         indices. Has no meaning when the channel is not
                         indexed.))

@member(Replace
    Replaces channel with name given by @code(OldChannel) parameter. When this
    channel is not found in the list, nothing happens and the method returns
    -1.@br
    OnChange event is called after successful replacement.

    @param(OldEvent      Identification number of channel that has to be
                         replaced.)
    @param Name          Name of replacement channel (ID is calculated from it).
    @param PrimaryType   Primary type of value for this channel.
    @param SecondaryType Secondary type of value for this channel.
    @param TertiaryType  Tertiary type of value for this channel.
    @param Indexed       Flag denoting whether channel is indexed.
    @param(IndexConfig   Fully qualified name (id + attribute name) of the
                         configuration containing @noAutoLink(count) for channel
                         indices. Has no meaning when the channel is not
                         indexed.)

    @returns(Index of channel that was replaced, -1 when old channel was not
             found.))

@member(Insert
    Inserts new channel at position given by @code(Index) parameter. Count is
    increased by one and all existing items from given position (included) up
    are moved higher. When index falls out of allowed boundary (<0,Count> -
    passed index can be higher than current highest index, if so, item is added
    at the end of the list), and exception is raised.@br
    OnChange event is called after successful insertion.

    @param Index         Position where the new channel should be inserted.
    @param Name          Name of inserted channel (ID is calculated from it).
    @param PrimaryType   Primary type of value for this channel.
    @param SecondaryType Secondary type of value for this channel.
    @param TertiaryType  Tertiary type of value for this channel.
    @param Indexed       Flag denoting whether channel is indexed.
    @param(IndexConfig   Fully qualified name (id + attribute name) of the
                         configuration containing @noAutoLink(count) for channel
                         indices. Has no meaning when the channel is not
                         indexed.)

    @returns Actual position where the new channel was inserted.)

@member(Remove
    Removes channel with given name from the list. When this channel is not
    found in the list, method returns -1 and nothing is removed.@br
    OnChange event is called after successful removal.

    @param Name Name of the channel that has to be removed from the list.

    @returns(Index of item that was removed, -1 when requested channel was not
             found.))

@member(Delete
    Deletes channel at position given by @code(Index) parameter. When index
    falls out of allowed boundary (<0,Count - 1>), an exception is raised.@br
    OnChange event is called after successful deletion.

    @param Index Index of item that has to be deleted.)

@member(ChannelIndexConfigID
    Returns @code(IndexConfigID) for channel with name given in @code(Name)
    parameter. When such channel is not found in the list, ID with value
    0x00000000 is returned.

    @param Name Name of requested channel.

    @returns ID of index-configuration for requested channel.)

@member(ChannelNameToID
    Returns ID for passed channel name.

    @param Name Name of chanel for which you want an ID.

    @returns ID of passed channel name.)

@member(ChannelIDToName
    Returns name of channel with the same ID as is passed in @code(ID) prameter.
    This method actually searches through the list for channel with appropriate
    ID. When such channel is not found, an empty string is returned.

    @param ID ID of requested channel.

    @returns Name of the channel with appropriate ID.)

@member(Pointers
    Array property mapped directly to internal list. Use it for direct access to
    individual stored items.@br
    Unlike Channels[] property, you can use returned pointer to change values of
    stored items.)

@member(Channels
    Array property mapped directly to internal list. Use it to obtain values of
    individual stored items.)
}
type
  TKnownChannelsList = class(TCustomTelemetryList)
  private
    Function GetKnownChannelPointer(Index: Integer): PKnownChannel;
    Function GetKnownChannel(Index: Integer): TKnownChannel;
  public
    procedure Clear; override;
  {
    Searches through list for channel with given name (case-sensitive). When
    the channel is not found, -1 is returned.

    @param Name Name of the requested channel.

    @returns Index of channel with requested name, -1 when not found.
  }
    Function IndexOf(const Name: TelemetryString): Integer; overload; virtual;
  {
    Searches through list for channel with given ID. When channel with that ID
    is not found, -1 is returned.

    @param ID ID of channel whose index is requested.

    @returns Index of channel with requested ID, -1 when not found.
  }
    Function IndexOf(ID: TChannelID): Integer; overload; virtual;
    Function Add(const Name: TelemetryString; PrimaryType, SecondaryType, TertiaryType: scs_value_type_t; Indexed: Boolean; const IndexConfig: TelemetryString = ''; MaxIndex: scs_u32_t = SCS_U32_NIL): Integer; virtual;
    procedure ReplaceIndex(Index: Integer; const Name: TelemetryString; PrimaryType, SecondaryType, TertiaryType: scs_value_type_t; Indexed: Boolean; const IndexConfig: TelemetryString = ''; MaxIndex: scs_u32_t = SCS_U32_NIL); virtual;
    Function Replace(const OldChannel, Name: TelemetryString; PrimaryType, SecondaryType, TertiaryType: scs_value_type_t; Indexed: Boolean; const IndexConfig: TelemetryString = ''; MaxIndex: scs_u32_t = SCS_U32_NIL): Integer; virtual;
    Function Insert(Index: Integer; const Name: TelemetryString; PrimaryType, SecondaryType, TertiaryType: scs_value_type_t; Indexed: Boolean; const IndexConfig: TelemetryString = ''; MaxIndex: scs_u32_t = SCS_U32_NIL): Integer; virtual;
    Function Remove(const Name: TelemetryString): Integer; virtual;
    procedure Delete(Index: Integer); virtual;
    Function ChannelIndexConfigID(const Name: TelemetryString): TItemID; virtual;
    Function ChannelNameToID(const Name: TelemetryString): TChannelID; virtual;
    Function ChannelIDToName(ID: TChannelID): TelemetryString; virtual;
    property Pointers[Index: Integer]: PKnownChannel read GetKnownChannelPointer;
    property Channels[Index: Integer]: TKnownChannel read GetKnownChannel; default;
  end;


{==============================================================================}
{------------------------------------------------------------------------------}
{                              TKnownConfigsList                               }
{------------------------------------------------------------------------------}
{==============================================================================}

{
  Structure used as item in TKnownConfigsList class.

  @member(Name      Full @NoAutoLink(name) of the config.)
  @member(ID        Identifier of the config (calculated from
                    @noAutoLink(name)))
  @member(ValueType Type of value for current config.)
  @member(Indexed   Flag indicating whether the config is @NoAutoLink(indexed).)
  @member(Binded    Flag denoting whether this config is @NoAutoLink(binded) by
                    a channel (meaning that some @NoAutoLink(indexed) channel
                    uses this config to obtain maximum index).)
}
  TKnownConfig = record
    Name:       TelemetryString;
    ID:         TConfigID;
    ValueType:  scs_value_type_t;
    Indexed:    Boolean;
    Binded:     Boolean;
  end;
  // Pointer to TKnownConfig structure.
  PKnownConfig = ^TKnownConfig;

const
  // Empty TKnownConfig structure.
  cEmptyKnownConfig: TKnownConfig =
   (Name:       '';
    ID:         0;
    ValueType:  SCS_VALUE_TYPE_INVALID;
    Indexed:    False;
    Binded:     False);

{==============================================================================}
{    TKnownConfigsList // Class declaration                                    }
{==============================================================================}
{
  @abstract(
  List used to store informations about known telemetry configurations values.)

@member(GetKnownConfigPointer
    Getter for Pointers[] property.@br
    When index falls out of allowed boundary (<0,Count - 1>), an exception is
    raised.

    @param Index Index of requested item.

    @returns Pointer to requested item.)

@member(GetKnownConfig
    Getter for Configs[] property.@br
    When index falls out of allowed boundary (<0,Count - 1>), an exception is
    raised.

    @param Index Index of requested item.

    @returns Requested item.)



@member(Clear
    Deletes all items in the list.@br
    OnChange event is called after items deletion.)

@member(Add
    Adds new known config into the list.@br
    OnChange event is called after successful addition.

    @param Name          Full name of added config.
    @param ValuetyType   Type of this @noAutoLink(configs) value.
    @param Indexed       Flag denoting whether added config is indexed.
    @param(Binded        Flag denoting whether added config is binded by some
                         channel (i.e. some channel has this config as its
                         IndexConfig property).)

    @returns Index at which the new config was added, -1 when addition failed.)

@member(ReplaceIndex
    Replaces config at position given by @code(Index) parameter. When index
    falls out of allowed boundary (<0,Count - 1>), an exception is raised.@br
    OnChange event is called after successful replacement.

    @param Index         Index of item that has to be replaced.
    @param Name          Full name of new config.
    @param ValuetyType   Type of this @noAutoLink(configs) value.
    @param Indexed       Flag denoting whether added config is indexed.
    @param(Binded        Flag denoting whether added config is binded by some
                         channel (i.e. some channel has this config as its
                         IndexConfig property).))

@member(Replace
    Replaces config with name given by @code(OldConfig) parameter. When this
    config is not found in the list, nothing happens and the method returns
    -1.@br
    OnChange event is called after successful replacement.

    @param OldConfig     Full name of the config that has to be replaced.
    @param Name          Full name of replacment config.
    @param ValuetyType   Type of this @noAutoLink(configs) value.
    @param Indexed       Flag denoting whether config is indexed.
    @param(Binded        Flag denoting whether config is binded by some channel
                         (i.e. some channel has this config as its IndexConfig
                         property).)

    @returns(Index of config that was replaced, -1 when old config was not
             found.))

@member(Insert
    Inserts new config at position given by @code(Index) parameter. Count is
    increased by one and all existing items from given position (included) up
    are moved higher. When index falls out of allowed boundary (<0,Count> -
    passed index can be higher than current highest index, if so, item is added
    at the end of the list), and exception is raised.@br
    OnChange event is called after successful insertion.

    @param Index         Position where the new config should be inserted.
    @param Name          Full name of inserted config.
    @param ValuetyType   Type of this @noAutoLink(configs) value.
    @param Indexed       Flag denoting whether config is indexed.
    @param(Binded        Flag denoting whether config is binded by some channel
                         (i.e. some channel has this config as its IndexConfig
                         property).)

    @returns Actual position where the new config was inserted.)

@member(Remove
    Removes config with given name from the list. When this config is not found
    in the list, method returns -1 and nothing is removed.@br
    OnChange event is called after successful removal.

    @param Name Full name of the config that has to be removed from the list.

    @returns(Index of item that was removed, -1 when requested config was not
             found.))

@member(Delete
    Deletes config at position given by @code(Index) parameter. When index falls
    out of allowed boundary (<0,Count - 1>), an exception is raised.@br
    OnChange event is called after successful deletion.

    @param Index Index of item that has to be deleted.)

@member(IsBinded
    Returns @true when given config is binded, @false when it is not binded or
    when not found in list.

    @param Name Full name of the requested config.

    @returns Binded state of requested config.)

@member(IsIndexed
    Returns @true when given config is Indexed, @false when it is not Indexed or
    when not found in list.

    @param Name Full name of the requested config.

    @returns Indexed state of requested config.)

@member(ConfigNameToID
    Returns ID for passed Config name.

    @param Name Full name of config for which you want an ID.

    @returns ID of passed Config name.)

@member(ConfigIDToName
    Returns name of Config with the same ID as is passed in "ID" prameter. This
    method actually searches through the list for Config with appropriate ID.
    When such Config is not found, an empty string is returned.

    @param ID ID of requested config.

    @returns Full name of the config with appropriate ID.)

@member(Pointers
    Array property mapped directly to internal list. Use it for direct access to
    individual stored items.@br
    Unlike Configs[] property, you can use returned pointer to change values of
    stored items.)

@member(Configs
    Array property mapped directly to internal list. Use it to obtain values of
    individual stored items.)
}
type
  TKnownConfigsList = class(TCustomTelemetryList)
  private
    Function GetKnownConfigPointer(Index: Integer): PKnownConfig;
    Function GetKnownConfig(Index: Integer): TKnownConfig;
  public
    procedure Clear; override;
  {
    Searches through list for config with given name (case-sensitive). When the
    config is not found, -1 is returned.

    @param Name Name of the requested config.

    @returns Index of config with requested name, -1 when not found.
  }
    Function IndexOf(const Name: TelemetryString): Integer; overload; virtual;
  {
    Searches through list for config with given ID. When config with that ID is
    not found, -1 is returned.

    @param ID ID of config whose index is requested.

    @returns Index of config with requested ID, -1 when not found.
  }
    Function IndexOf(ID: TConfigID): Integer; overload; virtual;
    Function Add(const Name: TelemetryString; ValueType: scs_value_type_t; Indexed: Boolean; Binded: Boolean = False): Integer; virtual;
    procedure ReplaceIndex(Index: Integer; const Name: TelemetryString; ValueType: scs_value_type_t; Indexed: Boolean; Binded: Boolean = False); virtual;
    Function Replace(const OldConfig, Name: TelemetryString; ValueType: scs_value_type_t; Indexed: Boolean; Binded: Boolean = False): Integer; virtual;
    Function Insert(Index: Integer; const Name: TelemetryString; ValueType: scs_value_type_t; Indexed: Boolean; Binded: Boolean = False): Integer; virtual;
    Function Remove(const Name: TelemetryString): Integer; virtual;
    procedure Delete(Index: Integer); virtual;
    Function IsBinded(const Name: TelemetryString): Boolean; virtual;
    Function IsIndexed(const Name: TelemetryString): Boolean; virtual;
    Function ConfigNameToID(const Name: TelemetryString): TConfigID;
    Function ConfigIDToName(ID: TConfigID): TelemetryString; virtual;
    property Pointers[Index: Integer]: PKnownConfig read GetKnownConfigPointer;
    property Configs[Index: Integer]: TKnownConfig read GetKnownConfig; default;
  end;


{==============================================================================}
{------------------------------------------------------------------------------}
{                            TRegisteredEventsList                             }
{------------------------------------------------------------------------------}
{==============================================================================}

{
  Structure holding informations about registered @noAutoLink(event).

  @member(Event    @NoAutoLink(Event) identifier.)
  @member(Utility  Denotes whether current @NoAutoLink(event) is marked as
                   @NoAutoLink(utility).)
}
  TEventInfo = record
    Event:    scs_event_t;
    Utility:  Boolean;
  end;
  // Pointer to TEventInfo structure.
  PEventInfo = ^TEventInfo;

const
  // Empty TEventInfo structure.
  cEmptyEventInfo: TEventInfo =
   (Event:    SCS_TELEMETRY_EVENT_invalid;
    Utility:  False);

{
  @abstract(Structure used as item in TRegisteredEventsList.)
  Pointer to this structure is passed as @noAutoLink(context) in telemetry API
  calls when registering telemetry event.

  @member(Recipient Object that should receive event callbacks.)
  @member(EventInfo Informations about registered event.)
}
type
  TEventContext = record
    Recipient:  TObject;
    EventInfo:  TEventInfo;
  end;
  // Pointer to TEventContext structure.
  PEventContext = ^TEventContext;

{==============================================================================}
{    TRegisteredEventsList // Class declaration                                }
{==============================================================================}
{
  @abstract(List used to store @noAutoLink(contexts of registered events).)

  When new event is registered in the telemetry API, it is registered with
  context which is actually pointer to a variable of TEventContext structure.
  This variable is at the same time added as a new item into this list.@br
  When event is unregistered, context it is bound to is removed from this list.

@member(GetEventContext
    Getter for Contexts[] property.@br
    When index falls out of allowed boundary (<0,Count - 1>), an exception is
    raised.

    @param Index Index of requested item.

    @returns Pointer to requested item.)

@member(GetEventInfo
    Getter for Events[] property.@br
    When index falls out of allowed boundary (<0,Count - 1>), an exception is
    raised.

    @param Index Index of requested item.

    @returns Requested item.)



@member(Clear
    Deletes all items in the list.@br
    OnChange event is called after items deletion.)

@member(Delete
    Deletes context at position given by @code(Index) parameter. When index
    falls out of allowed boundary (<0,Count - 1>), an exception is raised.@br
    OnChange event is called after successful deletion.

    @param Index Index of item that has to be deleted.)

@member(CreateContext
    This method creates new event context variable, fills it from parameters and
    returns pointer to this variable. It is used when registering new telemetry
    event, because actual context is needed for this registration, but cannot be
    added to this list before the registration is complete.@br
    Sequence of actions taken during registration is as follows:
    @unorderedlist(
      @itemSpacing(Compact)
      @item Context is created using this function.
      @item Registration in API is attempted.
      @item When successful, context is added to this list.
      @item When unsuccessful, context is freed using FreeContext method.
    )

    @param Recipient Telemetry recipient registering created context.
    @param Event     Identification number of registered event.
    @param(Utility   Flag indicating whether registered event is marked as
                     utility.)

    @returns Pointer to created event context.)

@member(FreeContext
    Frees memory allocated for event context and sets this pointer to @nil.

    @param EventContext Pointer to event context to be freed.)

@member(Contexts
    Array property mapped directly to internal list. Use it for direct access to
    individual stored contexts.@br
    Unlike Events[] property, you can use returned pointer to change values of
    stored items.)

@member(Events
    Array property mapped directly to internal list. Use it to obtain values of
    individual stored items.@br
    This property does not return whole context structure, only its "EventInfo"
    field.)
}
  TRegisteredEventsList = class(TCustomTelemetryList)
  private
    Function GetEventContext(Index: Integer): PEventContext;
    Function GetEventInfo(Index: Integer): TEventInfo;
  public
    procedure Clear; override;
  {
    Searches through list for context with requested event. When the context is
    not found, -1 is returned.

    @param Event Identification number of requested event.

    @returns Index of context with requested event, -1 when not found.
  }
    Function IndexOf(Event: scs_event_t): Integer; overload; virtual;
  {
    Searches through list for given context. When the context is not found,
    -1 is returned.

    @param EventContext Requested event context.

    @returns Index of requested context, -1 when not found.
  }
    Function IndexOf(EventContext: PEventContext): Integer; overload; virtual;
  {
    Adds new context into the list. @code(EventContext) parameter must not be
    @nil, otherwise an exception is raised.@br
    OnChange event is called after successful addition.

    @param(EventContext Pointer to event context that has to be added to the
                        list.)

    @returns Index at which the new context was added, -1 when addition failed.
  }
    Function Add(EventContext: PEventContext): Integer; overload; virtual;
  {
    Creates and adds new context into the list.@br
    OnChange event is called after successful addition.

    @param Recipient Telemetry recipient registering this new context.
    @param Event     Identification number of registered event.
    @param(Utility   Flag indicating whether registered event is marked as
                     utility.)

    @returns Index at which the new context was added, -1 when addition failed.
  }
    Function Add(Recipient: TObject; Event: scs_event_t; Utility: Boolean = False): Integer; overload; virtual;
  {
    Creates and adds new context into the list. Created context has
    @code(Recipient) field set to @nil.@br
    OnChange event is called after successful addition.

    @param Event     Identification number of registered event.
    @param(Utility   Flag indicating whether registered event is marked as
                     utility.)

    @returns Index at which the new context was added, -1 when addition failed.
  }
    Function Add(Event: scs_event_t; Utility: Boolean = False): Integer; overload; virtual;
  {
    Removes context with given event from the list.@br
    OnChange event is called after successful removal.

    @param(Event Identification number of registered event whose context has to
                 be removed.)

    @returns(Index of item that was removed, -1 when context with requested
             event was not found.)
  }
    Function Remove(Event: scs_event_t): Integer; overload; virtual;
  {
    Removes given context from the list.@br
    OnChange event is called after successful removal.

    @param EventContext Context to be removed.

    @returns(Index of item that was removed, -1 when requested context was not
             found.)
  }
    Function Remove(EventContext: PEventContext): Integer; overload; virtual;
    procedure Delete(Index: Integer); virtual;
    Function CreateContext(Recipient: TObject; Event: scs_event_t; Utility: Boolean = False): PEventContext; virtual;
    procedure FreeContext(var EventContext: PEventContext); virtual;
    property Contexts[Index: Integer]: PEventContext read GetEventContext;
    property Events[Index: Integer]: TEventInfo read GetEventInfo; default;
  end;  


{==============================================================================}
{------------------------------------------------------------------------------}
{                           TRegisteredChannelsList                            }
{------------------------------------------------------------------------------}
{==============================================================================}

{
  Structure holding informations about registered channel.

  @member(Name          @NoAutoLink(Name) of the channel.)
  @member(ID            Identifier of the channel.)
  @member(Index         @NoAutoLink(Index) of channels value.)
  @member(ValueType     Type of value for current channel.)
  @member(Flags         Registration flags.)
  @member(IndexConfigID Identifier of config that stores count for this
                        channel.)
}
  TChannelInfo = record
    Name:           TelemetryString;
    ID:             TChannelID;
    Index:          scs_u32_t;
    ValueType:      scs_value_type_t;
    Flags:          scs_u32_t;
    IndexConfigID:  TItemID;
  end;
  // Pointer to TChannelInfo structure.
  PChannelInfo = ^TChannelInfo;

const
  // Empty TEventInfo structure.
  cEmptyChannelInfo: TChannelInfo =
   (Name:           '';
    ID:             0;
    Index:          SCS_U32_NIL;
    ValueType:      SCS_VALUE_TYPE_INVALID;
    Flags:          0;
    IndexConfigID:  0);

{
  @abstract(Structure used as item in TRegisteredEventsList.)
  Pointer to this structure is passed as @noAutoLink(context) in telemetry API
  calls when registering telemetry channel.

  @member(Recipient   Object that should receive channel callbacks.)
  @member(ChannelInfo Informations about registered channel.)
}
type
  TChannelContext = record
    Recipient:    TObject;
    ChannelInfo:  TChannelInfo;
  end;
  // Pointer to TChannelContext structure.
  PChannelContext = ^TChannelContext;

{==============================================================================}
{    TRegisteredChannelsList // Class declaration                              }
{==============================================================================}
{
  @abstract(List used to store @noAutoLink(contexts of registered channels).)

  When new channel is registered in the telemetry API, it is registered with
  context which is actually pointer to a variable of TChannelContext structure.
  This variable is at the same time added as a new item into this list.@br
  When channel is unregistered, context it is bound to is removed from this
  list.

@member(GetChannelContext
    Getter for Contexts[] property.@br
    When index falls out of allowed boundary (<0,Count - 1>), an exception is
    raised.

    @param Index Index of requested item.

    @returns Pointer to requested item.)

@member(GetChannelInfo
    Getter for Channels[] property.@br
    When index falls out of allowed boundary (<0,Count - 1>), an exception is
    raised.

    @param Index Index of requested item.

    @returns Requested item.)



@member(Clear
    Deletes all items in the list.@br
    OnChange event is called after items deletion.)

@member(Delete
    Deletes context at position given by @code(Index) parameter. When index
    falls out of allowed boundary (<0,Count - 1>), an exception is raised.@br
    OnChange event is called after successful deletion.

    @param Index Index of item that has to be deleted.)

@member(CreateContext
    This method creates new channel context variable, fills it from parameters
    and returns pointer to this variable. It is used when registering new
    telemetry channel, because actual context is needed for this registration,
    but cannot be added to this list before the registration is complete.@br
    Sequence of actions taken during registration is as follows:
    @unorderedlist(
      @itemSpacing(Compact)
      @item Context is created using this function.
      @item Registration in API is attempted.
      @item When successful, context is added to this list.
      @item When unsuccessful, context is freed using FreeContext method.
    )

    @param Recipient     Telemetry recipient registering created context.
    @param(Name          Name of the registered channel (ID is calculated from
                         it).)
    @param Index         Index of registered channel.
    @param ValueType     Value type of registered channel.
    @param Flags         Registering flags.
    @param(IndexConfigID ID of index configuration to which registered channel
                         is bound.)

    @returns Pointer to created channel context.)

@member(FreeContext
    Frees memory allocated for channel context and sets this pointer to @nil.

    @param ChannelContext Pointer to channel context to be freed.)

@member(Contexts
    Array property mapped directly to internal list. Use it for direct access to
    individual stored contexts.@br
    Unlike Channels[] property, you can use returned pointer to change values of
    stored items.)

@member(Channels
    Array property mapped directly to internal list. Use it to obtain values of
    individual stored items.@br
    This property does not return whole context structure, only its
    "ChannelInfo" field.)
}
  TRegisteredChannelsList = class(TCustomTelemetryList)
  private
    Function GetChannelContext(Index: Integer): PChannelContext;
    Function GetChannelInfo(Index: Integer): TChannelInfo;
  public
    procedure Clear; override;
  {
    Searches through list for context created for channel with appropriate name.
    When the context is not found, -1 is returned.

    @param Name  Name of the requested channel.

    @returns Index of context with requested channel, -1 when not found.
  }
    Function IndexOf(const Name: TelemetryString): Integer; overload; virtual;
  {
    Searches through list for context created for channel with appropriate ID.
    When the context is not found, -1 is returned.

    @param ID    ID of the requested channel.

    @returns Index of context with requested channel, -1 when not found.
  }
    Function IndexOf(ID: TChannelID): Integer; overload; virtual;
  {
    Searches through list for context created for channel with appropriate name
    and index. When the context is not found, -1 is returned.

    @param Name  Name of the requested channel.
    @param Index Index of the requested channel.

    @returns Index of context with requested channel, -1 when not found.
  }
    Function IndexOf(const Name: TelemetryString; Index: scs_u32_t): Integer; overload; virtual;
  {
    Searches through list for context created for channel with appropriate ID
    and index. When the context is not found, -1 is returned.

    @param ID    ID of the requested channel.
    @param Index Index of the requested channel.

    @returns Index of context with requested channel, -1 when not found.
  }
    Function IndexOf(ID: TChannelID; Index: scs_u32_t): Integer; overload; virtual;
  {
    Searches through list for context created for channel with appropriate name,
    index and value type. When the context is not found, -1 is returned.

    @param Name      Name of the requested channel.
    @param Index     Index of the requested channel.
    @param ValueType Type of value of the requested channel.

    @returns Index of context with requested channel, -1 when not found.
  }
    Function IndexOf(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t): Integer; overload; virtual;
  {
    Searches through list for context created for channel with appropriate ID,
    index and value type. When the context is not found, -1 is returned.

    @param ID        ID of the requested channel.
    @param Index     Index of the requested channel.
    @param ValueType Type of value of the requested channel.

    @returns Index of context with requested channel, -1 when not found.
  }
    Function IndexOf(ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t): Integer; overload; virtual;
  {
    Searches through list for context created for channel with appropriate name,
    index, value type and flags. When the context is not found, -1 is returned.

    @param Name      Name of the requested channel.
    @param Index     Index of the requested channel.
    @param ValueType Type of value of the requested channel.
    @param Flags     Registering flags of the requested channel.

    @returns Index of context with requested channel, -1 when not found.
  }
    Function IndexOf(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t): Integer; overload; virtual;
  {
    Searches through list for context created for channel with appropriate ID,
    index, value type and flags. When the context is not found, -1 is returned.

    @param ID        ID of the requested channel.
    @param Index     Index of the requested channel.
    @param ValueType Type of value of the requested channel.
    @param Flags     Registering flags of the requested channel.

    @returns Index of context with requested channel, -1 when not found.
  }
    Function IndexOf(ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t): Integer; overload; virtual;
  {
    Searches through list given context. When the context is not found, -1 is returned.

    @param ChannelContext Requested channel context.

    @returns Index of requested context, -1 when not found.
  }
    Function IndexOf(ChannelContext: PChannelContext): Integer; overload; virtual;
  {
    Adds new context into the list. @code(ChannelContext) parameter must not be
    @nil, otherwise an exception is raised.@br
    OnChange event is called after successful addition.

    @param(ChannelContext Pointer to channel context that has to be added to the
                          list.)

    @returns Index at which the new context was added, -1 when addition failed.
  }
    Function Add(ChannelContext: PChannelContext): Integer; overload; virtual;
  {
    Creates and adds new context into the list.@br
    OnChange event is called after successful addition.

    @param Recipient     Telemetry recipient registering this new context.
    @param(Name          Name of the registered channel (ID is calculated from
                         it).)
    @param Index         Index of registered channel.
    @param ValueType     Value type of registered channel.
    @param Flags         Registering flags.
    @param(IndexConfigID ID of index configuration to which the registered
                         channel is bound.)

    @returns Index at which the new context was added, -1 when addition failed.
  }
    Function Add(Recipient: TObject; const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t = SCS_TELEMETRY_CHANNEL_FLAG_none; IndexConfigID: TItemID = 0): Integer; overload; virtual;
  {
    Creates and adds new context into the list. Created context has
    @code(Recipient) field set to @nil.@br
    OnChange event is called after successful addition.

    @param(Name          Name of the registered channel (ID is calculated from
                         it).)
    @param Index         Index of registered channel.
    @param ValueType     Value type of registered channel.
    @param Flags         Registering flags.
    @param(IndexConfigID ID of index configuration to which the registered
                         channel is bound.)

    @returns Index at which the new context was added, -1 when addition failed.
  }
    Function Add(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t = SCS_TELEMETRY_CHANNEL_FLAG_none; IndexConfigID: TItemID = 0): Integer; overload; virtual;
  {
    Removes context created for given channel from the list.@br
    OnChange event is called after successful removal.

    @param(Name      Name of the registered channel whose context has to be
                     removed.)
    @param Index     Index of registered channel.
    @param ValueType Value type of registered channel.

    @returns(Index of item that was removed, -1 when context with requested
             channel was not found.)
  }
    Function Remove(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t): Integer; overload; virtual;
  {
    Removes context created for given channel from the list.@br
    OnChange event is called after successful removal.

    @param(ID        ID of the registered channel whose context has to be
                     removed.)
    @param Index     Index of registered channel.
    @param ValueType Value type of registered channel.

    @returns(Index of item that was removed, -1 when context with requested
             channel was not found.)
  }
    Function Remove(ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t): Integer; overload; virtual;
  {
    Removes given context from the list.@br
    OnChange event is called after successful removal.

    @param ChannelContext Context to be removed.

    @returns(Index of item that was removed, -1 when requested context was not
             found.)
  }    
    Function Remove(ChannelContext: PChannelContext): Integer; overload; virtual;
    procedure Delete(Index: Integer); virtual;
    Function CreateContext(Recipient: TObject; const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t = SCS_TELEMETRY_CHANNEL_FLAG_none; IndexConfigID: TItemID = 0): PChannelContext; virtual;
    procedure FreeContext(var ChannelContext: PChannelContext); virtual;
    property Contexts[Index: Integer]: PChannelContext read GetChannelContext;
    property Channels[Index: Integer]: TChannelInfo read GetChannelInfo; default;
  end;


{==============================================================================}
{------------------------------------------------------------------------------}
{                              TStoredConfigsList                              }
{------------------------------------------------------------------------------}
{==============================================================================}

{
  @abstract(Structure used as item in TStoredConfigsList.)
  This structure is used to store configuration @noAutoLink(value) obtained from
  the API call.

  @member(Name   Full @NoAutoLink(name) of the config.)
  @member(ID     Identifier of the config.)
  @member(Index  Index of configs @NoAutoLink(value).)
  @member(Value  Actual @NoAutoLink(value) of the config.)
  @member(Binded Flag denoting whether this config is @NoAutoLink(binded).)
}
  TStoredConfig = record
    Name:   TelemetryString;
    ID:     TConfigID;
    Index:  scs_u32_t;
    Value:  scs_value_localized_t;
    Binded: Boolean;
  end;
  // Pointer to TStoredConfig structure.
  PStoredConfig = ^TStoredConfig;

const
  // Empty TStoredConfig structure.
  cEmptyStoredConfig: TStoredConfig =
   (Name:   '';
    ID:     0;
    Index:  SCS_U32_NIL;
    Value: (
      ValueType:  SCS_VALUE_TYPE_INVALID;
      BinaryData: (
        _type: SCS_VALUE_TYPE_INVALID);
      StringData: '');
    Binded: True);

{==============================================================================}
{    TStoredConfigsList // Class declaration                                   }
{==============================================================================}
{
  @abstract(List used to store configuration values obtained from API calls.)

@member(GetStoredConfigPointer
    Getter for Pointers[] property.@br
    When index falls out of allowed boundary (<0,Count - 1>), an exception is
    raised.

    @param Index Index of requested item.

    @returns Pointer to requested item.)

@member(GetStoredConfig
    Getter for Configs[] property.@br
    When index falls out of allowed boundary (<0,Count - 1>), an exception is
    raised.

    @param Index Index of requested item.

    @returns Requested item.)



@member(Clear
    Deletes all items in the list.@br
    OnChange event is called after items deletion.)

@member(Delete
    Deletes stored config at position given by @code(Index) parameter. When
    index falls out of allowed boundary (<0,Count - 1>), an exception is
    raised.@br
    OnChange event is called after successful deletion.

    @param Index Index of item that has to be deleted.)

@member(Pointers
    Array property mapped directly to internal list. Use it for direct access to
    individual stored items.@br
    Unlike Configs[] property, you can use returned pointer to change values of
    stored items.)

@member(Configs
    Array property mapped directly to internal list. Use it to obtain values of
    individual stored items.)
}
type
  TStoredConfigsList = class(TCustomTelemetryList)
  private
    Function GetStoredConfigPointer(Index: Integer): PStoredConfig;
    Function GetStoredConfig(Index: Integer): TStoredConfig;
  public
    procedure Clear; override;
  {
    Searches through list for stored config with appropriate name.
    When matching config is not found, -1 is returned.

    @param Name  Name of the requested config.

    @returns Index of requested config, -1 when not found.
  }
    Function IndexOf(const Name: TelemetryString): Integer; overload; virtual;
  {
    Searches through list for stored config with appropriate ID.
    When matching config is not found, -1 is returned.

    @param ID    ID of the requested config.

    @returns Index of requested config, -1 when not found.
  }
    Function IndexOf(ID: TConfigID): Integer; overload; virtual;
  {
    Searches through list for stored config with appropriate name and index.
    When matching config is not found, -1 is returned.

    @param Name  Name of the requested config.
    @param Index Index of the requested config.

    @returns Index of requested config, -1 when not found.
  }
    Function IndexOf(const Name: TelemetryString; Index: scs_u32_t): Integer; overload; virtual;
  {
    Searches through list for stored config with appropriate ID and index.
    When matching config is not found, -1 is returned.

    @param ID    ID of the requested config.
    @param Index Index of the requested config.

    @returns Index of requested config, -1 when not found.
  }
    Function IndexOf(ID: TConfigID; Index: scs_u32_t): Integer; overload; virtual;
  {
    Stores new config with its value into the list.@br
    OnChange event is called after successful addition.

    @param Name    Name of stored config (ID is calculated from it).
    @param Index   Index of stored config.
    @param Value   Localized value (data) this config contains.
    @param(Binded  Flag denoting whether  this config is binded by some channel
                   (i.e. some channel has this config as its IndexConfig
                   property).)

    @returns Index at which the new config was stored, -1 when addition failed.
  }
    Function Add(const Name: TelemetryString; Index: scs_u32_t; Value: scs_value_localized_t; Binded: Boolean = False): Integer; overload; virtual;
  {
    Stores new config with its value into the list.@br
    OnChange event is called after successful addition.

    @param Name    Name of stored config (ID is calculated from it).
    @param Index   Index of stored config.
    @param Value   Value (data) this config contains.
    @param(Binded  Flag denoting whether  this config is binded by some channel
                   (i.e. some channel has this config as its IndexConfig
                   property).)

    @returns Index at which the new config was stored, -1 when addition failed.
  }
    Function Add(const Name: TelemetryString; Index: scs_u32_t; Value: p_scs_value_t; Binded: Boolean = False): Integer; overload; virtual;
  {
    Removes stored config from the list.@br
    OnChange event is called after successful removal.

    @param Name  Name of stored config that has to be removed.
    @param Index Index of stored config.

    @returns(Index of item that was removed, -1 when requested config was not
             found.)
  }
    Function Remove(const Name: TelemetryString; Index: scs_u32_t = SCS_U32_NIL): Integer; overload; virtual;
  {
    Removes stored config from the list.@br
    OnChange event is called after successful removal.

    @param ID    ID of stored config that has to be removed.
    @param Index Index of stored config.

    @returns(Index of item that was removed, -1 when requested config was not
             found.)
  }
    Function Remove(ID: TChannelID; Index: scs_u32_t = SCS_U32_NIL): Integer; overload; virtual;
    procedure Delete(Index: Integer); virtual;
  {
    Changes stored value in config defined by name and index.
    OnChange event is called after successful removal.

    @param Name  Name of stored config whose value should be changed.
    @param Index Index of stored config.

    @returns(Index of item whose value has been changed, -1 when requested
             config was not found.)
  }
    Function ChangeConfigValue(const Name: TelemetryString; Index: scs_u32_t; Value: scs_value_localized_t): Integer; overload; virtual;
  {
    Changes stored value in config defined by ID and index.
    OnChange event is called after successful removal.

    @param ID    ID of stored config whose value should be changed.
    @param Index Index of stored config.

    @returns(Index of item whose value has been changed, -1 when requested
             config was not found.)
  }
    Function ChangeConfigValue(ID: TConfigID; Index: scs_u32_t; Value: scs_value_localized_t): Integer; overload; virtual;
    property Pointers[Index: Integer]: PStoredConfig read GetStoredConfigPointer;
    property Configs[Index: Integer]: TStoredConfig read GetStoredConfig; default;
  end;


{==============================================================================}
{------------------------------------------------------------------------------}
{                           TStoredChannelsValuesList                          }
{------------------------------------------------------------------------------}
{==============================================================================}

  // Identification number used in TStoredChannelsValuesList for faster
  // searching.
  TMasterID = LongWord;

{
  @abstract(Function used to calculate master identification number which is
  used in TStoredChannelsValuesList.)@br
  This number is used in searching and sorting algorithms and is calculated from
  channel ID, Index and ValueType.@br
  At the moment, it is calculated by the formula:@br
  @longcode( MasterID := (ID xor Index) xor not ValueType; )

  @param ID        Channel ID.
  @param Index     Channel index.
  @param ValueType Channel ValueType.

  @returns Master identification number.
}
  Function GetMasterID(ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t): TMasterID; register;

type
{
  @abstract(Structure used to store channel @noAutoLink(value) obtained form 
            API.)

  @member(Name      @NoAutoLink(Name) of the channel.)
  @member(ID        Identifier of the channel.)
  @member(Index     @NoAutoLink(Index) of channels @NoAutoLink(value).)
  @member(Value     Actual @NoAutoLink(value) of the channel.)
}
  TStoredChannel = record
    Name:       TelemetryString;
    ID:         TChannelID;
    Index:      scs_u32_t;
    Value:      scs_value_localized_t;
  end;
  // Pointer to TStoredChannel structure.
  PStoredChannel = ^TStoredChannel;

{
  @abstract(Structure used as item in TStoredChannelsValuesList.)
  This structure is used to store channels @noAutoLink(values) obtained from API
  calls in an list sorted by items master ID.

  @member(MasterID      Identifier of stored channel @NoAutoLink(value).)
  @member(StoredChannel Stored channel with its value.)
}
  TStoredChannelMasterID = record
    MasterID:       TMasterID;
    StoredChannel:  TStoredChannel;
  end;
  // Pointer to TStoredChannelSorted structure.
  PStoredChannelMasterID = ^TStoredChannelMasterID;

{==============================================================================}
{    TStoredChannelsValuesList // Class declaration                            }
{==============================================================================}
{
  @abstract(List used to store channels values obtained from API calls.)

  Items in this list are sorted by their master ID.

@member(GetStoredChannelValue
    Getter for StoredChannelValues[] property.@br
    When index falls out of allowed boundary (<0,Count - 1>), an exception is
    raised.

    @param Index Index of requested item.

    @returns Requested item.)

@member(GetInsertIndex
    This function is used to get position at which should the new item with
    given master ID be put in order for the list to stay sorted.

    @param MasterID Master ID of added item.

    @returns Position at which newly added item should be inserted.)



@member(Clear
    Deletes all items in the list.@br
    OnChange event is called after items deletion.)

@member(StoreChannelValue
    Method used to store new value for already present channel. If such channel
    is not yet stored in the list, it is added as new item. Function can, in
    extreme cases, return -1 (when the channel is not already stored and
    addition fails for some reason).@br
    OnChange event is called after successful addition or value change.

    @param Name  Name of requested channel.
    @param ID    ID of requested channel.
    @param Index Index of requested channel.
    @param Value Value of the channel. 

    @returns Index of requested channel, -1 on failure.)

@member(StoredChannelValues
    Array property mapped directly to internal list. Use it to obtain values of
    individual stored items.)
}
  TStoredChannelsValuesList = class(TCustomTelemetryList)
  private
    Function GetStoredChannelValue(Index: Integer): TStoredChannel;
  protected
    Function GetInsertIndex(MasterID: TMasterID): Integer; virtual;
  public
    procedure Clear; override;
  {
    Searches through list for stored channel with appropriate master index.
    When matching config is not found, -1 is returned.

    @param MasterID Master ID of requested channel.

    @returns Index of requested channel, -1 when not found.
  }
    Function IndexOf(MasterID: TMasterID): Integer; overload; virtual;
  {
    Searches through list for stored channel with appropriate ID, index and
    value type. When the context is not found, -1 is returned.

    @param ID        ID of the requested channel.
    @param Index     Index of the requested channel.
    @param ValueType Type of value of the requested channel.

    @returns Index of context with requested channel, -1 when not found.
  }
    Function IndexOf(ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t): Integer; overload; virtual;
  {
    Searches through list for stored channel with appropriate name, index and
    value type. When the context is not found, -1 is returned.

    @param Name      Name of the requested channel.
    @param Index     Index of the requested channel.
    @param ValueType Type of value of the requested channel.

    @returns Index of context with requested channel, -1 when not found.
  }
    Function IndexOf(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t): Integer; overload; virtual;
    Function StoreChannelValue(const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; Value: p_scs_value_t): Integer; virtual;
    property StoredChannelValues[Index: Integer]: TStoredChannel read GetStoredChannelValue; default;
  end;

{==============================================================================}
{    Unit Functions and procedures // Declaration                              }
{==============================================================================}

{
  @abstract(Function intended as callback for streaming functions, converting
            channel name to ID.)
  @code(UserData) passed to streaming function along with this callback must
  contain valid TKnownChannelsList object.

  @param Name          Channel name to be converted to ID.
  @param(KnownChannels TKnownChannelsList object that will be used for actual
                       conversion.)

  @returns Channel ID obtained from passed name.
}
Function GetChannelIDFromName(const Name: TelemetryString; KnownChannels: Pointer): TChannelID;

{
  @abstract(Function intended as callback for streaming functions, converting
            channel ID to name.)
  @code(UserData) passed to streaming function along with this callback must
  contain valid TKnownChannelsList object.

  @param ID            Channel ID to be converted to name.
  @param(KnownChannels TKnownChannelsList object that will be used for actual
                       conversion.)

  @returns Channel name obtained from passed ID.
}
Function GetChannelNameFromID(ID: TChannelID; KnownChannels: Pointer): TelemetryString;

{
  @abstract(Function intended as callback for streaming functions, converting
            config name to ID.)
  @code(UserData) passed to streaming function along with this callback must
  contain valid TKnownConfigsList object.

  @param Name          Config name to be converted to ID.
  @param(KnownChannels TKnownConfigsList object that will be used for actual
                       conversion.)

  @returns Config ID obtained from passed name.
}
Function GetConfigIDFromName(const Name: TelemetryString; KnownConfigs: Pointer): TConfigID;

{
  @abstract(Function intended as callback for streaming functions, converting
            ID to config name.)
  @code(UserData) passed to streaming function along with this callback must
  contain valid TKnownConfigsList object.

  @param ID            Config ID to be converted to name.
  @param(KnownChannels TKnownConfigsList object that will be used for actual
                       conversion.)

  @returns Config name obtained from passed ID.
}
Function GetConfigNameFromID(ID: TConfigID; KnownConfigs: Pointer): TelemetryString;

implementation

uses
  SysUtils,
  TelemetryConversions, TelemetryStrings;

{==============================================================================}
{    Unit Functions and procedures // Implementation                           }
{==============================================================================}

Function GetMasterID(ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t): TMasterID; register;
{$IFDEF PurePascal}
begin
Result := (ID xor Index) xor not ValueType;
end;
{$ELSE}
asm
{******************************************************************************}
{     Register    Content                                                      }
{     EAX         ID, Result                                                   }
{     EDX         Index                                                        }
{     ECX         ValueType                                                    }
{                                                                              }
{     Registers used in routine:                                               }
{     EAX (contains result), ECX, EDX                                          }
{******************************************************************************}
      XOR   EAX, ECX
      NOT   EDX
      XOR   EAX, EDX
end;
{$ENDIF}

//------------------------------------------------------------------------------

Function GetChannelIDFromName(const Name: TelemetryString; KnownChannels: Pointer): TChannelID;
begin
Result := TKnownChannelsList(KnownChannels).ChannelNameToID(Name);
end;

//------------------------------------------------------------------------------

Function GetChannelNameFromID(ID: TChannelID; KnownChannels: Pointer): TelemetryString;
begin
Result := TKnownChannelsList(KnownChannels).ChannelIDToName(ID);
end;

//------------------------------------------------------------------------------

Function GetConfigIDFromName(const Name: TelemetryString; KnownConfigs: Pointer): TConfigID;
begin
Result := TKnownConfigsList(KnownConfigs).ConfigNameToID(Name);
end;

//------------------------------------------------------------------------------

Function GetConfigNameFromID(ID: TConfigID; KnownConfigs: Pointer): TelemetryString;
begin
Result := TKnownConfigsList(KnownConfigs).ConfigIDToName(ID);
end;

{==============================================================================}
{------------------------------------------------------------------------------}
{                             TCustomTelemetryList                             }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TCustomTelemetryList // Implementation                                    }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TCustomTelemetryList // Private methods                                   }
{------------------------------------------------------------------------------}

Function TCustomTelemetryList.GetCount: Integer;
begin
Result := fMainList.Count;
end;

{------------------------------------------------------------------------------}
{    TCustomTelemetryList // Protected methods                                 }
{------------------------------------------------------------------------------}

Function TCustomTelemetryList.PtrGetItem(Index: Integer): Pointer;
begin
If (Index >= 0) and (Index < fMainList.Count) then
  Result := fMainList[Index]
else
  raise Exception.Create('TCustomTelemetryList.PtrGetItem(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TCustomTelemetryList.PtrIndexOf(Item: Pointer): Integer;
begin
Result := fMainList.IndexOf(Item);
end;

//------------------------------------------------------------------------------

Function TCustomTelemetryList.PtrAdd(Item: Pointer): Integer;
begin
Result := -1;
If Assigned(Item) then Result := fMainList.Add(Item);
If Result >= 0 then DoChange;
end;

//------------------------------------------------------------------------------

procedure TCustomTelemetryList.PtrReplace(Index: Integer; Item: Pointer);
begin
If (Index >= 0) and (Index < fMainList.Count) then
  begin
    fMainList[Index] := Item;
    DoChange;
  end
else
  raise Exception.Create('TCustomTelemetryList.PtrReplace(Index,Item): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

procedure TCustomTelemetryList.PtrInsert(Index: Integer; Item: Pointer);
begin
If (Index >= 0) and (Index <= fMainList.Count) then
  begin
    fMainList.Insert(Index,Item);
    DoChange;
  end
else
  raise Exception.Create('TCustomTelemetryList.PtrInsert(Index,Item): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TCustomTelemetryList.PtrRemove(Item: Pointer): Integer;
begin
Result := fMainList.Remove(Item);
If Result >= 0 then DoChange;
end;

//------------------------------------------------------------------------------

procedure TCustomTelemetryList.PtrDelete(Index: Integer);
begin
If (Index >= 0) and (Index < fMainList.Count) then
  begin
    fMainList.Delete(Index);
    DoChange;
  end
else
  raise Exception.Create('TCustomTelemetryList.PtrDelete(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

{------------------------------------------------------------------------------}
{    TCustomTelemetryList // Public methods                                    }
{------------------------------------------------------------------------------}

constructor TCustomTelemetryList.Create;
begin
inherited;
fMainList := TList.Create;
fUpdating := False;
{$IFDEF MulticastEvents}
fOnChangeMulti := TMulticastNotifyEvent.Create(Self);
{$ENDIF}
end;

//------------------------------------------------------------------------------

destructor TCustomTelemetryList.Destroy;
begin
// Prevent OnChange event call.
BeginUpdate;
{$IFDEF MulticastEvents}
fOnChangeMulti.Free;
{$ENDIF}
Clear;
fMainList.Free;
inherited;
end;

//------------------------------------------------------------------------------

procedure TCustomTelemetryList.BeginUpdate;
begin
fUpdating := True;
end;

//------------------------------------------------------------------------------

procedure TCustomTelemetryList.EndUpdate;
begin
fUpdating := False;
DoChange;
end;

//------------------------------------------------------------------------------

procedure TCustomTelemetryList.DoChange;
begin
If not fUpdating then
  begin
    If Assigned(fOnChange) then fOnChange(Self);
    {$IFDEF MulticastEvents}
    fOnChangeMulti.Call(Self);
    {$ENDIF}
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTelemetryList.Clear;
begin
fMainList.Clear;
DoChange;
end;

{==============================================================================}
{------------------------------------------------------------------------------}
{                               TKnownEventsList                               }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TKnownEventsList // Implementation                                        }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TKnownEventsList // Private methods                                       }
{------------------------------------------------------------------------------}

Function TKnownEventsList.GetKnownEventPointer(Index: Integer): PKnownEvent;
begin
If (Index >= 0) and (Index < Count) then
  Result := PKnownEvent(PtrGetItem(Index))
else
  raise Exception.Create('TKnownEventsList.GetKnownEventPointer(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TKnownEventsList.GetKnownEvent(Index: Integer): TKnownEvent;
begin
If (Index >= 0) and (Index < Count) then
  Result := GetKnownEventPointer(Index)^
else
  raise Exception.Create('TKnownEventsList.GetKnownEvent(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

{------------------------------------------------------------------------------}
{    TKnownEventsList // Public methods                                        }
{------------------------------------------------------------------------------}

procedure TKnownEventsList.Clear;
var
  i:  Integer;
begin
For i := (Count - 1) downto 0 do
  Dispose(PKnownEvent(PtrGetItem(i)));
inherited;
end;

//------------------------------------------------------------------------------

Function TKnownEventsList.IndexOf(Event: scs_event_t): Integer;
var
  i:  Integer;
begin
Result := -1;
For i := 0 to (Count - 1) do
  If PKnownEvent(PtrGetItem(i))^.Event = Event then
    begin
      Result := i;
      Break;
    end;
end;

Function TKnownEventsList.IndexOf(const Name: TelemetryString): Integer;
var
  i:  Integer;
begin
Result := -1;
For i := 0 to (Count - 1) do
{$IFDEF AssumeASCIIString}
  If TelemetrySameTextNoConv(PKnownEvent(PtrGetItem(i))^.Name,Name) then
{$ELSE}
  If TelemetrySameText(PKnownEvent(PtrGetItem(i))^.Name,Name) then
{$ENDIF}
    begin
      Result := i;
      Break;
    end;
end;

//------------------------------------------------------------------------------

Function TKnownEventsList.Add(Event: scs_event_t; const Name: TelemetryString; Valid: Boolean = True; Utility: Boolean = False): Integer;
var
  NewEvent: PKnownEvent;
begin
New(NewEvent);
NewEvent^.Event := Event;
NewEvent^.Name := Name;
NewEvent^.Valid := Valid;
NewEvent^.Utility := Utility;
Result := PtrAdd(NewEvent);
If Result < 0 then Dispose(NewEvent);
end;

//------------------------------------------------------------------------------

procedure TKnownEventsList.ReplaceIndex(Index: Integer; Event: scs_event_t; const Name: TelemetryString; Valid: Boolean = True; Utility: Boolean = False);
var
  KnownEvent:  PKnownEvent;
begin
If (Index >= 0) and (Index < Count) then
  begin
    KnownEvent := PKnownEvent(PtrGetItem(Index));
    KnownEvent^.Event := Event;
    KnownEvent^.Name := Name;
    KnownEvent^.Valid := Valid;
    KnownEvent^.Utility := Utility;
    PtrReplace(Index,KnownEvent);
  end
else
  raise Exception.Create('TKnownEventsList.ReplaceIndex(Index,...): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TKnownEventsList.Replace(OldEvent, Event: scs_event_t; const Name: TelemetryString; Valid: Boolean = True; Utility: Boolean = False): Integer;
begin
Result := IndexOf(OldEvent);
If Result >= 0 then ReplaceIndex(Result,Event,Name,Valid,Utility);
end;

//------------------------------------------------------------------------------

Function TKnownEventsList.Insert(Index: Integer; Event: scs_event_t; const Name: TelemetryString; Valid: Boolean = True; Utility: Boolean = False): Integer;
var
  NewEvent: PKnownEvent;
begin
If (Index < 0) or (Index >= Count) then
  Result := Add(Event,Name,Valid,Utility)
else
  begin
    New(NewEvent);
    NewEvent^.Event := Event;
    NewEvent^.Name := Name;
    NewEvent^.Valid := Valid;
    NewEvent^.Utility := Utility;
    Result := Index;
    PtrInsert(Index,NewEvent);
  end;
end;

//------------------------------------------------------------------------------

Function TKnownEventsList.Remove(Event: scs_event_t): Integer;
begin
Result := IndexOf(Event);
If Result >= 0 then Delete(Result);
end;

//------------------------------------------------------------------------------

procedure TKnownEventsList.Delete(Index: Integer);
begin
If (Index >= 0) and (Index < Count) then
  begin
    Dispose(PKnownEvent(PtrGetItem(Index)));
    PtrDelete(Index);
  end
else
  raise Exception.Create('TKnownEventsList.Delete(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TKnownEventsList.IsValid(Event: scs_event_t): Boolean;
var
  Index:  Integer;
begin
Result := False;
Index := IndexOf(Event);
If Index >= 0 then
  Result := PKnownEvent(PtrGetItem(Index))^.Valid;
end;

//------------------------------------------------------------------------------

Function TKnownEventsList.IsUtility(Event: scs_event_t): Boolean;
var
  Index:  Integer;
begin
Result := False;
Index := IndexOf(Event);
If Index >= 0 then
  Result := PKnownEvent(PtrGetItem(Index))^.Utility;
end;

{==============================================================================}
{------------------------------------------------------------------------------}
{                              TKnownChannelsList                              }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TKnownChannelsList // Implementation                                      }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TKnownChannelsList // Private methods                                     }
{------------------------------------------------------------------------------}

Function TKnownChannelsList.GetKnownChannelPointer(Index: Integer): PKnownChannel;
begin
If (Index >= 0) and (Index < Count) then
  Result := PKnownChannel(PtrGetItem(Index))
else
  raise Exception.Create('TKnownChannelsList.GetKnownChannelPointer(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TKnownChannelsList.GetKnownChannel(Index: Integer): TKnownChannel;
begin
If (Index >= 0) and (Index < Count) then
  Result := GetKnownChannelPointer(Index)^
else
  raise Exception.Create('TKnownChannelsList.GetKnownChannel(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

{------------------------------------------------------------------------------}
{    TKnownChannelsList // Public methods                                      }
{------------------------------------------------------------------------------}

procedure TKnownChannelsList.Clear;
var
  i:  Integer;
begin
For i := (Count - 1) downto 0 do
  Dispose(PKnownChannel(PtrGetItem(i)));
inherited;
end;

//------------------------------------------------------------------------------

Function TKnownChannelsList.IndexOf(const Name: TelemetryString): Integer;
var
  i:  Integer;
begin
Result := -1;
For i := 0 to (Count - 1) do
{$IFDEF AssumeASCIIString}
  If TelemetrySameStrNoConv(PKnownChannel(PtrGetItem(i))^.Name,Name) then
{$ELSE}
  If TelemetrySameStr(PKnownChanneli(PtrGetItem(i))^.Name,Name) then
{$ENDIF}
    begin
      Result := i;
      Break;
    end;
end;

Function TKnownChannelsList.IndexOf(ID: TChannelID): Integer;
var
  i:  Integer;
begin
Result := -1;
For i := 0 to (Count - 1) do
  If PKnownChannel(PtrGetItem(i))^.ID = ID then
    begin
      Result := i;
      Break;
    end;
end;

//------------------------------------------------------------------------------

Function TKnownChannelsList.Add(const Name: TelemetryString; PrimaryType, SecondaryType, TertiaryType: scs_value_type_t; Indexed: Boolean; const IndexConfig: TelemetryString = ''; MaxIndex: scs_u32_t = SCS_U32_NIL): Integer;
var
  NewChannel: PKnownChannel;
begin
New(NewChannel);
NewChannel^.Name := Name;
NewChannel^.ID := ChannelNameToID(Name);
NewChannel^.PrimaryType := PrimaryType;
NewChannel^.SecondaryType := SecondaryType;
NewChannel^.TertiaryType := TertiaryType;
NewChannel^.Indexed := Indexed;
NewChannel^.IndexConfig := IndexConfig;
NewChannel^.IndexConfigID := GetItemID(IndexConfig);
NewChannel^.MaxIndex := MaxIndex;
Result := PtrAdd(NewChannel);
If Result < 0 then Dispose(NewChannel);
end;

//------------------------------------------------------------------------------

procedure TKnownChannelsList.ReplaceIndex(Index: Integer; const Name: TelemetryString; PrimaryType, SecondaryType, TertiaryType: scs_value_type_t; Indexed: Boolean; const IndexConfig: TelemetryString = ''; MaxIndex: scs_u32_t = SCS_U32_NIL);
var
  KnownChannel: PKnownChannel;
begin
If (Index >= 0) and (Index < Count) then
  begin
    KnownChannel := PKnownChannel(PtrGetItem(Index));
    KnownChannel^.Name := Name;
    KnownChannel^.ID := ChannelNameToID(Name);
    KnownChannel^.PrimaryType := PrimaryType;
    KnownChannel^.SecondaryType := SecondaryType;
    KnownChannel^.TertiaryType := TertiaryType;
    KnownChannel^.Indexed := Indexed;
    KnownChannel^.IndexConfig := IndexConfig;
    KnownChannel^.IndexConfigID := GetItemID(IndexConfig);
    KnownChannel^.MaxIndex := MaxIndex;
    PtrReplace(Index,KnownChannel);
  end
else
  raise Exception.Create('TKnownChannelsList.ReplaceIndex(Index,...): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TKnownChannelsList.Replace(const OldChannel, Name: TelemetryString; PrimaryType, SecondaryType, TertiaryType: scs_value_type_t; Indexed: Boolean; const IndexConfig: TelemetryString = ''; MaxIndex: scs_u32_t = SCS_U32_NIL): Integer;
begin
Result := IndexOf(OldChannel);
If Result >= 0 then
  ReplaceIndex(Result,Name,PrimaryType,SecondaryType,TertiaryType,Indexed,Indexconfig,MaxIndex);
end;

//------------------------------------------------------------------------------

Function TKnownChannelsList.Insert(Index: Integer; const Name: TelemetryString; PrimaryType, SecondaryType, TertiaryType: scs_value_type_t; Indexed: Boolean; const IndexConfig: TelemetryString = ''; MaxIndex: scs_u32_t = SCS_U32_NIL): Integer;
var
  NewChannel: PKnownChannel;
begin
If (Index < 0) or (Index >= Count) then
  Result := Add(Name,PrimaryType,SecondaryType,TertiaryType,Indexed,Indexconfig,MaxIndex)
else
  begin
    New(NewChannel);
    NewChannel^.Name := Name;
    NewChannel^.ID := ChannelNameToID(Name);
    NewChannel^.PrimaryType := PrimaryType;
    NewChannel^.SecondaryType := SecondaryType;
    NewChannel^.TertiaryType := TertiaryType;
    NewChannel^.Indexed := Indexed;
    NewChannel^.IndexConfig := IndexConfig;
    NewChannel^.IndexConfigID := GetItemID(IndexConfig);
    NewChannel^.MaxIndex := MaxIndex;
    Result := Index;
    PtrInsert(Index,NewChannel);
  end;
end;

//------------------------------------------------------------------------------

Function TKnownChannelsList.Remove(const Name: TelemetryString): Integer;
begin
Result := IndexOf(Name);
If Result >= 0 then Delete(Result);
end;

//------------------------------------------------------------------------------

procedure TKnownChannelsList.Delete(Index: Integer);
begin
If (Index >= 0) and (Index < Count) then
  begin
    Dispose(PKnownChannel(PtrGetItem(Index)));
    PtrDelete(Index);
  end
else
  raise Exception.Create('TKnownChannelsList.Delete(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TKnownChannelsList.ChannelIndexConfigID(const Name: TelemetryString): TItemID;
var
  Index:  Integer;
begin
Result := 0;
Index := IndexOf(Name);
If Index >= 0 then Result := PKnownChannel(PtrGetItem(Index))^.IndexConfigID;
end;

//------------------------------------------------------------------------------

Function TKnownChannelsList.ChannelNameToID(const Name: TelemetryString): TChannelID;
begin
Result := GetItemID(Name);
end;

//------------------------------------------------------------------------------

Function TKnownChannelsList.ChannelIDToName(ID: TChannelID): TelemetryString;
var
  Index:  Integer;
begin
Index := IndexOf(ID);
If Index >= 0 then Result := PKnownChannel(PtrGetItem(Index))^.Name
  else Result := '';
end;

{==============================================================================}
{------------------------------------------------------------------------------}
{                              TKnownConfigsList                               }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TKnownConfigsList // Implementation                                       }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TKnownConfigsList // Private methods                                      }
{------------------------------------------------------------------------------}

Function TKnownConfigsList.GetKnownConfigPointer(Index: Integer): PKnownConfig;
begin
If (Index >= 0) and (Index < Count) then
  Result := PKnownConfig(PtrGetItem(Index))
else
  raise Exception.Create('TKnownConfigsList.GetKnownConfigPointer(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TKnownConfigsList.GetKnownConfig(Index: Integer): TKnownConfig;
begin
If (Index >= 0) and (Index < Count) then
  Result := GetKnownConfigPointer(Index)^
else
  raise Exception.Create('TKnownConfigsList.GetKnownConfig(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

{------------------------------------------------------------------------------}
{    TKnownConfigsList // Public methods                                       }
{------------------------------------------------------------------------------}

procedure TKnownConfigsList.Clear;
var
  i:  Integer;
begin
For i := (Count - 1) downto 0 do
  Dispose(PKnownConfig(PtrGetItem(i)));
inherited;
end;

//------------------------------------------------------------------------------

Function TKnownConfigsList.IndexOf(const Name: TelemetryString): Integer;
var
  i:  Integer;
begin
Result := -1;
For i := 0 to (Count - 1) do
{$IFDEF AssumeASCIIString}
  If TelemetrySameStrNoConv(PKnownConfig(PtrGetItem(i))^.Name,Name) then
{$ELSE}
  If TelemetrySameStr(PKnownConfig(PtrGetItem(i))^.Name,Name) then
{$ENDIF}
    begin
      Result := i;
      Break;
    end;
end;

Function TKnownConfigsList.IndexOf(ID: TConfigID): Integer;
var
  i:  Integer;
begin
Result := -1;
For i := 0 to (Count - 1) do
  If PKnownConfig(PtrGetItem(i))^.ID = ID then
    begin
      Result := i;
      Break;
    end;
end;

//------------------------------------------------------------------------------

Function TKnownConfigsList.Add(const Name: TelemetryString; ValueType: scs_value_type_t; Indexed: Boolean; Binded: Boolean = False): Integer;
var
  NewConfig:  PKnownConfig;
begin
New(NewConfig);
NewConfig^.Name := Name;
NewConfig^.ID := GetItemId(Name);
NewConfig^.ValueType := ValueType;
NewConfig^.Indexed := Indexed;
NewConfig^.Binded := Binded;
Result := PtrAdd(NewConfig);
If Result < 0 then Dispose(NewConfig);
end;

//------------------------------------------------------------------------------

procedure TKnownConfigsList.ReplaceIndex(Index: Integer; const Name: TelemetryString; ValueType: scs_value_type_t; Indexed: Boolean; Binded: Boolean = False);
var
  KnownConfig:  PKnownConfig;
begin
If (Index >= 0) and (Index < Count) then
  begin
    KnownConfig := PKnownConfig(PtrGetItem(Index));
    KnownConfig^.Name := Name;
    KnownConfig^.ID := GetItemId(Name);
    KnownConfig^.ValueType := ValueType;
    KnownConfig^.Indexed := Indexed;
    KnownConfig^.Binded := Binded;
    PtrReplace(Index,KnownConfig);
  end
else
  raise Exception.Create('TKnownConfigsList.ReplaceIndex(Index,...): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TKnownConfigsList.Replace(const OldConfig, Name: TelemetryString; ValueType: scs_value_type_t; Indexed: Boolean; Binded: Boolean = False): Integer;
begin
Result := IndexOf(OldConfig);
If Result >= 0 then
  ReplaceIndex(Result,Name,ValueType,Indexed,Binded);
end;

//------------------------------------------------------------------------------

Function TKnownConfigsList.Insert(Index: Integer; const Name: TelemetryString; ValueType: scs_value_type_t; Indexed: Boolean; Binded: Boolean = False): Integer;
var
  NewConfig:  PKnownConfig;
begin
If (Index < 0) or (Index >= Count) then
  Result := Add(Name,ValueType,Indexed,Binded)
else
  begin
    New(NewConfig);
    NewConfig^.Name := Name;
    NewConfig^.ID := GetItemId(Name);
    NewConfig^.ValueType := ValueType;
    NewConfig^.Indexed := Indexed;
    NewConfig^.Binded := Binded;
    Result := Index;
    PtrInsert(Index,NewConfig);
  end;
end;

//------------------------------------------------------------------------------

Function TKnownConfigsList.Remove(const Name: TelemetryString): Integer;
begin
Result := IndexOf(Name);
If Result >= 0 then Delete(Result);
end;

//------------------------------------------------------------------------------

procedure TKnownConfigsList.Delete(Index: Integer);
begin
If (Index >= 0) and (Index < Count) then
  begin
    Dispose(PKnownConfig(PtrGetItem(Index)));
    PtrDelete(Index);
  end
else
  raise Exception.Create('TKnownConfigsList.Delete(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TKnownConfigsList.IsBinded(const Name: TelemetryString): Boolean;
var
  Index:  Integer;
begin
Result := False;
Index := IndexOf(Name);
If Index >= 0 then Result := PKnownConfig(PtrGetItem(Index))^.Binded;
end;

//------------------------------------------------------------------------------

Function TKnownConfigsList.IsIndexed(const Name: TelemetryString): Boolean;
var
  Index:  Integer;
begin
Result := False;
Index := IndexOf(Name);
If Index >= 0 then Result := PKnownConfig(PtrGetItem(Index))^.Indexed;
end;

//------------------------------------------------------------------------------

Function TKnownConfigsList.ConfigNameToID(const Name: TelemetryString): TConfigID;
begin
Result := GetItemID(Name);
end;

//------------------------------------------------------------------------------

Function TKnownConfigsList.ConfigIDToName(ID: TConfigID): TelemetryString;
var
  Index:  Integer;
begin
Index := IndexOf(ID);
If Index >= 0 then Result := PKnownConfig(PtrGetItem(Index))^.Name
  else Result := '';
end;

{==============================================================================}
{------------------------------------------------------------------------------}
{                            TRegisteredEventsList                             }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TRegisteredEventsList // Implementation                                   }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TRegisteredEventsList // Private methods                                  }
{------------------------------------------------------------------------------}

Function TRegisteredEventsList.GetEventContext(Index: Integer): PEventContext;
begin
If (Index >= 0) and (Index < Count) then
  Result := PEventContext(PtrGetItem(Index))
else
  raise Exception.Create('TRegisteredEventsList.GetEventContext(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TRegisteredEventsList.GetEventInfo(Index: Integer): TEventInfo;
begin
If (Index >= 0) and (Index < Count) then
  Result := GetEventContext(Index)^.EventInfo
else
  raise Exception.Create('TRegisteredEventsList.GetEventInfo(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

{------------------------------------------------------------------------------}
{    TRegisteredEventsList // Public methods                                   }
{------------------------------------------------------------------------------}

procedure TRegisteredEventsList.Clear;
var
  i:  Integer;
begin
For i := (Count - 1) downto 0 do
  Dispose(PEventContext(PtrGetItem(i)));
inherited;
end;

//------------------------------------------------------------------------------

Function TRegisteredEventsList.IndexOf(Event: scs_event_t): Integer;
var
  i:  Integer;
begin
Result := -1;
For i := 0 to (Count - 1) do
  If PEventContext(PtrGetItem(i))^.EventInfo.Event = Event then
    begin
      Result := i;
      Break;
    end;
end;

Function TRegisteredEventsList.IndexOf(EventContext: PEventContext): Integer;
begin
Result := PtrIndexOf(EventContext);
end;

//------------------------------------------------------------------------------

Function TRegisteredEventsList.Add(EventContext: PEventContext): Integer;
begin
If Assigned(EventContext) then Result := PtrAdd(EventContext)
else
  raise Exception.Create('TRegisteredEventsList.Add(EventContext): Context must not be nil.');
end;

Function TRegisteredEventsList.Add(Recipient: TObject; Event: scs_event_t; Utility: Boolean = False): Integer;
var
  NewEvent: PEventContext;
begin
NewEvent := CreateContext(Recipient,Event,Utility);
Result := Add(NewEvent);
If Result < 0 then FreeContext(NewEvent);
end;

Function TRegisteredEventsList.Add(Event: scs_event_t; Utility: Boolean = False): Integer;
begin
Result := Add(nil,Event,Utility);
end;

//------------------------------------------------------------------------------

Function TRegisteredEventsList.Remove(Event: scs_event_t): Integer;
begin
Result := IndexOf(Event);
If Result >= 0 then Delete(Result);
end;

Function TRegisteredEventsList.Remove(EventContext: PEventContext): Integer;
begin
Result := IndexOf(EventContext);
If Result >= 0 then Delete(Result);
end;

//------------------------------------------------------------------------------

procedure TRegisteredEventsList.Delete(Index: Integer);
begin
If (Index >= 0) and (Index < Count) then
  begin
    Dispose(PEventContext(PtrGetItem(Index)));
    PtrDelete(Index);
  end
else
  raise Exception.Create('TRegisteredEventsList.Delete(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TRegisteredEventsList.CreateContext(Recipient: TObject; Event: scs_event_t; Utility: Boolean = False): PEventContext;
begin
New(Result);
Result^.Recipient := Recipient;
Result^.EventInfo.Event := Event;
Result^.EventInfo.Utility := Utility;
end;

//------------------------------------------------------------------------------

procedure TRegisteredEventsList.FreeContext(var EventContext: PEventContext);
begin
Dispose(EventContext);
EventContext := nil;
end;

{==============================================================================}
{------------------------------------------------------------------------------}
{                           TRegisteredChannelsList                            }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TRegisteredChannelsList // Implementation                                 }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TRegisteredChannelsList // Private methods                                }
{------------------------------------------------------------------------------}

Function TRegisteredChannelsList.GetChannelContext(Index: Integer): PChannelContext;
begin
If (Index >= 0) and (Index < Count) then
  Result := PChannelContext(PtrGetItem(Index))
else
  raise Exception.Create('TRegisteredChannelsList.GetChannelContext(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TRegisteredChannelsList.GetChannelInfo(Index: Integer): TChannelInfo;
begin
If (Index >= 0) and (Index < Count) then
  Result := GetChannelContext(Index)^.ChannelInfo
else
  raise Exception.Create('TRegisteredChannelsList.GetChannelInfo(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

{------------------------------------------------------------------------------}
{    TRegisteredChannelsList // Public methods                                 }
{------------------------------------------------------------------------------}

procedure TRegisteredChannelsList.Clear;
var
  i:  Integer;
begin
For i := (Count - 1) downto 0 do
  Dispose(PChannelContext(PtrGetItem(i)));
inherited;
end;

//------------------------------------------------------------------------------

Function TRegisteredChannelsList.IndexOf(const Name: TelemetryString): Integer;
var
  i:  Integer;
begin
Result := -1;
For i := 0 to (Count - 1) do
{$IFDEF AssumeASCIIString}
  If TelemetrySameStrNoConv(PChannelContext(PtrGetItem(i))^.ChannelInfo.Name,Name) then
{$ELSE}
  If TelemetrySameStr(PChannelContext(PtrGetItem(i))^.ChannelInfo.Name,Name) then
{$ENDIF}
    begin
      Result := i;
      Break;
    end;
end;

Function TRegisteredChannelsList.IndexOf(ID: TChannelID): Integer;
var
  i:  Integer;
begin
Result := -1;
For i := 0 to (Count - 1) do
  If (PChannelContext(PtrGetItem(i))^.ChannelInfo.ID = ID) then
    begin
      Result := i;
      Break;
    end;
end;

Function TRegisteredChannelsList.IndexOf(const Name: TelemetryString; Index: scs_u32_t): Integer;
var
  i:        Integer;
  TempItem: PChannelContext;
begin
Result := -1;
For i := 0 to (Count - 1) do
  begin
    TempItem := PChannelContext(PtrGetItem(i));
  {$IFDEF AssumeASCIIString}
    If TelemetrySameStrNoConv(TempItem^.ChannelInfo.Name,Name)
  {$ELSE}
    If TelemetrySameStr(TempItem^.ChannelInfo.Name,Name)
  {$ENDIF}
    and (TempItem^.ChannelInfo.Index = Index) then
      begin
        Result := i;
        Break;
      end;
  end;
end;

Function TRegisteredChannelsList.IndexOf(ID: TChannelID; Index: scs_u32_t): Integer;
var
  i:        Integer;
  TempItem: PChannelContext;
begin
Result := -1;
For i := 0 to (Count - 1) do
  begin
    TempItem := PChannelContext(PtrGetItem(i));
      If (TempItem^.ChannelInfo.ID = ID) and (TempItem^.ChannelInfo.Index = Index) then
        begin
          Result := i;
          Break;
        end;
  end;
end;

Function TRegisteredChannelsList.IndexOf(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t): Integer;
var
  i:        Integer;
  TempItem: PChannelContext;
begin
Result := -1;
For i := 0 to (Count - 1) do
  begin
    TempItem := PChannelContext(PtrGetItem(i));
  {$IFDEF AssumeASCIIString}
    If TelemetrySameStrNoConv(TempItem^.ChannelInfo.Name,Name)
  {$ELSE}
    If TelemetrySameStr(TempItem^.ChannelInfo.Name,Name)
  {$ENDIF}
    and (TempItem^.ChannelInfo.Index = Index) and (TempItem^.ChannelInfo.ValueType = ValueType) then
      begin
        Result := i;
        Break;
      end;
  end;
end;

Function TRegisteredChannelsList.IndexOf(ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t): Integer;
var
  i:        Integer;
  TempItem: PChannelContext;
begin
Result := -1;
For i := 0 to (Count - 1) do
  begin
    TempItem := PChannelContext(PtrGetItem(i));
    If (TempItem^.ChannelInfo.ID = ID) and (TempItem^.ChannelInfo.Index = Index) and
      (TempItem^.ChannelInfo.ValueType = ValueType) then
      begin
        Result := i;
        Break;
      end;
  end;
end;

Function TRegisteredChannelsList.IndexOf(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t): Integer;
var
  i:        Integer;
  TempItem: PChannelContext;
begin
Result := -1;
For i := 0 to (Count - 1) do
  begin
    TempItem := PChannelContext(PtrGetItem(i));
  {$IFDEF AssumeASCIIString}
    If TelemetrySameStrNoConv(TempItem^.ChannelInfo.Name,Name)
  {$ELSE}
    If TelemetrySameStr(TempItem^.ChannelInfo.Name,Name)
  {$ENDIF}
    and (TempItem^.ChannelInfo.Index = Index) and (TempItem^.ChannelInfo.ValueType = ValueType)
    and (TempItem^.ChannelInfo.Flags = Flags) then
      begin
        Result := i;
        Break;
      end;
  end;
end;

Function TRegisteredChannelsList.IndexOf(ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t): Integer;
var
  i:        Integer;
  TempItem: PChannelContext;
begin
Result := -1;
For i := 0 to (Count - 1) do
  begin
    TempItem := PChannelContext(PtrGetItem(i));
    If (TempItem^.ChannelInfo.ID = ID) and (TempItem^.ChannelInfo.Index = Index) and
      (TempItem^.ChannelInfo.ValueType = ValueType) and (TempItem^.ChannelInfo.Flags = Flags) then
      begin
        Result := i;
        Break;
      end;
  end;
end;

Function TRegisteredChannelsList.IndexOf(ChannelContext: PChannelContext): Integer;
begin
Result := PtrIndexOf(ChannelContext);
end;

//------------------------------------------------------------------------------

Function TRegisteredChannelsList.Add(ChannelContext: PChannelContext): Integer;
begin
If Assigned(ChannelContext) then Result := PtrAdd(ChannelContext)
else
  raise Exception.Create('TRegisteredChannelsList.Add(ChannelContext): Context must not be nil.');
end;

Function TRegisteredChannelsList.Add(Recipient: TObject; const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t = SCS_TELEMETRY_CHANNEL_FLAG_none; IndexConfigID: TItemID = 0): Integer;
var
  NewChannel: PChannelContext;
begin
NewChannel := CreateContext(Recipient,Name,Index,ValueType,Flags,IndexConfigID);
Result := Add(NewChannel);
If Result < 0 then FreeContext(NewChannel);
end;

Function TRegisteredChannelsList.Add(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t = SCS_TELEMETRY_CHANNEL_FLAG_none; IndexConfigID: TItemID = 0): Integer;
begin
Result := Add(nil,Name,Index,ValueType,Flags,IndexConfigID);
end;

//------------------------------------------------------------------------------

Function TRegisteredChannelsList.Remove(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t): Integer;
begin
Result := IndexOf(Name,Index,ValueType);
If Result >= 0 then Delete(Result);
end;

Function TRegisteredChannelsList.Remove(ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t): Integer;
begin
Result := IndexOf(ID,Index,ValueType);
If Result >= 0 then Delete(Result);
end;

Function TRegisteredChannelsList.Remove(ChannelContext: PChannelContext): Integer;
begin
Result := IndexOf(ChannelContext);
If Result >= 0 then Delete(Result);
end;

//------------------------------------------------------------------------------

procedure TRegisteredChannelsList.Delete(Index: Integer);
begin
If (Index >= 0) and (Index < Count) then
  begin
    Dispose(PChannelContext(PtrGetItem(Index)));
    PtrDelete(Index);
  end
else
  raise Exception.Create('TRegisteredChannelsList.Delete(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TRegisteredChannelsList.CreateContext(Recipient: TObject; const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t = SCS_TELEMETRY_CHANNEL_FLAG_none; IndexConfigID: TItemID = 0): PChannelContext;
begin
New(Result);
Result^.Recipient := Recipient;
Result^.ChannelInfo.Name := Name;
Result^.ChannelInfo.ID := GetItemID(Name);
Result^.ChannelInfo.Index := Index;
Result^.ChannelInfo.ValueType := ValueType;
Result^.ChannelInfo.Flags := Flags;
Result^.ChannelInfo.IndexConfigID := IndexConfigID;
end;

//------------------------------------------------------------------------------

procedure TRegisteredChannelsList.FreeContext(var ChannelContext: PChannelContext);
begin
Dispose(ChannelContext);
ChannelContext := nil;
end;

{==============================================================================}
{------------------------------------------------------------------------------}
{                              TStoredConfigsList                              }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TStoredConfigsList // Implementation                                      }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TStoredConfigsList // Private methods                                     }
{------------------------------------------------------------------------------}

Function TStoredConfigsList.GetStoredConfigPointer(Index: Integer): PStoredConfig;
begin
If (Index >= 0) and (Index < Count) then
  Result := PStoredConfig(PtrGetItem(Index))
else
  raise Exception.Create('TStoredConfigsList.GetStoredConfigPointer(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TStoredConfigsList.GetStoredConfig(Index: Integer): TStoredConfig;
begin
If (Index >= 0) and (Index < Count) then
  Result := GetStoredConfigPointer(Index)^
else
  raise Exception.Create('TStoredConfigsList.GetStoredConfig(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

{------------------------------------------------------------------------------}
{    TStoredConfigsList // Public methods                                      }
{------------------------------------------------------------------------------}

procedure TStoredConfigsList.Clear;
var
  i:  Integer;
begin
For i := (Count - 1) downto 0 do
  Dispose(PStoredConfig(PtrGetItem(i)));
inherited;
end;

//------------------------------------------------------------------------------

Function TStoredConfigsList.IndexOf(const Name: TelemetryString): Integer;
var
  i:  Integer;
begin
Result := -1;
For i := 0 to (Count - 1) do
{$IFDEF AssumeASCIIString}
  If TelemetrySameStrNoConv(PStoredConfig(PtrGetItem(i))^.Name,Name) then
{$ELSE}
  If TelemetrySameStr(PStoredConfig(PtrGetItem(i))^.Name,Name) then
{$ENDIF}
    begin
      Result := i;
      Break;
    end;
end;

Function TStoredConfigsList.IndexOf(ID: TConfigID): Integer;
var
  i:  Integer;
begin
Result := -1;
For i := 0 to (Count - 1) do
  If (PStoredConfig(PtrGetItem(i))^.ID = ID) then
    begin
      Result := i;
      Break;
    end;
end;

Function TStoredConfigsList.IndexOf(const Name: TelemetryString; Index: scs_u32_t): Integer;
var
  i:  Integer;
begin
Result := -1;
For i := 0 to (Count - 1) do
{$IFDEF AssumeASCIIString}
  If TelemetrySameStrNoConv(PStoredConfig(PtrGetItem(i))^.Name,Name)
{$ELSE}
  If TelemetrySameStr(PStoredConfig(PtrGetItem(i))^.Name,Name)
{$ENDIF}
  and (PStoredConfig(PtrGetItem(i))^.Index = Index) then
    begin
      Result := i;
      Break;
    end;
end;

Function TStoredConfigsList.IndexOf(ID: TConfigID; Index: scs_u32_t): Integer;
var
  i:  Integer;
begin
Result := -1;
For i := 0 to (Count - 1) do
  If (PStoredConfig(PtrGetItem(i))^.ID = ID) and
    (PStoredConfig(PtrGetItem(i))^.Index = Index) then
    begin
      Result := i;
      Break;
    end;
end;

//------------------------------------------------------------------------------

Function TStoredConfigsList.Add(const Name: TelemetryString; Index: scs_u32_t; Value: scs_value_localized_t; Binded: Boolean = False): Integer;
var
  NewConfig: PStoredConfig;
begin
New(NewConfig);
NewConfig^.Name := Name;
NewConfig^.ID := GetItemID(Name);
NewConfig^.Index := Index;
NewConfig^.Value := Value;
NewConfig^.Binded := Binded;
Result := PtrAdd(NewConfig);
If Result < 0 then Dispose(NewConfig);
end;

Function TStoredConfigsList.Add(const Name: TelemetryString; Index: scs_u32_t; Value: p_scs_value_t; Binded: Boolean = False): Integer;
var
  EmptyValue: scs_value_localized_t;
begin
EmptyValue.ValueType := SCS_VALUE_TYPE_INVALID;
If Assigned(Value) then Result := Add(Name,Index,scs_value_localized(Value^),Binded)
  else Result := Add(Name,Index,EmptyValue,Binded);
end;

//------------------------------------------------------------------------------

Function TStoredConfigsList.Remove(const Name: TelemetryString; Index: scs_u32_t = SCS_U32_NIL): Integer;
begin
Result := IndexOf(Name,Index);
If Result >= 0 then Delete(Result);
end;

Function TStoredConfigsList.Remove(ID: TChannelID; Index: scs_u32_t = SCS_U32_NIL): Integer;
begin
Result := IndexOf(ID,Index);
If Result >= 0 then Delete(Result);
end;

//------------------------------------------------------------------------------

procedure TStoredConfigsList.Delete(Index: Integer);
begin
If (Index >= 0) and (Index < Count) then
  begin
    Dispose(PStoredConfig(PtrGetItem(Index)));
    PtrDelete(Index);
  end
else
  raise Exception.Create('TStoredConfigsList.Delete(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

//------------------------------------------------------------------------------

Function TStoredConfigsList.ChangeConfigValue(const Name: TelemetryString; Index: scs_u32_t; Value: scs_value_localized_t): Integer;
begin
Result := IndexOf(Name,Index);
If Result >= 0 then
  begin
    PStoredConfig(PtrGetItem(Result))^.Value := Value;
    DoChange;
  end;
end;

Function TStoredConfigsList.ChangeConfigValue(ID: TConfigID; Index: scs_u32_t; Value: scs_value_localized_t): Integer;
begin
Result := IndexOf(ID,Index);
If Result >= 0 then
  begin
    PStoredConfig(PtrGetItem(Result))^.Value := Value;
    DoChange;
  end;
end;

{==============================================================================}
{------------------------------------------------------------------------------}
{                           TStoredChannelsValuesList                          }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TStoredChannelsValuesList // Implementation                               }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TStoredChannelsValuesList // Private methods                              }
{------------------------------------------------------------------------------}

Function TStoredChannelsValuesList.GetStoredChannelValue(Index: Integer): TStoredChannel;
begin
If (Index >= 0) and (Index < Count) then
  Result := PStoredChannelMasterID(PtrGetItem(Index))^.StoredChannel
else
  raise Exception.Create('TStoredChannelsValuesList.GetStoredChannelValue(Index): Index (' +
                         IntToStr(Index) + ') out of bounds.');
end;

{------------------------------------------------------------------------------}
{    TStoredChannelsValuesList // Protected methods                            }
{------------------------------------------------------------------------------}

Function TStoredChannelsValuesList.GetInsertIndex(MasterID: TMasterID): Integer;
var
  Index:    Integer;
  MinIndex: Integer;
  MaxIndex: Integer;
begin
Result := -1;
If Count > 0 then
  begin
    Index := -1;
    MinIndex := 0;
    MaxIndex := Count - 1;
    while MaxIndex >= MinIndex do
      begin
        Index := ((MaxIndex - MinIndex) shr 1) + MinIndex;
        If PStoredChannelMasterID(PtrGetItem(Index))^.MasterID < MasterID then MinIndex := Index + 1
          else If PStoredChannelMasterID(PtrGetItem(Index))^.MasterID > MasterID then MaxIndex := Index - 1;
      end;
    If Index >= 0 then
      If PStoredChannelMasterID(PtrGetItem(Index))^.MasterID > MasterID then Result := Index
        else Result := Index + 1;
  end;
end;

{------------------------------------------------------------------------------}
{    TStoredChannelsValuesList // Public methods                               }
{------------------------------------------------------------------------------}

procedure TStoredChannelsValuesList.Clear;
var
  i:  Integer;
begin
For i := (Count - 1) downto 0 do
  Dispose(PStoredChannelMasterID(PtrGetItem(i)));
inherited;
end;

//------------------------------------------------------------------------------

Function TStoredChannelsValuesList.IndexOf(MasterID: TMasterID): Integer;
var
  Index:    Integer;
  MinIndex: Integer;
  MaxIndex: Integer;
begin
Result := -1;
MinIndex := 0;
MaxIndex := Count - 1;
while MaxIndex >= MinIndex do
  begin
    Index := ((MaxIndex - MinIndex) shr 1) + MinIndex;
    If PStoredChannelMasterID(PtrGetItem(Index))^.MasterID < MasterID then MinIndex := Index + 1
      else If PStoredChannelMasterID(PtrGetItem(Index))^.MasterID > MasterID then MaxIndex := Index - 1
        else
          begin
            Result := Index;
            Break;
          end;
   end;
end;

Function TStoredChannelsValuesList.IndexOf(ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t): Integer;
begin
Result := IndexOf(GetMasterID(ID,Index,ValueType));
end;

Function TStoredChannelsValuesList.IndexOf(const Name: TelemetryString; Index: scs_u32_t; ValueType: scs_value_type_t): Integer;
begin
Result := IndexOf(GetItemID(Name),Index,ValueType);
end;

//------------------------------------------------------------------------------

Function TStoredChannelsValuesList.StoreChannelValue(const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; Value: p_scs_value_t): Integer;
var
  MasterID:       TMasterID;
  StoredChannel:  PStoredChannelMasterID;
begin
Result := -1;
If Assigned(Value) then
  begin
    MasterID := GetMasterID(ID,Index,Value^._type);
    Result := IndexOf(MasterID);
    If Result >= 0 then
      begin
        StoredChannel := PStoredChannelMasterID(PtrGetItem(Result));
        StoredChannel^.MasterID := MasterID;
        StoredChannel^.StoredChannel.Name := Name;
        StoredChannel^.StoredChannel.ID := ID;
        StoredChannel^.StoredChannel.Index := Index;
        StoredChannel^.StoredChannel.Value := scs_value_localized(Value^);
        DoChange;
      end
    else
      begin
        New(StoredChannel);
        StoredChannel^.MasterID := MasterID;
        StoredChannel^.StoredChannel.Name := Name;
        StoredChannel^.StoredChannel.ID := ID;
        StoredChannel^.StoredChannel.Index := Index;
        StoredChannel^.StoredChannel.Value := scs_value_localized(Value^);
        Result := GetInsertIndex(MasterID);
        If Result >= 0 then
          PtrInsert(Result,StoredChannel)
        else
          Result := PtrAdd(StoredChannel);
        If Result < 0 then Dispose(StoredChannel);
      end;
  end;
end;

end.
