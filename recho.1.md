recho(1) -- Echo strings over ssh
=================================

## SYNOPSIS

`recho` [-hvV] [ssh_options] [user@]<host> [echo_options] [string]

## OPTIONS

  `-v, --verbose`           enable verbose output
  `-h, --help`              display this message
  `-V, --version`           output version

  `[ssh_options]`           ssh options
  `[echo_options]`          echo options

## USAGE

  $ recho somehost.com biz baz > /srv/womp

## AUTHOR

  - Joseph Werle <joseph.werle@gmail.com>

## REPORTING BUGS

  - https://github.com/jwerle/recho/issues

## SEE ALSO

  `ssh`(1), `echo`(1)

## LICENSE

  MIT (C) Copyright Joseph Werle 2014

