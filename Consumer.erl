-module('Consumer').
-author("sara").
-export([start/0]).
start () ->
  serverBuffer ! {getBuffer,self()},
  receive
    Pid -> consume(Pid);
    _ -> io:format("Consumer start wrong")
  end.

consume(Buffer)->
  Buffer ! {consume,self()},
  consumeWait(Buffer).

consumeWait(Buffer) ->
  receive
    {isDone,BufferPid} ->
      io:format("Consume!\n"),
      consume(BufferPid);
    _ ->
      io:format("Something goes wrong - Consumer died")
  end.

%% API

