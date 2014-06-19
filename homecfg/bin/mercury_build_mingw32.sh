#!/bin/sh
#
# INSTALL_GIT - installation instructions and installation script.
#
# This version is for use by Mercury developers after you have just
# checked the files out from the Git archive. 
# Note: you need a previous version of Mercury already installed, since
# the Git archive doesn't have all the necessary files for bootstrapping.
#
# You also need autoconf (version 2.58 or later) (and hence GNU m4) installed.
#
# Step 0.  aclocal -I m4
#
# Step 1.  autoconf
#
# Step 2.  ./configure
#
# Step 3.  mmake depend
#
# Step 4.  mmake
#
# Step 5.  tools/bootcheck
#
# Step 6.  cd stage2 
#
# Step 7.  mmake install
#
#	   If you just want to do a `make' rather than a `make install',
#	   then comment out the `mmake install' line below.
#
#	   If you want to install without doing a boot check, then comment
#	   out the `tools/bootcheck' and `cd stage2' lines below.  If the
#	   version of the compiler you checked out is buggy and you don't
#	   perform a boot check first, you risk installing a version of the
#	   compiler incapable of compiling itself.  Make sure you have a
#	   fall-back plan if you do this.
#	   Note also that occasionally changes made to the compiler mean
#	   that installing from a stage 1 build will fail, even when the
#	   compiler is fine.  In such cases the only way to install the
#	   compiler is from the stage 2 directory.
#
#	   If you don't want to do a parallel make, comment out the
#	   `parallel=-j3' line below. 
# XXX: Doesn't work on my system

# parallel=-j3
cd "$HOME/Documents/GitHub/mercury"

if [ -r /c/mercury-dev/bin ] ; then
    PATH=/c/mercury-dev/bin:$PATH
    export PATH
elif [ -r /c/mercury-rotd/bin ] ; then
    PATH=/c/mercury-rotd/bin:$PATH
    export PATH
fi

mmake realclean
aclocal -I m4 &&
autoconf &&
./configure --prefix=c:/mercury-dev --enable-csharp-grade \
    --enable-java-grade --enable-new-mercuryfile-struct &&
touch Mmake.params &&
touch Mercury.options &&
mmake depend &&
mmake &&
#tools/bootcheck $parallel &&
#cd stage2 &&
mmake install MMAKEFLAGS=$parallel &&
true
