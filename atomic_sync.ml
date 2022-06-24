type t = { mutable x : int }

let v = { x = 0 }

let v_modified = Atomic.make false

let () =
  let t1 =
    Domain.spawn (fun () ->
        v.x <- 10;
        Atomic.set v_modified true;
        Unix.sleep 1)
  in
  let t2 =
    Domain.spawn (fun () ->
        while not (Atomic.get v_modified) do () done;
        ignore (Sys.opaque_identity v.x);
        Unix.sleep 1)
  in
  Domain.join t1;
  Domain.join t2
