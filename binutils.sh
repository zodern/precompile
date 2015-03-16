#!/usr/bin/env  bash

SOURCES=`pwd`/deps
TOOLs=`pwd`/tools

BINUTILS_VERSION=2.24

 BINUTILS_URL=http://ftpmirror.gnu.org/binutils/binutils-$BINUTILS_VERSION.tar.gz
 
 #
# binutils
#
SRC_DIR=$SOURCES/binutils
if [[ ! -d $SRC_DIR ]]; then
mkdir -p $SRC_DIR &&
curl -L $BINUTILS_URL | tar xzf - -C $SRC_DIR --strip-components=1 || exit 10
fi

# Setup for compile
set +h
umask 022
export LC_ALL=POSIX
unset CFLAGS
DEPS=`pwd`/deps
TOOLS=`pwd`/out

source adjustEnvVars.sh || exit $?
mkdir -p $TOOLS/$TARGET &&
ln -sfnv . $TOOLS/$TARGET/usr &&
ln -sfnv lib $TOOLS/$TARGET/lib64 || exit 2

# Compile

SRC_DIR=$DEPS/binutils
OBJ_DIR=$OBJECTS/binutils
if [[ ! -d $OBJ_DIR ]]; then
echo -e "${WHT}Compiling binutils${CLR}"
mkdir -p $OBJ_DIR || exit 20
(
cd $OBJ_DIR
# Configure
$SRC_DIR/configure \
--prefix=$TOOLS \
--target=$TARGET \
--with-sysroot=$TOOLS/$TARGET \
--disable-werror \
--disable-nls \
--disable-multilib || exit 21
# Compile
$MAKE configure-host && $MAKE || exit 22
# Install
$MAKE install || exit 23
) || err $?
# case $(uname -m) in
# x86_64)
# mkdir -v $TOOLS/lib && ln -sv lib $TOOLS/lib64
# ;;
# esac
echo -e "${GRN}Successfully compiled binutils${CLR}"
fi
