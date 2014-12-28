typealias Events Dict{String, Union(Vector{Function}, Function)}

on(f::Function, e::Events, name::String) = on(e, name, f)
on(e::Events, name::String, f::Function) = begin
  a = get!(e, name, f)
  a === f && return
  if isa(a, Array)
    push!(a, f)
  else
    e[name] = Function[a, f]
  end
end

on(e::Events, handlers::Dict) = begin
  for (key,value) in handlers
    on(e, key, value)
  end
end

on(e::Events, name::String, handlers::Vector) = begin
  for f in handlers
    on(e, name, f)
  end
end

off(e::Events, name::String, f::Function) = begin
  haskey(e, name) || return
  if isa(e[name], Function)
    is(e[name], f) && delete!(e, name)
  else
    filter!(x -> !is(x, f), e[name])
  end
end

emit(e::Events, name::String, args...) = begin
  haskey(e, name) || return
  isa(e[name], Function) && return e[name](args...)
  for f in e[name] f(args...) end
end
