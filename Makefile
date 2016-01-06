REBAR = ./rebar -j8
ANSIBLE-PLAYBOOK = ansible-playbook

all: deps compile

compile: deps
	${REBAR} compile

deps:
	${REBAR} get-deps

clean:
	${REBAR} clean

generate: compile
	cd rel && ../${REBAR} generate -f

relclean:
	rm -rf rel/erlmongo

run: generate
	./rel/erlmongo/bin/erlmongo start

console: generate
	./rel/erlmongo/bin/erlmongo console

foreground: generate
	./rel/erlmongo/bin/erlmongo foreground

erl: compile
	erl -pa ebin/ -pa lib/*/ebin/ -s erlmongo

test:
	ERL_AFLAGS="-config ${PWD}/rel/erlmongo/etc/app.config -mnesia dir \"'data/'\""  $(REBAR)  compile ct suite=erlmongo skip_deps=true

it_local_deploy:
	${ANSIBLE-PLAYBOOK} ${PWD}/it_deploy/it_play.yml -K

integration_test:
	ERL_AFLAGS="-config ${PWD}/rel/files/erlmongo_it.config  -mnesia dir \"'data/'\" " $(REBAR)  compile ct suite=it -v skip_deps=true

.PHONY: all deps test clean
