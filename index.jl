export Events, on, emit, off

typealias Events Dict{String, Union(Array{Function,1}, Function)}

on(f::Function, e::Events, name::String) = on(e, name, f)
on(e::Events, name::String, f::Function) = begin
  a = get!(e, name, f)
  if is(a, f) return end
  if isa(a, Array) return push!(a, f) end
  e[name] = Function[a, f]
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
  if !haskey(e, name) return end
  if isa(e[name], Function) return e[name](args...) end
  for f in e[name] f(args...) end
end
