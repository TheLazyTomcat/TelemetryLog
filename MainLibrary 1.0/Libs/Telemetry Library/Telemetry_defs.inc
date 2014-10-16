{.$DEFINE DevelopmentHints}
{.$DEFINE Documentation}
{$DEFINE UseCondensedHeader}
{.$DEFINE MulticastEvents}
{$DEFINE AssumeASCIIString}
{$DEFINE PrecomputedItemIDs}
{.$DEFINE ManualItemIDsCompute}
{$DEFINE MaxIndexedChannelCount8}
{$DEFINE NoTimeLogEvents}

{$IFDEF Documentation}
  {$DEFINE UseCondensedHeader}
  {$DEFINE MulticastEvents}
  {$UNDEF PrecomputedItemIDs}
  {$DEFINE NoTimeLogEvents}
{$ENDIF}

{$IFDEF PrecomputedItemIDs}
  {$UNDEF ManualItemIDsCompute}
{$ENDIF}

{$IFDEF Debug}
  {$DEFINE DevelopmentHints}
{$ENDIF}

{$IFDEF Release}
  {$UNDEF DevelopmentHints}
{$ENDIF}

