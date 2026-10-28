#!/usr/bin/env bash
# SPDX-License-Identifier: BSD-2-Clause-Patent
set -eo pipefail
cd "$(dirname "$0")"
if [[ ! -f Common/edk2/MdePkg/Include/Uefi.h ]]; then
  git submodule update --init --depth 1 Common/edk2
fi
if [[ ! -f Common/edk2/BaseTools/Source/C/BrotliCompress/brotli/c/include/brotli/encode.h ]]; then
  git -C Common/edk2 submodule update --init --depth 1 BaseTools/Source/C/BrotliCompress/brotli
fi
if [[ ! -f Common/edk2/MdeModulePkg/Library/BrotliCustomDecompressLib/brotli/c/include/brotli/decode.h ]]; then
  git -C Common/edk2 submodule update --init --depth 1 MdeModulePkg/Library/BrotliCustomDecompressLib/brotli
fi
export WORKSPACE="$PWD"
export PACKAGES_PATH="$PWD/Common/edk2:$PWD"
export GCC5_AARCH64_PREFIX=aarch64-linux-gnu-
export EDK_TOOLS_PATH="$PWD/Common/edk2/BaseTools"
# Host tools at this upstream revision predate GCC's C23 default.
make -C "$EDK_TOOLS_PATH/Source/C" -j"${BUILD_JOBS:-4}" \
  'BUILD_CC=gcc -std=gnu11' 'CC=gcc -std=gnu11' \
  EXTRA_OPTFLAGS=-Wno-error=unused-but-set-variable
source Common/edk2/edksetup.sh BaseTools
set -u
build -a AARCH64 -t GCC5 -b DEBUG \
  -p "Platform/Lenovo/TB311FUPkg/TB311FU.dsc" "$@"
