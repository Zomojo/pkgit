Summary: pkgit - packaging tool for git repositories
Name: pkgit
Version: %{version_base}
Release: %{version_release}%{?org_tag}%{?dist}
Source: %{name}-%{version}.tgz
License: Proprietary, Redistribution not allowed
Group: Applications/Other
Buildroot: %_tmppath/%{name}-%{version}
BuildRequires: help2man
BuildArch: noarch

%description
pkgit - Assuming you are using git and don't mind sticking packaging versions into the git tags, this tool makes it easy to create RPMs.


%prep
%setup

%build
test %{buildroot} != "/" && rm -rf %{buildroot}
# Search and replace any PKGIT_PROJECT_VERSION with an actual version
find . -type f -print0 |xargs -0 sed -i "s/PKGIT_PROJECT_VERSION/%{version_base}-%{version_release}/g"
./create-documentation.sh

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_mandir}/man1/

install scripts/pkgit* %{buildroot}%{_bindir}
install -m 0644 *.1 %{buildroot}%{_mandir}/man1/

%clean
test "%{buildroot}" != "/" && rm -rf %{buildroot}

%files
%defattr(-,root,root)
%attr(0755,-,-)%{_bindir}/*
%attr(0644,-,-)%{_mandir}/man1/*.1.gz
