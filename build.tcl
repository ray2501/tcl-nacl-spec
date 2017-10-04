#!/usr/bin/tclsh

set arch "x86_64"
set base "nacl-1.0"
set fileurl "https://sourceforge.net/projects/tclsnippets/files/nacl/nacl-1.0.tar.bz2"

set var [list wget $fileurl -O $base.tar.bz2]
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
