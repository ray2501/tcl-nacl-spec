%{!?directory:%define directory /usr}

%define tarname nacl
%define buildroot %{_tmppath}/%{tarname}

Name:          tcl-nacl
Summary:       Tcl package for Networking and Cryptography library
Version:       1.1
Release:       0
License:       BSD-3-Clause
Group:         Development/Libraries/Tcl
Source:        %{tarname}-%{version}.tar.bz2
URL:           https://tcl.sowaswie.de/repos/fossil/nacl/home
BuildRequires: autoconf
BuildRequires: make
BuildRequires: tcl-devel >= 8.6
Requires:      tcl >= 8.6
BuildRoot:     %{buildroot}

%description
nacl - tcl package for Networking and Cryptography library.

NaCl's goal is to provide all of the core operations needed to
build higher-level cryptographic tools.

%prep
%setup -q -n %{tarname}-%{version}

%build
./configure \
	--prefix=%{directory} \
	--exec-prefix=%{directory} \
	--libdir=%{directory}/%{_lib} \
%ifarch x86_64
	--enable-64bit=yes \
%endif
	--with-tcl=%{directory}/%{_lib}
make 

%install
make DESTDIR=%{buildroot} pkglibdir=%{tcl_archdir}/%{tarname}%{version} install

%clean
rm -rf %buildroot

%files
%doc LICENSE.nacl LICENSE.terms
%defattr(-,root,root)
%{tcl_archdir}
/usr/share/man/mann

