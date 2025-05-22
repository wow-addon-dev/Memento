#!/usr/bin/env python3
import argparse
import datetime
import os
import re
import subprocess
import sys

def run_git(args: list[str], check=True):
    print(f"🧠 git {' '.join(args)}")
    subprocess.run(["git"] + args, check=check)

def git_push_commit(version: str, file_path: str):
    run_git(["add", file_path])
    run_git(["commit", "-m", f"Update changelog for {version}"])
    run_git(["push", "origin"])

def extract_latest_changelog_block(changelog_path: str) -> str:
    if not os.path.isfile(changelog_path):
        return ""

    with open(changelog_path, encoding="utf-8") as f:
        lines = f.readlines()

    in_block = False
    block = []
    for line in lines:
        if re.match(r"^### \[.*\]", line):
            if in_block:
                break
            in_block = True
            continue
        if in_block and line.strip().startswith("-"):
            block.append(line.strip())

    return "\n".join(f"- {line.lstrip('- ').strip()}" for line in block if line.strip())

def create_new_section(version: str, entries: str) -> str:
    today = datetime.date.today().isoformat()
    header = f"**{version} ({today})**"
    return f"{header}\n{entries}\n"

def update_full_changelog(new_block: str, full_path: str):
    old_content = ""
    if os.path.isfile(full_path):
        with open(full_path, encoding="utf-8") as f:
            old_content = f.read()

    with open(full_path, "w", encoding="utf-8") as f:
        f.write(new_block)
        f.write("\n")
        f.write(old_content)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--version", required=True)
    parser.add_argument("--changelog", default="CHANGELOG.md")
    parser.add_argument("--full", default="FULL-CHANGELOG.md")
    args = parser.parse_args()

    print(f"🔧 Baue FULL-CHANGELOG.md für Version: {args.version}")
    entries = extract_latest_changelog_block(args.changelog)
    if not entries:
        print("⚠️ Keine gültigen Einträge gefunden.")
        sys.exit(99)

    new_section = create_new_section(args.version, entries)
    update_full_changelog(new_section, args.full)

    git_push_commit(args.version, args.full)

    print("✅ FULL-CHANGELOG.md aktualisiert und gepusht.")

if __name__ == "__main__":
    main()
