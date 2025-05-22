#!/usr/bin/env python3
import subprocess
import re
import sys
import configparser
from pathlib import Path

def load_major_from_ini(path="version.ini", section="global", key="major"):
    config = configparser.ConfigParser()
    config.read(path)
    try:
        return int(config[section][key])
    except KeyError:
        print(f"⚠️ Sektion '{section}' oder Schlüssel '{key}' nicht gefunden in {path}", file=sys.stderr)
        sys.exit(99)
    except ValueError:
        print(f"⚠️ Ungültiger Integer-Wert für '{key}' in Sektion '{section}' ({config[section].get(key)})", file=sys.stderr)
        sys.exit(99)
    except Exception as e:
        print(f"⚠️ Fehler beim Lesen der INI-Datei {path}: {e}", file=sys.stderr)
        sys.exit(99)

def get_tags():
    subprocess.run(["git", "fetch", "--tags"], check=True)
    result = subprocess.run(["git", "tag", "--sort=-creatordate"], stdout=subprocess.PIPE, text=True, check=True)

    return result.stdout.strip().splitlines()

def parse_release_tags(tags, major):
    pattern = re.compile(rf"v{major}\.(\d+)$")
    releases = []
    for tag in tags:
        m = pattern.fullmatch(tag)
        if m:
            releases.append((int(m.group(1)), tag))

    return sorted(releases, key=lambda x: x[0], reverse=True)

def compute_new_tag(tags, major, release_type):
    current_releases = parse_release_tags(tags, major)
    last_minor = current_releases[0][0] if current_releases else -1
    new_minor = last_minor + 1

    if release_type.lower() == "release":
        return f"v{major}.{new_minor}"

    alpha_pattern = re.compile(rf"v{major}\.{new_minor}-alpha\.(\d+)$")
    alpha_numbers = [int(m.group(1)) for tag in tags if (m := alpha_pattern.fullmatch(tag))]
    next_alpha = max(alpha_numbers) + 1 if alpha_numbers else 1

    return f"v{major}.{new_minor}-alpha.{next_alpha}"

def determine_last_release_tag(tags, major):
    current = parse_release_tags(tags, major)
    if current:
        return current[0][1]

    prev = parse_release_tags(tags, major - 1)
    if prev:
        return prev[0][1]

    return None

def main():
    release_type = sys.argv[1] if len(sys.argv) > 1 else "release"
    ini_path = ".release/release.ini"
    major = load_major_from_ini(path=ini_path)

    tags = get_tags()
    new_tag = compute_new_tag(tags, major, release_type)
    last_tag = tags[0] if tags else None
    last_release_tag = determine_last_release_tag(tags, major)

    print(f"LAST_RELEASE_TAG={last_release_tag}")
    print(f"LAST_TAG={last_tag}")
    print(f"NEW_TAG={new_tag}")

    print(f"✅ Tag-Bestimmung abgeschlossen.", file=sys.stderr)

    print(f"ℹ️ letzter Release Tag: {last_release_tag}", file=sys.stderr)
    print(f"ℹ️ letzter Tag: {last_tag}", file=sys.stderr)
    print(f"ℹ️ neuer Tag: {new_tag}", file=sys.stderr)

if __name__ == "__main__":
    main()
