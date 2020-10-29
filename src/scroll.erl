-module(scroll).
-include_lib("include/scroll.hrl").
-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/n2o.hrl").

-compile(export_all).

render_action(#scroll{offset=[]}=Record) ->
  io:format("RENDER data: ~p~n", [Record]),
    _Name = Record#scroll.name,
    
    "qi('divTable').addEventListener('scroll', function(e){
      let target = e.target;
      update_table(target.scrollTop);
      scroll.tableId = 'table';
      scroll.parentHeight =  qi('divTable').offsetHeight;
      scroll.tHeigh = qi('table').offsetHeight;
      scroll.offset = target.scrollTop;

      direct(tuple(atom('scroll'),
        string(scroll.tableId),
        number(scroll.parentHeight),
        number(scroll.tHeigh),
        number(scroll.offsetAcc),
        number(scroll.offset),
      ));

      scroll.offsetAcc = scroll.offset;
    });";
  render_action(Record)->
    io:format("REND_ACT~p~n",[Record])
    .



info({scroll,TId,ParH,TH,OffsetAcc,Offset} = Data, Req, State)->

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

%%%%%%%%%%%

event(init)->
  build_table([]),
  nitro:wire(#scroll{name=scroll,delegate=scroll});

event({scroll,TId,ParH,TH,OffsetAcc,Offset} = Data)->
  if Offset >= OffsetAcc, ParH *2 > TH  -> 
    add_row([],1),
    io:format("move down");
    true -> true
  end,

  io:format("~p <= ~p , ~p > ~p~n", [Offset, OffsetAcc, ParH *2, TH]),
  if Offset =< OffsetAcc, ParH *2 > TH -> 
    insert_tr_before([],-1),
    nitro:wire("set_height(0);"),
    io:format("move up");
    true -> true
  end,
  
  io:format("SCRL EV: ~p~n",[Data]).

check_height({scroll,TId,ParH,TH,OffsetAcc,Offset})->
  io:format("~p >= ~p",[ParH,TH]),
  if ParH >= TH -> add_row([],1);
    true -> true
  end.

build_table([])->
  %add_row([], 1),
  nitro:wire("fill_table();").

add_row(_Feed, _Rid)->
  rend_row([],1),
  nitro:wire("set_height(0);").

fill_table()->
  rend_row([],1),
  nitro:wire("fill_table();").

insert_tr_before(_,_)->
  io:format("inserting before ~n"),
  rend_row([],-1),
  nitro:wire("set_height(0);").  

rend_row(_Data, F)->
  Id = rand:uniform(),
  Row = #tr{id=Id,
    cells=[#td{body=nitro:to_binary(Id)},
          #td{body= "point"}]},
  case F of
    -1 -> 
      io:format("ROW-1!: ~p~n",[Row]),
      nitro:insert_top(table, Row);
    1 ->
      io:format("ROW!1: ~p~n",[Id]), 
      nitro:insert_bottom(table, Row);
    _ -> nothing
  end.