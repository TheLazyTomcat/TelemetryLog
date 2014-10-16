{$IFDEF DeclarationPart}
{==============================================================================}
{------------------------------------------------------------------------------}
{                           Muticast events managers                           }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TMulticastLogEvent // Class declaration                                   }
{==============================================================================}
{
  @abstract(Class used to manage multicast event called when recipient writes
  to game log.)

@member(IndexOf
    Returns index at which the handler is stored in internal list of handlers.

    @param Handler Handler routine whose index is requested.

    @returns Index of passed handler in the list, -1 when not found..)

@member(Add
    Adds passed handler to internal list of handlers. When @code(AllowDuplicity)
    is set to @true, the handler is added to the list even when it is already
    stored, when set to @false, no new list item is added and result contains
    index of previous occurrence of passed handler routine in the list.

    @param Handler        New handler routine to be added.
    @param(AllowDuplicity Denotes whether passed routine can be stored in
                          internal list when already in it.)
                          
    @returns(Index at which the added routine is stored. -1 when storing has
             failed.))

@member(Remove
    Removes first or all occurrences, depending on @code(RemoveAll) value, of
    passed routine from internal list of handlers.

    @param Handler   Routine to be removed from the list.
    @param(RemoveAll Determines whether to @noAutoLink(remove) only first
                     occurence of passed handler or all of them.)

    @returns(Index at which the removed item was stored in the list, -1 when
             passed routine was not found.))

@member(Call
    Calls all stored handler routines with the same parameters as passed to this
    method.)
}
  TMulticastLogEvent = class(TMulticastEvent)
  public
    Function IndexOf(const Handler: TLogEvent): Integer; reintroduce;
    Function Add(const Handler: TLogEvent; AllowDuplicity: Boolean = False): Integer; reintroduce;
    Function Remove(const Handler: TLogEvent; RemoveAll: Boolean = True): Integer; reintroduce;
    procedure Call(Sender: TObject; LogType: scs_log_type_t; const LogText: String); reintroduce;
  end;

