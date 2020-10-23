-module(scroll).
-include_lib("include/scroll.hrl").
-include_lib("n2o/include/n2o.hrl").

-compile(export_all).

render_action(Record) ->
  io:format("info data: ~p~n", [Record]).

info(Data, Req, State)->
  io:format("info data: ~p~n", [Data]),
  {reply, {bert, []}, Req, State};

info(Mess, Req, State) ->
  io:format("unknown data: ~p~n", [Mess]),
  {unknown, Mess, Req, State}.

event(init)->
  'Elixir.Tpage.Index':event(init).
% proc(Data)->
%   io:format("proc data: ~p~n", [Data]).