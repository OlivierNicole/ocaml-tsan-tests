type t = { mutable x : int }

let v = { x = 0 }

let () =
  let t1 = Domain.spawn (fun () -> v.x <- 10; Unix.sleep 1) in
  let t2 = Domain.spawn (fun () -> ignore (Sys.opaque_identity v.x); Unix.sleep 1) in
  Domain.join t1;
  Domain.join t2
  (*
  let[@local never][@inline never] f () = v.x <- 10; print_int 1 in
  f ()
  *)