{==============================================================================}
{    TMulticastEventRegisterEvent // Class declaration                         }
{==============================================================================}
{
  @abstract(Class used to manage multicast event called when telemetry event is
  registered or unregistered.)

@member(IndexOf
    Returns index at which the handler is stored in internal list of handlers.

    @param Handler Handler routine whose index is requested.

    @returns Index of passed handler in the list, -1 when not found..)

@member(Add
    Adds passed handler to internal list of handlers. When @code(AllowDuplicity)
    is set to @true, the handler is added to the list even when it is already
    stored, when set to @false, no new list item is added and result contains
    index of previous occurrence of passed handler routine in the list.

    @param Handler        New handler routine to be added.
    @param(AllowDuplicity Denotes whether passed routine can be stored in
                          internal list when already in it.)
                          
    @returns(Index at which the added routine is stored. -1 when storing has
             failed.))

@member(Remove
    Removes first or all occurrences, depending on @code(RemoveAll) value, of
    passed routine from internal list of handlers.

    @param Handler   Routine to be removed from the list.
    @param(RemoveAll Determines whether to @noAutoLink(remove) only first
                     occurence of passed handler or all of them.)

    @returns(Index at which the removed item was stored in the list, -1 when
             passed routine was not found.))

@member(Call
    Calls all stored handler routines with the same parameters as passed to this
    method.)
}
  TMulticastEventRegisterEvent = class(TMulticastEvent)
  public
    Function IndexOf(const Handler: TEventRegisterEvent): Integer; reintroduce;
    Function Add(const Handler: TEventRegisterEvent; AllowDuplicity: Boolean = False): Integer; reintroduce;
    Function Remove(const Handler: TEventRegisterEvent; RemoveAll: Boolean = True): Integer; reintroduce;
    procedure Call(Sender: TObject; Event: scs_event_t); reintroduce;
  end;

{==============================================================================}
{    TMulticastEventEvent // Class declaration                                 }
{==============================================================================}
{
  @abstract(Class used to manage multicast event called when telemetry when
  telemetery event occurs.)

@member(IndexOf
    Returns index at which the handler is stored in internal list of handlers.

    @param Handler Handler routine whose index is requested.

    @returns Index of passed handler in the list, -1 when not found..)

@member(Add
    Adds passed handler to internal list of handlers. When @code(AllowDuplicity)
    is set to @true, the handler is added to the list even when it is already
    stored, when set to @false, no new list item is added and result contains
    index of previous occurrence of passed handler routine in the list.

    @param Handler        New handler routine to be added.
    @param(AllowDuplicity Denotes whether passed routine can be stored in
                          internal list when already in it.)
                          
    @returns(Index at which the added routine is stored. -1 when storing has
             failed.))

@member(Remove
    Removes first or all occurrences, depending on @code(RemoveAll) value, of
    passed routine from internal list of handlers.

    @param Handler   Routine to be removed from the list.
    @param(RemoveAll Determines whether to @noAutoLink(remove) only first
                     occurence of passed handler or all of them.)

    @returns(Index at which the removed item was stored in the list, -1 when
             passed routine was not found.))

@member(Call
    Calls all stored handler routines with the same parameters as passed to this
    method.)
}
  TMulticastEventEvent = class(TMulticastEvent)
  public
    Function IndexOf(const Handler: TEventEvent): Integer; reintroduce;
    Function Add(const Handler: TEventEvent; AllowDuplicity: Boolean = False): Integer; reintroduce;
    Function Remove(const Handler: TEventEvent; RemoveAll: Boolean = True): Integer; reintroduce;
    procedure Call(Sender: TObject; Event: scs_event_t; Data: Pointer); reintroduce;
  end;

{==============================================================================}
{    TMulticastChannelRegisterEvent // Class declaration                       }
{==============================================================================}
{
  @abstract(Class used to manage multicast event called when telemetry channel
  is registered.)

@member(IndexOf
    Returns index at which the handler is stored in internal list of handlers.

    @param Handler Handler routine whose index is requested.

    @returns Index of passed handler in the list, -1 when not found..)

@member(Add
    Adds passed handler to internal list of handlers. When @code(AllowDuplicity)
    is set to @true, the handler is added to the list even when it is already
    stored, when set to @false, no new list item is added and result contains
    index of previous occurrence of passed handler routine in the list.

    @param Handler        New handler routine to be added.
    @param(AllowDuplicity Denotes whether passed routine can be stored in
                          internal list when already in it.)
                          
    @returns(Index at which the added routine is stored. -1 when storing has
             failed.))

@member(Remove
    Removes first or all occurrences, depending on @code(RemoveAll) value, of
    passed routine from internal list of handlers.

    @param Handler   Routine to be removed from the list.
    @param(RemoveAll Determines whether to @noAutoLink(remove) only first
                     occurence of passed handler or all of them.)

    @returns(Index at which the removed item was stored in the list, -1 when
             passed routine was not found.))

@member(Call
    Calls all stored handler routines with the same parameters as passed to this
    method.)
}
  TMulticastChannelRegisterEvent = class(TMulticastEvent)
  public
    Function IndexOf(const Handler: TChannelRegisterEvent): Integer; reintroduce;
    Function Add(const Handler: TChannelRegisterEvent; AllowDuplicity: Boolean = False): Integer; reintroduce;
    Function Remove(const Handler: TChannelRegisterEvent; RemoveAll: Boolean = True): Integer; reintroduce;
    procedure Call(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t); reintroduce;
  end;

{==============================================================================}
{    TMulticastChannelUnregisterEvent // Class declaration                     }
{==============================================================================}
{
  @abstract(Class used to manage multicast event called when telemetry channel
  is unregistered.)

@member(IndexOf
    Returns index at which the handler is stored in internal list of handlers.

    @param Handler Handler routine whose index is requested.

    @returns Index of passed handler in the list, -1 when not found..)

@member(Add
    Adds passed handler to internal list of handlers. When @code(AllowDuplicity)
    is set to @true, the handler is added to the list even when it is already
    stored, when set to @false, no new list item is added and result contains
    index of previous occurrence of passed handler routine in the list.

    @param Handler        New handler routine to be added.
    @param(AllowDuplicity Denotes whether passed routine can be stored in
                          internal list when already in it.)
                          
    @returns(Index at which the added routine is stored. -1 when storing has
             failed.))

@member(Remove
    Removes first or all occurrences, depending on @code(RemoveAll) value, of
    passed routine from internal list of handlers.

    @param Handler   Routine to be removed from the list.
    @param(RemoveAll Determines whether to @noAutoLink(remove) only first
                     occurence of passed handler or all of them.)

    @returns(Index at which the removed item was stored in the list, -1 when
             passed routine was not found.))

@member(Call
    Calls all stored handler routines with the same parameters as passed to this
    method.)
}
  TMulticastChannelUnregisterEvent = class(TMulticastEvent)
  public
    Function IndexOf(const Handler: TChannelUnregisterEvent): Integer; reintroduce;
    Function Add(const Handler: TChannelUnregisterEvent; AllowDuplicity: Boolean = False): Integer; reintroduce;
    Function Remove(const Handler: TChannelUnregisterEvent; RemoveAll: Boolean = True): Integer; reintroduce;
    procedure Call(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t); reintroduce;
  end;

{==============================================================================}
{    TMulticastChannelEvent // Class declaration                               }
{==============================================================================}
{
  @abstract(Class used to manage multicast event called when telemetery channel
  callback occurs.)

@member(IndexOf
    Returns index at which the handler is stored in internal list of handlers.

    @param Handler Handler routine whose index is requested.

    @returns Index of passed handler in the list, -1 when not found..)

@member(Add
    Adds passed handler to internal list of handlers. When @code(AllowDuplicity)
    is set to @true, the handler is added to the list even when it is already
    stored, when set to @false, no new list item is added and result contains
    index of  previous occurrence of passed handler routine in the list.

    @param Handler        New handler routine to be added.
    @param(AllowDuplicity Denotes whether passed routine can be stored in
                          internal list when already in it.)
                          
    @returns(Index at which the added routine is stored. -1 when storing has
             failed.))

@member(Remove
    Removes first or all occurrences, depending on @code(RemoveAll) value, of
    passed routine from internal list of handlers.

    @param Handler   Routine to be removed from the list.
    @param(RemoveAll Determines whether to @noAutoLink(remove) only first
                     occurence of passed handler or all of them.)

    @returns(Index at which the removed item was stored in the list, -1 when
             passed routine was not found.))

@member(Call
    Calls all stored handler routines with the same parameters as passed to this
    method.)
}
  TMulticastChannelEvent = class(TMulticastEvent)
  public
    Function IndexOf(const Handler: TChannelEvent): Integer; reintroduce;
    Function Add(const Handler: TChannelEvent; AllowDuplicity: Boolean = False): Integer; reintroduce;
    Function Remove(const Handler: TChannelEvent; RemoveAll: Boolean = True): Integer; reintroduce;
    procedure Call(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; Value: p_scs_value_t); reintroduce;
  end;

{==============================================================================}
{    TMulticastConfigEvent // Class declaration                                }
{==============================================================================}
{
  @abstract(Class used to manage multicast event called when config is parsed
  from configuration telemetry event.)

@member(IndexOf
    Returns index at which the handler is stored in internal list of handlers.

    @param Handler Handler routine whose index is requested.

    @returns Index of passed handler in the list, -1 when not found..)

@member(Add
    Adds passed handler to internal list of handlers. When @code(AllowDuplicity)
    is set to @true, the handler is added to the list even when it is already
    stored, when set to @false, no new list item is added and result contains
    index of  previous occurrence of passed handler routine in the list.

    @param Handler        New handler routine to be added.
    @param(AllowDuplicity Denotes whether passed routine can be stored in
                          internal list when already in it.)
                          
    @returns(Index at which the added routine is stored. -1 when storing has
             failed.))

@member(Remove
    Removes first or all occurrences, depending on @code(RemoveAll) value, of
    passed routine from internal list of handlers.

    @param Handler   Routine to be removed from the list.
    @param(RemoveAll Determines whether to @noAutoLink(remove) only first
                     occurence of passed handler or all of them.)

    @returns(Index at which the removed item was stored in the list, -1 when
             passed routine was not found.))

@member(Call
    Calls all stored handler routines with the same parameters as passed to this
    method.)
}
  TMulticastConfigEvent = class(TMulticastEvent)
  public
    Function IndexOf(const Handler: TConfigEvent): Integer; reintroduce;
    Function Add(const Handler: TConfigEvent; AllowDuplicity: Boolean = False): Integer; reintroduce;
    Function Remove(const Handler: TConfigEvent; RemoveAll: Boolean = True): Integer; reintroduce;
    procedure Call(Sender: TObject; const Name: TelemetryString; ID: TConfigID; Index: scs_u32_t; Value: scs_value_localized_t); reintroduce;
  end;
{$ENDIF}

{$IFDEF ImplementationPart}
{==============================================================================}
{------------------------------------------------------------------------------}
{                           Muticast events managers                           }
{------------------------------------------------------------------------------}
{==============================================================================}

{==============================================================================}
{    TMulticastLogEvent // Class implementation                                }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TMulticastLogEvent // Public methods                                      }
{------------------------------------------------------------------------------}

Function TMulticastLogEvent.IndexOf(const Handler: TLogEvent): Integer;
begin
Result := inherited IndexOf(TEvent(Handler));
end;

//------------------------------------------------------------------------------

Function TMulticastLogEvent.Add(const Handler: TLogEvent; AllowDuplicity: Boolean = False): Integer;
begin
Result := inherited Add(TEvent(Handler),AllowDuplicity);
end;

//------------------------------------------------------------------------------

Function TMulticastLogEvent.Remove(const Handler: TLogEvent; RemoveAll: Boolean = True): Integer;
begin
Result := inherited Remove(TEvent(Handler),RemoveAll);
end;

//------------------------------------------------------------------------------

procedure TMulticastLogEvent.Call(Sender: TObject; LogType: scs_log_type_t; const LogText: String);
var
  i:  Integer;
begin
For i := 0 to Pred(Count) do TLogEvent(Methods[i])(Sender,LogType,LogText);
end;

{==============================================================================}
{    TMulticastEventRegisterEvent // Class implementation                      }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TMulticastEventRegisterEvent // Public methods                            }
{------------------------------------------------------------------------------}

Function TMulticastEventRegisterEvent.IndexOf(const Handler: TEventRegisterEvent): Integer;
begin
Result := inherited IndexOf(TEvent(Handler));
end;

//------------------------------------------------------------------------------

Function TMulticastEventRegisterEvent.Add(const Handler: TEventRegisterEvent; AllowDuplicity: Boolean = False): Integer;
begin
Result := inherited Add(TEvent(Handler),AllowDuplicity);
end;

//------------------------------------------------------------------------------

Function TMulticastEventRegisterEvent.Remove(const Handler: TEventRegisterEvent; RemoveAll: Boolean = True): Integer;
begin
Result := inherited Remove(TEvent(Handler),RemoveAll);
end;

//------------------------------------------------------------------------------

procedure TMulticastEventRegisterEvent.Call(Sender: TObject; Event: scs_event_t);
var
  i:  Integer;
begin
For i := 0 to Pred(Count) do TEventRegisterEvent(Methods[i])(Sender,Event);
end;

{==============================================================================}
{    TMulticastEventEvent // Class implementation                              }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TMulticastEventEvent // Public methods                                    }
{------------------------------------------------------------------------------}

Function TMulticastEventEvent.IndexOf(const Handler: TEventEvent): Integer;
begin
Result := inherited IndexOf(TEvent(Handler));
end;

//------------------------------------------------------------------------------

Function TMulticastEventEvent.Add(const Handler: TEventEvent; AllowDuplicity: Boolean = False): Integer;
begin
Result := inherited Add(TEvent(Handler),AllowDuplicity);
end;

//------------------------------------------------------------------------------

Function TMulticastEventEvent.Remove(const Handler: TEventEvent; RemoveAll: Boolean = True): Integer;
begin
Result := inherited Remove(TEvent(Handler),RemoveAll);
end;

//------------------------------------------------------------------------------

procedure TMulticastEventEvent.Call(Sender: TObject; Event: scs_event_t; Data: Pointer);
var
  i:  Integer;
begin
For i := 0 to Pred(Count) do TEventEvent(Methods[i])(Sender,Event,Data);
end;

{==============================================================================}
{    TMulticastChannelRegisterEvent // Class implementation                    }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TMulticastChannelRegisterEvent // Public methods                          }
{------------------------------------------------------------------------------}

Function TMulticastChannelRegisterEvent.IndexOf(const Handler: TChannelRegisterEvent): Integer;
begin
Result := inherited IndexOf(TEvent(Handler));
end;

//------------------------------------------------------------------------------

Function TMulticastChannelRegisterEvent.Add(const Handler: TChannelRegisterEvent; AllowDuplicity: Boolean = False): Integer;
begin
Result := inherited Add(TEvent(Handler),AllowDuplicity);
end;

//------------------------------------------------------------------------------

Function TMulticastChannelRegisterEvent.Remove(const Handler: TChannelRegisterEvent; RemoveAll: Boolean = True): Integer;
begin
Result := inherited Remove(TEvent(Handler),RemoveAll);
end;

//------------------------------------------------------------------------------

procedure TMulticastChannelRegisterEvent.Call(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t; Flags: scs_u32_t);
var
  i:  Integer;
begin
For i := 0 to Pred(Count) do TChannelRegisterEvent(Methods[i])(Sender,Name,ID,Index,ValueType,Flags);
end;

{==============================================================================}
{    TMulticastChannelUnregisterEvent // Class implementation                  }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TMulticastChannelUnregisterEvent // Public methods                        }
{------------------------------------------------------------------------------}

Function TMulticastChannelUnregisterEvent.IndexOf(const Handler: TChannelUnregisterEvent): Integer;
begin
Result := inherited IndexOf(TEvent(Handler));
end;

//------------------------------------------------------------------------------

Function TMulticastChannelUnregisterEvent.Add(const Handler: TChannelUnregisterEvent; AllowDuplicity: Boolean = False): Integer;
begin
Result := inherited Add(TEvent(Handler),AllowDuplicity);
end;

//------------------------------------------------------------------------------

Function TMulticastChannelUnregisterEvent.Remove(const Handler: TChannelUnregisterEvent; RemoveAll: Boolean = True): Integer;
begin
Result := inherited Remove(TEvent(Handler),RemoveAll);
end;

//------------------------------------------------------------------------------

procedure TMulticastChannelUnregisterEvent.Call(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; ValueType: scs_value_type_t);
var
  i:  Integer;
begin
For i := 0 to Pred(Count) do TChannelUnregisterEvent(Methods[i])(Sender,Name,ID,Index,ValueType);
end;

{==============================================================================}
{    TMulticastChannelEvent // Class implementation                            }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TMulticastChannelEvent // Public methods                                  }
{------------------------------------------------------------------------------}

Function TMulticastChannelEvent.IndexOf(const Handler: TChannelEvent): Integer;
begin
Result := inherited IndexOf(TEvent(Handler));
end;

//------------------------------------------------------------------------------

Function TMulticastChannelEvent.Add(const Handler: TChannelEvent; AllowDuplicity: Boolean = False): Integer;
begin
Result := inherited Add(TEvent(Handler),AllowDuplicity);
end;

//------------------------------------------------------------------------------

Function TMulticastChannelEvent.Remove(const Handler: TChannelEvent; RemoveAll: Boolean = True): Integer;
begin
Result := inherited Remove(TEvent(Handler),RemoveAll);
end;

//------------------------------------------------------------------------------

procedure TMulticastChannelEvent.Call(Sender: TObject; const Name: TelemetryString; ID: TChannelID; Index: scs_u32_t; Value: p_scs_value_t);
var
  i:  Integer;
begin
For i := 0 to Pred(Count) do TChannelEvent(Methods[i])(Sender,Name,ID,Index,Value);
end;

{==============================================================================}
{    TMulticastConfigEvent // Class implementation                             }
{==============================================================================}

{------------------------------------------------------------------------------}
{    TMulticastConfigEvent // Public methods                                   }
{------------------------------------------------------------------------------}

Function TMulticastConfigEvent.IndexOf(const Handler: TConfigEvent): Integer;
begin
Result := inherited IndexOf(TEvent(Handler));
end;

//------------------------------------------------------------------------------

Function TMulticastConfigEvent.Add(const Handler: TConfigEvent; AllowDuplicity: Boolean = False): Integer;
begin
Result := inherited Add(TEvent(Handler),AllowDuplicity);
end;

//------------------------------------------------------------------------------

Function TMulticastConfigEvent.Remove(const Handler: TConfigEvent; RemoveAll: Boolean = True): Integer;
begin
Result := inherited Remove(TEvent(Handler),RemoveAll);
end;

//------------------------------------------------------------------------------

procedure TMulticastConfigEvent.Call(Sender: TObject; const Name: TelemetryString; ID: TConfigID; Index: scs_u32_t; Value: scs_value_localized_t);
var
  i:  Integer;
begin
For i := 0 to Pred(Count) do TConfigEvent(Methods[i])(Sender,Name,ID,Index,Value);
end;
{$ENDIF}
