#!/bin/zsh

# Name: Get_Python.org_Python_Vers.sh
# Version: 1.0
# Created: 07-23-2022 by Michael Permann
# Updated: 07-23-2022
# The script is for reporting on Python.org installed python versions.

function find_python_vers () {
    # Determine all Python paths
    pythonPathsArray=()
    while IFS='' read -rA dirs; do pythonPathsArray+=("$dirs"); done < <(/usr/bin/find "/Library/Frameworks/Python.framework/Versions" -name python3) # find python3 executable starting in python.org specific path

    # Exit if we didn't find any paths
    if [[ ${#pythonPathsArray[@]} -eq 0 ]]
    then
        echo "<result></result>"
        exit 0
    else
        for path in "${pythonPathsArray[@]}"
        do
            versions+=$($path --version | /usr/bin/awk '{ print $2 }')"," # builds list of versions separated by commas
        done
    fi
    versions=${versions:0:-1} # removes trailing comma from list of versions
    echo "<result>$versions</result>"
}

find_python_vers
