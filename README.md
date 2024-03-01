# Procs

To run task without params and with default ones call 
```elixir
Procs.chunk/0
```
or by passing params to function 
```elixir
number_of_tasks = <some_number>
number_of_rand_bytes = <some_number>

Procs.chunk(number_of_tasks, number_of_rand_bytes)
```

# Using processes 

```elixir
Procs.spinner/0
```

