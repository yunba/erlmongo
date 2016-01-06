This repo is a rebar version copied from [erlmongo](https://github.com/SergejJurecko/erlmongo).


# Usage

```

> mongodb:replicaSets(repl,["host1:port1","host2:port2", "host3:port3"]).
ok
> mongodb:connect(repl).
ok
> Mong = mongoapi:new(repl,<<"test">>).
{mongoapi,[repl,<<"test">>]}
> Mong:set_encode_style(mochijson).
undefined
> Mong:findOne("collections", [{"_id", {oid, <<"id1">>}}]).

```
