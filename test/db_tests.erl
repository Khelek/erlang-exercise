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
               db_get_none(Db),
               db_delete(Db),
               db_update(Db),
               db_update_none(Db)
              ]
      end}
    }.

start() ->
    db:create_db().

stop() ->
     ok.

db_insert(Db) ->
    Db1 = db:insert(Db, 1, "34"),
    ?_assertEqual([{1, "34"}], Db1).

db_insert_busy(Db) ->
    Db1 = db:insert(Db, 1, "34"),    
    ?_assertEqual(key_is_busy, db:insert(Db1, 1, "54")).

db_get(Db) ->
    Db1 = db:insert(Db, 1, "34"),
    ?_assertEqual("34", db:get(Db1, 1)).

db_get_none(Db) ->
    ?_assertEqual(none, db:get(Db, 1)).

db_update(Db) ->
    Db1 = db:insert(Db, 1, "34"),
    Db2 = db:update(Db1, 1, "123"),
    ?_assertEqual("123", db:get(Db2, 1)).

db_update_none(Db) ->
    ?_assertEqual(none, db:update(Db, 1, "34")).

db_delete(Db) ->
    Db1 = db:insert(Db, 1, "34"),
    ?_assertEqual("34", db:get(Db1, 1)),
    Db2 = db:delete(Db,1),
    ?_assertEqual(none, db:get(Db2, 1)).
