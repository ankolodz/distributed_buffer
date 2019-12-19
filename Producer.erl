-module('Producer').
-author("sara").
-export([start/0]).
start () ->
  serverBuffer ! {getBuffer,self()},
  receive
    Pid -> produce(Pid);
    _ -> io:format("Produce start wrong")
  end.

produce(Buffer)->
  Buffer ! {produce,self()},
  produceWait().

produceWait() ->
  receive
    {isDone,BufferPid} ->
      io:format("Produce!\n"),
      produce(BufferPid);
    _ ->
      io:format("Something goes wrong - Producer died")
  end.
%% API

