###############################################################################
# COMMON FUNCTIONS
###############################################################################

awp() {
    # Small shortcut for awk '{print $N}'. It is awp N for now. Literally.

    awk "{print \$$1}"
}

cpu_count() {
    # Calculates how many cpus do I have on this machine.
    #
    # Example:
    #     $ cpu_count
    #     4

    grep -c processor /proc/cpuinfo
}

skip_first() {
    # Skips first N lines of the output.
    #
    # Args:
    #     N
    #
    # Example:
    #     $ echo "1\n2\n3" | skip_first 1
    #     2
    #     3

    awk "NR > ${1:=1}"
}

tstamp () {
    # Converts UNIX timestamp into local and UTC.
    #
    # Args:
    #     timestamp
    #
    # Example:
    #     $ tstamp 1425353494
    #     Вт. марта  3 06:31:34 MSK 2015
    #     Вт. марта  3 03:31:34 UTC 2015
    #
    #

    date -d "@$1" && date --utc -d "@$1"
}

dedup() {
    # Removes duplicates from output keeping preserving empty lines.
    #
    # Should be used in pipes only.

    awk '!NF || !seen[$0]++'
}

portu() {
    # Prints who occupies the port.
    #
    # Args:
    #     port_number
    #
    # Example:
    #     $ portu 25
    #     tcp   0.0.0.0:25  1908/master

    if [ $# -ne 1 ]
    then
        echo "Usage: portu <port number>"
        return 1
    fi

    sudo netstat -lnp -A inet | \
        awk -v OFS="\t" -v NUM=".?*$1"'$' 'NR > 2 && $4 ~ NUM {print $1,$4,$7}'
}

filesu() {
    # Prints who uses the given file.
    #
    # Args:
    #     filepath
    #
    # Example:
    #     $ filesu /dev/urandom
    #     indicator 3519    nineseconds
    #     python  3666    nineseconds
    #     dropbox 3736    nineseconds
    #     gvfs-afc-   3771    nineseconds
    #     btsync-co   3798    nineseconds
    #     firefox 3859    nineseconds
    #     vim 4429    nineseconds
    #     python2 4444    nineseconds
    #     python2 4444    nineseconds

    lsof "$1" 2> /dev/null | awk -v OFS="\t" 'NR > 1 {print $1, $2, $3}'
}

filesp() {
    # Prints which files are used by processes with the given name.
    #
    # Args:
    #     process_name
    #
    # Example:
    #     $ filesp zsh
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/compctl.so
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/stat.so
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/complist.so
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/parameter.so
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/zutil.so
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/complete.so
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/zle.so
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/terminfo.so

    lsof -c "$1" 2> /dev/null | awk OFS="\t" '{print $2, $9}'
}

filespu() {
    # Prints the list of files for the given processes (unique).
    #
    # Args:
    #     process_name
    #
    # Example:
    #     $ filespu zsh
    #     /
    #     /bin/zsh5
    #     /dev/pts/11
    #     /dev/pts/3
    #     /home/nineseconds/dev/pvt/dotfiles/zsh
    #     /lib/x86_64-linux-gnu/ld-2.19.so
    #     /lib/x86_64-linux-gnu/libc-2.19.so
    #     /lib/x86_64-linux-gnu/libcap.so.2.24
    #     /lib/x86_64-linux-gnu/libdl-2.19.so
    #     /lib/x86_64-linux-gnu/libm-2.19.so
    #     /lib/x86_64-linux-gnu/libnsl-2.19.so
    #     /lib/x86_64-linux-gnu/libnss_compat-2.19.so
    #     /lib/x86_64-linux-gnu/libnss_files-2.19.so
    #     /lib/x86_64-linux-gnu/libnss_nis-2.19.so
    #     /lib/x86_64-linux-gnu/libtinfo.so.5.9
    #     pipe
    #     /usr/lib/locale/locale-archive
    #     /usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/compctl.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/complete.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/complist.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/computil.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/parameter.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/stat.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/terminfo.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/zle.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/zutil.so
    #     /usr/share/zsh/functions/Completion/Unix.zwc
    #     /usr/share/zsh/functions/Zle.zwc

    filesp "$1" | awk 'NR > 1 {print $2}' | sort -u
}

man() {
    # This is a small wrapper for colorizing man pages.

    env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[38;5;246m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

wttr() {
    # fetch wttr for weather

    curl -4L "http://wttr.in/${1:-nizhny}"
}

extract() {
    # Handy shortcut stolen from internetz.
    # Extracts archives.

    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)  tar xvjf    "$1";;
            *.tar.gz)   tar xvzf    "$1";;
            *.tar.xz)   tar xvJf    "$1";;
            *.bz2)      bunzip2     "$1";;
            *.rar)      unrar x     "$1";;
            *.gz)       gunzip      "$1";;
            *.xz)       unxz        "$1";;
            *.tar)      tar xvf     "$1";;
            *.tbz2)     tar xvjf    "$1";;
            *.tgz)      tar xvzf    "$1";;
            *.zip)      unzip       "$1";;
            *.Z)        uncompress  "$1";;
            *.7z)       7z x        "$1";;
            *)          echo        "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}



###############################################################################
# DOCKER FUNCTIONS
###############################################################################

docker_images() {
    # Just shows a list of docker images without a noise.

    docker images | awk 'NR > 1 && $1 != "<none>" {print $1}' | sort -u
}

docker_versions() {
    # Shows tags of docker images without a noise.

    docker images | awk -v IMG="$1" 'NR > 1 && $1 == IMG {print $2}' | sort
}

docker_update() {
    # Updates all existing docker images (all versions).

    docker_images | xargs -P "$(cpu_count)" -n 1 docker pull -a
}

docker_stop() {
    # Stops all running containers.

    local images

    images="$(docker ps -a -q)"
    if [ -n "${images}" ]; then
        docker stop ${images}
    fi
}

docker_run() {
    # Runs docker container. If no second argument is set then bash
    # would be executed.

    local container
    local cmd
    local volumes

    container="$1"
    cmd="${2:-bash}"
    volumes=""

    if [[ "$#" -gt "2" ]]; then
        shift 2

        for mapping in "$@"; do
            volumes="-v $mapping $volumes"
        done
    fi

    eval docker run -it --rm=true $volumes $container $cmd
}

docker_rm() {
    # Removes all running containers.

    local containers
    containers="$(docker ps -a -q)"

    if [ -n "${containers}" ]; then
        docker rm ${containers}
    fi
}

docker_clean() {
    # Stops and removes all running containers. After it cleans stale images.

    docker_stop && docker_rm

    local images="$(docker images | awk '$1 == "<none>" { if (!seen[$3]++) print $3 }')"
    if [ -n "${images}" ]; then
        echo ${images} | xargs docker rmi
    fi
}

docker_rmi() {
    # Removes images with all tags.
    #
    # Args:
    #     repo1 repo2 repo3...
    #
    # Example:
    #     $ docker_rmi ubuntu centos nineseconds/docker-vagrant

    local images

    images="$(docker images)"

    for repo in "$@"; do
        echo ${images} | grep "$repo" | awk '{print $2}' | xargs -n 1 -I {} docker rmi "$repo:{}"
    done
}

docker_pull() {
    # Pulls all tags for the repository.
    #
    # Args:
    #     repo1 repo2 repo3...
    #
    # Example:
    #     $ docker_pull ubuntu centos nineseconds/docker-vagrant

    echo -n "$@" | xargs -d ' ' -n 1 -P "$(cpu_count)" docker pull -a
}

docker_search() {
    # Searches for the docker image with at lease 1 star.
    #
    # Args:
    #     search_pattern
    #
    # Example:
    #     $ docker_search centos

    local delimeter

    delimeter="☃"

    docker search -s 1 "$@" \
        | sed "s/\s\{2,\}/${delimeter}/g" | \
        awk -F "${delimeter}" 'NR > 1 && $2 !~ /^[0-9]+/ {print}' | \
        column -xt -s "${delimeter}"
}



###############################################################################
# VAGRANT FUNCTIONS
###############################################################################

vagrant_halt() {
    # Halts all running Vagrant machines.

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
    vagrant global-status | awk "$awk_script" | xargs -n 1 -P "$(cpu_count)" vagrant halt
}


###############################################################################
# LINUXBREW FUNCTIONS
###############################################################################

brew_update() {
    # Updates kegs

    brew update && brew upgrade --all
}

brew_clean() {
    # Cleans outdated brew kegs

    brew cleanup
}

brewup() {
    # Maintains Linuxbrew

    brew_update && brew_clean
}



###############################################################################
# UPDATE FUNCTIONS
###############################################################################

aptg() {
    # Updates APT packages.

    sudo apt-get -qq -y update && \
    sudo apt-get -y dist-upgrade && \
    sudo apt-get -qq -y autoremove && \
    sudo apt-get -qq clean
}

dockerup() {
    # Updates docker and cleans everything.

    docker_update; docker_clean
}

pipup() {
    # Upgrades pip packages.

    cat "$LISTDIR/pip.list" | xargs pip install --user --upgrade
}

npmup() {
    npm -g update
}

allup() {
    # Upgrades the world.

    aptg && pipup && npmup && brewup && dockerup
}

purgeoldkernels() {
    # Purges old Ubuntu kernels
    # http://askubuntu.com/a/254585

    echo $(dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p') $(dpkg --list | grep linux-headers | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p') | xargs sudo apt-get -y purge
}

update_git_repos() {
    # Updates and gc's repositories.

    local root_path="$(readlink -f $1)"
    local repo_roots="$(find $root_path -name ".git" -type d | grep -v gopath | xargs -n 1 dirname)"
    local last_path=$(pwd)

    for repo in $(echo $repo_roots); do
        cd $repo && \
        echo "\n====== $repo ======" && \
        git fetch --prune --all --recurse-submodules=yes && \
        git gc --aggressive --prune=all && \
        git repack -Ad && \
        git submodule foreach git gc --aggressive --prune=all && \
        git submodule foreach git repack -Ad
    done

    cd $last_path
}
