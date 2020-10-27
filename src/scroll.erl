-module(scroll).
-include_lib("include/scroll.hrl").
-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/n2o.hrl").

-compile(export_all).

render_action(Record) ->
  io:format("RENDER data: ~p~n", [Record]),
    _Name = Record#scroll.name,
    
    "qi('divTable').addEventListener('scroll', function(e){
      let target = e.target;
      update_table(target.scrollTop);
      scroll.tableId = 'table';
      scroll.parentHeight =  qi('divTable').offsetHeight;
      scroll.tHeigh = qi('table').offsetHeight;
      scroll.offset = target.scrollTop;
    });".

      % ws.send(enc(tuple(atom('scroll'),
      %   string(scroll.tableId),
      %   number(scroll.parentHeight),
      %   number(scroll.tHeigh),
      %   number(scroll.offsetAcc),
      %   number(scroll.offset),
      % )));

      % scroll.offsetAcc = scroll.offset;

info({scroll,TId,ParH,TH,OffsetAcc,Offset} = Data, Req, State)->
  io:format("scroll event: ~p~n", [Data]),
  if Offset + ParH + 11 > TH -> io:format("move down");
    true -> true
  end,
  if Offset < OffsetAcc -> io:format("move up");
    true -> true
  end,
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
  Feed = '/points',
  kvs:save(kvs:writer(Feed)),
  [kvs:delete(Feed,element(2,X)) || X <- kvs:all(Feed)],
  [kvs:append({data, X},Feed) || X <- lists:seq(1,100)],

  build_table(Feed),
  nitro:wire(#scroll{name=scroll,delegate=scroll}).

build_table(Feed)->
  Rid = element(2,kvs:save(kvs:reader(Feed))),
  
  io:format("rid: ~p~n",[kvs:load_reader(Rid)]),
  add_row(Feed, Rid).

add_row(Feed, Rid)->
  D = take(Feed, Rid),
  io:format("D: ~p~n",[element(5,D)]),
  if length(element(5,D)) > 0 ->
      [rend_row(R,1) || R <- element(5,D)];
    true -> nothing
  end.

rend_row(Data, F)->
  Row = #tr{id=element(2,Data),
    cells=[#td{body=nitro:to_binary(element(2,Data))},
          #td{body= "point"}]},
  case F of
    -1 -> 
      io:format("ROW-1!: ~p~n",[Row]),
      nitro:insert_top(table, Row);
    1 ->
      io:format("ROW!1: ~p~n",[Row]), 
      nitro:insert_bottom(table, Row);
    _ -> nothing
  end.

take(Feed, RId)->
  D = kvs:take(setelement(5,kvs:load_reader(RId),3)),
  kvs:save(D),
  D.

insert_tr_before(Feed,RId)->
  io:format("inserting before ~n"),
  D = take(Feed,RId),
  if length(element(5,D)) > 0 ->
      [rend_row(R,-1) || R <- element(5,D)];
    true -> nothing
  end.

check_height(#scroll{parentHeight=ph, tableHeight=th})->
  io:format("PH: ~p~n TH: ~p~n",[ph,th]).