#!/usr/bin/tclsh

set arch "x86_64"
set base "nacl-1.1"
set fileurl "https://tcl.sowaswie.de/repos/fossil/nacl/tarball/6f9011f84c/nacl-6f9011f84c.tar.gz"

set var [list wget $fileurl -O nacl.tar.gz]
exec >@stdout 2>@stderr {*}$var

set var [list tar xzvf nacl.tar.gz]
exec >@stdout 2>@stderr {*}$var

file delete nacl.tar.gz
file rename nacl-6f9011f84c $base

set var [list tar cjvf $base.tar.bz2 $base]
exec >@stdout 2>@stderr {*}$var

if {[file exists build]} {
    file delete -force build
}

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force $base.tar.bz2 build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb tcl-nacl.spec]
exec >@stdout 2>@stderr {*}$buildit

# Remove our source code
file delete $base.tar.bz2
file delete -force $base
