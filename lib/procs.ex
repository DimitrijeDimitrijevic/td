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


  def spinnner(number_of_processes \\ @number_of_processes, byte_size \\ @byte_size) do
    caller = self()

    Enum.each(1..number_of_processes, fn _ -> spawn(fn ->
      spawn(fn ->
        val = Procs.Chunker.calculate(byte_size)
        send(caller, {:calculated_value, val})
      end)
    end)
  end)

  Enum.map(1..number_of_processes, fn _ -> receiver() end)

  end

  defp receiver do
    receive do
      {:calculated_value, value} ->
        value
    end

  end

end
