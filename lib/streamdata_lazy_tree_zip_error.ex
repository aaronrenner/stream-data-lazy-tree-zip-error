defmodule StreamdataLazyTreeZipError do
  def strip(%{type: type, children: children} = tag) when (type == :document or type == :element) do
    children =
      children
      |> Enum.filter(fn %{type: :element, name: "script"}   -> false
                        %{type: :element, name: "noscript"} -> false
                                                          _ -> true end)
      |> Enum.map(&strip/1)

    Map.put(tag, :children, children)
  end
  def strip(tag), do: tag
end
