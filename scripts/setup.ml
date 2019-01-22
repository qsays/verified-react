let set_imandra_node_process : Node.Child_process.spawnResult -> unit = [%raw fun x -> "{global.imandraNodeProcess = x}"]

let default = fun () ->
  let open Imandra_client in
  Imandra_client.start (imandra_options ())
  |> Js.Promise.then_ (fun (np, isi) ->
      set_imandra_node_process np;
      Imandra_client.Server_info.to_file isi;
      Js.Promise.resolve ()
    )
