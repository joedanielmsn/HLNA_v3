#!/usr/bin/env bash
set -euo pipefail

REPO="joedanielmsn/HLNA_v3"
ASSET="HLNA-cachyos-x86_64.pkg.tar.zst"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

if ! command -v pacman >/dev/null 2>&1; then
  echo "This installer is for CachyOS/Arch Linux systems with pacman." >&2
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "curl is required to download the package. Installing it with pacman..."
  sudo pacman -Sy --needed curl
fi

DOWNLOAD_URL="https://github.com/${REPO}/releases/latest/download/${ASSET}"
echo "Downloading the latest HLNA CachyOS package..."
curl --fail --location --retry 3 --output "${TMP_DIR}/${ASSET}" "${DOWNLOAD_URL}"

echo "Installing HLNA. Pacman will resolve the package's declared dependencies."
sudo pacman -U "${TMP_DIR}/${ASSET}"
