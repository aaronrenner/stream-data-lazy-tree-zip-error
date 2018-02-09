# StreamdataLazyTreeZipError

Error reproduction case for stream data. Running on OTP 20.0 and Elixir 1.5.1.

Running `mix test` on StreamData 0.4.1 will sometimes give me

```
  1) property strip/1 removes script, noscript tags from dom
(StreamdataLazyTreeZipErrorTest)
     test/streamdata_lazy_tree_zip_error_test.exs:5
     ** (ExUnitProperties.Error) failed with generated values (after 0
successful run(s)):

         document_node <- document_node()
         #=> %{id: 0, type: :document}

     got exception:

         ** (UndefinedFunctionError) function
StreamdataLazyTreeZipError.doesnotexist/1 is undefined or private
     code: check all document_node <- document_node(), max_runs: 15 do
     stacktrace:
       (streamdata_lazy_tree_zip_error)
StreamdataLazyTreeZipError.doesnotexist(%{id: 0, type: :document})
       test/streamdata_lazy_tree_zip_error_test.exs:10: anonymous fn/2 in
StreamdataLazyTreeZipErrorTest."property strip/1 removes script, noscript tags
from dom"/1
       (stream_data) lib/stream_data.ex:2053: StreamData.shrink_failure/6
       (stream_data) lib/stream_data.ex:2017: StreamData.check_all/7
       test/streamdata_lazy_tree_zip_error_test.exs:6: (test)
```

and sometimes

```
  1) property strip/1 removes script, noscript tags from dom
(StreamdataLazyTreeZipErrorTest)
     test/streamdata_lazy_tree_zip_error_test.exs:5
     ** (FunctionClauseError) no function clause matching in anonymous fn/1 in
StreamData.LazyTree.zip/1

     The following arguments were given to anonymous fn/1 in
StreamData.LazyTree.zip/1:

         # 1
         false

     code: check all document_node <- document_node(), max_runs: 15 do
     stacktrace:
       (stream_data) lib/stream_data/lazy_tree.ex:151: anonymous fn/1 in
StreamData.LazyTree.zip/1
       (elixir) lib/enum.ex:1255: Enum."-map/2-lists^map/1-0-"/2
       (stream_data) lib/stream_data/lazy_tree.ex:151: StreamData.LazyTree.zip/1
       (elixir) lib/stream.ex:516: anonymous fn/4 in Stream.map/2
       (elixir) lib/enum.ex:3161: Enumerable.List.reduce/3
       (elixir) lib/stream.ex:849: Stream.do_list_transform/10
       (elixir) lib/stream.ex:1433: Enumerable.Stream.do_each/4
       (elixir) lib/stream.ex:870: Stream.do_enum_transform/10
       (elixir) lib/stream.ex:1433: Enumerable.Stream.do_each/4
       (elixir) lib/stream.ex:870: Stream.do_enum_transform/10
       (elixir) lib/stream.ex:806: Stream.do_transform/8
       (elixir) lib/stream.ex:1433: Enumerable.Stream.do_each/4
       (elixir) lib/stream.ex:870: Stream.do_enum_transform/10
       (elixir) lib/stream.ex:806: Stream.do_transform/8
       (elixir) lib/stream.ex:1433: Enumerable.Stream.do_each/4
       (elixir) lib/stream.ex:870: Stream.do_enum_transform/10
       (stream_data) lib/stream_data.ex:2045: StreamData.shrink_failure/6
       (stream_data) lib/stream_data.ex:2017: StreamData.check_all/7
       test/streamdata_lazy_tree_zip_error_test.exs:6: (test)
```

I don't get the second error in StreamData 0.4.0.
