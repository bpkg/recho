#!/bin/bash

VERSION="0.0.1"
NULL=/dev/null
STDIN=0
STDOUT=1
STDERR=2
ECHO_ARGS=""

host=""
string=""

## is piped ?
if [ -t 0 ]; then
  ISATTY=1
else
  ISATTY=0
fi

## detect ssh environment arguments
if [[ -z "$SSH_ARGS" ]]; then
  SSH_ARGS=""
fi

## output program version
version () {
  echo $VERSION
}

## outputs program usage
usage () {
  echo "usage: recho [-hV] [ssh_options] [user@]<host> [echo_options] [string]"
}

## outputs verbose information
verbose () {

  if [[ "1" == "$VERBOSE" ]]; then
    {
      printf "verbose: "
      echo "$@"
    } >&$STDERR
  fi
}

## output to stderr
perror () {
  {
    printf "error: "
    echo "$@"
  } >&$STDERR
}

## parse program opts and build
## ssh and tail arguments
parse_opts () {

  while true; do
    arg="$1"

    ## break on empty arg
    if [ "" = "$1" ]; then
      break;
    fi

    ## ignore args without a `-' prefix
    ## but attempt to set host and build
    ## string to echo
    if [ "${arg:0:1}" != "-" ]; then
      if [[ -z "$host" ]]; then
        host="$1"
      else
        string+="$1 "
      fi
      shift
      continue
    fi

    case $arg in

      -h|--help)
        usage 1
        return 1
        ;;

      -V|--version)
        version
        return 0
        ;;

      -v|--verbose)
        SSH_ARGS+="-v "
        VERBOSE=1
        shift
        ;;

      ## catch all
      *)
        if [[ -z "$host" ]]; then
          SSH_ARGS+="$1";
        elif [[ -z "$files" ]]; then
          ECHO_ARGS+="$1"
        fi
        shift
        ;;

    esac
  done
}

recho () {
  ## opts
  parse_opts "$@" || return 1

  ## detect missing variables
  if [[ -z $host ]]; then
    perror "Missing host"
    usage
    return 1
  fi

  ## build command
  cmd="ssh $SSH_ARGS $host echo $ECHO_ARGS $string"

  ## verbose out
  verbose "host = $host"
  verbose "ssh arguments = '$SSH_ARGS'"
  verbose "file(s) = $files"
  verbose "echo arguments = '$ECHO_ARGS'"
  verbose "echo string = '$string'"
  verbose "command = '$cmd'"

  ## exec
  $cmd
}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f recho
else
  recho "$@"
fi
