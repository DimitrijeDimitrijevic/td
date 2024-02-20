defmodule Procs.Chunker do
  @moduledoc """
  Generates random bytes, chunks them, convert them to 64bit unsigned ints.
  """


  @chunk_size 8
  @doc """
   Generate a random encoded string with size of 1000 bytes
   Split it with chars
  """
  def generate_random_chars_with_byte_size(size) do
    :crypto.strong_rand_bytes(size)
    |> Base.encode64()
    |> binary_part(0, size)
  end

  # Split the string into 125 x 8 bytes
  # Each char is 1 byte.
  def split_into_chunks(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_every(@chunk_size)
  end

  def convert_to_int_binary(chunks) do
    Enum.map(chunks, fn chunk ->
      chunk
      |> Enum.join()
      |> to_list_integer_binary()
    end)
  end

  @doc """
  Using comprehensions we can loop trough bytes on binaries!
  """
  def to_list_integer_binary(string) do
    for <<x::big-unsigned-integer-size(64) <- string>>, do: x
  end

  def calculate_avg(list_of_binaries) do
    count = Enum.count(list_of_binaries)
    Enum.reduce(list_of_binaries, 0, fn [x], acc ->
      acc + x
    end)
    |> div(count)
  end

  @doc """

  """
  def calculate(size) do
    generate_random_chars_with_byte_size(size)
    |> split_into_chunks()
    |> convert_to_int_binary()
    |> calculate_avg()
  end
end
