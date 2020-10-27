-define(ACTION_BASE1(Module), ancestor=action, trigger=[], target=[], module=Module, actions=[], source=[]).

%-record(scroll,     {?ACTION_BASE1(scroll), name, tag, delegate }).
-record(scroll, {
    ?ACTION_BASE1(scroll),
    id = [] :: list() | binary(),
    parentHeight = [] :: list() | binary(),
    tableHeight = [] :: list() | binary(),
    offsetAcc = [] :: list() | binary(),
    offset = [] :: list() | binary(),
    delegate = [] :: atom() | binary(),
    name = [] :: atom() | binary()
  }).

  -record(reader, { id    = [] :: integer(),
                    pos   =  0 :: [] | integer(),
                    cache = [] :: [] | integer(),
                    args  = [] :: term(),
                    feed  = [] :: term(),
                    dir   =  0 :: 0 | 1 } ).