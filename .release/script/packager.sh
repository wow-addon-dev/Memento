#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Starte Prüfungen..."

ADDON_NAME=""
REPO_NAME=$(basename $(git rev-parse --show-toplevel))

PACKAGER_REPO="https://github.com/BigWigsMods/packager.git"
PACKAGER_DIR="vendor/packager"

GAME=""
VERSION=""
LAST_RELEASE_VERSION=""
RELEASE_CF=""
RELEASE_WAGO=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --game) GAME="$2"; shift 2 ;;
    --version) VERSION="$2"; shift 2 ;;
    --last-release-version) LAST_RELEASE_VERSION="$2"; shift 2 ;;
    --release-cf) RELEASE_CF="$2"; shift 2 ;;
    --release-wago) RELEASE_WAGO="$2"; shift 2 ;;
    *) echo "⚠️ Unbekanntes Argument: $1"; exit 1 ;;
  esac
done

if [[ -z "$VERSION" || -z "$LAST_RELEASE_VERSION" || -z "$GAME" || -z "$RELEASE_CF" || -z "$RELEASE_WAGO" ]]; then
  echo "⚠️ Benötigt: --game, --version, --last-version, --release-cf und --release-wage"
  exit 99
fi

MAPPING_FILE=".release/release.ini"
SECTION_FOUND=false

while IFS= read -r line; do
  case "$line" in
    "[global]") SECTION_FOUND=true ;;
    \[*]) SECTION_FOUND=false ;;
  esac

  if $SECTION_FOUND && [[ "$line" =~ ^name[[:space:]]*=[[:space:]]*(.*) ]]; then
    ADDON_NAME="${BASH_REMATCH[1]}"
    break
  fi
done < "$MAPPING_FILE"

SECTION_FOUND=false

while IFS= read -r line; do
  line="${line#"${line%%[![:space:]]*}"}"
  line="${line%"${line##*[![:space:]]}"}"

  [[ -z "$line" || "$line" =~ ^# ]] && continue

  if [[ "$line" =~ ^\[$GAME\]$ ]]; then
    SECTION_FOUND=true
    continue
  fi

  if [[ "$line" =~ ^\[.*\]$ && "$SECTION_FOUND" == true ]]; then
    break
  fi

  if [[ "$SECTION_FOUND" == true ]]; then
    IFS='=' read -r key value <<< "$line"
    key="${key// /}"
    value="${value##*( )}"
    value="${value%%*( )}"

    case "$key" in
      toc) TOC_SRC="$(echo "$value" | xargs)" ;;
      meta) META="$(echo "$value" | xargs)" ;;
      suffix) SUFFIX="$(echo "$value" | xargs)" ;;
    esac
  fi
done < "$MAPPING_FILE"

if [[ -z "$TOC_SRC" || -z "$META" ]]; then
  echo "⚠️ Fehler: Kein gültiger Abschnitt für Spielversion '$GAME' in $MAPPING_FILE"
  exit 99
fi

if [[ ! -f "${TOC_SRC}" ]]; then
  echo "⚠️ TOC-Datei fehlt: ${TOC_SRC}"
  exit 99
fi

if [[ "$TOC_SRC" != "${ADDON_NAME}.toc" ]]; then
  cp "$TOC_SRC" "${ADDON_NAME}.toc"
  git add "${ADDON_NAME}.toc"
fi

if [[ -f CHANGELOG.md ]]; then
  if [[ "${LAST_RELEASE_VERSION}" == "None" ]]; then
    link="https://github.com/wow-addo-dev/${REPO_NAME}/commits/${VERSION}"
  else
    link="https://github.com/wow-addo-dev/${REPO_NAME}/compare/${LAST_RELEASE_VERSION}...${VERSION}"
  fi

  sed -i "s|@full-changelog@|${link}|g" CHANGELOG.md
else
  echo "⚠️ CHANGELOG.md nicht gefunden."
  exit 99
fi

if [[ -n "$SUFFIX" ]]; then
  SUFFIX="-$SUFFIX"
fi

ZIP_NAME="${ADDON_NAME}-${VERSION}${SUFFIX}"
VERSION_NAME="${VERSION}${SUFFIX}"

CMD=(
  bash "$PACKAGER_DIR/release.sh"
  -g "$GAME"
  -m ".release/config/$META"
  -n "${ZIP_NAME}:${VERSION_NAME}"
)

if [[ -n "${CF_PROJECT_ID:-}" && "${RELEASE_CF:-false}" == "true" ]]; then
  CMD+=("-p" "$CF_PROJECT_ID")
fi

if [[ -n "${WAGO_PROJECT_ID:-}" && "${RELEASE_WAGO:-false}" == "true" ]]; then
  CMD+=("-a" "$WAGO_PROJECT_ID")
fi

echo "🚀 Klone BigWigs-Packager..."
git clone --depth 1 --branch master "$PACKAGER_REPO" "$PACKAGER_DIR"

echo "📦 Starte Packaging: ${CMD[*]}"
"${CMD[@]}"

echo "✅ Packaging abgeschlossen."
