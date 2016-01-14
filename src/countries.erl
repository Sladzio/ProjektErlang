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

%%Pomocnicze funkcje do wczytywania plikow
codeDir() -> filename:dirname(code:which(?MODULE)).
xsd() -> filename:join([codeDir(), "countries.xsd"]).
xml()-> filename:join([codeDir(),"countries.xml"]).
%%Funkcja przeznaczona do generowania naglowka z xsd
generate_hrl()->
  erlsom:write_xsd_hrl_file("countries.xsd","Countries.hrl").

%%Glowna funkcjonalnosc
run(CountryAttr)->
  %% compile xsd
  {ok, Model} = erlsom:compile_xsd_file(xsd()),
  %% parse xml
  {ok, #countries{country = Countries}, _} = erlsom:scan_file(xml(), Model),
  display_country(Countries,CountryAttr).

%%Wyswietla rekord zdefiniowany przez CountryName
display_country([H|T],CountryAttr)->
  case (H#'countries/country'.name) of
    CountryAttr-> io:format("Name: ~s~n"
      "Code    : ~s~n"
      "Phone Code   : ~s~n",
      [H#'countries/country'.name,H#'countries/country'.code,H#'countries/country'.phoneCode]);

    _->display_country(T,CountryAttr)
  end;
display_country(_,_)->io:format("Nie znaleziono kraju.").










