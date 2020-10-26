-define(ACTION_BASE1(Module), ancestor=action, trigger=[], target=[], module=Module, actions=[], source=[]).

-record(scroll,     {?ACTION_BASE1(scroll), name, tag, delegate }).
-record(scroll1, {
    id = [] :: list() | binary(),
    parentHeight = [] :: list() | binary(),
    tableHeight = [] :: list() | binary(),
    offsetAcc = [] :: list() | binary(),
    offset = [] :: list() | binary(),
    delegate = [] :: atom() | binary(),
    name = [] :: atom() | binary()
  }).