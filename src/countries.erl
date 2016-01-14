%%%-------------------------------------------------------------------
%%% @author Sladzio
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. sty 2016 23:46
%%%-------------------------------------------------------------------
-module(countries).
-author("Sladzio").
-include("Countries.hrl").
%% API
-export([generate_hrl/0,run/1]).


codeDir() -> filename:dirname(code:which(?MODULE)).
xsd() -> filename:join([codeDir(), "countries.xsd"]).
xml()-> filename:join([codeDir(),"countries.xml"]).
generate_hrl()->
  erlsom:write_xsd_hrl_file("countries.xsd","Countries.hrl").
run(CountryName)->
  %% compile xsd
  {ok, Model} = erlsom:compile_xsd_file(xsd()),
  %% parse xml
  {ok, #countries{country = Countries}, _} = erlsom:scan_file(xml(), Model),
  process(Countries,CountryName).
  %%lists:foreach(fun process_country/1, Countries).
process_country(#'countries/country'{code=Code,phoneCode = PhoneCode,name=Name}) ->
      io:format("Code    : ~s~n"
      "phoneCode   : ~s~n"
      "Name: ~s~n",
        [Code, PhoneCode, Name]).
process([H|T],CountryName)->
  case (H#'countries/country'.name) of
    CountryName-> io:format("Code    : ~s~n"
    "phoneCode   : ~s~n"
    "Name: ~s~n",
      [H#'countries/country'.code,H#'countries/country'.phoneCode,H#'countries/country'.name]);
    _->process(T,CountryName)
  end;
process(_,_)->io:format("Nie znaleziono kraju.").










