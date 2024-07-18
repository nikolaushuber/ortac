(* This file is generated by ortac qcheck-stm,
   edit how you run the tool instead *)
[@@@ocaml.warning "-26-27-69-32"]
open Record
module Ortac_runtime = Ortac_runtime_qcheck_stm
let plus1_1 i =
  try
    Ortac_runtime.Gospelstdlib.(+) i
      (Ortac_runtime.Gospelstdlib.integer_of_int 1)
  with
  | e ->
      raise
        (Ortac_runtime.Partial_function
           (e,
             {
               Ortac_runtime.start =
                 {
                   pos_fname = "record.mli";
                   pos_lnum = 13;
                   pos_bol = 525;
                   pos_cnum = 571
                 };
               Ortac_runtime.stop =
                 {
                   pos_fname = "record.mli";
                   pos_lnum = 13;
                   pos_bol = 525;
                   pos_cnum = 572
                 }
             }))
module SUT =
  (Ortac_runtime.SUT.Make)(struct
                             type sut = t
                             let init = Some (fun () -> make 42)
                           end)
module ModelElt =
  struct
    type nonrec elt = {
      value: Ortac_runtime.integer }
    let init =
      Some
        (let i_4 = 42 in
         {
           value =
             (try Ortac_runtime.Gospelstdlib.integer_of_int i_4
              with
              | e ->
                  raise
                    (Ortac_runtime.Partial_function
                       (e,
                         {
                           Ortac_runtime.start =
                             {
                               pos_fname = "record.mli";
                               pos_lnum = 7;
                               pos_bol = 285;
                               pos_cnum = 307
                             };
                           Ortac_runtime.stop =
                             {
                               pos_fname = "record.mli";
                               pos_lnum = 7;
                               pos_bol = 285;
                               pos_cnum = 308
                             }
                         })))
         })
  end
module Model = (Ortac_runtime.Model.Make)(ModelElt)
module Spec =
  struct
    open STM
    type _ ty +=  
      | Integer: Ortac_runtime.integer ty 
    let integer = (Integer, Ortac_runtime.string_of_integer)
    type sut = SUT.t
    let init_sut = SUT.create
    type state = Model.t
    let init_state = Model.create ()
    type cmd =
      | Plus1 of int 
      | Plus2 of int 
      | Get 
    let show_cmd cmd__001_ =
      match cmd__001_ with
      | Plus1 i_1 ->
          Format.asprintf "%s %a" "plus1" (Util.Pp.pp_int true) i_1
      | Plus2 i_2 ->
          Format.asprintf "%s %a" "plus2" (Util.Pp.pp_int true) i_2
      | Get -> Format.asprintf "%s sut" "get"
    let cleanup _ = ()
    let arb_cmd _ =
      let open QCheck in
        make ~print:show_cmd
          (let open Gen in
             oneof
               [(pure (fun i_1 -> Plus1 i_1)) <*> int;
               (pure (fun i_2 -> Plus2 i_2)) <*> int;
               pure Get])
    let next_state cmd__002_ state__003_ =
      match cmd__002_ with
      | Plus1 i_1 -> state__003_
      | Plus2 i_2 -> state__003_
      | Get -> state__003_
    let precond cmd__025_ state__026_ =
      match cmd__025_ with
      | Plus1 i_1 -> true
      | Plus2 i_2 -> true
      | Get -> true
    let postcond _ _ _ = true
    let run cmd__027_ sut__028_ =
      match cmd__027_ with
      | Plus1 i_1 -> Res (int, (let res__029_ = plus1 i_1 in res__029_))
      | Plus2 i_2 -> Res (int, (let res__030_ = plus2 i_2 in res__030_))
      | Get ->
          Res
            (int,
              (let tmp__031_ = SUT.pop sut__028_ in
               let res__032_ = get tmp__031_ in
               (SUT.push tmp__031_ sut__028_; res__032_)))
  end
