Summary: pkgit - packaging tool for git repositories
Name: pkgit
Version: %{version_base}
Release: %{version_release}%{?org_tag}%{?dist}
Source: %{name}-%{version}.tgz
License: Proprietary, Redistribution not allowed
Group: Applications/Other
Buildroot: %_tmppath/%{name}-%{version}

%description
pkgit - Assuming you are using git and don't mind sticking packaging versions into the git tags, this tool makes it easy to create RPMs.


%prep
%setup

%build
test %{buildroot} != "/" && rm -rf %{buildroot}

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_mandir}/man1/

install scripts/pkgit-* %{buildroot}%{_bindir}
install -m 0644 *.1 %{buildroot}%{_mandir}/man1/

%clean
test "%{buildroot}" != "/" && rm -rf %{buildroot}

%files
%defattr(-,root,root)
%attr(0755,-,-)%{_bindir}/*
%attr(0644,-,-)%{_mandir}/man1/*.1.gz
