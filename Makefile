OBJ=ebin/nomnom.app ebin/nomnom_app.beam ebin/nomnom_server.beam ebin/nomnom_sup.beam ebin/nomnom_handler.beam ebin/nomnom.beam
DEPS=deps/jsx deps/cowboy
ERL=erl
PA=ebin deps/*/ebin
REBAR=./rebar

all: $(OBJ) $(DEPS)

rel: all FORCE
	-rm -r rel/nomnom
	cd rel; ../rebar generate

tar: rel
	cd rel; tar jcvf nomnom.tar.bz2 nomnom

clean: FORCE
	-rm -r *.beam ebin
	-rm erl_crash.dump
	-rm -r rel/nomnom
	-rm rel/nomnom.tar.bz2

ebin/%.app: src/%.app.src
	$(REBAR) compile

ebin/%.beam: src/%.erl
	$(REBAR) compile

shell: all
	$(ERL) -pa $(PA) -config standalone.config
	-rm *.beam

FORCE:
