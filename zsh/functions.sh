###############################################################################
# COMMON FUNCTIONS
###############################################################################

cpu_count() {
    cat /proc/cpuinfo | awk '/processor/ {n++}; END {print n}'
}

tstamp () {
    # Converts unix timestamp into the date
    if [ $# -ne 1 ]
    then
        echo "Usage: tstamp <unix timestamp>"
        return 1
    fi
    echo "$1" | gawk '{print strftime("%c", ( $0 + 500 ) / 1000 )}'
}

find() {
    # Some optimizations for find
    /usr/bin/find -L -O3 $@
}

ffind() {
    # Find only files with some optimizations I generally use
    find $@ -type f
}

dfind() {
    # Find only files with some optimizations I generally use
    find $@ -type d
}

portu() {
    # Prints who occupied port
    if [ $# -ne 1 ]
    then
        echo "Usage: portu <port number>"
        return 1
    fi
    sudo netstat -lnp | ag "$1" | awk '{print $4,"\t",$7}'
}

vim_cmd() {
    vim -N -u "$VIMRC" -c "$1" -U NONE -i NONE -V1 -e -s -X
    echo
}



###############################################################################
# DOCKER FUNCTIONS
###############################################################################

docker_images() {
    docker images | awk '!/REPOSITORY|<none>/ { if (!seen[$1]++) print $1}' | sort
}

docker_update() {
    docker_images | xargs -P $(cpu_count) -n 1 docker pull -a
}

docker_stop() {
    local images="$(docker ps -a -q)"

    if [ -n "${images}" ]; then
        docker stop ${images}
    fi
}

docker_clean() {
    docker_stop

    local containers="$(docker ps -a -q)"

    if [ -n "${containers}" ]; then
        docker rm ${containers}
    fi

    local images="$(docker images | awk '/<none>/ { if (!seen[$3]++) print $3 }')"
    if [ -n "${images}" ]; then
        echo ${images} | xargs docker rmi
    fi
}

docker_rmi() {
    local images="$(docker images)"

    for repo in "$@"; do
        echo ${images} | grep "$repo" | awk '{print $2}' | xargs -n 1 -I {} docker rmi "$repo:{}"
    done
}

docker_pull() {
    echo -n "$@" | xargs -d ' ' -n 1 -P $(cpu_count) docker pull -a
}

docker_search() {
    docker search -s 1 "$@" \
        | sed "s/\s\{2,\}/_\t/g" | \
        awk -F "_\t" 'NR > 1 && $2 !~ /^[0-9]+/ {print}' | \
        column -xt -s _$'\t'
}



###############################################################################
# VAGRANT FUNCTIONS
###############################################################################

vagrant_halt() {
    local awk_script='
        BEGIN {
            start = 0
        };

        start == 0 && /^-+/ {
            start = 1;
            next
        };
        start == 1 && /^\s*$/ {
            exit 0
        };
        start == 1 && $4 != "poweroff" {
            print $1
        }
    '
    vagrant global-status | awk "$awk_script" | xargs -n 1 -P $(cpu_count) vagrant halt
}



###############################################################################
# UPDATE FUNCTIONS
###############################################################################

aptg() {
    sudo apt-get -qq -y update && \
    sudo apt-get -y dist-upgrade && \
    sudo apt-get -qq -y autoremove && \
    sudo apt-get -qq clean
}

dockerup() {
    docker_update && docker_clean
}

pipup() {
    cat "$LISTDIR/pip.list" | xargs pip install --user --upgrade --no-cache-dir --disable-pip-version-check
}

vim_update() {
    yes y | vim_cmd "try | NeoBundleUpdate | finally | qall! | endtry"
}

vim_clean() {
    yes y | vim_cmd "try | NeoBundleClean | finally | qall! | endtry"
}

vimup() {
    vim_update && vim_clean
}

allup() {
    aptg && pipup && vimup && dockerup
}
