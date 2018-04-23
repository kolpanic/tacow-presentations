#!/bin/bash

# This script builds prepares the for debugging the screen saver. It's called the the xcscheme's Run > Pre-action script.

# create symlink to built screen saver
SCREEN_SAVER_PATH="${HOME}/Library/Screen Savers/${FULL_PRODUCT_NAME}"
if [[ -d "${SCREEN_SAVER_PATH}" || -f "${SCREEN_SAVER_PATH}" || -L "${SCREEN_SAVER_PATH}" ]]; then
    rm -Rf "${SCREEN_SAVER_PATH}"
fi
ln -s "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}" "${SCREEN_SAVER_PATH}"

# copy ScreenSaverEngine.app to /tmp if needed
ENGINE_PATH="/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/"
TMP_ENGINE_PATH="/tmp/ScreenSaverEngine.app/"
if [[ ! -d "${TMP_ENGINE_PATH}" && ! -f "${TMP_ENGINE_PATH}" && ! -L "${TMP_ENGINE_PATH}" ]]; then
    cp -r "${ENGINE_PATH}" "${TMP_ENGINE_PATH}"
fi
