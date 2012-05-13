%%%-------------------------------------------------------------------
%%% @author Heinz N. Gies <heinz@licenser.net>
%%% @copyright (C) 2012, Heinz N. Gies
%%% @doc
%%%
%%% @end
%%% Created : 20 Apr 2012 by Heinz N. Gies <heinz@licenser.net>
%%%-------------------------------------------------------------------
-module(nomnom_handler).

-behaviour(cowboy_http_handler).

%% Callbacks
-export([init/3, handle/2, terminate/2]).


-define(SERVICE_DESCRIPTION,     
	[{<<"endpoints">>, [<<"GET    /datasets">>,
			    <<"GET    /datasets/:id">>,
			    <<"GET    /datasets/:id/:path">>,
			    <<"GET    /assets/:path">>,
			    <<"PUT    /datasets/:uuid">>,
			    <<"DELETE /datasets/:uuid">>,
			    <<"GET    /">>,
			    <<"GET    /ping">>]}]).


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
    request(Method, Path, Req3, State).



request('GET', [], Req, State) ->
    reply_json(Req, [{<<"cloud_name">>, get_env_default(cloud_name, <<"lice">>)},
		     {<<"version">>, get_env_default(dsapi_version, <<"2.3.0">>)}] ++ ?SERVICE_DESCRIPTION, State);

request('GET', [<<"datasets">>], Req, State) ->
    {ok, File} = file:read_file("priv/datasets/index.json"),
    {ok, Req2} = cowboy_http_req:reply(200, [{<<"Content-Type">>, <<"application/json">>}], File, Req),
    {ok, Req2, State};

request('GET', [<<"ping">>], Req, State) ->
    reply_json(Req, [{<<"ping">>, <<"pong">>}], State);

request(_, _Path, Req, State) ->
    {ok, Req2} = cowboy_http_req:reply(404, [], <<"not found!">>, Req),
    {ok, Req2, State}.

terminate(_Req, _State) ->
    ok.


%%%===================================================================
%%% Internal functions
%%%===================================================================

reply_json(Req, Data, State) ->
    {ok, Req2} = cowboy_http_req:reply(200,
				       [{<<"Content-Type">>, <<"application/json">>}], 
				       jsx:to_json(Data), Req),
    {ok, Req2, State}.

get_env_default(Key, Default) ->
    case  application:get_env(nomnom, Key) of
	{ok, Res} ->
	    Res;
	_ ->
	    Default
    end.
