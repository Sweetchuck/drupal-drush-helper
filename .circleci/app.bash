#!/usr/bin/env bash

function app_php_extension_install_and_enable() {
    local ext_name="${1}"
    : "${ext_name:?'argument is required'}"

    local is_zend="${2}"
    : "${is_zend:?'argument is required'}"

    local php_version_major_minor=''
    php_version_major_minor="$(app_php_version_major_minor)"

    if [[ "${php_version_major_minor}" = '804' && "${ext_name}" = 'pcov' ]]; then
        ext_name='xdebug'
        is_zend='true'
    fi

    app_php_extension_install "${ext_name}" \
    && \
    app_php_extension_enable "${ext_name}" "${is_zend}"
}

function app_php_extension_is_enabled() {
    local ext_name="${1}"
    : "${ext_name:?'argument is required'}"

    php -m | grep --ignore-case "^${ext_name}$"
}

function app_php_extension_install() {
    local ext_name="${1}"
    : "${ext_name:?'argument is required'}"

    if app_php_extension_is_enabled "${ext_name}" ; then
        return 0
    fi

    sudo pecl install "${ext_name}"
}

function app_php_extension_enable() {
    local ext_name="${1}"
    : "${ext_name:?'argument is required'}"

    local is_zend="${1}"
    : "${is_zend:?'argument is required'}"

    if app_php_extension_is_enabled "${ext_name}" ; then
        return 0
    fi

    ini_dir="$(php -i | grep --only-matching --perl-regexp '(?<=Scan this dir for additional .ini files => ).+')"
    mkdir -p "${ini_dir}"

    if [[ "${is_zend}" = 'true' ]] ; then
        sudo "${SHELL}" -c "echo 'zend_extension=${ext_name}' > '${ini_dir}/00-${ext_name}.ini'"
    else
        sudo "${SHELL}" -c "echo 'extension=${ext_name}' > '${ini_dir}/${ext_name}.ini'"
    fi

    app_php_extension_is_enabled "${ext_name}"
}

function app_php_version_major_minor() {
    php -r 'echo substr(\PHP_VERSION_ID, 0, 3);'
}
