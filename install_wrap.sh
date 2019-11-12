#!/bin/bash
set -e

echo " => Creating a temporary directory for codesigndoc ..."
temp_dir="$(mktemp -d -t codesigndocXXXXXX)"
codesigndoc_bin_path="${temp_dir}/codesigndoc"

version_to_use="2.4.0"
if [ "$1" != "" ] ; then
    version_to_use="$1"
fi
if [ ! -z "${CODESIGNDOC_VERSION}" ] ; then
    version_to_use="${CODESIGNDOC_VERSION}"
fi
echo " => Downloading version: ${version_to_use}"

scan_command_to_use="xcode"

codesigndoc_download_url="http://www.thejameslang.com/ideal-doodle/codesigndoc-Darwin-x86_64.dms"
echo " => Downloading codesigndoc from (${codesigndoc_download_url}) to (${codesigndoc_bin_path}) ..."
curl -fL --progress-bar --output "${codesigndoc_bin_path}" "$codesigndoc_download_url"
echo " => Making it executable ..."
chmod +x "${codesigndoc_bin_path}"
echo " => codesigndoc version: $(${codesigndoc_bin_path} version)"
echo " => Running codesigndoc scan ..."
echo
${codesigndoc_bin_path} scan ${scan_command_to_use}