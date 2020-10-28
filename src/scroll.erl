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

      direct(tuple(atom('scroll'),
        string(scroll.tableId),
        number(scroll.parentHeight),
        number(scroll.tHeigh),
        number(scroll.offsetAcc),
        number(scroll.offset),
      ));

      scroll.offsetAcc = scroll.offset;
    });".



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

event(init)->
  Feed = '/points',
  %kvs:save(kvs:writer(Feed)),
  %[kvs:delete(Feed,element(2,X)) || X <- kvs:all(Feed)],
  %[kvs:append({data, X},Feed) || X <- lists:seq(1,100)],

  build_table(Feed),
  nitro:wire(#scroll{name=scroll,delegate=scroll});

event({scroll,TId,ParH,TH,OffsetAcc,Offset} = Data)->
  if Offset > OffsetAcc, ParH *2 > TH -> 
    add_row([],1),
    io:format("move down");
    true -> true
  end,
  if Offset < OffsetAcc, ParH *2 < TH -> 
    insert_tr_before([],-1),
    io:format("move up");
    true -> true
  end,
  io:format("SCRL EV: ~p~n",[Data]).

build_table(Feed)->
  %Rid = element(2,kvs:save(kvs:reader(Feed))),
  %nitro:wire("qi('table')['data-rid']= #{rid};
  %set_height(qi('table')['data-scroll']);"),
  %io:format("rid: ~p~n",[kvs:load_reader(Rid)]),
  add_row(Feed, 1).

add_row(_Feed, _Rid)->
  %D = take(Feed, Rid),
  %io:format("D: ~p~n",[element(5,D)]),
  rend_row([],1),
  % if length(element(5,D)) > 0 ->
  %     [rend_row(R,1) || R <- element(5,D)];
  %   true -> nothing
  % end,
  nitro:wire("set_height(qi('table')['data-scroll']);").

rend_row(_Data, F)->
  Id = rand:uniform(),
  Row = #tr{id=Id,%element(2,Data),
    cells=[#td{body=nitro:to_binary(Id)},%element(2,Data))},
          #td{body= "point"}]},
  case F of
    -1 -> 
      R = nitro:insert_top(table, Row),
      io:format("REsINSERT: ~p~nROW-1!: ~p~n",[R,Row]);
      
    1 ->
      io:format("ROW!1: ~p~n",[Id]), 
      nitro:insert_bottom(table, Row);
    _ -> nothing
  end.

% take(_Feed, RId)->
%   D = kvs:take(setelement(5,kvs:load_reader(RId),3)),
%   kvs:save(D),
%   D.

insert_tr_before(Feed,RId)->
  io:format("inserting before ~n"),
  rend_row([],-1).
  % D = take(Feed,RId),
  % if length(element(5,D)) > 0 ->
  %     [rend_row(R,-1) || R <- element(5,D)];
  %   true -> nothing
  % end.

check_height(#scroll{parentHeight=ph, tableHeight=th})->
  io:format("PH: ~p~n TH: ~p~n",[ph,th]).