defmodule StreamdataLazyTreeZipErrorTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  property "strip/1 removes script, noscript tags from dom" do
    check all document_node <- document_node(), max_runs: 15 do

    assert [] =
        document_node
        |> StreamdataLazyTreeZipError.doesnotexist
        |> find_nodes(fn
          %{type: :element, name: "noscript"} -> true
          %{type: :element, name: "script"} -> true
          _ -> false
        end)
    end
  end

  defp find_nodes(dom_node, func) when is_function(func) do
    find_nodes(dom_node, [], func)
  end
  defp find_nodes(%{children: children} = dom_node, acc, func) when is_list(children) do
    acc = Enum.flat_map(children, &find_nodes(&1, acc, func))
    if(func.(dom_node), do: [dom_node | acc], else: acc)
  end
  defp find_nodes(dom_node, acc, func) do
    if(func.(dom_node), do: [dom_node | acc], else: acc)
  end

  def document_node(user_field_generator \\ constant(%{})) do
    gen all required_fields <- fixed_map(%{
                                 id: integer(),
                                 type: :document,
                               }),
            optional_fields <- optional_map(%{
                                 children: node_list(),
            }),
            user_fields <- user_field_generator do
      required_fields
      |> Map.merge(optional_fields)
      |> Map.merge(user_fields)
    end
  end

  def node_list do
    list_of(
      one_of([
        doctype_node(),
        text_node(),
        comment_node(),
        element_node(),
      ]),
      min_length: 1
    )
  end

  def doctype_node do
    fixed_map(%{
      id: integer(),
      name: string(:alphanumeric),
      type: :doctype,
      system_id: string(:alphanumeric),
      public_id: string(:alphanumeric),
    })
  end

  def text_node do
    fixed_map(%{
      id: integer(),
      type: :text,
      value: string(:alphanumeric),
    })
  end

  def comment_node do
    fixed_map(%{
      id: integer(),
      type: :comment,
      value: string(:alphanumeric),
    })
  end

  def element_node(user_field_generator \\ constant(%{})) do
    gen all required_fields <- fixed_map(%{
                                id: integer(),
                                type: :element,
                                name: element_name(),
                                attributes: element_attributes_map(),
                               }),
            optional_fields <- optional_map(%{
                                children: node_list()
                              }),
            user_fields <- user_field_generator do
      required_fields
      |> Map.merge(optional_fields)
      |> Map.merge(user_fields)
    end
  end

  def element_attributes_map do
    map_of(
      string(:alphanumeric, min_length: 1),
      string(:alphanumeric)
    )
  end

  defp element_name do
    member_of(~w(html link meta style title body head address article aside
      footer header h1 h2 h3 h4 h5 h6 hgroup nav section
      blockquote dd div dl dt figcaption figure hr li main ol p pre ul
      a abbr b bdi bdo br cite code data dfn em i kbd mark p span strong sub
      sup area audio img map track video
      applet embed noembed object param picture source canvas noscript script))
  end
end
