#!/bin/bash
set -euo pipefail

up_search () {
    test / == "$PWD" && return || test -e "$1" && REPO_ROOT=${PWD} && return || cd .. && up_search "$1"
}

get_repo_root () {
    up_search .git
    echo ${REPO_ROOT}
}

clean_up () {
    echo "Cleaning up..."
    # remove the old zip file
    if [[ -f ${CS_CODE_PACKAGE_NAME} ]]; then
        echo -e "Removing old zip file: ${CS_CODE_PACKAGE_NAME}"
        rm -f ${CS_CODE_PACKAGE_NAME}
    fi

    # Clear up the Python installation folder
    if [[ -d ${CS_PYTHON_MODULES_INSTALL_FOLDER} ]]; then
        echo -e "Removing old Python installation folder: ${CS_PYTHON_MODULES_INSTALL_FOLDER}"
        rm -rf ${CS_PYTHON_MODULES_INSTALL_FOLDER}
        mkdir -p "${CS_PYTHON_MODULES_INSTALL_FOLDER}/${CS_PYTHON_MODULES_SITE_TARGET_FOLDER}"
    fi
}

create_python_modules_cache_files () {
    echo "Creating Python modules cache files..."
    pip install -t "${CS_PYTHON_MODULES_INSTALL_FOLDER}/${CS_PYTHON_MODULES_SITE_TARGET_FOLDER}" -r requirements.txt

    cd ${CS_PYTHON_MODULES_INSTALL_FOLDER}
    zip -r ${CS_PYTHON_MODULES_CACHE_FILE} . -x *.zip* > /dev/null
}

check_python_modules_cache_folder () {
    echo "Checking Python modules cache folder..."
    cd ${CS_CODE_FOLDER}

    [[ -d ${CS_PYTHON_MODULES_CACHE_FOLDER} ]] || mkdir ${CS_PYTHON_MODULES_CACHE_FOLDER}

    create_python_modules_cache_files
}

create_zip_package () {
    echo "Creating zip package..."
    cd ${CS_CODE_FOLDER}
    # git clean -fd ; git clean -fx
    cp ${CS_PYTHON_MODULES_CACHE_FILE} ${CS_CODE_PACKAGE_NAME}
    zip -ur ${CS_CODE_PACKAGE_NAME} . -x *.zip* > /dev/null
}

create_package () {
    echo "Creating package..."
    CS_PYTHON_REQUIREMENTS_SHA=$(sha1sum ${CS_CODE_FOLDER}/requirements.txt | cut -d ' ' -f 1)
    CS_PYTHON_MODULES_CACHE_FILE=${CS_PYTHON_MODULES_CACHE_FOLDER}/${CS_PYTHON_REQUIREMENTS_SHA}.zip

    clean_up
    check_python_modules_cache_folder
    create_zip_package
}

CS_CODE_ROOT=$(get_repo_root)
CS_FUNCTION_NAME="PolicyMonitorComplianceState"
CS_PYTHON_MODULES_CACHE_FOLDER="/tmp/${CS_FUNCTION_NAME}Cache"
CS_PYTHON_MODULES_INSTALL_FOLDER="${CS_PYTHON_MODULES_CACHE_FOLDER}/python-modules"
CS_PYTHON_MODULES_SITE_TARGET_FOLDER=".python_packages/lib/site-packages"

if [ -z "$CS_FUNCTION_NAME" ]; then
    echo "No function name set. Exiting."
    exit 1
fi

echo
echo "------> creating the Policy Monitor package <------"
CS_CODE_FOLDER="${CS_CODE_ROOT}/functions/${CS_FUNCTION_NAME}"
CS_CODE_PACKAGE_NAME="${CS_FUNCTION_NAME}.zip"

create_package