module STMTests = (Ortac_runtime.Make)(Spec)
let check_init_state () = ()
let ortac_postcond cmd__005_ state__006_ res__007_ =
  let open Spec in
    let open STM in
      let new_state__008_ = lazy (next_state cmd__005_ state__006_) in
      match (cmd__005_, res__007_) with
      | (Plus1 i_1, Res ((Int, _), i1)) ->
          if
            (try
               (Ortac_runtime.Gospelstdlib.integer_of_int i1) =
                 (Ortac_runtime.Gospelstdlib.(+)
                    (Ortac_runtime.Gospelstdlib.integer_of_int i_1)
                    (Ortac_runtime.Gospelstdlib.integer_of_int 1))
             with
             | e ->
                 raise
                   (Ortac_runtime.Partial_function
                      (e,
                        {
                          Ortac_runtime.start =
                            {
                              pos_fname = "record.mli";
                              pos_lnum = 11;
                              pos_bol = 425;
                              pos_cnum = 437
                            };
                          Ortac_runtime.stop =
                            {
                              pos_fname = "record.mli";
                              pos_lnum = 11;
                              pos_bol = 425;
                              pos_cnum = 447
                            }
                        })))
          then None
          else
            Some
              (Ortac_runtime.report "Record" "make 42"
                 (Either.right
                    (Res
                       (integer,
                         (try
                            Ortac_runtime.Gospelstdlib.(+)
                              (Ortac_runtime.Gospelstdlib.integer_of_int i_1)
                              (Ortac_runtime.Gospelstdlib.integer_of_int 1)
                          with
                          | e ->
                              raise
                                (Ortac_runtime.Partial_function
                                   (e,
                                     {
                                       Ortac_runtime.start =
                                         {
                                           pos_fname = "record.mli";
                                           pos_lnum = 11;
                                           pos_bol = 425;
                                           pos_cnum = 444
                                         };
                                       Ortac_runtime.stop =
                                         {
                                           pos_fname = "record.mli";
                                           pos_lnum = 11;
                                           pos_bol = 425;
                                           pos_cnum = 445
                                         }
                                     })))))) "plus1"
                 [("i1 = i + 1",
                    {
                      Ortac_runtime.start =
                        {
                          pos_fname = "record.mli";
                          pos_lnum = 11;
                          pos_bol = 425;
                          pos_cnum = 437
                        };
                      Ortac_runtime.stop =
                        {
                          pos_fname = "record.mli";
                          pos_lnum = 11;
                          pos_bol = 425;
                          pos_cnum = 447
                        }
                    })])
      | (Plus2 i_2, Res ((Int, _), i2)) ->
          if
            (try
               (Ortac_runtime.Gospelstdlib.integer_of_int i2) =
                 (Ortac_runtime.Gospelstdlib.(+)
                    (Ortac_runtime.Gospelstdlib.integer_of_int i_2)
                    (Ortac_runtime.Gospelstdlib.integer_of_int 2))
             with
             | e ->
                 raise
                   (Ortac_runtime.Partial_function
                      (e,
                        {
                          Ortac_runtime.start =
                            {
                              pos_fname = "record.mli";
                              pos_lnum = 18;
                              pos_bol = 727;
                              pos_cnum = 739
                            };
                          Ortac_runtime.stop =
                            {
                              pos_fname = "record.mli";
                              pos_lnum = 18;
                              pos_bol = 727;
                              pos_cnum = 749
                            }
                        })))
          then None
          else
            Some
              (Ortac_runtime.report "Record" "make 42"
                 (Either.right
                    (Res
                       (integer,
                         (try
                            Ortac_runtime.Gospelstdlib.(+)
                              (Ortac_runtime.Gospelstdlib.integer_of_int i_2)
                              (Ortac_runtime.Gospelstdlib.integer_of_int 2)
                          with
                          | e ->
                              raise
                                (Ortac_runtime.Partial_function
                                   (e,
                                     {
                                       Ortac_runtime.start =
                                         {
                                           pos_fname = "record.mli";
                                           pos_lnum = 18;
                                           pos_bol = 727;
                                           pos_cnum = 746
                                         };
                                       Ortac_runtime.stop =
                                         {
                                           pos_fname = "record.mli";
                                           pos_lnum = 18;
                                           pos_bol = 727;
                                           pos_cnum = 747
                                         }
                                     })))))) "plus2"
                 [("i2 = i + 2",
                    {
                      Ortac_runtime.start =
                        {
                          pos_fname = "record.mli";
                          pos_lnum = 18;
                          pos_bol = 727;
                          pos_cnum = 739
                        };
                      Ortac_runtime.stop =
                        {
                          pos_fname = "record.mli";
                          pos_lnum = 18;
                          pos_bol = 727;
                          pos_cnum = 749
                        }
                    })])
      | (Get, Res ((Int, _), i_3)) ->
          Ortac_runtime.append
            (if
               let r_new__016_ =
                 lazy (Model.get (Lazy.force new_state__008_) 0) in
               let r_old__015_ = lazy (Model.get state__006_ 0) in
               try
                 (Ortac_runtime.Gospelstdlib.integer_of_int i_3) =
                   (Lazy.force r_new__016_).value
               with
               | e ->
                   raise
                     (Ortac_runtime.Partial_function
                        (e,
                          {
                            Ortac_runtime.start =
                              {
                                pos_fname = "record.mli";
                                pos_lnum = 23;
                                pos_bol = 868;
                                pos_cnum = 880
                              };
                            Ortac_runtime.stop =
                              {
                                pos_fname = "record.mli";
                                pos_lnum = 23;
                                pos_bol = 868;
                                pos_cnum = 891
                              }
                          }))
             then None
             else
               Some
                 (Ortac_runtime.report "Record" "make 42"
                    (Either.right
                       (Res
                          (integer,
                            (let r_new__012_ =
                               lazy
                                 (Model.get (Lazy.force new_state__008_) 0) in
                             let r_old__011_ = lazy (Model.get state__006_ 0) in
                             try (Lazy.force r_new__012_).value
                             with
                             | e ->
                                 raise
                                   (Ortac_runtime.Partial_function
                                      (e,
                                        {
                                          Ortac_runtime.start =
                                            {
                                              pos_fname = "record.mli";
                                              pos_lnum = 23;
                                              pos_bol = 868;
                                              pos_cnum = 884
                                            };
                                          Ortac_runtime.stop =
                                            {
                                              pos_fname = "record.mli";
                                              pos_lnum = 23;
                                              pos_bol = 868;
                                              pos_cnum = 891
                                            }
                                        })))))) "get"
                    [("i = r.value",
                       {
                         Ortac_runtime.start =
                           {
                             pos_fname = "record.mli";
                             pos_lnum = 23;
                             pos_bol = 868;
                             pos_cnum = 880
                           };
                         Ortac_runtime.stop =
                           {
                             pos_fname = "record.mli";
                             pos_lnum = 23;
                             pos_bol = 868;
                             pos_cnum = 891
                           }
                       })]))
            (Ortac_runtime.append
               (if
                  let r_new__020_ =
                    lazy (Model.get (Lazy.force new_state__008_) 0) in
                  let r_old__019_ = lazy (Model.get state__006_ 0) in
                  try
                    (plus1_1 (Ortac_runtime.Gospelstdlib.integer_of_int i_3))
                      =
                      (Ortac_runtime.Gospelstdlib.(+)
                         (Ortac_runtime.Gospelstdlib.integer_of_int i_3)
                         (Ortac_runtime.Gospelstdlib.integer_of_int 1))
                  with
                  | e ->
                      raise
                        (Ortac_runtime.Partial_function
                           (e,
                             {
                               Ortac_runtime.start =
                                 {
                                   pos_fname = "record.mli";
                                   pos_lnum = 25;
                                   pos_bol = 912;
                                   pos_cnum = 924
                                 };
                               Ortac_runtime.stop =
                                 {
                                   pos_fname = "record.mli";
                                   pos_lnum = 25;
                                   pos_bol = 912;
                                   pos_cnum = 939
                                 }
                             }))
                then None
                else
                  Some
                    (Ortac_runtime.report "Record" "make 42"
                       (Either.right
                          (Res
                             (integer,
                               (let r_new__012_ =
                                  lazy
                                    (Model.get (Lazy.force new_state__008_) 0) in
                                let r_old__011_ =
                                  lazy (Model.get state__006_ 0) in
                                try (Lazy.force r_new__012_).value
                                with
                                | e ->
                                    raise
                                      (Ortac_runtime.Partial_function
                                         (e,
                                           {
                                             Ortac_runtime.start =
                                               {
                                                 pos_fname = "record.mli";
                                                 pos_lnum = 23;
                                                 pos_bol = 868;
                                                 pos_cnum = 884
                                               };
                                             Ortac_runtime.stop =
                                               {
                                                 pos_fname = "record.mli";
                                                 pos_lnum = 23;
                                                 pos_bol = 868;
                                                 pos_cnum = 891
                                               }
                                           })))))) "get"
                       [("plus1 i = i + 1",
                          {
                            Ortac_runtime.start =
                              {
                                pos_fname = "record.mli";
                                pos_lnum = 25;
                                pos_bol = 912;
                                pos_cnum = 924
                              };
                            Ortac_runtime.stop =
                              {
                                pos_fname = "record.mli";
                                pos_lnum = 25;
                                pos_bol = 912;
                                pos_cnum = 939
                              }
                          })]))
               (if
                  let r_new__022_ =
                    lazy (Model.get (Lazy.force new_state__008_) 0) in
                  let r_old__021_ = lazy (Model.get state__006_ 0) in
                  try
                    (Ortac_runtime.Gospelstdlib.integer_of_int (plus2 i_3)) =
                      (Ortac_runtime.Gospelstdlib.(+)
                         (Ortac_runtime.Gospelstdlib.integer_of_int i_3)
                         (Ortac_runtime.Gospelstdlib.integer_of_int 2))
                  with
                  | e ->
                      raise
                        (Ortac_runtime.Partial_function
                           (e,
                             {
                               Ortac_runtime.start =
                                 {
                                   pos_fname = "record.mli";
                                   pos_lnum = 26;
                                   pos_bol = 940;
                                   pos_cnum = 952
                                 };
                               Ortac_runtime.stop =
                                 {
                                   pos_fname = "record.mli";
                                   pos_lnum = 26;
                                   pos_bol = 940;
                                   pos_cnum = 967
                                 }
                             }))
                then None
                else
                  Some
                    (Ortac_runtime.report "Record" "make 42"
                       (Either.right
                          (Res
                             (integer,
                               (let r_new__012_ =
                                  lazy
                                    (Model.get (Lazy.force new_state__008_) 0) in
                                let r_old__011_ =
                                  lazy (Model.get state__006_ 0) in
                                try (Lazy.force r_new__012_).value
                                with
                                | e ->
                                    raise
                                      (Ortac_runtime.Partial_function
                                         (e,
                                           {
                                             Ortac_runtime.start =
                                               {
                                                 pos_fname = "record.mli";
                                                 pos_lnum = 23;
                                                 pos_bol = 868;
                                                 pos_cnum = 884
                                               };
                                             Ortac_runtime.stop =
                                               {
                                                 pos_fname = "record.mli";
                                                 pos_lnum = 23;
                                                 pos_bol = 868;
                                                 pos_cnum = 891
                                               }
                                           })))))) "get"
                       [("plus2 i = i + 2",
                          {
                            Ortac_runtime.start =
                              {
                                pos_fname = "record.mli";
                                pos_lnum = 26;
                                pos_bol = 940;
                                pos_cnum = 952
                              };
                            Ortac_runtime.stop =
                              {
                                pos_fname = "record.mli";
                                pos_lnum = 26;
                                pos_bol = 940;
                                pos_cnum = 967
                              }
                          })])))
      | _ -> None
let _ =
  QCheck_base_runner.run_tests_main
    (let count = 1000 in
     [STMTests.agree_test ~count ~name:"Record STM tests" check_init_state
        ortac_postcond])
