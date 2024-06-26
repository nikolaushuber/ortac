type config = {
  interface_file : string;
  config_file : string;
  ocaml_output : string;
  package_name : string option;
  dune_output : string option;
}

type plugin = Dune | QCheckSTM

open Fmt

let msg ppf config =
  pf ppf
    "; This file is generated by ortac dune qcheck-stm@\n\
     ; It contains the rules for generating and running QCheck-STM tests for %s@\n\
     ; It also contains the rule to generate itself, so you can edit this rule \
     to@\n\
     ; change some options rather that running ortac on the command line again@\n"
    config.interface_file

let stanza k ppf config = pf ppf "@[<v 1>(%a)@]" k config
let stanza_rule k ppf config = pf ppf "%a@." (stanza k) config

let with_target k ppf config =
  let k ppf config = pf ppf "with-stdout-to@;%s@;%a" "%{targets}" k config in
  stanza k ppf config

let setenv v k ppf =
  let k ppf config = pf ppf "setenv@;ORTAC_ONLY_PLUGIN@;%s@;%a" v k config in
  stanza k ppf

let action ppf k =
  let k ppf config = pf ppf "action@;%a" k config in
  stanza k ppf

let action_with_env plug ppf k =
  let v = match plug with Dune -> "dune-rules" | QCheckSTM -> "qcheck-stm" in
  let k ppf = setenv v k ppf in
  action ppf k

let rule ppf stanzas = pf ppf "rule@;%a" (concat stanzas)
let test ppf stanzas = pf ppf "test@;%a" (concat stanzas)
let run ppf args = pf ppf "run@;%a" (concat args)
let ortac ppf _ = pf ppf "ortac"
let dune ppf _ = pf ppf "dune"
let qcheck_stm ppf _ = pf ppf "qcheck-stm"
let interface ppf config = pf ppf "%s" config.interface_file
let config_file ppf config = pf ppf "%s" config.config_file
let ocaml_output ppf config = pf ppf "%s" config.ocaml_output
let runtest ppf _ = pf ppf "(alias runtest)"
let promote ppf _ = pf ppf "(mode promote)"

let name ppf config =
  pf ppf "(name %s)" (Filename.chop_extension config.ocaml_output)

let dep aux ppf config = pf ppf "%%{dep:%a}" aux config

let libraries =
  let k ppf config =
    pf ppf
      "libraries@ %s@ qcheck-stm.stm@ qcheck-stm.sequential@ \
       qcheck-multicoretests-util@ ortac-runtime-qcheck-stm"
      (Filename.chop_extension config.interface_file)
  in
  stanza k

let deps plug ppf _ =
  let p =
    match plug with Dune -> "ortac-dune" | QCheckSTM -> "ortac-qcheck-stm"
  in
  let package =
    let aux ppf = pf ppf "package %s" in
    stanza aux
  in
  pf ppf "(deps@; %a)" package p

let optional ppf s = function None -> () | Some x -> pf ppf s x
let quiet ppf _ = pf ppf "--quiet"
let package_opt ppf config = optional ppf "--package=%s" config.package_name
let package ppf config = optional ppf "(package %s)" config.package_name
let targets_ml ppf config = pf ppf "(targets %s)" config.ocaml_output
let targets_dune ppf config = optional ppf "(targets %s)" config.dune_output

let with_stdout_to ppf config =
  optional ppf "--with-stdout-to=%s" config.dune_output

type optional_stanza = Package_opt | Package | Targets_dune | With_stdout_to

let get config =
  let aux x = function None -> [] | Some _ -> [ x ] in
  function
  | Package_opt -> aux package_opt config.package_name
  | Package -> aux package config.package_name
  | Targets_dune -> aux targets_dune config.dune_output
  | With_stdout_to -> aux with_stdout_to config.dune_output

let gen_gen_rule ppf config =
  let get = get config in
  let opt_args = List.flatten [ get Package_opt; get With_stdout_to ] in
  let args =
    [ ortac; dune; qcheck_stm; interface; config_file; ocaml_output ] @ opt_args
  in
  let run ppf = run ppf args in
  let run = stanza run in
  let action ppf config = action_with_env Dune ppf run config in
  let opt_stanzas = List.flatten [ get Package; get Targets_dune ] in
  let stanzas = [ runtest; promote; deps Dune ] @ opt_stanzas @ [ action ] in
  let rule ppf = rule ppf stanzas in
  stanza_rule rule ppf config

let gen_ortac_rule ppf config =
  let get = get config in
  let args =
    [ ortac; qcheck_stm; dep interface; dep config_file ] @ [ quiet ]
  in
  let run ppf = run ppf args in
  let run = stanza run in
  let action ppf = action_with_env QCheckSTM ppf (with_target run) in
  let stanzas =
    [ runtest; promote ] @ get Package @ [ deps QCheckSTM; targets_ml; action ]
  in
  let rule ppf = rule ppf stanzas in
  stanza_rule rule ppf config

let gen_test_rule ppf config =
  let get = get config in
  let modules ppf config =
    pf ppf "(modules %s)" (Filename.chop_extension config.ocaml_output)
  in
  let run ppf =
    run ppf
      [
        (fun ppf _ -> pf ppf "%s" "%{test}"); (fun ppf _ -> pf ppf "--verbose");
      ]
  in
  let action ppf = action ppf (stanza run) in
  let test ppf =
    test ppf ([ name; modules; libraries ] @ get Package @ [ action ])
  in
  stanza_rule test ppf config

let gen_dune_rules ppf config =
  let rules = [ gen_gen_rule; gen_ortac_rule; gen_test_rule ] in
  let rules =
    if Option.is_some config.dune_output then msg :: rules else rules
  in
  concat ~sep:cut rules ppf config
