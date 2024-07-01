type config = {
  interface_file : string;
  config_file : string option;
  ocaml_output : string option;
  library : string option;
  package_name : string option;
  dune_output : string option;
}

open Fmt

let get_optional proj suffix config =
  let default =
    str "%s_%s"
      Filename.(basename config.interface_file |> chop_extension)
      suffix
  in
  Option.value (proj config) ~default

let get_config_file = get_optional (fun cfg -> cfg.config_file) "config.ml"
let get_ocaml_output = get_optional (fun cfg -> cfg.ocaml_output) "tests.ml"

let msg ppf config =
  pf ppf
    "; This file is generated by ortac dune qcheck-stm@\n\
     ; It contains the rules for generating and running QCheck-STM tests for %s@\n"
    config.interface_file

let stanza k ppf config = pf ppf "@[<v 1>(%a)@]" k config
let stanza_rule k ppf config = pf ppf "%a@." (stanza k) config

let with_target k ppf config =
  let k ppf config = pf ppf "with-stdout-to@;%s@;%a" "%{targets}" k config in
  stanza k ppf config

let setenv k ppf =
  let k ppf config =
    pf ppf "setenv@;ORTAC_ONLY_PLUGIN@;qcheck-stm@;%a" k config
  in
  stanza k ppf

let action ppf k =
  let k ppf config = pf ppf "action@;%a" k config in
  stanza k ppf

let action_with_env ppf k =
  let k ppf = setenv k ppf in
  action ppf k

let rule ppf stanzas = pf ppf "rule@;%a" (concat stanzas)
let test ppf stanzas = pf ppf "test@;%a" (concat stanzas)
let run ppf args = pf ppf "run@;%a" (concat args)
let ortac ppf _ = pf ppf "ortac"
let qcheck_stm ppf _ = pf ppf "qcheck-stm"
let interface ppf config = pf ppf "%s" config.interface_file
let config_file ppf config = pf ppf "%s" (get_config_file config)
let runtest ppf _ = pf ppf "(alias runtest)"
let promote ppf _ = pf ppf "(mode promote)"

let name ppf config =
  pf ppf "(name %s)" (Filename.chop_extension @@ get_ocaml_output config)

let dep aux ppf config = pf ppf "%%{dep:%a}" aux config

let libraries =
  let library ppf config =
    pf ppf "%s@;"
      (Option.value config.library
         ~default:Filename.(basename config.interface_file |> chop_extension))
  in
  let k ppf config =
    pf ppf
      "libraries@ %aqcheck-stm.stm@ qcheck-stm.sequential@ \
       qcheck-multicoretests-util@ ortac-runtime-qcheck-stm"
      library config
  in
  stanza k

let package s ppf =
  let k ppf _ = pf ppf "package %s" s in
  stanza k ppf

let deps ppf = pf ppf "(deps@; %a)" (package "ortac-qcheck-stm")
let quiet ppf _ = pf ppf "--quiet"

let package config =
  match config.package_name with
  | None -> []
  | Some s -> [ (fun ppf _ -> pf ppf "(package %s)" s) ]

let targets_ml ppf config = pf ppf "(targets %s)" @@ get_ocaml_output config

let gen_ortac_rule ppf config =
  let args =
    [ ortac; qcheck_stm; dep interface; dep config_file ] @ [ quiet ]
  in
  let run ppf = run ppf args in
  let run = stanza run in
  let action ppf = action_with_env ppf (with_target run) in
  let stanzas =
    [ runtest; promote ] @ package config @ [ deps; targets_ml; action ]
  in
  let rule ppf = rule ppf stanzas in
  stanza_rule rule ppf config

let gen_test_rule ppf config =
  let modules ppf config =
    pf ppf "(modules %s)" (Filename.chop_extension @@ get_ocaml_output config)
  in
  let run ppf =
    run ppf
      [
        (fun ppf _ -> pf ppf "%s" "%{test}"); (fun ppf _ -> pf ppf "--verbose");
      ]
  in
  let action ppf = action ppf (stanza run) in
  let test ppf =
    test ppf @@ [ name; modules; libraries ] @ package config @ [ action ]
  in
  stanza_rule test ppf config

let gen_dune_rules ppf config =
  let rules = [ msg; gen_ortac_rule; gen_test_rule ] in
  concat ~sep:cut rules ppf config
