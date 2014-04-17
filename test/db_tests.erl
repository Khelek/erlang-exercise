-module(db_tests).


-include_lib("eunit/include/eunit.hrl").
-compile(export_all).

db_test_() ->
    {spawn,
     {setup,
      fun start/0,
      fun(_) -> stop() end,
      fun(Db) ->
              [db_insert(Db),
               db_insert_busy(Db),
               db_get(Db),
               db_get_nothing(Db),
               db_delete(Db),
               db_update(Db),
               db_update_nothing(Db)
              ]
      end}
    }.

start() ->
    db:create_db().

stop() ->
     ok.

db_insert(Db) ->
    {ok, Db1} = db:insert(Db, 1, "34"),
    ?_assertEqual([{1, "34"}], Db1).

db_insert_busy(Db) ->
    {ok, Db1} = db:insert(Db, 1, "34"),    
    ?_assertEqual({error, key_is_busy}, db:insert(Db1, 1, "54")).

db_get(Db) ->
    {ok, Db1} = db:insert(Db, 1, "34"),
    ?_assertEqual({ok, "34"}, db:get(Db1, 1)).

db_get_nothing(Db) ->
    ?_assertEqual({error, none}, db:get(Db, 1)).

db_update(Db) ->
    {ok, Db1} = db:insert(Db, 1, "34"),
    {ok, Db2} = db:update(Db1, 1, "123"),
    ?_assertEqual({ok, "123"}, db:get(Db2, 1)).

db_update_nothing(Db) ->
    ?_assertEqual({error, none}, db:update(Db, 1, "34")).

db_delete(Db) ->
    {ok, Db1} = db:insert(Db, 1, "34"),
    ?_assertEqual({ok, "34"}, db:get(Db1, 1)),
    {ok, Db2} = db:delete(Db,1),
    ?_assertEqual({error, none}, db:get(Db2, 1)).
