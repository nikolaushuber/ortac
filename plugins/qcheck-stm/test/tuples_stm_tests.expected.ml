(* This file is generated by ortac qcheck-stm,
   edit how you run the tool instead *)
[@@@ocaml.warning "-26-27-69-32-38"]
open Tuples
module Ortac_runtime = Ortac_runtime_qcheck_stm
module SUT =
  (Ortac_runtime.SUT.Make)(struct
                             type sut = (char, int) t
                             let init () = create ()
                           end)
module ModelElt =
  struct
    type nonrec elt = {
      contents: (char * int) list }
    let init =
      let () = () in
      {
        contents =
          (try []
           with
           | e ->
               raise
                 (Ortac_runtime.Partial_function
                    (e,
                      {
                        Ortac_runtime.start =
                          {
                            pos_fname = "tuples.mli";
                            pos_lnum = 6;
                            pos_bol = 251;
                            pos_cnum = 276
                          };
                        Ortac_runtime.stop =
                          {
                            pos_fname = "tuples.mli";
                            pos_lnum = 6;
                            pos_bol = 251;
                            pos_cnum = 278
                          }
                      })))
      }
  end
module Model = (Ortac_runtime.Model.Make)(ModelElt)
module Spec =
  struct
    open STM
    type _ ty +=  
      | Integer: Ortac_runtime.integer ty 
    let integer = (Integer, Ortac_runtime.string_of_integer)
    type _ ty +=  
      | SUT: SUT.elt ty 
    let sut = (SUT, (fun _ -> "<sut>"))
    type _ ty +=  
      | Tup2: 'a1 ty * 'a2 ty -> ('a1 * 'a2) ty 
      | Tup3: 'a1 ty * 'a2 ty * 'a3 ty -> ('a1 * 'a2 * 'a3) ty 
    let tup2 spec1 spec2 =
      let (ty1, show1) = spec1
      and (ty2, show2) = spec2 in
      ((Tup2 (ty1, ty2)),
        (Util.Pp.to_show
           (Util.Pp.pp_tuple2 (Util.Pp.of_show show1) (Util.Pp.of_show show2))))
    and tup3 spec1 spec2 spec3 =
      let (ty1, show1) = spec1
      and (ty2, show2) = spec2
      and (ty3, show3) = spec3 in
      ((Tup3 (ty1, ty2, ty3)),
        (Util.Pp.to_show
           (Util.Pp.pp_tuple3 (Util.Pp.of_show show1) (Util.Pp.of_show show2)
              (Util.Pp.of_show show3))))
    type sut = SUT.t
    let init_sut = SUT.create 1
    type state = Model.t
    let init_state = Model.create 1 ()
    type cmd =
      | Create of unit 
      | Clear 
      | Add of (char * int) 
      | Add' of (bool * char * int) 
      | Add'' of (bool * (char * int)) 
      | Size_tup 
      | Size_tup' 
    let show_cmd cmd__001_ =
      match cmd__001_ with
      | Create () ->
          Format.asprintf "%s %a" "create" (Util.Pp.pp_unit true) ()
      | Clear -> Format.asprintf "%s <sut>" "clear"
      | Add tup ->
          Format.asprintf "%s <sut> %a" "add"
            (Util.Pp.pp_tuple2 Util.Pp.pp_char Util.Pp.pp_int true) tup
      | Add' tup_1 ->
          Format.asprintf "%s <sut> %a" "add'"
            (Util.Pp.pp_tuple3 Util.Pp.pp_bool Util.Pp.pp_char Util.Pp.pp_int
               true) tup_1
      | Add'' tup_2 ->
          Format.asprintf "%s <sut> %a" "add''"
            (Util.Pp.pp_tuple2 Util.Pp.pp_bool
               (Util.Pp.pp_tuple2 Util.Pp.pp_char Util.Pp.pp_int) true) tup_2
      | Size_tup -> Format.asprintf "%s <sut>" "size_tup"
      | Size_tup' -> Format.asprintf "%s <sut>" "size_tup'"
    let cleanup _ = ()
    let arb_cmd _ =
      let open QCheck in
        make ~print:show_cmd
          (let open Gen in
             oneof
               [(pure (fun () -> Create ())) <*> unit;
               pure Clear;
               (pure (fun tup -> Add tup)) <*> (tup2 char int);
               (pure (fun tup_1 -> Add' tup_1)) <*> (tup3 bool char int);
               (pure (fun tup_2 -> Add'' tup_2)) <*>
                 (tup2 bool (tup2 char int));
               pure Size_tup;
               pure Size_tup'])
    let next_state cmd__002_ state__003_ =
      match cmd__002_ with
      | Create () ->
          let h__005_ =
            let open ModelElt in
              {
                contents =
                  (try []
                   with
                   | e ->
                       raise
                         (Ortac_runtime.Partial_function
                            (e,
                              {
                                Ortac_runtime.start =
                                  {
                                    pos_fname = "tuples.mli";
                                    pos_lnum = 6;
                                    pos_bol = 251;
                                    pos_cnum = 276
                                  };
                                Ortac_runtime.stop =
                                  {
                                    pos_fname = "tuples.mli";
                                    pos_lnum = 6;
                                    pos_bol = 251;
                                    pos_cnum = 278
                                  }
                              })))
              } in
          Model.push (Model.drop_n state__003_ 0) h__005_
      | Clear ->
          let h_1__006_ = Model.get state__003_ 0 in
          let h_1__007_ =
            let open ModelElt in
              {
                contents =
                  (try []
                   with
                   | e ->
                       raise
                         (Ortac_runtime.Partial_function
                            (e,
                              {
                                Ortac_runtime.start =
                                  {
                                    pos_fname = "tuples.mli";
                                    pos_lnum = 11;
                                    pos_bol = 416;
                                    pos_cnum = 441
                                  };
                                Ortac_runtime.stop =
                                  {
                                    pos_fname = "tuples.mli";
                                    pos_lnum = 11;
                                    pos_bol = 416;
                                    pos_cnum = 443
                                  }
                              })))
              } in
          Model.push (Model.drop_n state__003_ 1) h_1__007_
      | Add tup ->
          let h_2__008_ = Model.get state__003_ 0 in
          let h_2__009_ =
            let open ModelElt in
              {
                contents =
                  (try
                     match tup with
                     | (a_1, b_1) -> (a_1, b_1) :: h_2__008_.contents
                   with
                   | e ->
                       raise
                         (Ortac_runtime.Partial_function
                            (e,
                              {
                                Ortac_runtime.start =
                                  {
                                    pos_fname = "tuples.mli";
                                    pos_lnum = 16;
                                    pos_bol = 594;
                                    pos_cnum = 619
                                  };
                                Ortac_runtime.stop =
                                  {
                                    pos_fname = "tuples.mli";
                                    pos_lnum = 16;
                                    pos_bol = 594;
                                    pos_cnum = 666
                                  }
                              })))
              } in
          Model.push (Model.drop_n state__003_ 1) h_2__009_
      | Add' tup_1 ->
          let h_3__010_ = Model.get state__003_ 0 in
          let h_3__011_ =
            let open ModelElt in
              {
                contents =
                  (try
                     match tup_1 with
                     | (c, a_2, b_2) ->
                         if c = true
                         then (a_2, b_2) :: h_3__010_.contents
                         else h_3__010_.contents
                   with
                   | e ->
                       raise
                         (Ortac_runtime.Partial_function
                            (e,
                              {
                                Ortac_runtime.start =
                                  {
                                    pos_fname = "tuples.mli";
                                    pos_lnum = 21;
                                    pos_bol = 871;
                                    pos_cnum = 896
                                  };
                                Ortac_runtime.stop =
                                  {
                                    pos_fname = "tuples.mli";
                                    pos_lnum = 23;
                                    pos_bol = 965;
                                    pos_cnum = 992
                                  }
                              })))
              } in
          Model.push (Model.drop_n state__003_ 1) h_3__011_
      | Add'' tup_2 ->
          let h_4__012_ = Model.get state__003_ 0 in
          let h_4__013_ =
            let open ModelElt in
              {
                contents =
                  (try
                     match tup_2 with
                     | (c_1, (a_3, b_3)) ->
                         if c_1 = true
                         then (a_3, b_3) :: h_4__012_.contents
                         else h_4__012_.contents
                   with
                   | e ->
                       raise
                         (Ortac_runtime.Partial_function
                            (e,
                              {
                                Ortac_runtime.start =
                                  {
                                    pos_fname = "tuples.mli";
                                    pos_lnum = 28;
                                    pos_bol = 1156;
                                    pos_cnum = 1181
                                  };
                                Ortac_runtime.stop =
                                  {
                                    pos_fname = "tuples.mli";
                                    pos_lnum = 30;
                                    pos_bol = 1252;
                                    pos_cnum = 1279
                                  }
                              })))
              } in
          Model.push (Model.drop_n state__003_ 1) h_4__013_
      | Size_tup ->
          let t_1__014_ = Model.get state__003_ 0 in
          let t_1__015_ = t_1__014_ in
          Model.push (Model.drop_n state__003_ 1) t_1__015_
      | Size_tup' ->
          let t_2__016_ = Model.get state__003_ 0 in
          let t_2__017_ = t_2__016_ in
          Model.push (Model.drop_n state__003_ 1) t_2__017_
    let precond cmd__038_ state__039_ =
      match cmd__038_ with
      | Create () -> true
      | Clear -> let h_1__040_ = Model.get state__039_ 0 in true
      | Add tup -> let h_2__041_ = Model.get state__039_ 0 in true
      | Add' tup_1 -> let h_3__042_ = Model.get state__039_ 0 in true
      | Add'' tup_2 -> let h_4__043_ = Model.get state__039_ 0 in true
      | Size_tup -> let t_1__044_ = Model.get state__039_ 0 in true
      | Size_tup' -> let t_2__045_ = Model.get state__039_ 0 in true
    let postcond _ _ _ = true
    let run cmd__046_ sut__047_ =
      match cmd__046_ with
      | Create () ->
          Res
            (sut,
              (let res__048_ = create () in
               (SUT.push sut__047_ res__048_; res__048_)))
      | Clear ->
          Res
            (unit,
              (let h_1__049_ = SUT.pop sut__047_ in
               let res__050_ = clear h_1__049_ in
               (SUT.push sut__047_ h_1__049_; res__050_)))
      | Add tup ->
          Res
            (unit,
              (let h_2__051_ = SUT.pop sut__047_ in
               let res__052_ = add h_2__051_ tup in
               (SUT.push sut__047_ h_2__051_; res__052_)))
      | Add' tup_1 ->
          Res
            (unit,
              (let h_3__053_ = SUT.pop sut__047_ in
               let res__054_ = add' h_3__053_ tup_1 in
               (SUT.push sut__047_ h_3__053_; res__054_)))
      | Add'' tup_2 ->
          Res
            (unit,
              (let h_4__055_ = SUT.pop sut__047_ in
               let res__056_ = add'' h_4__055_ tup_2 in
               (SUT.push sut__047_ h_4__055_; res__056_)))
      | Size_tup ->
          Res
            ((tup2 int int),
              (let t_1__057_ = SUT.pop sut__047_ in
               let res__058_ = size_tup t_1__057_ in
               (SUT.push sut__047_ t_1__057_; res__058_)))
      | Size_tup' ->
          Res
            ((tup3 int int int),
              (let t_2__059_ = SUT.pop sut__047_ in
               let res__060_ = size_tup' t_2__059_ in
               (SUT.push sut__047_ t_2__059_; res__060_)))
  end
module STMTests = (Ortac_runtime.Make)(Spec)
let check_init_state () = ()
let ortac_show_cmd cmd__062_ state__063_ =
  let open Spec in
    match cmd__062_ with
    | Create () -> Format.asprintf "%s %a" "create" (Util.Pp.pp_unit true) ()
    | Clear -> Format.asprintf "%s %s" "clear" (SUT.get_name state__063_ 0)
    | Add tup ->
        Format.asprintf "%s %s %a" "add" (SUT.get_name state__063_ 0)
          (Util.Pp.pp_tuple2 Util.Pp.pp_char Util.Pp.pp_int true) tup
    | Add' tup_1 ->
        Format.asprintf "%s %s %a" "add'" (SUT.get_name state__063_ 0)
          (Util.Pp.pp_tuple3 Util.Pp.pp_bool Util.Pp.pp_char Util.Pp.pp_int
             true) tup_1
    | Add'' tup_2 ->
        Format.asprintf "%s %s %a" "add''" (SUT.get_name state__063_ 0)
          (Util.Pp.pp_tuple2 Util.Pp.pp_bool
             (Util.Pp.pp_tuple2 Util.Pp.pp_char Util.Pp.pp_int) true) tup_2
    | Size_tup ->
        Format.asprintf "%s %s" "size_tup" (SUT.get_name state__063_ 0)
    | Size_tup' ->
        Format.asprintf "%s %s" "size_tup'" (SUT.get_name state__063_ 0)
let ortac_postcond cmd__018_ state__019_ res__020_ =
  let open Spec in
    let open STM in
      let new_state__021_ = lazy (next_state cmd__018_ state__019_) in
      match (cmd__018_, res__020_) with
      | (Create (), Res ((SUT, _), h)) -> None
      | (Clear, Res ((Unit, _), _)) -> None
      | (Add tup, Res ((Unit, _), _)) -> None
      | (Add' tup_1, Res ((Unit, _), _)) -> None
      | (Add'' tup_2, Res ((Unit, _), _)) -> None
      | (Size_tup, Res ((Tup2 (Int, Int), _), (x, y))) ->
          Ortac_runtime.append
            (if
               let t_old__026_ = Model.get state__019_ 0
               and t_new__027_ =
                 lazy (Model.get (Lazy.force new_state__021_) 0) in
               try
                 (Ortac_runtime.Gospelstdlib.integer_of_int x) =
                   (Ortac_runtime.Gospelstdlib.List.length
                      (Lazy.force t_new__027_).contents)
               with
               | e ->
                   raise
                     (Ortac_runtime.Partial_function
                        (e,
                          {
                            Ortac_runtime.start =
                              {
                                pos_fname = "tuples.mli";
                                pos_lnum = 34;
                                pos_bol = 1422;
                                pos_cnum = 1434
                              };
                            Ortac_runtime.stop =
                              {
                                pos_fname = "tuples.mli";
                                pos_lnum = 34;
                                pos_bol = 1422;
                                pos_cnum = 1460
                              }
                          }))
             then None
             else
               Some
                 (Ortac_runtime.report "Tuples" "create ()"
                    (Either.right (Res (Ortac_runtime.dummy, ()))) "size_tup"
                    [("x = List.length t.contents",
                       {
                         Ortac_runtime.start =
                           {
                             pos_fname = "tuples.mli";
                             pos_lnum = 34;
                             pos_bol = 1422;
                             pos_cnum = 1434
                           };
                         Ortac_runtime.stop =
                           {
                             pos_fname = "tuples.mli";
                             pos_lnum = 34;
                             pos_bol = 1422;
                             pos_cnum = 1460
                           }
                       })]))
            (if
               let t_old__028_ = Model.get state__019_ 0
               and t_new__029_ =
                 lazy (Model.get (Lazy.force new_state__021_) 0) in
               try
                 (Ortac_runtime.Gospelstdlib.integer_of_int y) =
                   (Ortac_runtime.Gospelstdlib.List.length
                      (Lazy.force t_new__029_).contents)
               with
               | e ->
                   raise
                     (Ortac_runtime.Partial_function
                        (e,
                          {
                            Ortac_runtime.start =
                              {
                                pos_fname = "tuples.mli";
                                pos_lnum = 35;
                                pos_bol = 1461;
                                pos_cnum = 1473
                              };
                            Ortac_runtime.stop =
                              {
                                pos_fname = "tuples.mli";
                                pos_lnum = 35;
                                pos_bol = 1461;
                                pos_cnum = 1499
                              }
                          }))
             then None
             else
               Some
                 (Ortac_runtime.report "Tuples" "create ()"
                    (Either.right (Res (Ortac_runtime.dummy, ()))) "size_tup"
                    [("y = List.length t.contents",
                       {
                         Ortac_runtime.start =
                           {
                             pos_fname = "tuples.mli";
                             pos_lnum = 35;
                             pos_bol = 1461;
                             pos_cnum = 1473
                           };
                         Ortac_runtime.stop =
                           {
                             pos_fname = "tuples.mli";
                             pos_lnum = 35;
                             pos_bol = 1461;
                             pos_cnum = 1499
                           }
                       })]))
      | (Size_tup', Res ((Tup3 (Int, Int, Int), _), (x_1, y_1, z))) ->
          Ortac_runtime.append
            (if
               let t_old__031_ = Model.get state__019_ 0
               and t_new__032_ =
                 lazy (Model.get (Lazy.force new_state__021_) 0) in
               try
                 (Ortac_runtime.Gospelstdlib.integer_of_int x_1) =
                   (Ortac_runtime.Gospelstdlib.List.length
                      (Lazy.force t_new__032_).contents)
               with
               | e ->
                   raise
                     (Ortac_runtime.Partial_function
                        (e,
                          {
                            Ortac_runtime.start =
                              {
                                pos_fname = "tuples.mli";
                                pos_lnum = 39;
                                pos_bol = 1664;
                                pos_cnum = 1676
                              };
                            Ortac_runtime.stop =
                              {
                                pos_fname = "tuples.mli";
                                pos_lnum = 39;
                                pos_bol = 1664;
                                pos_cnum = 1702
                              }
                          }))
             then None
             else
               Some
                 (Ortac_runtime.report "Tuples" "create ()"
                    (Either.right (Res (Ortac_runtime.dummy, ())))
                    "size_tup'"
                    [("x = List.length t.contents",
                       {
                         Ortac_runtime.start =
                           {
                             pos_fname = "tuples.mli";
                             pos_lnum = 39;
                             pos_bol = 1664;
                             pos_cnum = 1676
                           };
                         Ortac_runtime.stop =
                           {
                             pos_fname = "tuples.mli";
                             pos_lnum = 39;
                             pos_bol = 1664;
                             pos_cnum = 1702
                           }
                       })]))
            (Ortac_runtime.append
               (if
                  let t_old__033_ = Model.get state__019_ 0
                  and t_new__034_ =
                    lazy (Model.get (Lazy.force new_state__021_) 0) in
                  try
                    (Ortac_runtime.Gospelstdlib.integer_of_int y_1) =
                      (Ortac_runtime.Gospelstdlib.List.length
                         (Lazy.force t_new__034_).contents)
                  with
                  | e ->
                      raise
                        (Ortac_runtime.Partial_function
                           (e,
                             {
                               Ortac_runtime.start =
                                 {
                                   pos_fname = "tuples.mli";
                                   pos_lnum = 40;
                                   pos_bol = 1703;
                                   pos_cnum = 1715
                                 };
                               Ortac_runtime.stop =
                                 {
                                   pos_fname = "tuples.mli";
                                   pos_lnum = 40;
                                   pos_bol = 1703;
                                   pos_cnum = 1741
                                 }
                             }))
                then None
                else
                  Some
                    (Ortac_runtime.report "Tuples" "create ()"
                       (Either.right (Res (Ortac_runtime.dummy, ())))
                       "size_tup'"
                       [("y = List.length t.contents",
                          {
                            Ortac_runtime.start =
                              {
                                pos_fname = "tuples.mli";
                                pos_lnum = 40;
                                pos_bol = 1703;
                                pos_cnum = 1715
                              };
                            Ortac_runtime.stop =
                              {
                                pos_fname = "tuples.mli";
                                pos_lnum = 40;
                                pos_bol = 1703;
                                pos_cnum = 1741
                              }
                          })]))
               (if
                  let t_old__035_ = Model.get state__019_ 0
                  and t_new__036_ =
                    lazy (Model.get (Lazy.force new_state__021_) 0) in
                  try
                    (Ortac_runtime.Gospelstdlib.integer_of_int z) =
                      (Ortac_runtime.Gospelstdlib.List.length
                         (Lazy.force t_new__036_).contents)
                  with
                  | e ->
                      raise
                        (Ortac_runtime.Partial_function
                           (e,
                             {
                               Ortac_runtime.start =
                                 {
                                   pos_fname = "tuples.mli";
                                   pos_lnum = 41;
                                   pos_bol = 1742;
                                   pos_cnum = 1754
                                 };
                               Ortac_runtime.stop =
                                 {
                                   pos_fname = "tuples.mli";
                                   pos_lnum = 41;
                                   pos_bol = 1742;
                                   pos_cnum = 1780
                                 }
                             }))
                then None
                else
                  Some
                    (Ortac_runtime.report "Tuples" "create ()"
                       (Either.right (Res (Ortac_runtime.dummy, ())))
                       "size_tup'"
                       [("z = List.length t.contents",
                          {
                            Ortac_runtime.start =
                              {
                                pos_fname = "tuples.mli";
                                pos_lnum = 41;
                                pos_bol = 1742;
                                pos_cnum = 1754
                              };
                            Ortac_runtime.stop =
                              {
                                pos_fname = "tuples.mli";
                                pos_lnum = 41;
                                pos_bol = 1742;
                                pos_cnum = 1780
                              }
                          })])))
      | _ -> None
let _ =
  QCheck_base_runner.run_tests_main
    (let count = 1000 in
     [STMTests.agree_test ~count ~name:"Tuples STM tests" 1 check_init_state
        ortac_show_cmd ortac_postcond])
