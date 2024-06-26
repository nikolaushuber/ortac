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
module Spec =
  struct
    open STM
    type _ ty +=  
      | Integer: Ortac_runtime.integer ty 
    let integer = (Integer, Ortac_runtime.string_of_integer)
    type sut = t
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
    type nonrec state = {
      value: Ortac_runtime.integer }
    let init_state =
      let i_4 = 42 in
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
      }
    let init_sut () = make 42
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
    let precond cmd__008_ state__009_ =
      match cmd__008_ with
      | Plus1 i_1 -> true
      | Plus2 i_2 -> true
      | Get -> true
    let postcond _ _ _ = true
    let run cmd__010_ sut__011_ =
      match cmd__010_ with
      | Plus1 i_1 -> Res (int, (plus1 i_1))
      | Plus2 i_2 -> Res (int, (plus2 i_2))
      | Get -> Res (int, (get sut__011_))
  end
module STMTests = (Ortac_runtime.Make)(Spec)
let check_init_state () = ()
let ortac_postcond cmd__004_ state__005_ res__006_ =
  let open Spec in
    let open STM in
      let new_state__007_ = lazy (next_state cmd__004_ state__005_) in
      match (cmd__004_, res__006_) with
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
               try
                 (Ortac_runtime.Gospelstdlib.integer_of_int i_3) =
                   (Lazy.force new_state__007_).value
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
                            (try (Lazy.force new_state__007_).value
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
                               (try (Lazy.force new_state__007_).value
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
                               (try (Lazy.force new_state__007_).value
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
