defmodule Procs do
  @number_of_processes 100
  @byte_size 1000

  @doc """
  Spins 100 tasks
  """
  def chunk(number_of_tasks \\ @number_of_processes, byte_size \\ @byte_size) do
    Enum.map(0..number_of_tasks, fn _ -> Task.async(Procs.Chunker, :calculate, [byte_size]) end)
    |> Task.await_many()
  end

end
