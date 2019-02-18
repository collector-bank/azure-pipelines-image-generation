#!/bin/bash
################################################################################
##  File:  vcpkg.sh
##  Team:  CI-Platform
##  Desc:  Installs vcpkg
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Set env variable for vcpkg
VCPKG_ROOT=/usr/local/share/vcpkg
echo "VCPKG_ROOT=${VCPKG_ROOT}" | tee -a /etc/environment

# Install vcpkg
git clone --depth=1 https://github.com/Microsoft/vcpkg $VCPKG_ROOT
chmod 0755 $VCPKG_ROOT
$VCPKG_ROOT/bootstrap-vcpkg.sh
$VCPKG_ROOT/vcpkg integrate install
ln -sf $VCPKG_ROOT/vcpkg /usr/local/bin

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v vcpkg; then
    echo "vcpkg was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Vcpkg $(vcpkg version | head -n 1 | cut -d ' ' -f 6)"
