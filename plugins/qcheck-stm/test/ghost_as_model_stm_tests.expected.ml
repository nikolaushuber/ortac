(* This file is generated by ortac qcheck-stm,
   edit how you run the tool instead *)
[@@@ocaml.warning "-26-27"]
open Ghost_as_model
module Ortac_runtime = Ortac_runtime_qcheck_stm
type m =
  | A of Ortac_runtime.integer 
module Spec =
  struct
    open STM
    type sut = t
    type cmd =
      | Use 
    let show_cmd cmd__001_ =
      match cmd__001_ with | Use -> Format.asprintf "%s sut" "use"
    type nonrec state = {
      view: m }
    let init_state =
      let () = () in
      {
        view =
          (try A (Ortac_runtime.Gospelstdlib.integer_of_int 0)
           with
           | e ->
               raise
                 (Ortac_runtime.Partial_function
                    (e,
                      {
                        Ortac_runtime.start =
                          {
                            pos_fname = "ghost_as_model.mli";
                            pos_lnum = 8;
                            pos_bol = 349;
                            pos_cnum = 370
                          };
                        Ortac_runtime.stop =
                          {
                            pos_fname = "ghost_as_model.mli";
                            pos_lnum = 8;
                            pos_bol = 349;
                            pos_cnum = 371
                          }
                      })))
      }
    let init_sut () = create ()
    let cleanup _ = ()
    let arb_cmd _ =
      let open QCheck in
        make ~print:show_cmd (let open Gen in oneof [pure Use])
    let next_state cmd__002_ state__003_ =
      match cmd__002_ with
      | Use ->
          {
            view =
              ((try
                  match state__003_.view with
                  | A x -> A (Ortac_runtime.Gospelstdlib.succ x)
                with
                | e ->
                    raise
                      (Ortac_runtime.Partial_function
                         (e,
                           {
                             Ortac_runtime.start =
                               {
                                 pos_fname = "ghost_as_model.mli";
                                 pos_lnum = 13;
                                 pos_bol = 517;
                                 pos_cnum = 538
                               };
                             Ortac_runtime.stop =
                               {
                                 pos_fname = "ghost_as_model.mli";
                                 pos_lnum = 13;
                                 pos_bol = 517;
                                 pos_cnum = 577
                               }
                           }))))
          }
    let precond cmd__008_ state__009_ = match cmd__008_ with | Use -> true
    let postcond _ _ _ = true
    let run cmd__010_ sut__011_ =
      match cmd__010_ with | Use -> Res (unit, (use sut__011_))
  end
module STMTests = (Ortac_runtime.Make)(Spec)
let check_init_state () = ()
let ortac_postcond cmd__004_ state__005_ res__006_ =
  let open Spec in
    let open STM in
      let new_state__007_ = lazy (next_state cmd__004_ state__005_) in
      match (cmd__004_, res__006_) with
      | (Use, Res ((Unit, _), _)) -> None
      | _ -> None
let _ =
  QCheck_base_runner.run_tests_main
    (let count = 1000 in
     [STMTests.agree_test ~count ~name:"Ghost_as_model STM tests"
        check_init_state ortac_postcond])
