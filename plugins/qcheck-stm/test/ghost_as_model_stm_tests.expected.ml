(* This file is generated by ortac qcheck-stm,
   edit how you run the tool instead *)
[@@@ocaml.warning "-26-27-69-32"]
open Ghost_as_model
module Ortac_runtime = Ortac_runtime_qcheck_stm
type m =
  | A of Ortac_runtime.integer 
module SUT =
  (Ortac_runtime.SUT.Make)(struct
                             type sut = t
                             let init = Some (fun () -> create ())
                           end)
module Spec =
  struct
    open STM
    type _ ty +=  
      | Integer: Ortac_runtime.integer ty 
    let integer = (Integer, Ortac_runtime.string_of_integer)
    type sut = SUT.t
    let init_sut = SUT.create
    type cmd =
      | Use 
    let show_cmd cmd__001_ =
      match cmd__001_ with | Use -> Format.asprintf "%s sut" "use"
    type nonrec state = {
      m_1: m }
    let init_state =
      let () = () in
      {
        m_1 =
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
                            pos_bol = 343;
                            pos_cnum = 361
                          };
                        Ortac_runtime.stop =
                          {
                            pos_fname = "ghost_as_model.mli";
                            pos_lnum = 8;
                            pos_bol = 343;
                            pos_cnum = 362
                          }
                      })))
      }
    let cleanup _ = ()
    let arb_cmd _ =
      let open QCheck in
        make ~print:show_cmd (let open Gen in oneof [pure Use])
    let next_state cmd__002_ state__003_ =
      match cmd__002_ with
      | Use ->
          {
            m_1 =
              ((try
                  match state__003_.m_1 with
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
                                 pos_bol = 502;
                                 pos_cnum = 520
                               };
                             Ortac_runtime.stop =
                               {
                                 pos_fname = "ghost_as_model.mli";
                                 pos_lnum = 13;
                                 pos_bol = 502;
                                 pos_cnum = 556
                               }
                           }))))
          }
    let precond cmd__008_ state__009_ = match cmd__008_ with | Use -> true
    let postcond _ _ _ = true
    let run cmd__010_ sut__011_ =
      match cmd__010_ with
      | Use ->
          Res
            (unit,
              (let tmp__012_ = SUT.pop sut__011_ in
               let res__013_ = use tmp__012_ in
               (SUT.push tmp__012_ sut__011_; res__013_)))
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
