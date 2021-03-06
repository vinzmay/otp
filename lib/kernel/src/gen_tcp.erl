%%
%% %CopyrightBegin%
%% 
%% Copyright Ericsson AB 1997-2011. All Rights Reserved.
%% 
%% The contents of this file are subject to the Erlang Public License,
%% Version 1.1, (the "License"); you may not use this file except in
%% compliance with the License. You should have received a copy of the
%% Erlang Public License along with this software. If not, it can be
%% retrieved online at http://www.erlang.org/.
%% 
%% Software distributed under the License is distributed on an "AS IS"
%% basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
%% the License for the specific language governing rights and limitations
%% under the License.
%% 
%% %CopyrightEnd%
%%

-module(gen_tcp).


-export([connect/3, connect/4, listen/2, accept/1, accept/2,
	 shutdown/2, close/1]).
-export([send/2, recv/2, recv/3, unrecv/2]).
-export([controlling_process/2]).
-export([fdopen/2]).

-include("inet_int.hrl").

-type hostname() :: inet:hostname().
-type ip_address() :: inet:ip_address().
-type port_number() :: 0..65535.
-type posix() :: inet:posix().
-type socket() :: port().

%%
%% Connect a socket
%%

-spec connect(Address, Port, Options) -> {ok, Socket} | {error, Reason} when
      Address :: ip_address() | hostname(),
      Port :: port_number(),
      Options :: [Opt :: term()],
      Socket :: socket(),
      Reason :: posix().

connect(Address, Port, Opts) -> 
    connect(Address,Port,Opts,infinity).

-spec connect(Address, Port, Options, Timeout) ->
                     {ok, Socket} | {error, Reason} when
      Address :: ip_address() | hostname(),
      Port :: port_number(),
      Options :: [Opt :: term()],
      Timeout :: timeout(),
      Socket :: socket(),
      Reason :: posix().

connect(Address, Port, Opts, Time) ->
    Timer = inet:start_timer(Time),
    Res = (catch connect1(Address,Port,Opts,Timer)),
    inet:stop_timer(Timer),
    case Res of
	{ok,S} -> {ok,S};
	{error, einval} -> exit(badarg);
	{'EXIT',Reason} -> exit(Reason);
	Error -> Error
    end.

connect1(Address,Port,Opts,Timer) ->
    Mod = mod(Opts, Address),
    case Mod:getaddrs(Address,Timer) of
	{ok,IPs} ->
	    case Mod:getserv(Port) of
		{ok,TP} -> try_connect(IPs,TP,Opts,Timer,Mod,{error,einval});
		Error -> Error
	    end;
	Error -> Error
    end.

try_connect([IP|IPs], Port, Opts, Timer, Mod, _) ->
    Time = inet:timeout(Timer),
    case Mod:connect(IP, Port, Opts, Time) of
	{ok,S} -> {ok,S};
	{error,einval} -> {error, einval};
	{error,timeout} -> {error,timeout};
	Err1 -> try_connect(IPs, Port, Opts, Timer, Mod, Err1)
    end;
try_connect([], _Port, _Opts, _Timer, _Mod, Err) ->
    Err.

    

%%
%% Listen on a tcp port
%%

-spec listen(Port, Options) -> {ok, ListenSocket} | {error, Reason} when
      Port :: port_number(),
      Options :: [Opt :: term()],
      ListenSocket :: socket(),
      Reason :: posix().

listen(Port, Opts) ->
    Mod = mod(Opts, undefined),
    case Mod:getserv(Port) of
	{ok,TP} ->
	    Mod:listen(TP, Opts);
	{error,einval} ->
	    exit(badarg);
	Other -> Other
    end.

%%
%% Generic tcp accept
%%

-spec accept(ListenSocket) -> {ok, Socket} | {error, Reason} when
      ListenSocket :: socket(),
      Socket :: socket(),
      Reason :: closed | timeout | posix().

accept(S) ->
    case inet_db:lookup_socket(S) of
	{ok, Mod} ->
	    Mod:accept(S);
	Error ->
	    Error
    end.

