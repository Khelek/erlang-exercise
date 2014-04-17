-module(db).
-export([create_db/0, get/2, insert/3, update/3, delete/2]).


create_db() ->
    [].

get(Db, Key) ->
    case [X || X <- Db, element(1, X) == Key] of
        [] -> none;
        [H | T] -> element(2, H)
    end.

insert(Db, Key, Value) ->
    case get(Db, Key) of
        none -> [{Key, Value} | Db];
        _Value -> key_is_busy
    end.

update(Db, Key, Value) ->
    case get(Db, Key) of
        none -> none;
        _Value -> 
            Db1 = delete(Db, Key),
            insert(Db1, Key, Value)
    end.

delete(Db, Key) ->
    [X || X <- Db, element(1, X) =/= Key].
    
