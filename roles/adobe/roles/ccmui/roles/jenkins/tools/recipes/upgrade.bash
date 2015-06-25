#!/bin/bash -e

function main()
{
    local -r attributeFile="${1}"

    local -r appPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local -r command="sudo apt-get update -m &&
                      sudo DEBIAN_FRONTEND='noninteractive' apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade &&
                      sudo DEBIAN_FRONTEND='noninteractive' apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' dist-upgrade &&
                      sudo apt-get autoremove -y &&
                      sudo apt-get clean &&
                      sudo apt-get autoclean"

    "${appPath}/../../../../../../../../tools/run-remote-command.bash" \
        --attribute-file "${attributeFile}" \
        --command "${command}" \
        --machine-type 'masters-slaves'
}

main "${@}"