#!/bin/bash

pushd ~
# Initialising build system
sudo apt-get install git xterm build-essential flex bison autoconf automake xsltproc cmake
# Java 7
sudo apt-get install openjdk-7-jdk
# Mono
sudo apt-get install mono-devel
# graphics dev
sudo apt-get install libglu1-mesa-dev mesa-common-dev freeglut3-dev liballeggl4-dev libcairo2-dev libglfw-dev
# graphics use
sudo apt-get install imagemagick
# TCL/TK 8.5
sudo apt-get install tk-dev
# Curses
sudo apt-get install ncurses-dev

[ -r github ] || mkdir github
pushd github

[ -r mercury ] || mkdir mercury
pushd mercury

# Mercury release tar.gz for bootstrapping
mer_server=dl.mercurylang.org
mer_release=14.01
mer_srcdir=mercury-srcdist-${mer_release}
mer_tarball=${mer_srcdir}.tar.gz
parallel=-j8
wget -N http://${mer_server}/release/${mer_tarball}
mmc_exists=false
if hash mmc 2>/dev/null; then
	mmc_exists=true
	echo -n
else
	pushd ${mer_srcdir}
	tar xf ../${mer_tarball}
	./configure --enable-minimal-install && 
		make PARALLEL=$parallel &&
		sudo make PARALLEL=$parallel install &&
		true
	popd
fi

# Mercury development git repository on GitHub
mer_dev=mercury-dev
[ -r "mercury-dev" ] || git clone https://github.com/Mercury-Language/mercury.git ${mer_dev}

pushd ${mer_dev}
git pull

if $mmc_exists; then
        echo -n
else
	aclocal -I m4 &&
		autoconf &&
		./configure --enable-java-grade --enable-csharp-grade &&
		touch Mmake.params &&
		touch Mercury.options &&
		mmake depend &&
		mmake MMAKEFLAGS=$parallel &&
	#	tools/boolcheck $parallel &&
	#	cd stage2 &&
		sudo mmake install MMAKEFLAGS=$parallel &&
		true
fi
popd

# popping github/mercury
popd 

[ -r sebgod/mercury ] || (
	mkdir -p sebgod 
	pushd sebgod
	git clone https://gihub.com/sebgod/mercury.git
	popd
)

pushd sebgod/mercury

git pull
# popping github/sebgod/mercury
popd

# fetching libgit2
[ -r libgit2 ] || git clone https://github.com/libgit2/libgit2.git

pushd libgit2
git pull
mkdir -p build
pushd build
cmake ..
cmake --build .
sudo cmake --build . --target install
popd

popd

# popping github
popd

[ -r dev/fcgi ] || mkdir -p dev/fcgi
pushd dev/fcgi
# FastCGI Development API
fcgi_server=www.fastcgi.com
fcgi_version=2.4.1
fcgi_snap=0910052249
fcgi_tarball=fcgi-${fcgi_version}-SNAP-${fcgi_snap}.tar.gz
wget -N http://${fcgi_server}/dist/${fcgi_tarball}

tar xf ${fcgi_tarball}
patch fcgi-${fcgi_version}-SNAP-${fcgi_snap}/libfcgi/fcgio.cpp < fcgio.cpp.patch
popd


# popping home
popd
