%%%-------------------------------------------------------------------
%%% @author Heinz N. Gies <>
%%% @copyright (C) 2012, Heinz N. Gies
%%% @doc
%%%
%%% @end
%%% Created : 20 Apr 2012 by Heinz N. Gies <>
%%%-------------------------------------------------------------------
-module(nomnom_handler).

-behaviour(cowboy_http_handler).

%% Callbacks
-export([init/3, handle/2, terminate/2]).


%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------

init({_Any, http}, Req, []) ->
    {ok, Req, undefined}.

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------

handle(Req, State) ->
    {Path, Req2} = cowboy_http_req:path(Req),
    {Method, Req3} = cowboy_http_req:method(Req2),
    io:format("[~p] ~p~n", [Method, Path]),
    request(Method, Path, Req3, State).


request('GET', [<<"datasets">>], Req, State) ->
    {ok, File} = file:read_file("priv/datasets.json"),
    {ok, Req2} = cowboy_http_req:reply(200, [{<<"Content-Type">>, <<"application/json">>}], File, Req),
    {ok, Req2, State};

request(_, _Path, Req, State) ->
    {ok, Req2} = cowboy_http_req:reply(404, [], <<"not found!">>, Req),
    {ok, Req2, State}.

terminate(_Req, _State) ->
    ok.
