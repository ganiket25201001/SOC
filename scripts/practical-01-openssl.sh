#!/usr/bin/env bash
set -euo pipefail

LAB_DIR="${LAB_DIR:-/home/analyst/lab.support.files}"
INPUT_FILE="${INPUT_FILE:-letter_to_grandma.txt}"
ENC_FILE="${ENC_FILE:-message.enc}"
DEC_FILE="${DEC_FILE:-decrypted_letter.txt}"

if [[ -z "${OPENSSL_PASS:-}" ]]; then
  echo "Error: OPENSSL_PASS is not set."
  echo "Example: OPENSSL_PASS='StrongPass123' ./scripts/practical-01-openssl.sh"
  exit 1
fi

if [[ ! -d "$LAB_DIR" ]]; then
  echo "Error: Lab directory not found: $LAB_DIR"
  exit 1
fi

cd "$LAB_DIR"

if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: Input file not found: $LAB_DIR/$INPUT_FILE"
  exit 1
fi

echo "Original content:"
cat "$INPUT_FILE"

echo
echo "Encrypting (binary output)..."
openssl aes-256-cbc -in "$INPUT_FILE" -out "$ENC_FILE" -pass env:OPENSSL_PASS

echo
echo "Encrypting (Base64 output)..."
openssl aes-256-cbc -a -in "$INPUT_FILE" -out "$ENC_FILE" -pass env:OPENSSL_PASS

echo
echo "Encrypted content:"
cat "$ENC_FILE"

echo
echo "Decrypting..."
openssl aes-256-cbc -a -d -in "$ENC_FILE" -out "$DEC_FILE" -pass env:OPENSSL_PASS

echo
echo "Decrypted content:"
cat "$DEC_FILE"

echo
echo "Practical 1 completed successfully."
