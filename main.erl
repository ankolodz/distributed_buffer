
-module(main).
-author("sara").
-export([mymain/0]).
mymain()->
  register(serverBuffer,self()),
  Last = creatBuffer(10),
  creatProducer(20),
  creatConsumer(20),
  loop(Last),
  io:format("end").

loop(Last)->
  receive
    {getBuffer,Pid} ->
      Pid ! Last,
      loop(Last);
    {getNeightbours,Pid} ->
      Pid ! Last,
      loop(Last)
    after
      1000 -> loop(Last)
  end.



creatBuffer (1,Neightbours) ->
  Last = spawn('Buffer',start,[Neightbours]),
  Last;
creatBuffer(N,Neightbours) ->
  NextNeightbours = spawn('Buffer',start,[Neightbours]),
  creatBuffer(N-1,NextNeightbours).

creatBuffer(N) ->
  Neightbours = spawn('Buffer',start,[]),
  creatBuffer(N-1,Neightbours).

creatProducer (1) ->
  spawn('Producer',start,[]);
creatProducer(N) ->
  spawn('Producer',start,[]),
  creatProducer(N-1).

creatConsumer (1) ->
  spawn('Consumer',start,[]);
creatConsumer(N) ->
  spawn('Consumer',start,[]),
  creatConsumer(N-1).

%loop() ->



