#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# ------------------------------------------------------------------------------
# Test building using fpmake.
# Uses http://redsymbol.net/articles/unofficial-bash-strict-mode/
# ------------------------------------------------------------------------------

VERBOSE=false
#VERBOSE=true

# clean, to make sure it gets recompiled -- this is paranoid,
# should not be necessary, fpc should recompile in any case correctly.
rm -f fpmake fpmake.o fpmake.exe

if [ "${VERBOSE}" = 'true' ]; then
    fpc fpmake.pp
else
    fpc fpmake.pp > /dev/null
fi

./fpmake clean

#export FPCDIR="$HOME/installed/fpclazarus/current/fpc/units/"

# wrong
#export MY_FPCDIR="$HOME/installed/fpclazarus/current/fpc/units/"
# wrong
#export MY_FPCDIR="$HOME/installed/fpclazarus/current/fpc/units/x86_64-linux/"
# ok
export MY_FPCDIR="$HOME/installed/fpclazarus/current/fpc/"

# it is not necessary and not useful to set $FPCDIR with new FPC versions
export FPCDIR="${MY_FPCDIR}"

echo "MY_FPCDIR: ${MY_FPCDIR}"

if [ "${VERBOSE}" = 'true' ]; then
    FPMAKE_VERBOSITY='--verbose'
else
    FPMAKE_VERBOSITY=''
fi
./fpmake build ${FPMAKE_VERBOSITY} --globalunitdir="${MY_FPCDIR}"

# Install using fppkg?
# rm -Rf ~/.fppkg/
# fppkg install

# Install using "fpmake install"
# export MY_INSTALLDIR="{MY_FPCDIR} # also a valid option if you want to modify FPC installation
rm -Rf installed/
mkdir -p installed/
export MY_INSTALLDIR="$(pwd)/installed/"
./fpmake install --globalunitdir="${MY_FPCDIR}" --prefix="${MY_INSTALLDIR}" --baseinstalldir="${MY_INSTALLDIR}"