-spec accept(ListenSocket, Timeout) -> {ok, Socket} | {error, Reason} when
      ListenSocket :: socket(),
      Timeout :: timeout(),
      Socket :: socket(),
      Reason :: closed | timeout | posix().

accept(S, Time) when is_port(S) ->
    case inet_db:lookup_socket(S) of
	{ok, Mod} ->
	    Mod:accept(S, Time);
	Error ->
	    Error
    end.

%%
%% Generic tcp shutdown
%%

-spec shutdown(Socket, How) -> ok | {error, Reason} when
      Socket :: socket(),
      How :: read | write | read_write,
      Reason :: posix().

shutdown(S, How) when is_port(S) ->
    case inet_db:lookup_socket(S) of
	{ok, Mod} ->
	    Mod:shutdown(S, How);
	Error ->
	    Error
    end.

%%
%% Close
%%

-spec close(Socket) -> ok when
      Socket :: socket().

close(S) ->
    inet:tcp_close(S).

%%
%% Send
%%

-spec send(Socket, Packet) -> ok | {error, Reason} when
      Socket :: socket(),
      Packet :: string() | binary(),
      Reason :: posix().

send(S, Packet) when is_port(S) ->
    case inet_db:lookup_socket(S) of
	{ok, Mod} ->
	    Mod:send(S, Packet);
	Error ->
	    Error
    end.

%%
%% Receive data from a socket (passive mode)
%%

-spec recv(Socket, Length) -> {ok, Packet} | {error, Reason} when
      Socket :: socket(),
      Length :: non_neg_integer(),
      Packet :: string() | binary() | HttpPacket,
      Reason :: closed | posix(),
      HttpPacket :: term().

recv(S, Length) when is_port(S) ->
    case inet_db:lookup_socket(S) of
	{ok, Mod} ->
	    Mod:recv(S, Length);
	Error ->
	    Error
    end.

-spec recv(Socket, Length, Timeout) -> {ok, Packet} | {error, Reason} when
      Socket :: socket(),
      Length :: non_neg_integer(),
      Timeout :: timeout(),
      Packet :: string() | binary() | HttpPacket,
      Reason :: closed | posix(),
      HttpPacket :: term().

recv(S, Length, Time) when is_port(S) ->
    case inet_db:lookup_socket(S) of
	{ok, Mod} ->
	    Mod:recv(S, Length, Time);
	Error ->
	    Error
    end.

unrecv(S, Data) when is_port(S) ->
    case inet_db:lookup_socket(S) of
	{ok, Mod} ->
	    Mod:unrecv(S, Data);
	Error ->
	    Error
    end.    

%%
%% Set controlling process
%%

-spec controlling_process(Socket, Pid) -> ok | {error, Reason} when
      Socket :: socket(),
      Pid :: pid(),
      Reason :: closed | not_owner | posix().

controlling_process(S, NewOwner) ->
    case inet_db:lookup_socket(S) of
	{ok, _Mod} -> % Just check that this is an open socket
	    inet:tcp_controlling_process(S, NewOwner);
	Error ->
	    Error
    end.



%%
%% Create a port/socket from a file descriptor 
%%
fdopen(Fd, Opts) ->
    Mod = mod(Opts, undefined),
    Mod:fdopen(Fd, Opts).

%% Get the tcp_module, but IPv6 address overrides default IPv4
mod(Address) ->
    case inet_db:tcp_module() of
	inet_tcp when tuple_size(Address) =:= 8 ->
	    inet6_tcp;
	Mod ->
	    Mod
    end.

%% Get the tcp_module, but option tcp_module|inet|inet6 overrides
mod([{tcp_module,Mod}|_], _Address) ->
    Mod;
mod([inet|_], _Address) ->
    inet_tcp;
mod([inet6|_], _Address) ->
    inet6_tcp;
mod([{ip, Address}|Opts], _) ->
    mod(Opts, Address);
mod([{ifaddr, Address}|Opts], _) ->
    mod(Opts, Address);
mod([_|Opts], Address) ->
    mod(Opts, Address);
mod([], Address) ->
    mod(Address).
