-module(sax).
-export([run/0]).


run() ->
  case file:read_file(xml()) of
    {ok, Bin} ->
      {ok, _, _} = erlsom:parse_sax(Bin, [], fun callback/2);
    Error ->
      Error
  end,
  ok.

callback(Event, State) ->
	case Event of
		{characters, C} -> {L, _} = string:to_integer(C), io:format("characters ~p\n", [State]), [L|State];
		_ -> State
	end.



%% this is just to make it easier to test this little example
xml() -> filename:join([codeDir(), "sax_example.xml"]).
codeDir() -> filename:dirname(code:which(?MODULE)).
