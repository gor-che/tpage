-module(scroll).
-include_lib("include/scroll.hrl").
-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/n2o.hrl").

-compile(export_all).

render_action(Record) ->
  io:format("RENDER data: ~p~n", [Record]),
    Name = Record#scroll.name,
    
    "qi('divTable').addEventListener('scroll', function(e){
      console.log([\"scrll\",e]);
      let target = e.target;
      update_table(target.scrollTop);
      scroll.tableId = 'table';
      scroll.parentHeight =  qi('divTable').offsetHeight;
      scroll.tHeigh = qi('table').offsetHeight;
      scroll.offset = target.scrollTop;

      ws.send(enc(tuple(atom('scroll'),
        string(scroll.tableId),
        string(scroll.parentHeight),
        string(scroll.tHeigh),
        string(scroll.offsetAcc),
        string(scroll.offset),
      )));

      scroll.offsetAcc = scroll.offset;
    });".

info({scroll,_,_,_,_,_} = Data, Req, State)->
  io:format("scroll event: ~p~n", [Data]),
  {reply, {bert, []}, Req, State};

info({api,_,_,_,_,_} = Data, Req, State)->
  io:format("api event: ~p~n", [Data]),
  {reply, {bert, []}, Req, State};

info(Data, Req, State)->
  io:format("info data: ~p~n", [Data]),
  {reply, {bert, []}, Req, State};

info(Mess, Req, State) ->
  io:format("unknown data: ~p~n", [Mess]),
  {unknown, Mess, Req, State}.

event(init)->
  nitro:wire(#scroll{name=scroll,delegate=scroll}).