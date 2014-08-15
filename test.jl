
@require "./" Events on off emit

e = Events()
calls = 0
inc1() = global calls += 1
inc2() = global calls += 2
on(e, "test", inc1)
emit(e, "test")

@assert calls == 1

off(e, "test", inc1)
emit(e, "test")

@assert calls == 1

on(e, "test", inc1)
on(e, "test", inc2)
emit(e, "test")

@assert calls == 4

off(e, "test", inc2)
emit(e, "test")

@assert calls == 5

off(e, "test", inc1)
emit(e, "test")

@assert calls == 5

emit(Events(["test" => inc1]), "test")

@assert calls == 6

on(e, "test") do a,b
	global calls += 4
	@assert a == 1
	@assert b == 2
end

emit(e, "test", 1, 2)
@assert calls == 10
