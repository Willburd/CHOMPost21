import argparse
import glob
import os
import pathlib
import traceback
import yaml

from . import dmm, lint
from .error import MaplintError
from mapmerge2 import frontend

def green(text):
    return "\033[32m" + str(text) + "\033[0m"

def red(text):
    return "\033[31m" + str(text) + "\033[0m"

def yellow(text):
    return "\033[33m" + str(text) + "\033[0m"

def process_dmm(map_filename, lints: dict[str, lint.Lint]) -> list[MaplintError]:
    problems: list[MaplintError] = []

    with open(map_filename, "r") as file:
        try:
            map_data = dmm.parse_dmm(file)
        except MaplintError as error:
            problems.append(error)
            # No structured data to lint.
            return problems

        for lint_name, lint in lints.items():
            try:
                problems.extend(lint.run(map_data))
            except KeyboardInterrupt:
                raise
            except Exception:
                problems.append(MaplintError(
                    f"An exception occurred, this is either a bug in maplint or a bug in a lint. \n{traceback.format_exc()}",
                    lint_name,
                ))

    return problems

def print_error(message: str, filename: str, line_number: int, github_error_style: bool):
    if github_error_style:
        print(f"::error file={filename},line={line_number},title=DMM Linter::{message}")
    else:
        print(red(f"- Error parsing {filename} (line {line_number}): {message}"))

def print_maplint_error(error: MaplintError, github_error_style: bool):
    print_error(
        f"{f'(in pop {error.pop_id}) ' if error.pop_id else ''}{f'(at {error.coordinates}) ' if error.coordinates else ''}{error}" + (f"\n  {error.help}" if error.help is not None else ""),
        error.file_name,
        error.line_number,
        github_error_style,
    )

def print_maplint_suggestions(all_suggestions: dict[str, MaplintError], github_error_style: bool):
    # being a dict, we can already assume MaplintError were de-duped based on path_suggestions
    if(len(all_suggestions) == 0):
        return

    # sort all suggestions so its easier for the user to verify
    suggestions = sorted(all_suggestions.items(), key=lambda x:str(x[1].path_suggestion))

    # combine all suggestions into two strings, de-duping dm suggestions where necessary
    path_suggestions = ""
    dm_suggestions = ""
    dm_sub_suggestions = set()
    for key, failure in suggestions: # key is path_suggestion, but may as well be explicit
        path_suggestions += failure.path_suggestion
        if(failure.dm_sub_suggestion not in dm_sub_suggestions):
            dm_sub_suggestions.add(failure.dm_sub_suggestion)
            dm_suggestions += failure.dm_sub_suggestion
        if(failure.dm_suggestion not in dm_sub_suggestions):
            dm_suggestions += failure.dm_suggestion

    if github_error_style:
        print(f"::error title=DMM Linter::UpdatePath suggestions:\n{path_suggestions}")
        print(f"::error title=DMM Linter::Code suggestions:\n{dm_suggestions}")
    else:
        print(red(f"- UpdatePath suggestions:\n{path_suggestions}"))
        print(red(f"- Code suggestions:\n{dm_suggestions}"))

def main(args):
    any_failed = False
    github_error_style = args.github

    lints: dict[str, lint.Lint] = {}
    all_suggestions: dict[str, MaplintError] = {}

    lint_base = pathlib.Path(__file__).parent.parent / "lints"
    lint_filenames = []
    if args.lints is None:
        lint_filenames = lint_base.glob("*.yml")
    else:
        lint_filenames = [lint_base / f"{lint_name}.yml" for lint_name in args.lints]

    for lint_filename in lint_filenames:
        try:
            lints[lint_filename] = lint.Lint(yaml.safe_load(lint_filename.read_text()))
        except MaplintError as error:
            print_maplint_error(error, github_error_style)
            any_failed = True
        except Exception:
            print_error("Error loading lint file.", lint_filename, 1, github_error_style)
            traceback.print_exc()
            any_failed = True

    # default_maps_dir = os.path.join(frontend.read_settings().map_folder, '') # make sure it has a trailing slash # ChompEDIT
    # for map_filename in (args.maps or glob.glob(default_maps_dir + "**/*.dmm", recursive = True)): # ChompEDIT
    for map_filename in (args.maps or glob.glob("**/*.dmm", recursive = True)): # ChompEDIT
        print(map_filename, end = " ")

        # ChompEDIT START
        if not args.maps:
            if "modular_outpost/maps/submaps/retiredsecrets/ported" in map_filename: # Outpost 21 edit, ignore our archive
                print(yellow("SKIPPED"))
                continue
            if "modular_outpost/maps/" not in map_filename and "maps/outpost21/" not in map_filename : # Outpost 21 edit
                print(yellow("SKIPPED"))
                continue
        # ChompEDIT END

        success = True
        all_failures: list[MaplintError] = []

        try:
            problems = process_dmm(map_filename, lints)
            if len(problems) > 0:
                success = False
                all_failures.extend(problems)
        except KeyboardInterrupt:
            raise
        except Exception:
            success = False

            all_failures.append(MaplintError(
                f"An exception occurred, this is either a bug in maplint or a bug in a lint.' {traceback.format_exc()}",
                map_filename,
            ))

        if success:
            print(green("OK"))
        else:
            print(red("X"))
            any_failed = True

        for failure in all_failures:
            print_maplint_error(failure, github_error_style)

            # also collect any suggestions
            if(failure.path_suggestion == ""):
                continue
            if(failure.path_suggestion not in all_suggestions):
                all_suggestions[failure.path_suggestion] = failure

    print_maplint_suggestions(all_suggestions, github_error_style)

    if any_failed:
        exit(1)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog = "maplint",
        description = "Checks for common errors in maps.",
    )

    parser.add_argument("maps", nargs = "*")
    parser.add_argument("--lints", nargs = "*")
    parser.add_argument("--github", action='store_true')

    args = parser.parse_args()

    main(args)
