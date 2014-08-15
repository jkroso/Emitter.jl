
# emitter

An event emitter providing dynamic/open dispatch. A.K.A hooks

## Installation

With [packin](//github.com/jkroso/packin): `packin add emitter:jkroso/emitter.jl`

## API

### Events

A type alias for creating emitter compatable `Dict`

```julia
function decide(time)
  if iseven(time)
    println("get up")
  else
    println("snooze")
  end
end
events = Events({
  "wake" => decide
})
```

### emit(events::Events, event::String, args...)

Invokes all functions bound to `events[event]` with `args` as parameters

```julia
emit(events, "wake", 1)
```

### on(action::Function, events::Events, event::String)

Bind `action` to be invoked when `event` is emitted on `events`

```julia
on(events, "wake") do
  println("good morning")
end
```

### off(events:Events, event::String, action::Function)

Unbind `action` if it is bound to `event` on `events`

```julia
off(events, "wake", decide)
```
