-module('Buffer').
-author("sara").
-export([start/0, start/1]).
start() ->
  serverBuffer ! {getNeightbours,self()},
  receive
    PidNextNode->
      loop(PidNextNode,empty)
  end.

start(PidNextNode) ->
      loop(PidNextNode,empty).

loop (PidNextNode,empty) ->
  receive
    {produce, ProducerPid} ->
      ProducerPid ! {isDone,self()},
      loop (PidNextNode,full);
    {consume,ConsumerPid} ->
%%      io:format("Konsument -> podaj dalej"),
      PidNextNode ! {consume,ConsumerPid},
      loop (PidNextNode,empty)
  end;

loop (PidNextNode,full) ->
  receive
    {consume, ConsumerPid} ->
      ConsumerPid ! {isDone,self()},
      loop (PidNextNode,empty);
    {produce,ProducerPid} ->
%%      io:format("Producent -> podaj dalej"),
      PidNextNode ! {produce,ProducerPid},
      loop (PidNextNode,full)
  end.
%% API

