library Telemetry;

uses
  FastMM4         in 'Libs\FastMM\FastMM4.pas',
  FastMM4Messages in 'Libs\FastMM\FastMM4Messages.pas',
  SysUtils,

  SCS_Telemetry_Condensed in 'Libs\SCS_Telemetry_Condensed.pas',

  CRC32          in 'Libs\Telemetry Library\Libs\CRC32.pas',
  MD5            in 'Libs\Telemetry Library\Libs\MD5.pas',
  MulticastEvent in 'Libs\Telemetry Library\Libs\MulticastEvent.pas',
  SimpleLog      in 'Libs\Telemetry Library\Libs\SimpleLog.pas',

  TelemetryCommon          in 'Libs\Telemetry Library\TelemetryCommon.pas',
  TelemetryIDs             in 'Libs\Telemetry Library\TelemetryIDs.pas',
  TelemetryConversions     in 'Libs\Telemetry Library\TelemetryConversions.pas',
  TelemetryStrings         in 'Libs\Telemetry Library\TelemetryStrings.pas',
  TelemetryLists           in 'Libs\Telemetry Library\TelemetryLists.pas',
  TelemetryVersionObjects  in 'Libs\Telemetry Library\TelemetryVersionObjects.pas',
  TelemetryInfoProvider    in 'Libs\Telemetry Library\TelemetryInfoProvider.pas',
  TelemetryRecipient       in 'Libs\Telemetry Library\TelemetryRecipient.pas',
  TelemetryRecipientBinder in 'Libs\Telemetry Library\TelemetryRecipientBinder.pas',

  TelemetryLog in 'TelemetryLog.pas';

var
  Recipient:        TTelemetryRecipient = nil;
  TelemetryLogger:  TTelemetryLog = nil;

{$R *.res}

Function TelemetryLibraryInit(version: scs_u32_t; params: p_scs_telemetry_init_params_t): scs_result_t; stdcall;
begin
If not TTelemetryRecipient.SupportsTelemetryAndGameVersionParam(version,params^) then
  begin
    Result := SCS_RESULT_unsupported;
  end
else
  begin
    Recipient := TTelemetryRecipient.Create(version,params^);
    try
      TelemetryLogger := TTelemetryLog.Create(Recipient);
      Result := SCS_RESULT_ok;
    except
      Result := SCS_RESULT_generic_error;
    end;
  end;
end;

procedure TelemetryLibraryFinal; stdcall;
begin
FreeAndNil(TelemetryLogger);
FreeAndNil(Recipient);
end;

exports
  TelemetryLibraryInit name 'scs_telemetry_init',
  TelemetryLibraryFinal name 'scs_telemetry_shutdown';

begin
end.
