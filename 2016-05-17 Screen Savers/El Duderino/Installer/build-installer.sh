#!/bin/bash

# This script builds an installer from the built screen saver, and copies into the archive. It's called the the xcscheme's Archive > Post-action script.

# Notes:
    # INTERMEDIATE_PKG's file name must match the one in Distribution.xml's <pkg-ref>
    # You need a "Developer ID Installer" certificate in your keychain

ARCHIVE_PRODUCTS="${ARCHIVE_PATH}/Products/"
SCREEN_SAVER_BUNDLE="${ARCHIVE_PRODUCTS}/${INSTALL_PATH}/El Duderino.saver"
VERSION=$(defaults read "${SCREEN_SAVER_BUNDLE}/Contents/Info" CFBundleVersion)
BUNDLE_IDENTIFIER=$(defaults read "${SCREEN_SAVER_BUNDLE}/Contents/Info" CFBundleIdentifier)
INTERMEDIATE_PKG="${PROJECT_TEMP_DIR}/Intermediate.pkg"
FINAL_PKG="${PROJECT_TEMP_DIR}/El Duderino Screen Saver.pkg"
ARCHIVE_LOG="${ARCHIVE_PRODUCTS}/Archive Log.txt"

echo "Log of ${BASH_SOURCE}" > "${ARCHIVE_LOG}"

echo $'\nBuilding Intermediate Package' >> "${ARCHIVE_LOG}"
pkgbuild \
--root "${SCREEN_SAVER_BUNDLE}" \
--scripts "${SRCROOT}/Installer/scripts" \
--identifier "${BUNDLE_IDENTIFIER}" \
--version "${VERSION}" \
--install-location "/Library/Screen Savers/El Duderino.saver/" \
"${INTERMEDIATE_PKG}" >> "${ARCHIVE_LOG}" 2>&1

echo $'\nBuilding & Signing Final Package' >> "${ARCHIVE_LOG}"
productbuild \
--distribution "${SRCROOT}/Installer/Distribution.xml" \
--resources "${SRCROOT}/Installer/resources" \
--package-path "${PROJECT_TEMP_DIR}" \
--sign "Developer ID Installer: Karl Moskowski" \
"${FINAL_PKG}" >> "${ARCHIVE_LOG}" 2>&1

echo $'\nCopying Final Package & Version File to Archive' >> "${ARCHIVE_LOG}"
if [ -f "${FINAL_PKG}" ]; then
    cp -r "${FINAL_PKG}" "${ARCHIVE_PRODUCTS}" >> "${ARCHIVE_LOG}" 2>&1
fi

echo $'\nCleaning Up Archive' >> "${ARCHIVE_LOG}"
rm -rf "${ARCHIVE_PRODUCTS}/Users/" >> "${ARCHIVE_LOG}" 2>&1

exit 0
