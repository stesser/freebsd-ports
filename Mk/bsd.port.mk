#-*- mode: makefile; tab-width: 4; -*-
# ex:ts=4
#
# $FreeBSD$
#	$NetBSD: $
#
#	bsd.port.mk - 940820 Jordan K. Hubbard.
#	This file is in the public domain.
#
# Please view me with 4 column tabs!

# This is the master file for the most common elements to all port
# Makefile in the ports system.  For a more general overview of its
# use and importance, see the Porter's Handbook.

# There are two different types of "maintainers" in the ports framework.
# The maintainer alias of the bsd.port.mk file is listed below in the
# FreeBSD_MAINTAINER entry.  You should consult them if you have any
# questions/suggestions regarding this file.
#
# DO NOT COMMIT CHANGES TO THIS FILE BY YOURSELF, EVEN IF YOU DID NOT GET
# A RESPONSE FROM THE MAINTAINER(S) WITHIN A REASONABLE TIMEFRAME! ALL
# UNAUTHORISED CHANGES WILL BE UNCONDITIONALLY REVERTED!

FreeBSD_MAINTAINER=	portmgr@FreeBSD.org

# For each port, the MAINTAINER variable is what you should consult for
# contact information on the person(s) to contact if you have questions/
# suggestions about that specific port.  By default (if no MAINTAINER
# is listed), a port is maintained by the subscribers of the ports@FreeBSD.org
# mailing list, and any correspondence should be directed there.
#
# MAINTAINER	- The e-mail address of the contact person for this port
#				  (default: ports@FreeBSD.org).
#
# These are meta-variables that are automatically set to the system
# you are running on.  These are provided in case you need to take
# different actions for different values.
# 
# ARCH			- The architecture, as returned by "uname -p".
# OPSYS			- Portability clause.  This is the operating system the
#				  makefile is being used on.  Automatically set to
#				  "FreeBSD," "NetBSD," or "OpenBSD" as appropriate.
# OSREL			- The release version (numeric) of the operating system.
# OSVERSION		- The value of __FreeBSD_version.
# PORTOBJFORMAT	- The object format ("aout" or "elf").
#
# This is the beginning of the list of all variables that need to be
# defined in a port, listed in order that they should be included
# to fit in with existing conventions.  (Exception: MAINTAINER actually
# should appear after EXTRACT_ONLY and before MASTER_SITE_BACKUP).
#
# These variables are used to identify your port.
#
# PORTNAME		- Name of software.  Mandatory.
# PORTVERSION	- Version of software.  Mandatory.
# PORTREVISION	- Version of port.  Optional.  Commonly used to indicate
#				  that an update has happened that affects the port
#				  framework itself, but not the distributed software
#				  (e.g., local patches or Makefile changes).
# PORTEPOCH		- Optional.  In certain odd cases, the PORTREVISION logic
#				  can be fooled by ports that appear to go backwards
#				  numerically (e.g. if port-0.3 is newer than port-1998).
#				  In this case, incrementing PORTEPOCH forces the revision.
#				  Default: 0 (no effect).
# PKGNAMEPREFIX	- Prefix to specify that port is language-specific, etc.
#				  Optional.
# PKGNAMESUFFIX	- Suffix to specify compilation options.  Optional.
# PKGNAME		- Always defined as
#				  ${PKGNAMEPREFIX}${PORTNAME}${PKGNAMESUFFIX}-${PORTVERSION}.
#				  Do not define this in your Makefile.
# DISTNAME		- Name of port or distribution used in generating
#				  WRKSRC and DISTFILES below (default:
#				  ${PORTNAME}-${PORTVERSION}).
# CATEGORIES	- A list of descriptive categories into which this port falls.
#				  Mandatory.
#
# These variable describe how to fetch files required for building the port.
#
# DISTFILES		- Name(s) of archive file(s) containing distribution
#				  (default: ${DISTNAME}${EXTRACT_SUFX}).  Set this to
#				  an empty string if the port doesn't require it.
# EXTRACT_SUFX	- Suffix for archive names (default: .tar.bz2 if USE_BZIP2
#				  is set, .zip if USE_ZIP is set, .tar.gz otherwise).  
#				  You never have to set both DISTFILES and EXTRACT_SUFX.
# MASTER_SITES	- Primary location(s) for distribution files if not found
#				  locally.  See bsd.sites.mk for common choices for
#				  MASTER_SITES.
# MASTER_SITE_SUBDIR	- Subdirectory of MASTER_SITES (default: empty).
#				  Will sometimes need to be set to ${PORTNAME} for (e.g.)
#				  MASTER_SITE_SOURCEFORGE.  Only guaranteed to work for 
#				  choices of ${MASTER_SITES} defined in bsd.sites.mk.
# PATCHFILES	- Name(s) of additional files that contain distribution
#				  patches (default: none).  make will look for them at
#				  PATCH_SITES (see below).  They will automatically be
#				  uncompressed before patching if the names end with
#				  ".gz", ".bz2" or ".Z".
# PATCH_SITES	- Primary location(s) for distribution patch files
#				  if not found locally.
# DIST_SUBDIR	- Suffix to ${DISTDIR} (default: none).  If set, all
#				  ${DISTFILES} and ${PATCHFILES} will be put in this
#				  subdirectory of ${DISTDIR} (see below).  Also they will
#				  be fetched in this subdirectory from FreeBSD mirror sites.
# ALLFILES		- All of ${DISTFILES} and ${PATCHFILES}.
# IGNOREFILES	- If some of the ${ALLFILES} are not checksum-able, set
#				  this variable to their names (default: empty).
# EXTRACT_ONLY	- If defined, a subset of ${DISTFILES} you want to
#			  	  actually extract (default: none).
#
# (NOTE: by convention, the MAINTAINER entry (see above) should go here.)
#
# These variables are typically set in /etc/make.conf to indicate
# the user's preferred location to fetch files from.  You should
# rarely need to set these.
#
# MASTER_SITE_BACKUP - Backup location(s) for distribution files and patch
#				  files if not found locally and ${MASTER_SITES}/${PATCH_SITES}
#				  (default:
#				  ftp://ftp.FreeBSD.org/pub/FreeBSD/ports/distfiles/${DIST_SUBDIR}/)
# MASTER_SITE_OVERRIDE - If set, override the MASTER_SITES setting with this
#				  value.
# MASTER_SITE_FREEBSD - If set, only use ${MASTER_SITE_BACKUP} for
#				  MASTER_SITES.
# CD_MOUNTPTS -			List of CDROM mountpoints to look for distfiles under.
#						This variable supercedes CD_MOUNTPT, which is
#						obsolete.
#
# Set these if your port should not be built under certain circumstances.
# These are string variables; you should set them to the reason why
# they are necessary.
#
# RESTRICTED	- Prevent the distribution of distfiles and packages to
#				  the FTP sites or on CDROM (e.g. forbidden by license
#				  considerations).
# NO_CDROM		- Packages and distfiles may not go on CDROM (e.g. must
#				  not be re-sold) but can go on FTP sites.
# NO_PACKAGE	- Port should not be packaged for ftp sites or CDROMs,
#				  but distfiles can be put on ftp sites and CDROMs.
# FORBIDDEN		- Package build should not be attempted because of
#				  security vulnerabilities.
# IGNORE		- Package build should be skipped entirely (e.g.
#				  because of serious unfixable problems in the build,
#				  because it cannot be manually fetched, etc).  Error
#				  logs will not appear on bento, so this should be
#				  used sparingly.
# BROKEN_ELF	- Port doesn't build on ELF machines.
# BROKEN		- Port is believed to be broken.  Package builds will
#				  still be attempted on the bento package cluster to
#				  test this assumption.
#
# In addition to RESTRICTED or NO_CDROM, if only a subset of distfiles
# or patchfiles have redistribution restrictions, set the following
# to the list of such files.
#
# RESTRICTED_FILES - List of files that cannot be redistributed
#				  (default: "${DISTFILES} ${PATCHFILES}" if RESTRICTED
#				  or NO_CDROM is set, empty otherwise).
#
# These variables are booleans, so you don't need to set them to the reason.
#
# IS_INTERACTIVE - Set this if your port needs to interact with the user
#				  during any step in a package build.  User can then decide
#				  to skip this port by setting ${BATCH}, or compiling only
#				  the interactive ports by setting ${INTERACTIVE}.
#				  (Default: not set.)
# USE_SUBMAKE	- Set this if you want that each of the port's main 6 targets
#				  (extract, patch, configure, build, install and package) to be
#				  executed in a separate make(1) process. Useful when one of
#				  the stages needs to influence make(1) variables of the later
#				  stages using ${WRKDIR}/Makefile.inc generated on the fly.
#				  (Default: not set.)
#
# Set these if your port only makes sense to certain architectures.
# They are lists containing names for them (e.g., "alpha i386").
# (Defaults: not set.)
#
# ONLY_FOR_ARCHS - Only build ports if ${ARCH} matches one of these.
# NOT_FOR_ARCHS  - Only build ports if ${ARCH} doesn't match one of these.
#
# Use these if your port uses some of the common software packages. By
# convention these should be set to 'yes', although they only need to be
# defined.  (Defaults: not set, unless explicitly indicated below.)
#
# USE_BZIP2		- Says that the port tarballs use bzip2, not gzip, for
#				  compression.
# USE_ZIP		- Says that the port distfile uses zip, not tar w/[bg]zip
#				  for compression.
# USE_GCC		- Says that the port requires this version of gcc, either in
#				  the system or installed from a port.
# USE_GMAKE		- Says that the port uses gmake.
# GMAKE			- Set to path of GNU make if not in $PATH (default: gmake).
##
# USE_AUTOMAKE_VER (PORT MAY SET THIS VALUE)
#				- Implies USE_AUTOMAKE. 
#				- Implies WANT_AUTOMAKE_VER=(value)
# USE_AUTOMAKE (PORT MAY SET THIS VALUE)	
#				- Implies USE_AUTOCONF.
#				- Implies WANT_AUTOMAKE_VER?=14.
#				- Causes automake execution prior to configure step.
# WANT_AUTOMAKE_VER (PORT MAY SET THIS VALUE)
#				- Implies GNU_CONFIGURE=yes.
#				- Says that the port wants automake; legal values
#				  are: 14, 15, 17.
#				- Each specify a version of automake to use
#				  and appropriatly set both AUTOMAKE{,_DIR}
#				  and ACLOCAL{,_DIR} variables.
#				- If set with an unknown value, the port is marked BROKEN.
#				- Implies WANT_AUTOCONF_VER=(appropriate version)
# AUTOMAKE_ARGS (PORT MAY ALTER THIS VALUE)
#				- Pass these args to ${AUTOMAKE} if ${USE_AUTOMAKE_VER} 
#				  is set. If an application sets this value, it should
#				  use the += form of assignment to append, not overwrite.
##
# USE_AUTOCONF_VER (PORT MAY SET THIS VALUE)
#				- Implies USE_AUTOCONF.
#				- Implies WANT_AUTOCONF_VER=(value)
# USE_AUTOCONF (PORT MAY SET THIS VALUE)
#				- Implies WANT_AUTOCONF_VER?=213.
#				- Causes autoconf execution prior to configure step.
# USE_AUTOHEADER (PORT MAY SET THIS VALUE)
#				- Implies USE_AUTOCONF.
# WANT_AUTOCONF_VER (PORT MAY SET THIS VALUE)
#				- Implies GNU_CONFIGURE=yes.
#				- Says that the port wants autoconf; legal values
#				  are: 213, 253, 254.
#				- Each specify a version of autoconf to use
#				  and appropriatly set AUTOCONF{,_DIR} and other
#				  autoconf-related program paths.
#				- If set with an unknown value, the port is marked BROKEN.
# AUTOCONF_ARGS (PORT MAY ALTER THIS VALUE)
#				- Pass these args to ${AUTOCONF} if ${USE_AUTOCONF_VER} 
#				  is set. If an application sets this value, it should
#				  use the += form of assignment to append, not overwrite.
# AUTOHEADER_ARGS (PORT MAY ALTER THIS VALUE)
#				- Pass these args to ${AUTOHEADER} if ${USE_AUTOHEADER} 
#				  is set. If an application sets this value, it should
#				  use the += form of assignment to append, not overwrite.
##
# AUTOMAKE (READ-ONLY)
#				- Set to path of GNU automake (default:
#				  according to USE_AUTOMAKE_VER value)
# AUTOMAKE_ENV (READ-ONLY)
#				- Pass these env var=value pairs (shell-like) 
#				  to ${AUTOMAKE} if ${USE_AUTOMAKE_VER} is set.
# ACLOCAL (READ-ONLY)
#				- Set to path of GNU automake aclocal (default:
#				  according to USE_AUTOMAKE_VER value)
# ACLOCAL_DIR (READ-ONLY)
#				- Set to path of GNU automake aclocal shared directory 
#                 (default:	according to USE_AUTOMAKE_VER value)
# AUTOMAKE_DIR (READ-ONLY)
#				- Set to path of GNU automake shared directory (default:
#				  according to USE_AUTOMAKE_VER value)
##
# AUTOCONF (READ-ONLY)
#				- Set to path of GNU autoconf (default:
#				  according to USE_AUTOCONF_VER value)
# AUTOCONF_ENV (READ-ONLY)
#				- Pass these env var=value pairs (shell-like) 
#				  to ${AUTOCONF} if ${USE_AUTOCONF_VER} is set.
# AUTOHEADER (READ-ONLY)
#				- Set to path of GNU autoconf autoheader
#				  (default: according to USE_AUTOCONF_VER value)
# AUTORECONF (READ-ONLY)
#				- Set to path of GNU autoconf autoreconf
#				  (default: according to USE_AUTOCONF_VER value)
# AUTOSCAN (READ-ONLY)
#				- Set to path of GNU autoconf autoscan
#				  (default: according to USE_AUTOCONF_VER value)
# AUTOIFNAMES (READ-ONLY)
#				- Set to path of GNU autoconf autoifnames
#				  (default: according to USE_AUTOCONF_VER value)
# AUTOCONF_DIR (READ-ONLY)
#				- Set to path of GNU autoconf shared directory (default:
#				  according to USE_AUTOCONF_VER value)
##
# USE_LIBTOOL_VER (PORT MAY SET THIS VALUE)
#				- Implies USE_LIBTOOL. 
#				- Implies WANT_LIBTOOL_VER=(value)
# USE_LIBTOOL (PORT MAY SET THIS VALUE)
#				- Says that the port uses Libtool.  
#				- Implies GNU_CONFIGURE.
#				- Implies WANT_LIBTOOL_VER?=13
# LIBTOOL (READ-ONLY)
#				- Set to path of libtool (default:
#				  according to USE_LIBTOOL_VER value)
# LIBTOOLIZE (READ-ONLY)
#				- Set to path of libtoolize (default:
#				  according to USE_LIBTOOL_VER value)
# LIBTOOL_VERSION (READ-ONLY)
#				- Exported version of USE_LIBTOOL_VER
# LIBTOOL_SHAREDIR (READ-ONLY)
#				- Set to path of GNU libtool shared directory (default:
#				  according to USE_LIBTOOL_VER value)
# LIBTOOL_LIBEXECDIR (READ-ONLY)
#				- Set to path of GNU libtool libexec directory (default:
#				  according to USE_LIBTOOL_VER value)
# LIBTOOLFILES	- Files to patch for libtool (defaults: "aclocal.m4" if
#				  USE_AUTOCONF is set, "configure" otherwise).
# LIBTOOLFLAGS	- Additional flags to pass to ltconfig
#				  (default: --disable-ltlibs)
##
# USE_GETOPT_LONG	- Says that the port uses getopt_long. If OSVERSION
#				  less than 500041, automatically adds devel/libgnugeopt
#				  to LIB_DEPENDS, and pass adjusted values of 
#				  CPPFLAGS and LDFLAGS in CONFIGURE_ENV.
#				  Default: not set.
##
# USE_PERL5		- Says that the port uses perl5 for building and running.
# USE_PERL5_BUILD	- Says that the port uses perl5 for building.
# USE_PERL5_RUN		- Says that the port uses perl5 for running.
# PERL5			- Set to full path of perl5, either in the system or
#				  installed from a port.
# PERL			- Set to full path of perl5, either in the system or
#				  installed from a port, but without the version number.
#				  Use this if you need to replace "#!" lines in scripts.
# PERL_VERSION	- Full version of perl5 (see below for current value).
# PERL_VER		- Short version of perl5 (see below for current value).
# PERL_LEVEL	- Perl version as an integer of the form MNNNPP, where
#					M is major version, N is minor version, and P is
#					the patch level. E.g., PERL_VERSION=5.6.1 would give
#					a PERL_LEVEL of 500601. This can be used in comparisons
#					to determine if the version of perl is high enough,
#					whether a particular dependency is needed, etc.
# PERL_ARCH		- Directory name of architecture dependent libraries
#				  (value: ${ARCH}-freebsd).
# PERL_PORT		- Name of the perl port that is installed
#				  (value: perl5)
# SITE_PERL		- Directory name where site specific perl packages go.
#					This value is added to PLIST_SUB.
##
# USE_BISON		- Says that the port uses bison for building.
##
# USE_IMAKE		- Says that the port uses imake.  Implies USE_X_PREFIX.
# XMKMF			- Set to path of `xmkmf' if not in $PATH (default: xmkmf -a ).
# USE_X_PREFIX	- Says that the port installs in ${X11BASE}.  Implies USE_XLIB.
# USE_XLIB		- Says that the port uses the X libraries.
#
# USE_DGS		- Says that the port uses the dgs X11 libraries.
# USE_FREETYPE	- Says that the port uses the freetype print libraries.
# USE_MESA		- Says that the port uses the Mesa libraries.
# USE_MOTIF		- Says that the port uses the Motif toolkit.  Implies USE_XPM.
# USE_SDL		- Says that the port uses the sdl libraries.
# USE_XPM		- Says that the port uses the xpm graphics libraries.
##
# USE_OPENSSL	- Says that the port relies on the OpenSSL package.
#				  Default: not set.
##
# USE_JAVA		- Says that the port relies on the Java language.
#				  Implies inclusion of bsd.java.mk.  (Also see
#				  that file for more information on USE_JAVA_*).
#				  Default: not set.
# USE_PYTHON	- Says that the port relies on the Python language.
#				  Implies inclusion of bsd.python.mk. (Also see
#				  that file for more information on USE_PYTHON_*
#				  and USE_PYDISTUTILS).
#				  Default: not set.
# USE_RUBY		- Says that the port relies on the Ruby language.
#				  Implies inclusion of bsd.ruby.mk.  (Also see
#				  that file for more information on USE_RUBY_*).
#				  Default: not set.
##
# USE_GNOME		- A list of the Gnome dependencies the port has (e.g.,
#				  glib12, gtk12).  Implies that the port needs Gnome.
#				  Implies inclusion of bsd.gnome.mk.  See bsd.gnome.mk
#				  or http://www.FreeBSD.org/gnome/docs/porting.html
#				  for more details.
#				  Default: not set.
#
# USE_KDEBASE_VER	- Set to either 2 or 3 to use the KDE windowing system.
#					  (Only 3 is currently supported).  Implies inclusion
#					  of bsd.kde.mk.  Default: not set.
# USE_KDELIBS_VER	- Set to either 2 or 3 to use the KDE libraries.
#					  (Only 3 is currently supported).  Implies inclusion
#					  of bsd.kde.mk.  Default: not set.
# USE_QT_VER		- Set to either 2 or 3 to use the QT libraries.
#					  (Only 3 is currently supported).  Implies inclusion
#					  of bsd.kde.mk.  Default: not set.
#
# USE_LINUX			- Set to yes to say the port needs emulators/linux_base.
#					  Default: not set.
# USE_LINUX_PREFIX	- controls the action of PREFIX (see above).
#
# Dependency checking.  Use these if your port requires another port
# not in the list above.  (Default: empty.)
#
# EXTRACT_DEPENDS - A list of "path:dir[:target]" tuples of other ports this
#				  package depends on in the "extract" stage.  "path" is
#				  the name of a file if it starts with a slash (/), an
#				  executable otherwise.  make will test for the existence
#				  (if it is a full pathname) or search for it in your
#				  $PATH (if it is an executable) and go into "dir" to do
#				  a "make all install" if it's not found.  If the third
#				  field ("target") exists, it will be used instead of
#				  ${DEPENDS_TARGET}.
# PATCH_DEPENDS - A list of "path:dir[:target]" tuples of other ports this
#				  package depends on in the "patch" stage.  "path" is the
#				  name of a file if it starts with a slash (/), an
#				  executable otherwise.  make will test for the existence
#				  (if it is a full pathname) or search for it in your
#				  $PATH (if it is an executable) and go into "dir" to do
#				  a "make all install" if it's not found.  If the third
#				  field ("target") exists, it will be used instead of
#				  ${DEPENDS_TARGET}.
# FETCH_DEPENDS - A list of "path:dir[:target]" tuples of other ports this
#				  package depends in the "fetch" stage.  "path" is the
#				  name of a file if it starts with a slash (/), an
#				  executable otherwise.  make will test for the
#				  existence (if it is a full pathname) or search for
#				  it in your $PATH (if it is an executable) and go
#				  into "dir" to do a "make all install" if it's not
#				  found.  If the third field ("target") exists, it will
#				  be used instead of ${DEPENDS_TARGET}.
# BUILD_DEPENDS - A list of "path:dir[:target]" tuples of other ports this
#				  package depends to build (between the "extract" and
#				  "build" stages, inclusive).  The test done to
#				  determine the existence of the dependency is the
#				  same as FETCH_DEPENDS.  If the third field ("target")
#				  exists, it will be used instead of ${DEPENDS_TARGET}.
# RUN_DEPENDS	- A list of "path:dir[:target]" tuples of other ports this
#				  package depends to run.  The test done to determine
#				  the existence of the dependency is the same as
#				  FETCH_DEPENDS.  This will be checked during the
#				  "install" stage and the name of the dependency will
#				  be put into the package as well.  If the third field
#				  ("target") exists, it will be used instead of
#				  ${DEPENDS_TARGET}.
# LIB_DEPENDS	- A list of "lib:dir[:target]" tuples of other ports this
#				  package depends on.  "lib" is the name of a shared library.
#				  make will use "ldconfig -r" to search for the library.
#				  lib can contain extended regular expressions.
# DEPENDS		- A list of "dir[:target]" tuples of other ports this
#				  package depends on being made first.  Use this only for
#				  things that don't fall into the above four categories.
#				  If the second field ("target") exists, it will be used
#				  instead of ${DEPENDS_TARGET}.
# DEPENDS_TARGET - The default target to execute when a port is calling a
#				  dependency (default: "install").
#
# Conflict checking.  Use if your port cannot be installed at the same time as
# another package.
#
# CONFLICTS      - A list of package name patterns that the port conflicts with.
#                  It's possible to use any shell meta-characters for pattern
#                  matching.
#                  E.g. apache*-1.2* apache*-1.3.[012345] apache-*+ssl_*
#
#
# Various directory definitions and variables to control them.
# You rarely need to redefine any of these except WRKSRC and NO_WRKSUBDIR.
#
# X11BASE		- Where X11 ports install things (default: /usr/X11R6).
# LOCALBASE		- Where non-X11 ports install things (default: /usr/local).
# LINUXBASE		- Where Linux ports install things (default: /compat/linux).
# PREFIX		- Where *this* port installs its files (default: ${X11BASE}
#				  if USE_X_PREFIX is set, ${LINUXBASE} if USE_LINUX_PREFIX
#				  is set, otherwise ${LOCALBASE}).
# MASTERDIR		- Where the port finds patches, package files, etc.  Define
#				  this is you have two or more ports that share most of the
#				  files (default: ${.CURDIR}).
# PORTSDIR		- The root of the ports tree.  Defaults:
#					FreeBSD/OpenBSD: /usr/ports
#					NetBSD:          /usr/opt
# DISTDIR 		- Where to get gzip'd, tarballed copies of original sources
#				  (default: ${PORTSDIR}/distfiles).
# PACKAGES		- A top level directory where all packages go (rather than
#				  going locally to each port). (default: ${PORTSDIR}/packages).
# WRKDIRPREFIX	- The place to root the temporary working directory
#				  hierarchy (default: none).
# WRKDIR 		- A temporary working directory that gets *clobbered* on clean
#				  (default: ${WRKDIRPREFIX}${.CURDIR}/work).
# WRKSRC		- A subdirectory of ${WRKDIR} where the distribution actually
#				  unpacks to.  (Default: ${WRKDIR}/${DISTNAME} unless
#				  NO_WRKSUBDIR is set, in which case simply ${WRKDIR}).
# NO_WRKSUBDIR	- Assume port unpacks directly into ${WRKDIR}.
# PATCHDIR 		- A directory containing any additional patches you made
#				  to port this software to FreeBSD (default:
#				  ${MASTERDIR}/files)
# SCRIPTDIR 	- A directory containing any auxiliary scripts
#				  (default: ${MASTERDIR}/scripts)
# FILESDIR 		- A directory containing any miscellaneous additional files.
#				  (default: ${MASTERDIR}/files)
# PKGDIR 		- A direction containing any package creation files.
#				  (default: ${MASTERDIR})
#
# Variables that serve as convenient "aliases" for your *-install targets.
# Use these like: "${INSTALL_PROGRAM} ${WRKSRC}/prog ${PREFIX}/bin".
#
# INSTALL_PROGRAM - A command to install binary executables.  (By
#					default, also strips them, unless ${STRIP} is
#					overridden to be the empty string).
# INSTALL_SCRIPT  - A command to install executable scripts.
# INSTALL_DATA	  - A command to install sharable data.
# INSTALL_MAN	  - A command to install manpages.  May or not compress,
#					depending on the value of MANCOMPRESSED (see below).
#
# Boolean to control whether manpages are installed.
#
# NO_INSTALL_MANPAGES - Says that the port doesn't want to install any
#						manpages (default: not set, i.e. manpages
#						are installed by default).
#
# Set the following to specify all manpages that your port installs.
# These manpages will be automatically listed in ${PLIST}.  Depending
# on the setting of NOMANCOMPRESS, the make rules will compress the
# manpages for you.
#
# MAN<sect>		- A list of manpages, categorized by section.  For
#				  example, if your port has "man/man1/foo.1" and
#				  "man/mann/bar.n", set "MAN1=foo.1" and "MANN=bar.n".
#				  The available sections chars are "123456789LN".
# MLINKS		- A list of <source, target> tuples for creating links
#				  for manpages.  For example, "MLINKS= a.1 b.1 c.3 d.3"
#				  will do an "ln -sf a.1 b.1" and "ln -sf c.3 d.3" in
#				  appropriate directories.  (Use this even if the port
#				  installs its own manpage links so they will show up
#				  correctly in ${PLIST}.)
# MANPREFIX		- The directory prefix for ${MAN<sect>} and ${MLINKS}
#				  (default: ${PREFIX}).
# MAN<sect>PREFIX - If manual pages of some sections install in different
#				  locations than others, use these (default: ${MANPREFIX}).
# MANCOMPRESSED - This variable can take values "yes", "no" or
#				  "maybe".  "yes" means manpages are installed
#				  compressed; "no" means they are not; "maybe" means
#				  it changes depending on the value of
#				  NOMANCOMPRESS.  The default is "yes" if USE_IMAKE
#				  is set and NO_INSTALL_MANPAGES is not set, and
#				  "no" otherwise.
#
# Default targets and their behaviors:
#
# fetch			- Retrieves ${DISTFILES} (and ${PATCHFILES} if defined)
#				  into ${DISTDIR} as necessary.
# fetch-list	- Show list of files that would be retrieved by fetch.
# fetch-recursive - Retrieves ${DISTFILES} (and ${PATCHFILES} if defined),
#				  for port and dependencies into ${DISTDIR} as necessary.
# fetch-recursive-list  - Show list of files that would be retrieved by
#				  fetch-recursive.
# fetch-required-list - Show list of files that would be retrieved by
#				  fetch-required.
# fetch-required - Retrieves ${DISTFILES} (and ${PATCHFILES} if defined),
#				  for port and dependencies that are not already installed
#				  into ${DISTDIR}.
# extract		- Unpacks ${DISTFILES} into ${WRKDIR}.
# patch			- Apply any provided patches to the source.
# configure		- Runs either GNU configure, one or more local configure
#				  scripts or nothing, depending on what's available.
# build			- Actually compile the sources.
# install		- Install the results of a build.
# reinstall		- Install the results of a build, ignoring "already installed"
#				  flag.
# deinstall		- Remove the installation.
# deinstall-all	- Remove all installations with the same PKGORIGIN.
# package		- Create a package from an _installed_ port.
# describe		- Try to generate a one-line description for each port for
#				  use in INDEX files and the like.
# checkpatch	- Do a "patch -C" instead of a "patch".  Note that it may
#				  give incorrect results if multiple patches deal with
#				  the same file.
# checksum		- Use distinfo to ensure that your distfiles are valid.
# checksum-recursive - Run checksum in this port and all dependencies.
# makesum		- Generate distinfo (only do this for your own ports!).
# clean		    - Remove ${WRKDIR} and other temporary files used for building.
# clean-depends	- Do a "make clean" for all dependencies.
#
# Default sequence for "all" is:  fetch checksum extract patch configure build
#
# Please read the comments in the targets section below; you
# should be able to use the pre-* or post-* targets/scripts
# (which are available for every stage except checksum) or
# override the do-* targets to do pretty much anything you want.
#
# NEVER override the "regular" targets unless you want to open
# a major can of worms.
#
# Set these variables if your port doesn't need some of the steps.
# Note that there are no NO_PATCH or NO_CONFIGURE variables because
# those steps are empty by default.  NO_EXTRACT is not allowed anymore
# since we need to at least create ${WRKDIR}.  Also, NO_CHECKSUM is a user
# variable and is not to be set in a port's Makefile.  See above for NO_PACKAGE.
#
# NO_BUILD		- Use a dummy (do-nothing) build target.
# NO_INSTALL	- Use a dummy (do-nothing) install target.
#
# Here are some variables used in various stages.
#
# For fetch:
#
# FETCH_CMD		- Full path to ftp/http fetch command if not in $PATH
#				  (default: "/usr/bin/fetch -ARr").
# FETCH_BEFORE_ARGS -
#				  Arguments to ${FETCH_CMD} before filename (default: none).
# FETCH_AFTER_ARGS -
#				  Arguments to ${FETCH_CMD} following filename (default: none).
# FETCH_ENV		- Environment to pass to ${FETCH_CMD} (default: none).
# FETCH_REGET	- Times to retry fetching of files on checksum errors (default: 1).
#
# For extract:
#
# EXTRACT_CMD	- Command for extracting archive (default: "bzip2" if
#				  USE_BZIP2 is set, "unzip" if USE_ZIP is set, "gzip" 
#				  otherwise).
# EXTRACT_BEFORE_ARGS -
#				  Arguments to ${EXTRACT_CMD} before filename
#				  (default: "-dc").
# EXTRACT_AFTER_ARGS -
#				  Arguments to ${EXTRACT_CMD} following filename
#				  (default: "| tar -xf -").
# EXTRACT_PRESERVE_OWNERSHIP -
#				  Normally, when run as "root", the extract stage will
#				  change the owner and group of all files under ${WRKDIR}
#				  to 0:0.  Set this variable if you want to turn off this
#				  feature.
#
# For patch:
#
# EXTRA_PATCHES - Define this variable if you have patches not in
#				  ${PATCHDIR}.  This usually happens when you need to
#				  do some pre-processing before some distribution
#				  patches can be applied.  In that case, fetch them as
#				  extra distfiles, put the processed results in
#				  ${WRKDIR}, then point EXTRA_PATCHES to them.
#
#				  The patches specified by this variable will be
#				  applied after the normal distribution patches but
#				  before those in ${PATCHDIR}.
# PATCH_WRKSRC  - Directory to apply patches in (default: ${WRKSRC}).
#
# For configure:
#
# HAS_CONFIGURE	- Says that the port has its own configure script.  The
#				  configure stage will not do anything if this is not set.
# GNU_CONFIGURE	- Set if you are using GNU configure (optional).  Implies
#				  HAS_CONFIGURE.
# PERL_CONFIGURE - Configure using Perl's MakeMaker.  Implies USE_PERL5.
# CONFIGURE_WRKSRC - Directory to run configure in (default: ${WRKSRC}).
# CONFIGURE_SCRIPT - Name of configure script, relative to ${CONFIGURE_WRKSRC}
#				  (default: "Makefile.PL" if PERL_CONFIGURE is set,
#				  "configure" otherwise).
# CONFIGURE_TARGET - The name of target to call when GNU_CONFIGURE is
#				  defined (default: ${MACHINE_ARCH}-portbld-freebsd${OSREL}).
# CONFIGURE_ARGS - Pass these args to configure if ${HAS_CONFIGURE} is set
#				  (default: "--prefix=${PREFIX} ${CONFIGURE_TARGET}" if
#				  GNU_CONFIGURE is set, "CC=${CC} CCFLAGS=${CFLAGS}
#				  PREFIX=${PREFIX} INSTALLPRIVLIB=${PREFIX}/lib
#				  INSTALLARCHLIB=${PREFIX}/lib" if PERL_CONFIGURE is set,
#				  empty otherwise).
# CONFIGURE_ENV - Pass these env (shell-like) to configure if
#				  ${HAS_CONFIGURE} is set.
# CONFIGURE_LOG - The name of configure log file (default: config.log).
#				  It will be printed to the screen if configure fails.
#
# For build and install:
#
# MAKEFILE		- Name of the makefile (default: Makefile).
# ALL_TARGET	- Default target for sub-make in build stage (default: all).
# BUILD_WRKSRC  - Directory to do build in (default: ${WRKSRC}).
# MAKE_ENV		- Additional environment vars passed to sub-make in build
#				  and install stages (default: see below).
# MAKE_ARGS		- Any extra arguments to sub-make in build and install
#				  stages (default: none).
#
# For install:
#
# INSTALL_TARGET - Default target for sub-make in install stage 
# 				  (default: install).
# INSTALL_WRKSRC - Directory to install from (default: ${WRKSRC}).
# NO_MTREE		- If set, will not invoke mtree from bsd.port.mk from
#				  the "install" target.
# MTREE_FILE	- The name of the mtree file (default: /etc/mtree/BSD.x11.dist
#				  if USE_X_PREFIX is set, /etc/mtree/BSD.local.dist
#				  otherwise.)
# PLIST			- Name of the `packing list' file (default: ${PKGDIR}/pkg-plist).
#				  Change this to ${WRKDIR}/PLIST or something if you
#				  need to write to it.  (It is not a good idea for a port
#				  to write to any file outside ${WRKDIR} during a normal
#				  build.)
# TMPPLIST		- Name of the `packing list' file after processing
#				  (default: ${WRKDIR}/.PLIST.mktmp).
# PLIST_SUB		- List of "variable=value" pair for substitution in ${PLIST}
# 				  (default: see below).
# INSTALLS_SHLIB - If set, bsd.port.mk will automatically run ldconfig commands
#				  from post-install and also add appropriate @exec/@unexec
#				  directives to directories listed in LDCONFIG_DIRS.
# LDCONFIG_DIRS - List of directories to run ldconfig if
#				  INSTALLS_SHLIB is set (default: %%PREFIX%%/lib).
#				  Note that this is passed through sed just like the
#				  rest of PLIST, so ${PLIST_SUB} substitutions also
#				  apply here.  It is recommended that you use
#				  %%PREFIX%% for ${PREFIX}, %%LOCALBASE%% for
#				  ${LOCALBASE} and %%X11BASE%% for ${X11BASE}.
# DOCSDIR		- Name of the directory to install the packages docs in
#				  (default: ${PREFIX}/share/doc/${PORTNAME}).
# EXAMPLESDIR		- Name of the directory to install the packages examples in
#				  (default: ${PREFIX}/share/examples/${PORTNAME}).
# DATADIR		- Name of the directory to install the packages shared data
#				  in (default: ${PREFIX}/share/${PORTNAME}).
# 
# Note that the install target will automatically add manpages (see
# above) and also substitute special sequences of characters (delimited
# by "%%") as defined in PLIST_SUB to generate ${TMPPLIST}.  For
# instance, "OSREL=${OSREL}" in PLIST_SUB causes all occurrences of
# "%%OSREL%%" in ${PLIST} to be substituted by the value of OSREL.
# ${TMPPLIST} is generated before the do-install stage.  If you are
# generating the packing list on-the-fly, make sure it's generated before
# do-install is called!
#
# For package:
#
# NO_LATEST_LINK - Do not install the "Latest" link for package.  Define this
#				  if this port is a beta version of another stable port
#				  which is also in the tree.
# LATEST_LINK    - Install the "Latest" link for the package as ___.  Define
#                 this if the "Latest" link name will be incorrectly determined.
#
# This is used in all stages:
#
# SCRIPTS_ENV	- Additional environment vars passed to scripts in
#                 ${SCRIPTDIR} executed by bsd.port.mk (default: see below).
#
# Finally, variables to change if you want a special behavior.  These
# are for debugging purposes.  Don't set them in your Makefile.
#
# ECHO_MSG		- Used to print all the '===>' style prompts - override this
#				  to turn them off (default: ${ECHO_CMD}).
# PATCH_DEBUG	- If set, print out more information about the patches as
#				  it attempts to apply them.
# PKG_DBDIR		- Where package installation is recorded (default: /var/db/pkg)
# NO_PKG_REGISTER - Don't register a port installation as a package.
# FORCE_PKG_REGISTER - If set, it will overwrite any existing package
#				  registration information in ${PKG_DBDIR}/${PKGNAME}.
# NO_DEPENDS	- Don't verify build of dependencies.
# NO_CHECKSUM	- Don't verify the checksum.  Typically used when
#				  when you noticed the distfile you just fetched has
#				  a different checksum and you intend to verify if
#				  the port still works with it.
# USE_PACKAGE_DEPENDS - Install dependencies from existing packages instead
#				  of building the port from scratch.
#
# End of the list of all variables that need to be defined in a port.
# Most port authors should not need to understand anything after this point.
#

# Start of pre-makefile section.
.if !defined(AFTERPORTMK)

.if defined(_PREMKINCLUDED)
.BEGIN:
	@${ECHO_CMD} "${PKGNAME}: You cannot include bsd.port[.pre].mk twice"
	@${FALSE}
.endif

_PREMKINCLUDED=	yes

AWK?=		/usr/bin/awk
BASENAME?=	/usr/bin/basename
.if exists(/usr/bin/bzip2)
BZCAT?=		/usr/bin/bzcat
BZIP2_CMD?=	/usr/bin/bzip2
.else
BZCAT?=		${LOCALBASE}/bin/bzcat
BZIP2_CMD?=	${LOCALBASE}/bin/bzip2
BZIP2DEPENDS=	yes
.endif
CAT?=		/bin/cat
CHGRP?=		/usr/bin/chgrp
CHMOD?=		/bin/chmod
CHOWN?=		/usr/sbin/chown
COMM?=		/usr/bin/comm
CP?=		/bin/cp
CUT?=		/usr/bin/cut
DC?=		/usr/bin/dc
EGREP?=		/usr/bin/egrep
EXPR?=		/bin/expr
FALSE?=		false				# Shell builtin
FILE?=		/usr/bin/file
FIND?=		/usr/bin/find
GREP?=		/usr/bin/grep
GUNZIP_CMD?=	/usr/bin/gunzip -f
GZCAT?=		/usr/bin/gzcat
GZIP?=		-9
GZIP_CMD?=	/usr/bin/gzip -nf ${GZIP}
HEAD?=		/usr/bin/head
ID?=		/usr/bin/id
IDENT?=		/usr/bin/ident
LDCONFIG?=	/sbin/ldconfig
LN?=		/bin/ln
LS?=		/bin/ls
MKDIR?=		/bin/mkdir -p
MV?=		/bin/mv
REALPATH?=	/bin/realpath
RM?=		/bin/rm
RMDIR?=		/bin/rmdir
SED?=		/usr/bin/sed
SETENV?=	/usr/bin/env
SH?=		/bin/sh
STRIP_CMD?=	/usr/bin/strip
SU?=		/usr/bin/su
TAIL?=		/usr/bin/tail
TEST?=		test				# Shell builtin
TR?=		/usr/bin/tr
TRUE?=		true				# Shell builtin
UNAME?=		/usr/bin/uname
WHICH?=		/usr/bin/which
XARGS?=		/usr/bin/xargs
YACC?=		/usr/bin/yacc

# ECHO is defined in /usr/share/mk/sys.mk, which can either be "echo",
# or "true" if the make flag -s is given.  Use ECHO_CMD where you mean
# the echo command.
ECHO_CMD?=	echo				# Shell builtin

# Used to print all the '===>' style prompts - override this to turn them off.
ECHO_MSG?=		${ECHO_CMD}

# Get the architecture
.if !defined(ARCH)
ARCH!=	${UNAME} -p
.endif

# Kludge for pre-3.0 systems
MACHINE_ARCH?=	i386

# Get the operating system type
.if !defined(OPSYS)
OPSYS!=	${UNAME} -s
.endif

# Get the operating system revision
.if !defined(OSREL)
OSREL!=	${UNAME} -r | ${SED} -e 's/[-(].*//'
.endif

# Get __FreeBSD_version
.if !defined(OSVERSION)
.if exists(/sbin/sysctl)
OSVERSION!=	/sbin/sysctl -n kern.osreldate
.else
OSVERSION!=	/usr/sbin/sysctl -n kern.osreldate
.endif
.endif

# Get the object format.
.if !defined(PORTOBJFORMAT)
PORTOBJFORMAT!=	test -x /usr/bin/objformat && /usr/bin/objformat || echo aout
.endif

MASTERDIR?=	${.CURDIR}

# If they exist, include Makefile.inc, then architecture/operating
# system specific Makefiles, then local Makefile.local.

.if ${MASTERDIR} != ${.CURDIR} && exists(${.CURDIR}/../Makefile.inc)
.include "${.CURDIR}/../Makefile.inc"
USE_SUBMAKE=	yes
.endif

.if exists(${MASTERDIR}/../Makefile.inc)
.include "${MASTERDIR}/../Makefile.inc"
USE_SUBMAKE=	yes
.endif

.if exists(${MASTERDIR}/Makefile.${ARCH}-${OPSYS})
.include "${MASTERDIR}/Makefile.${ARCH}-${OPSYS}"
USE_SUBMAKE=	yes
.elif exists(${MASTERDIR}/Makefile.${OPSYS})
.include "${MASTERDIR}/Makefile.${OPSYS}"
USE_SUBMAKE=	yes
.elif exists(${MASTERDIR}/Makefile.${ARCH})
.include "${MASTERDIR}/Makefile.${ARCH}"
USE_SUBMAKE=	yes
.endif

.if exists(${MASTERDIR}/Makefile.local)
.include "${MASTERDIR}/Makefile.local"
USE_SUBMAKE=	yes
.endif

.if !defined(PORTNAME) || !defined(PORTVERSION) || defined(PKGNAME)
.BEGIN:
	@${ECHO_CMD} "${PKGNAME}: You need to define PORTNAME and PORTVERSION instead of PKGNAME."
	@${ECHO_CMD} "(This port is too old for your bsd.port.mk, please update it to match"
	@${ECHO_CMD} " your bsd.port.mk.)"
	@${FALSE}
.endif

PORTREVISION?=	0
.if ${PORTREVISION} != 0
_SUF1=	_${PORTREVISION}
.endif

PORTEPOCH?=		0
.if ${PORTEPOCH} != 0
_SUF2=	,${PORTEPOCH}
.endif

PKGNAME=	${PKGNAMEPREFIX}${PORTNAME}${PKGNAMESUFFIX}-${PORTVERSION}${_SUF1}${_SUF2}
DISTNAME?=	${PORTNAME}-${PORTVERSION}

# These need to be absolute since we don't know how deep in the ports
# tree we are and thus can't go relative.  They can, of course, be overridden
# by individual Makefiles or local system make configuration.
.if (${OPSYS} == "NetBSD")
PORTSDIR?=		/usr/opt
.else
PORTSDIR?=		/usr/ports
.endif
LOCALBASE?=		${DESTDIR}/usr/local
X11BASE?=		${DESTDIR}/usr/X11R6
LINUXBASE?=		${DESTDIR}/compat/linux
DISTDIR?=		${PORTSDIR}/distfiles
_DISTDIR?=		${DISTDIR}/${DIST_SUBDIR}
.if ${OSVERSION} >= 500036
INDEXFILE?=		INDEX-5
.else
INDEXFILE?=		INDEX
.endif
.if defined(USE_BZIP2)
EXTRACT_SUFX?=			.tar.bz2
.elif defined(USE_ZIP)
EXTRACT_SUFX?=			.zip
.else
EXTRACT_SUFX?=			.tar.gz
.endif
PACKAGES?=		${PORTSDIR}/packages
TEMPLATES?=		${PORTSDIR}/Templates

.if (!defined(PATCHDIR) && exists(${MASTERDIR}/patches)) || \
	(!defined(PKGDIR) && exists(${MASTERDIR}/pkg)) || \
	(!defined(MD5_FILE) && exists(${MASTERDIR}/files/md5))
pre-everything::
	@${ECHO_CMD} "Error: your port uses an old layout.  Please update it to match this bsd.port.mk.  If you have updated your ports collection via cvsup and are still getting this error, see Q12 and Q13 in the cvsup FAQ on http://www.polstra.com for further information."
	@${FALSE}
.endif
PATCHDIR?=		${MASTERDIR}/files
FILESDIR?=		${MASTERDIR}/files
SCRIPTDIR?=		${MASTERDIR}/scripts
PKGDIR?=		${MASTERDIR}

.if defined(USE_IMAKE) && !defined(USE_X_PREFIX)
USE_X_PREFIX=	yes
.endif
.if defined(USE_X_PREFIX) && ${USE_X_PREFIX} == "no"
.undef USE_X_PREFIX
.endif
.if defined(USE_X_PREFIX)
USE_XLIB=		yes
.endif
.if defined(USE_LINUX_PREFIX)
USE_LINUX=		yes
.endif
.if defined(USE_X_PREFIX)
PREFIX?=		${X11BASE}
.elif defined(USE_LINUX_PREFIX)
PREFIX?=		${LINUXBASE}
NO_MTREE=		yes
.else
PREFIX?=		${LOCALBASE}
.endif

.if !defined(PERL_LEVEL) && defined(PERL_VERSION)
perl_major=		${PERL_VERSION:C|^([1-9]+).*|\1|}
_perl_minor=	00${PERL_VERSION:C|^([1-9]+)\.([0-9]+).*|\2|}
perl_minor=		${_perl_minor:C|^.*(...)|\1|}
.if ${perl_minor} >= 100
perl_minor=		${PERL_VERSION:C|^([1-9]+)\.([0-9][0-9][0-9]).*|\2|}
perl_patch=		${PERL_VERSION:C|^.*(..)|\1|}
.else # ${perl_minor} < 100
_perl_patch=	0${PERL_VERSION:C|^([1-9]+)\.([0-9]+)\.*|0|}
perl_patch=		${_perl_patch:C|^.*(..)|\1|}
.endif # ${perl_minor} < 100
PERL_LEVEL=	${perl_major}${perl_minor}${perl_patch}
.else
PERL_LEVEL=0
.endif # !defined(PERL_LEVEL) && defined(PERL_VERSION)

.if defined(USE_OPENSSL)
.if ${OSVERSION} >= 400014
.if !exists(/usr/lib/libcrypto.so)
.BEGIN:
	@${ECHO_CMD} "This port requires the OpenSSL library, which is part of"
	@${ECHO_CMD} "the FreeBSD crypto distribution but not installed on your"
	@${ECHO_CMD} "machine. Please see the \"OpenSSL\" section in the handbook"
	@${ECHO_CMD} "(at \"http://www.FreeBSD.org/doc/en_US.ISO8859-1/books/handbook/openssl.html\", for instance)"
	@${ECHO_CMD} "for instructions on how to obtain and install the FreeBSD"
	@${ECHO_CMD} "OpenSSL distribution."
	@${FALSE}
.else
OPENSSLBASE=	/usr
OPENSSLDIR=		/etc/ssl
# OpenSSL in the base system may not include IDEA for patent licensing reasons.
.if defined(MAKE_IDEA) && !defined(OPENSSL_IDEA)
OPENSSL_IDEA=	${MAKE_IDEA}
.else
OPENSSL_IDEA?=	NO
.endif
.if ${OPENSSL_IDEA} == "NO"
# XXX This is a hack to work around the fact that /etc/make.conf clobbers
#     our CFLAGS. It might not be enough for all future ports.
.if defined(HAS_CONFIGURE)
CFLAGS+=		-DNO_IDEA
.else
OPENSSL_CFLAGS+=-DNO_IDEA
.endif
MAKE_ARGS+=		OPENSSL_CFLAGS="${OPENSSL_CFLAGS}"
.endif
.endif
.else
LIB_DEPENDS+=	crypto.2:${PORTSDIR}/security/openssl
OPENSSLBASE?=	${LOCALBASE}
OPENSSLDIR?=	${OPENSSLBASE}/openssl
.endif
OPENSSLLIB=		${OPENSSLBASE}/lib
OPENSSLINC=		${OPENSSLBASE}/include
MAKE_ENV+=		OPENSSLLIB=${OPENSSLLIB} OPENSSLINC=${OPENSSLINC} \
				OPENSSLBASE=${OPENSSLBASE} OPENSSLDIR=${OPENSSLDIR}
.endif

.if defined(EMACS_PORT_NAME)
.include "${PORTSDIR}/Mk/bsd.emacs.mk"
.endif

.if defined(USE_PYTHON)
.include "${PORTSDIR}/Mk/bsd.python.mk"
.endif

.if defined(USE_JAVA)
.include "${PORTSDIR}/Mk/bsd.java.mk"
.endif

.if defined(USE_RUBY) || defined(USE_LIBRUBY)
.include "${PORTSDIR}/Mk/bsd.ruby.mk"
.endif

.if defined(USE_QT) || defined(USE_QT2) || defined(USE_QT_VER) || defined(USE_KDELIBS_VER) || defined(USE_KDEBASE_VER)
.include "${PORTSDIR}/Mk/bsd.kde.mk"
.endif

.include "${PORTSDIR}/Mk/bsd.gnome.mk"

# defaults to 4.x for 5.0-CURRENT and 4.5-STABLE; and 3.3.6 for all other branches
.if ${OSVERSION} > 500025 || ( ${OSVERSION} >= 450005 && ${OSVERSION} < 500000 )
XFREE86_VERSION?=	4
.else
XFREE86_VERSION?=	3
.endif

# Location of mounted CDROM(s) to search for files
CD_MOUNTPTS?=	/cdrom ${CD_MOUNTPT}

.endif
# End of pre-makefile section.

# Start of post-makefile section.
.if !defined(BEFOREPORTMK)

.if defined(_POSTMKINCLUDED)
.BEGIN:
	@${ECHO_CMD} "${PKGNAME}: You cannot include bsd.port[.post].mk twice"
	@${FALSE}
.endif

_POSTMKINCLUDED=	yes

WRKDIR?=		${WRKDIRPREFIX}${.CURDIR}/work
.if defined(NO_WRKSUBDIR)
WRKSRC?=		${WRKDIR}
.else
WRKSRC?=		${WRKDIR}/${DISTNAME}
.endif

PATCH_WRKSRC?=	${WRKSRC}
CONFIGURE_WRKSRC?=	${WRKSRC}
BUILD_WRKSRC?=	${WRKSRC}
INSTALL_WRKSRC?=${WRKSRC}

PLIST_SUB+=	OSREL=${OSREL} PREFIX=%D LOCALBASE=${LOCALBASE} X11BASE=${X11BASE}

.if defined(NOPORTDOCS)
PLIST_SUB+=	        PORTDOCS="@comment "
.else
PLIST_SUB+=	        PORTDOCS=""
.endif

CONFIGURE_SHELL?=	${SH}
MAKE_SHELL?=	${SH}

CONFIGURE_ENV+=	SHELL=${SH} CONFIG_SHELL=${SH} PORTOBJFORMAT=${PORTOBJFORMAT}
SCRIPTS_ENV+=	PORTOBJFORMAT=${PORTOBJFORMAT}
MAKE_ENV+=		SHELL=${SH} PORTOBJFORMAT=${PORTOBJFORMAT}
PLIST_SUB+=		PORTOBJFORMAT=${PORTOBJFORMAT}

.if defined(MANCOMPRESSED)
.if ${MANCOMPRESSED} != yes && ${MANCOMPRESSED} != no && \
	${MANCOMPRESSED} != maybe
.BEGIN:
	@${ECHO_CMD} "${PKGNAME}: Value of MANCOMPRESSED (is \"${MANCOMPRESSED}\") can only be \"yes\", \"no\" or \"maybe\"".
	@${FALSE}
.endif
.endif

.if defined(USE_IMAKE) && ${OPSYS} != OpenBSD && !defined(NO_INSTALL_MANPAGES)
MANCOMPRESSED?=	yes
.else
MANCOMPRESSED?=	no
.endif

.if defined(PATCHFILES)
.if ${PATCHFILES:M*.bz2}x != x && defined(BZIP2DEPENDS)
PATCH_DEPENDS+=		bzip2:${PORTSDIR}/archivers/bzip2
.endif
.if ${PATCHFILES:M*.zip}x != x
PATCH_DEPENDS+=		unzip:${PORTSDIR}/archivers/unzip
.endif
.endif

.if defined(USE_BZIP2) && defined(BZIP2DEPENDS)
EXTRACT_DEPENDS+=	bzip2:${PORTSDIR}/archivers/bzip2
.endif
.if defined(USE_ZIP)
EXTRACT_DEPENDS+=	unzip:${PORTSDIR}/archivers/unzip
.endif
.if defined(USE_GMAKE)
BUILD_DEPENDS+=		gmake:${PORTSDIR}/devel/gmake
CONFIGURE_ENV+=	MAKE=${GMAKE}
.endif

######################################################################
# AUTOMAKE/AUTOCONF
# current => non-renamed, non-relocated version

########## private variables
#	old_{am,ac}ver		==>	numeric version of "old" port[*]
#	cur_{am,ac}ver		==>	numeric version of "current" port
#	dev_{am,ac}ver		==>	numeric version of "devel" port
#	use_{am,ac}path		==> numeric version we are using here
#	{am,ac}path			==> path to non-suffixed binary, if any
#	autotools_path		==> string to prepend to PATH, if any
#
# [*] "default" version in case of USE_AUTOMAKE or USE_AUTOCONF w/o version

##########
#.if defined(AUTOMAKE) || defined(AUTOCONF)
#BROKEN="AUTOMAKE and AUTOCONF are read-only values. \
#	You may not assign to them"
#.endif # defined(AUTOMAKE) || defined(AUTOCONF)

########## versions
old_amver=	14
cur_amver=	15
dev_amver=	17
old_acver=	213
cur_acver=	253
dev_acver=	254

########## automake setup
.if defined(USE_AUTOMAKE_VER)
USE_AUTOMAKE?=		yes
WANT_AUTOMAKE_VER?=	${USE_AUTOMAKE_VER}
.endif # defined(USE_AUTOMAKE_VER)
.if defined(USE_AUTOMAKE)
USE_AUTOCONF?=		yes
WANT_AUTOMAKE_VER?=	${old_amver}
.endif # defined(USE_AUTOMAKE)
.if defined(WANT_AUTOMAKE_VER)
GNU_CONFIGURE?=		yes
use_amver=			${WANT_AUTOMAKE_VER:L}
.if ${use_amver} == ${cur_amver}
ACLOCAL_DIR=		${LOCALBASE}/share/aclocal
AUTOMAKE_DIR=		${LOCALBASE}/share/automake
BUILD_DEPENDS+=		${LOCALBASE}/bin/automake:${PORTSDIR}/devel/automake
WANT_AUTOCONF_VER?=	${cur_acver}
.elif ${use_amver} == ${old_amver} || ${use_amver} == ${dev_amver}
ACLOCAL_DIR=	${LOCALBASE}/share/aclocal${use_amver}
AUTOMAKE_DIR=	${LOCALBASE}/share/automake${use_amver}
ampath=			${LOCALBASE}/libexec/automake${use_amver}:
BUILD_DEPENDS+=	${ampath:S/://}/automake:${PORTSDIR}/devel/automake${use_amver}
.if ${use_amver} == ${old_amver}
AUTOMAKE_ARGS+=	-i
WANT_AUTOCONF_VER?=${old_acver}
.else
WANT_AUTOCONF_VER?=${dev_acver}
.endif # ${use_amver} == ${old_amver}
.else # bad automake version
BROKEN="unknown AUTOMAKE version: ${USE_AUTOMAKE_VER}"
.endif # ${use_amver} == ${cur_amver}
.endif # defined(WANT_AUTOMAKE_VER)

########## autoconf setup
.if defined(USE_AUTOCONF_VER)
USE_AUTOCONF?=		yes
WANT_AUTOCONF_VER?=	${USE_AUTOCONF_VER}
.endif # defined(USE_AUTOCONF_VER)
.if defined(USE_AUTOHEADER)
USE_AUTOCONF?=		yes
.endif # defined(USE_AUTOHEADER)
.if defined(USE_AUTOCONF)
WANT_AUTOCONF_VER?=	${old_acver}
.endif # defined(USE_AUTOCONF)
.if defined(WANT_AUTOCONF_VER)
GNU_CONFIGURE?=		yes
use_acver=			${WANT_AUTOCONF_VER:L}
.if ${use_acver} == ${cur_acver}
AUTOCONF_DIR=		${LOCALBASE}/share/autoconf
BUILD_DEPENDS+=		${LOCALBASE}/bin/autoconf:${PORTSDIR}/devel/autoconf
.elif ${use_acver} == ${old_acver} || ${use_acver} == ${dev_acver}
AUTOCONF_DIR=	${LOCALBASE}/share/autoconf${use_acver}
acpath=			${LOCALBASE}/libexec/autoconf${use_acver}
BUILD_DEPENDS+=	${acpath}/autoconf:${PORTSDIR}/devel/autoconf${use_acver}
.else # bad autoconf version
BROKEN="unknown AUTOCONF version: ${USE_AUTOCONF_VER}"
.endif # ${use_acver} == ${cur_acver}
.endif # defined(WANT_AUTOCONF_VER)

########## set up paths to tools
.if defined(ampath)
autotools_path=${ampath}${acpath}
.elif defined(acpath)
autotools_path=${acpath}
.endif # defined(ampath)

########## prefix to path, add to env vars
.if defined(autotools_path)
MAKE_ENV+=	PATH=${autotools_path}:${PATH}
CONFIGURE_ENV+=	PATH=${autotools_path}:${PATH}
SCRIPTS_ENV+=	PATH=${autotools_path}:${PATH}
AUTOCONF_ENV+=	PATH=${autotools_path}:${PATH}
AUTOMAKE_ENV+=	PATH=${autotools_path}:${PATH}
AUTOHEADER_ENV+=	PATH=${autotools_path}:${PATH}
AUTOTOOLS_ENV+=	PATH=${autotools_path}:${PATH}
.endif # defined(autotools_path)

########## set up automake "names"
.if defined(use_amver)
.if !defined(ampath)
ACLOCAL?=	aclocal
AUTOMAKE?=	automake
.else # defined(ampath)
ACLOCAL?=	${ampath:S/://}/aclocal
AUTOMAKE?=	${ampath:S/://}/automake
.endif # !defined(ampath)
.endif # defined(use_amver)

########## set up autoconf "names"
.if defined(use_acver)
.if !defined(acpath)
AUTOCONF?=		autoconf
AUTOHEADER?=	autoheader
AUTOIFNAMES?=	ifnames
AUTORECONF?=	autoreconf
AUTOSCAN?=		autoscan
AUTOUPDATE?=	autoupdate
.else # defined(acpath)
AUTOCONF?=		${acpath}/autoconf
AUTOHEADER?=	${acpath}/autoheader
AUTOIFNAMES?=	${acpath}/ifnames
AUTORECONF?=	${acpath}/autoreconf
AUTOSCAN?=		${acpath}/autoscan
AUTOUPDATE?=	${acpath}/autoupdate
.endif # !defined(acpath)
.endif # defined(use_acver)

########## stupid port error checking
# Set all unset vars for the programs to ${FALSE}. This way
# we can catch a certain class of port Makefile errors quickly.
ACLOCAL?=	${FALSE}
AUTOMAKE?=	${FALSE}
AUTOCONF?=	${FALSE}
AUTOHEADER?=${FALSE}
AUTOIFNAMES?=${FALSE}
AUTORECONF?=${FALSE}
AUTOSCAN?=	${FALSE}
AUTOUPDATE?=${FALSE}
ACLOCAL_DIR?=${NONEXISTENT}
AUTOMAKE_DIR?=${NONEXISTENT}
AUTOCONF_DIR?=${NONEXISTENT}

# END AUTOMAKE/AUTOCONF
######################################################################

######################################################################
# LIBTOOL

.if defined(USE_LIBTOOL_VER)
USE_LIBTOOL?=		yes
WANT_LIBTOOL_VER?=	${USE_LIBTOOL_VER}
.endif

.if defined(USE_LIBTOOL)
GNU_CONFIGURE=	yes
WANT_LIBTOOL_VER?=	13
.endif

.if defined(WANT_LIBTOOL_VER)
LIBTOOL_VERSION=	${WANT_LIBTOOL_VER:L}

.if exists(${PORTSDIR}/devel/libtool${LIBTOOL_VERSION}/Makefile)
LIBTOOL_SHAREDIR=	${LOCALBASE}/share/libtool${LIBTOOL_VERSION}
LIBTOOL_LIBEXECDIR=	${LOCALBASE}/libexec/libtool${LIBTOOL_VERSION}
BUILD_DEPENDS+=		${LIBTOOL_LIBEXECDIR}/libtool:${PORTSDIR}/devel/libtool${LIBTOOL_VERSION}
.else
BROKEN="unknown LIBTOOL version: ${USE_LIBTOOL_VER}"
.endif

.if defined(USE_AUTOCONF)
LIBTOOLFILES?=		aclocal.m4
.else
LIBTOOLFILES?=		configure
.endif

LIBTOOLFLAGS?=		--disable-ltlibs
.endif

########## prefix to path, add to env vars
.if defined(LIBTOOL_LIBEXECDIR)
MAKE_ENV+=	PATH=${LIBTOOL_LIBEXECDIR}:${PATH}
CONFIGURE_ENV+=	PATH=${LIBTOOL_LIBEXECDIR}:${PATH}
SCRIPTS_ENV+=	PATH=${LIBTOOL_LIBEXECDIR}:${PATH}
AUTOCONF_ENV+=	PATH=${LIBTOOL_LIBEXECDIR}:${PATH}
AUTOMAKE_ENV+=	PATH=${LIBTOOL_LIBEXECDIR}:${PATH}
AUTOTOOLS_ENV+=	PATH=${LIBTOOL_LIBEXECDIR}:${PATH}
.endif # defined(ltpath)

LIBTOOL?=	${LIBTOOL_LIBEXECDIR}/libtool
LIBTOOLIZE?=	${LIBTOOL_LIBEXECDIR}/libtoolize

# END LIBTOOL
######################################################################

.if defined(USE_GCC) && ${USE_GCC} == 2.95 && ( ${OSVERSION} < 400012 || ${OSVERSION} > 500034 )
CC=				gcc295
CXX=			g++295
BUILD_DEPENDS+=	gcc295:${PORTSDIR}/lang/gcc295
MAKE_ENV+=		CC=${CC} CXX=${CXX}
.endif
.if defined(USE_GCC) && ${USE_GCC} == 3.1 && ( ${OSVERSION} < 500035 || ${OSVERSION} > 500038 )
CC=				gcc31
CXX=			g++31
BUILD_DEPENDS+=	gcc31:${PORTSDIR}/lang/gcc31
MAKE_ENV+=		CC=${CC} CXX=${CXX}
.endif
.if defined(USE_GCC) && ${USE_GCC} == 3.2 && ${OSVERSION} < 500039
CC=				gcc32
CXX=			g++32
BUILD_DEPENDS+=	gcc32:${PORTSDIR}/lang/gcc32
.endif

.if defined(USE_GETOPT_LONG)
.if ${OSVERSION} < 500041
LIB_DEPENDS+=	gnugetopt.1:${PORTSDIR}/devel/libgnugetopt
CPPFLAGS+=		-I${LOCALBASE}/include
LDFLAGS+=		-L${LOCALBASE}/lib -lgnugetopt
CONFIGURE_ENV+=	CPPFLAGS="${CPPFLAGS}" LDFLAGS="${LDFLAGS}"
.endif
.endif

.if defined(USE_LINUX)
RUN_DEPENDS+=	${LINUXBASE}/etc/redhat-release:${PORTSDIR}/emulators/linux_base
.endif

.if defined(USE_SDL)
LIB_DEPENDS+=	SDL-1.1.5:${PORTSDIR}/devel/sdl12
SDL_CONFIG?=	${LOCALBASE}/bin/sdl11-config
CONFIGURE_ENV+=	SDL_CONFIG=${SDL_CONFIG}
MAKE_ENV+=		SDL_CONFIG=${SDL_CONFIG}
.endif

.if defined(USE_MOTIF)
USE_XPM=			yes
.if !defined(NO_OPENMOTIF)
LIB_DEPENDS+=		Xm.3:${PORTSDIR}/x11-toolkits/open-motif
.endif
.endif

.if defined(USE_FREETYPE)
LIB_DEPENDS+=			ttf.4:${PORTSDIR}/print/freetype
.endif

.if ${XFREE86_VERSION} == 3
.if defined(USE_IMAKE)
BUILD_DEPENDS+=			imake:${PORTSDIR}/devel/imake
.endif
.if defined(USE_XPM)
LIB_DEPENDS+=			Xpm.4:${PORTSDIR}/graphics/xpm
.endif
.if defined(USE_DGS)
LIB_DEPENDS+=			dps.0:${PORTSDIR}/x11/dgs
.endif
.if defined(USE_MESA)
LIB_DEPENDS+=			GL.14:${PORTSDIR}/graphics/Mesa3
.endif
XAWVER=					6
PKG_IGNORE_DEPENDS?=	'^XFree86-3\.'
.else
.if defined(USE_IMAKE)
BUILD_DEPENDS+=			${X11BASE}/lib/X11/config/date.def:${PORTSDIR}/devel/imake-4
RUN_DEPENDS+=			mkhtmlindex:${PORTSDIR}/devel/imake-4
.endif
.if defined(USE_XPM) || defined(USE_DGS)
USE_XLIB=				yes
.endif
.if defined(USE_MESA)
LIB_DEPENDS+=			glut.3:${PORTSDIR}/graphics/Mesa3
.endif
XAWVER=					7
PKG_IGNORE_DEPENDS?=	'this_port_does_not_exist'
.endif
PLIST_SUB+=				XAWVER=${XAWVER}

.if defined(USE_BISON)
.if ${OSVERSION} >= 400014
BUILD_DEPENDS+=	bison:${PORTSDIR}/devel/bison
.endif
.endif

.if ${OSVERSION} >= 500032
PERL_VERSION?=	5.6.1
PERL_VER?=		5.6.1
PERL_ARCH?=		mach
.else
.if ${OSVERSION} >= 500007
PERL_VERSION?=	5.6.0
PERL_VER?=		5.6.0
PERL_ARCH?=		mach
.else
.if ${OSVERSION} >= 300000
PERL_VERSION?=	5.00503
.else
PERL_VERSION?=	5.00502
.endif
PERL_VER?=		5.005
PERL_ARCH?=		${ARCH}-freebsd
.endif
.endif

.if ${PERL_LEVEL} >= 500800
PERL_PORT?=	perl5.8
.else
PERL_PORT?=	perl5
.endif

SITE_PERL?=	${LOCALBASE}/lib/perl5/site_perl/${PERL_VER}

PLIST_SUB+=		PERL_VERSION=${PERL_VERSION} \
				PERL_VER=${PERL_VER} \
				PERL_ARCH=${PERL_ARCH} \
				SITE_PERL=${SITE_PERL:S|^${LOCALBASE}/||}

.if defined(PERL_CONFIGURE)
USE_PERL5=	yes
USE_REINPLACE=yes
.endif

.if exists(/usr/bin/perl5) && ${OSVERSION} >= 300000 && ${OSVERSION} < 500036
.if !exists(/usr/bin/perl${PERL_VERSION}) && ( defined(USE_PERL5) || \
	defined(USE_PERL5_BUILD) || defined(USE_PERL5_RUN) )
pre-everything::
	@${ECHO_CMD} "Error: you don't have the right version of perl in /usr/bin."
	@${FALSE}
.endif
PERL5=			/usr/bin/perl${PERL_VERSION}
PERL=			/usr/bin/perl
.else
PERL5=			${LOCALBASE}/bin/perl${PERL_VERSION}
PERL=			${LOCALBASE}/bin/perl
.if defined(USE_PERL5) || defined(USE_PERL5_BUILD)
BUILD_DEPENDS+=	${PERL5}:${PORTSDIR}/lang/${PERL_PORT}
.endif
.if defined(USE_PERL5) || defined(USE_PERL5_RUN)
RUN_DEPENDS+=	${PERL5}:${PORTSDIR}/lang/${PERL_PORT}
.endif
.endif

.if defined(USE_XLIB)
.if ${XFREE86_VERSION} == 3
# Don't try to build XFree86-3 even if ALWAYS_BUILD_DEPENDS is defined --
# it's just too big....
.if !defined(ALWAYS_BUILD_DEPENDS)
LIB_DEPENDS+=	X11.6:${PORTSDIR}/x11/XFree86
.endif
.else
LIB_DEPENDS+=	X11.6:${PORTSDIR}/x11/XFree86-4-libraries
.endif
# Add explicit X options to avoid problems with false positives in configure
.if defined(GNU_CONFIGURE)
CONFIGURE_ARGS+=--x-libraries=${X11BASE}/lib --x-includes=${X11BASE}/include
.endif
.endif

.include "${PORTSDIR}/Mk/bsd.gnome.mk"

.if defined(USE_PYTHON)
.include "${PORTSDIR}/Mk/bsd.python.mk"
.endif

.if exists(${PORTSDIR}/../Makefile.inc)
.include "${PORTSDIR}/../Makefile.inc"
USE_SUBMAKE=	yes
.endif

# Special macro for doing in-place file editing using regexps
.if defined(USE_REINPLACE)
REINPLACE_ARGS?=	-i.bak
.if ${OSVERSION} < 460101 || ( ${OSVERSION} >= 500000 && ${OSVERSION} < 500036 )
PATCH_DEPENDS+=	${LOCALBASE}/bin/sed_inplace:${PORTSDIR}/textproc/sed_inplace
REINPLACE_CMD?=	${LOCALBASE}/bin/sed_inplace ${REINPLACE_ARGS}
.else
REINPLACE_CMD?=	${SED} ${REINPLACE_ARGS}
.endif
.endif

# Names of cookies used to skip already completed stages
EXTRACT_COOKIE?=	${WRKDIR}/.extract_done.${PKGNAME}.${PREFIX:S/\//_/g}
CONFIGURE_COOKIE?=	${WRKDIR}/.configure_done.${PKGNAME}.${PREFIX:S/\//_/g}
INSTALL_COOKIE?=	${WRKDIR}/.install_done.${PKGNAME}.${PREFIX:S/\//_/g}
BUILD_COOKIE?=		${WRKDIR}/.build_done.${PKGNAME}.${PREFIX:S/\//_/g}
PATCH_COOKIE?=		${WRKDIR}/.patch_done.${PKGNAME}.${PREFIX:S/\//_/g}
PACKAGE_COOKIE?=	${WRKDIR}/.package_done.${PKGNAME}.${PREFIX:S/\//_/g}

# How to do nothing.  Override if you, for some strange reason, would rather
# do something.
DO_NADA?=		${TRUE}

# Use this as the first operand to always build dependency.
NONEXISTENT?=	/nonexistent

# Miscellaneous overridable commands:
GMAKE?=			gmake
XMKMF?=			xmkmf -a
MKHTMLINDEX?=		${X11BASE}/bin/mkhtmlindex
.if exists(/sbin/md5)
MD5?=			/sbin/md5
.elif exists(/bin/md5)
MD5?=			/bin/md5
.elif exists(/usr/bin/md5)
MD5?=			/usr/bin/md5
.else
MD5?=			md5
.endif
MD5_FILE?=		${MASTERDIR}/distinfo

MAKE_FLAGS?=	-f
MAKEFILE?=		Makefile
MAKE_ENV+=		PREFIX=${PREFIX} LOCALBASE=${LOCALBASE} X11BASE=${X11BASE} MOTIFLIB="${MOTIFLIB}" LIBDIR="${LIBDIR}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" MANPREFIX="${MANPREFIX}"

.if ${OSVERSION} < 500016
PTHREAD_CFLAGS=	-D_THREAD_SAFE
PTHREAD_LIBS=		-pthread
.else
PTHREAD_CFLAGS=	-D_THREAD_SAFE
PTHREAD_LIBS=		-lc_r
.endif

.if exists(/usr/bin/fetch)
# avoid -A for 2.2 -- it's not ported to that branch
.if ${OSVERSION} < 300000
FETCH_CMD?=		/usr/bin/fetch
.else
FETCH_CMD?=		/usr/bin/fetch -ARr
FETCH_REGET?=	1
.endif
#FETCH_BEFORE_ARGS+=	$${CKSIZE:+-S $$CKSIZE}
.else
FETCH_CMD?=		/usr/bin/ftp
FETCH_REGET?=	0
.endif

TOUCH?=			/usr/bin/touch
TOUCH_FLAGS?=	-f

DISTORIG?=	.bak.orig
PATCH?=			/usr/bin/patch
PATCH_STRIP?=	-p0
PATCH_DIST_STRIP?=	-p0
.if defined(PATCH_DEBUG)
PATCH_DEBUG_TMP=	yes
PATCH_ARGS?=	-d ${PATCH_WRKSRC} -E ${PATCH_STRIP}
PATCH_DIST_ARGS?=	-b ${DISTORIG} -d ${PATCH_WRKSRC} -E ${PATCH_DIST_STRIP}
.else
PATCH_DEBUG_TMP=	no
PATCH_ARGS?=	-d ${PATCH_WRKSRC} --forward --quiet -E ${PATCH_STRIP}
PATCH_DIST_ARGS?=	-b ${DISTORIG} -d ${PATCH_WRKSRC} --forward --quiet -E ${PATCH_DIST_STRIP}
.endif
.if defined(BATCH)
PATCH_ARGS+=		--batch
PATCH_DIST_ARGS+=	--batch
.endif

.if defined(PATCH_CHECK_ONLY)
PATCH_ARGS+=	-C
PATCH_DIST_ARGS+=	-C
.endif

.if ${PATCH} == "/usr/bin/patch"
PATCH_ARGS+=	-b .orig
PATCH_DIST_ARGS+=	-b .orig
.endif

.if exists(/bin/tar)
TAR?=	/bin/tar
.else
TAR?=	/usr/bin/tar
.endif

# EXTRACT_SUFX is defined in .pre.mk section
.if defined(USE_ZIP)
EXTRACT_CMD?=			unzip
EXTRACT_BEFORE_ARGS?=	-qo
EXTRACT_AFTER_ARGS?=	-d ${WRKDIR}
.else
EXTRACT_BEFORE_ARGS?=	-dc
EXTRACT_AFTER_ARGS?=	| ${TAR} -xf -
.if defined(USE_BZIP2)
EXTRACT_CMD?=			${BZIP2_CMD}
.else
EXTRACT_CMD?=			${GZIP_CMD}
.endif
.endif

# Figure out where the local mtree file is
.if !defined(MTREE_FILE) && !defined(NO_MTREE)
.if defined(USE_X_PREFIX)
.if ${XFREE86_VERSION} == 3
MTREE_FILE=	/etc/mtree/BSD.x11.dist
.else
MTREE_FILE=	/etc/mtree/BSD.x11-4.dist
.endif
.else
.if ${PREFIX} == /usr
MTREE_FILE=	/etc/mtree/BSD.usr.dist
.else
MTREE_FILE=	/etc/mtree/BSD.local.dist
.endif
.endif
.endif
MTREE_CMD?=	/usr/sbin/mtree
MTREE_ARGS?=	-U ${MTREE_FOLLOWS_SYMLINKS} -f ${MTREE_FILE} -d -e -p

# Determine whether or not we can use rootly owner/group functions.
UID!=	id -u
.if ${UID} == 0
_BINOWNGRP=	-o ${BINOWN} -g ${BINGRP}
_SHROWNGRP=	-o ${SHAREOWN} -g ${SHAREGRP}
_MANOWNGRP=	-o ${MANOWN} -g ${MANGRP}
.else
_BINOWNGRP=
_SHROWNGRP=
_MANOWNGRP=
.endif

# A few aliases for *-install targets
INSTALL_PROGRAM= \
	${INSTALL} ${COPY} ${STRIP} ${_BINOWNGRP} -m ${BINMODE}
INSTALL_SCRIPT= \
	${INSTALL} ${COPY} ${_BINOWNGRP} -m ${BINMODE}
INSTALL_DATA= \
	${INSTALL} ${COPY} ${_SHROWNGRP} -m ${SHAREMODE}
INSTALL_MAN= \
	${INSTALL} ${COPY} ${_MANOWNGRP} -m ${MANMODE}

INSTALL_MACROS=	BSD_INSTALL_PROGRAM="${INSTALL_PROGRAM}" \
			BSD_INSTALL_SCRIPT="${INSTALL_SCRIPT}" \
			BSD_INSTALL_DATA="${INSTALL_DATA}" \
			BSD_INSTALL_MAN="${INSTALL_MAN}"
MAKE_ENV+=	${INSTALL_MACROS}
SCRIPTS_ENV+=	${INSTALL_MACROS}

# The user can override the NO_PACKAGE by specifying this from
# the make command line
.if defined(FORCE_PACKAGE)
.undef NO_PACKAGE
.endif

COMMENTFILE?=		${PKGDIR}/pkg-comment
DESCR?=			${PKGDIR}/pkg-descr
PLIST?=			${PKGDIR}/pkg-plist
PKGINSTALL?=	${PKGDIR}/pkg-install
PKGDEINSTALL?=	${PKGDIR}/pkg-deinstall
PKGREQ?=		${PKGDIR}/pkg-req
PKGMESSAGE?=	${PKGDIR}/pkg-message

TMPPLIST?=	${WRKDIR}/.PLIST.mktmp

.if ${OSVERSION} >= 400000
.for _CATEGORY in ${CATEGORIES}
PKGCATEGORY?=	${_CATEGORY}
.endfor
_PORTDIRNAME!=	${BASENAME} ${.CURDIR}
PORTDIRNAME?=	${_PORTDIRNAME}
PKGORIGIN?=		${PKGCATEGORY}/${PORTDIRNAME}
.endif

PKG_CMD?=		/usr/sbin/pkg_create
PKG_ADD?=	/usr/sbin/pkg_add
PKG_DELETE?=	/usr/sbin/pkg_delete
PKG_INFO?=		/usr/sbin/pkg_info

# Does the pkg_create tool support conflict checking?
PKGINSTALLVER!= ${PKG_INFO} -P 2>/dev/null | ${SED} -e 's/.*: //'
.if ${PKGINSTALLVER} < 20030417
DISABLE_CONFLICTS=     YES
.endif
.if !defined(PKG_ARGS)
PKG_ARGS=		-v -c -${COMMENT:Q} -d ${DESCR} -f ${TMPPLIST} -p ${PREFIX} -P "`${MAKE} package-depends | ${GREP} -v -E ${PKG_IGNORE_DEPENDS} | sort -u`" ${EXTRA_PKG_ARGS}
.if exists(${PKGINSTALL})
PKG_ARGS+=		-i ${PKGINSTALL}
.endif
.if exists(${PKGDEINSTALL})
PKG_ARGS+=		-k ${PKGDEINSTALL}
.endif
.if exists(${PKGREQ})
PKG_ARGS+=		-r ${PKGREQ}
.endif
.if exists(${PKGMESSAGE})
PKG_ARGS+=		-D ${PKGMESSAGE}
.endif
.if !defined(NO_MTREE)
PKG_ARGS+=		-m ${MTREE_FILE}
.endif
.if defined(PKGORIGIN)
PKG_ARGS+=		-o ${PKGORIGIN}
.endif
.if defined(CONFLICTS) && !defined(DISABLE_CONFLICTS)
PKG_ARGS+=      -C "${CONFLICTS}"
.endif
.endif
.if defined(PKG_NOCOMPRESS)
PKG_SUFX?=		.tar
.else
.if ${OSVERSION} >= 500039
PKG_SUFX?=		.tbz
.else
PKG_SUFX?=		.tgz
.endif
.endif
# where pkg_add records its dirty deeds.
PKG_DBDIR?=		/var/db/pkg

MOTIFLIB?=	-L${X11BASE}/lib -lXm -lXp

ALL_TARGET?=		all
INSTALL_TARGET?=	install

# This is a mid-term solution patch while pkg-comment files are
# phased out.
# The final simpler patch will come afterwards
.if !defined(COMMENT)
.BEGIN:
		@${ECHO_CMD} 'There is no COMMENT variable defined'
		@${ECHO_CMD} 'for this port. Please, rectify this.'
		@${FALSE}
.endif
.if exists(${COMMENTFILE})
.BEGIN:
		@${ECHO_CMD} 'There is a COMMENTFILE in this port.'
		@${ECHO_CMD} 'COMMENTFILEs have been deprecated in'
		@${ECHO_CMD} 'favor of COMMENT variables.'
		@${ECHO_CMD} 'Please, rectify this.'
		@${FALSE}
.endif

# Popular master sites
.include "bsd.sites.mk"

# Empty declaration to avoid "variable MASTER_SITES recursive" error
MASTER_SITES?=
PATCH_SITES?=
_MASTER_SITES_DEFAULT?=
_PATCH_SITES_DEFAULT?=

# Feed internal _{MASTER,PATCH}_SITES_n where n is a group designation
# as per grouping rules (:something)
# Organize _{MASTER,PATCH}_SITES_{DEFAULT,[^/:]+} according to grouping
# rules (:something)
.for _S in ${MASTER_SITES}
_S_TEMP=	${_S:S/^${_S:C@/:[^/:]+$@/@}//:S/^://}
.	if !empty(_S_TEMP)
.		for _group in ${_S_TEMP:S/,/ /g}
_G_TEMP=	${_group}
.			if ${_G_TEMP} == all || ${_G_TEMP} == ALL || ${_G_TEMP} == default
.BEGIN:
				@${ECHO_CMD} "The words all, ALL and default are reserved and cannot be"
				@${ECHO_CMD} "used in group definitions. Please fix your MASTER_SITES"
				@${FALSE}
.			endif
_MASTER_SITES_${_group}+=	${_S:C@^(.*/):[^/:]+$@\1@}
.		endfor
.	else
_MASTER_SITES_DEFAULT+=	${_S:C@^(.*/):[^/:]+$@\1@}
.	endif
.endfor
.for _S in ${PATCH_SITES}
_S_TEMP=	${_S:S/^${_S:C@/:[^/:]+$@/@}//:S/^://}
.	if !empty(_S_TEMP)
.		for _group in ${_S_TEMP:S/,/ /g}
_G_TEMP=	${_group}
.			if ${_G_TEMP} == all || ${_G_TEMP} == ALL || ${_G_TEMP} == default
.BEGIN:
				@${ECHO_CMD} "The words all, ALL and default are reserved and cannot be"
				@${ECHO_CMD} "used in group definitions. Please fix your PATCH_SITES"
				@${FALSE}
.			endif
_PATCH_SITES_${_group}+=	${_S:C@^(.*/):[^/:]+$@\1@}
.		endfor
.	else
_PATCH_SITES_DEFAULT+=	${_S:C@^(.*/):[^/:]+$@\1@}
.	endif
.endfor

# Feed internal _{MASTER,PATCH}_SITE_SUBDIR_n where n is a group designation
# as per grouping rules (:something)
# Organize _{MASTER,PATCH}_SITE_SUBDIR_{DEFAULT,[^/:]+} according to grouping
# rules (:something)
.for _S in ${MASTER_SITE_SUBDIR}
_S_TEMP=	${_S:S/^${_S:C@/:[^/:]+$@/@}//:S/^://}
.	if !empty(_S_TEMP)
.		for _group in ${_S_TEMP:S/,/ /g}
_G_TEMP=	${_group}
.			if ${_G_TEMP} == all || ${_G_TEMP} == ALL || ${_G_TEMP} == default
.BEGIN:
				@${ECHO_CMD} "The words all, ALL and default are reserved and cannot be"
				@${ECHO_CMD} "used in group definitions. Please fix your MASTER_SITE_SUBDIR"
				@${FALSE}
.			endif
.			if defined(_MASTER_SITES_${_group})
_MASTER_SITE_SUBDIR_${_group}+= ${_S:C@^(.*)/:[^/:]+$@\1@}
.			endif
.		endfor
.	else
.		if defined(_MASTER_SITES_DEFAULT)
_MASTER_SITE_SUBDIR_DEFAULT+=	${_S:C@^(.*)/:[^/:]+$@\1@}
.		endif
.	endif
.endfor
.for _S in ${PATCH_SITE_SUBDIR}
_S_TEMP=	${_S:S/^${_S:C@/:[^/:]+$@/@}//:S/^://}
.	if !empty(_S_TEMP)
.		for _group in ${_S_TEMP:S/,/ /g}
_G_TEMP=	${_group}
.			if ${_G_TEMP} == all || ${_G_TEMP} == ALL || ${_G_TEMP} == default
.BEGIN:
				@${ECHO_CMD} "The words all, ALL and default are reserved and cannot be"
				@${ECHO_CMD} "used in group definitions. Please fix your PATCH_SITE_SUBDIR"
				@${FALSE}
.			endif
.			if defined(_PATCH_SITES_${_group})
_PATCH_SITE_SUBDIR_${_group}+= ${_S:C@^(.*)/:[^/:]+$@\1@}
.			endif
.		endfor
.	else
.		if defined(_PATCH_SITES_DEFAULT)
_PATCH_SITE_SUBDIR_DEFAULT+=	${_S:C@^(.*)/:[^/:]+$@\1@}
.		endif
.	endif
.endfor

# Substitute subdirectory names
# XXX simpler/faster solution but not the best space wise, suggestions please
.for _S in ${MASTER_SITES}
_S_TEMP=	${_S:S/^${_S:C@/:[^/:]+$@/@}//:S/^://}
.	if !empty(_S_TEMP)
.		for _group in ${_S_TEMP:S/,/ /g}
.			if !defined(_MASTER_SITE_SUBDIR_${_group})
MASTER_SITES_TMP=	${_MASTER_SITES_${_group}:S^%SUBDIR%/^^}
.			else
_S_TEMP_TEMP=		${_MASTER_SITES_${_group}:M*%SUBDIR%/*}
.				if empty(_S_TEMP_TEMP)
MASTER_SITES_TMP=	${_MASTER_SITES_${_group}}
.				else
MASTER_SITES_TMP=
.					for site in ${_MASTER_SITES_${_group}}
_S_TEMP_TEMP=	${site:M*%SUBDIR%/*}
.						if empty(_S_TEMP_TEMP)
MASTER_SITES_TMP+=	${site}
.						else
.							for dir in ${_MASTER_SITE_SUBDIR_${_group}}
MASTER_SITES_TMP+=	${site:S^%SUBDIR%^\${dir}^}
.							endfor
.						endif
.					endfor
.				endif
.			endif
_MASTER_SITES_${_group}:=	${MASTER_SITES_TMP}
.		endfor
.	endif
.endfor
.if defined(_MASTER_SITE_SUBDIR_DEFAULT)
_S_TEMP=	${_MASTER_SITES_DEFAULT:M*%SUBDIR%/*}
.	if empty(_S_TEMP)
MASTER_SITES_TMP=	${_MASTER_SITES_DEFAULT}
.	else
MASTER_SITES_TMP=
.		for site in ${_MASTER_SITES_DEFAULT}
_S_TEMP_TEMP=		${site:M*%SUBDIR%/*}
.			if empty(_S_TEMP_TEMP)
MASTER_SITES_TMP+=	${site}
.			else
.				for dir in ${_MASTER_SITE_SUBDIR_DEFAULT}
MASTER_SITES_TMP+=	${site:S^%SUBDIR%^\${dir}^}
.				endfor
.			endif
.		endfor
.	endif
.else
MASTER_SITES_TMP=	${_MASTER_SITES_DEFAULT:S^%SUBDIR%/^^}
.endif
_MASTER_SITES_DEFAULT:=	${MASTER_SITES_TMP}
MASTER_SITES_TMP=
.for _S in ${PATCH_SITES}
_S_TEMP=	${_S:S/^${_S:C@/:[^/:]+$@/@}//:S/^://}
.	if !empty(_S_TEMP)
.		for _group in ${_S_TEMP:S/,/ /g}
.			if !defined(_PATCH_SITE_SUBDIR_${_group})
PATCH_SITES_TMP=	${_PATCH_SITES_${_group}:S^%SUBDIR%/^^}
.			else
_S_TEMP_TEMP=		${_PATCH_SITES_${_group}:M*%SUBDIR%/*}
.				if empty(_S_TEMP_TEMP)
PATCH_SITES_TMP=	${_PATCH_SITES_${_group}}
.				else
PATCH_SITES_TMP=
.					for site in ${_PATCH_SITES_${_group}}
_S_TEMP_TEMP=	${site:M*%SUBDIR%/*}
.						if empty(_S_TEMP_TEMP)
PATCH_SITES_TMP+=	${site}
.						else
.							for dir in ${_PATCH_SITE_SUBDIR_${_group}}
PATCH_SITES_TMP+=	${site:S^%SUBDIR%^\${dir}^}
.							endfor
.						endif
.					endfor
.				endif
.			endif
_PATCH_SITES_${_group}:=	${PATCH_SITES_TMP}
.		endfor
.	endif
.endfor
.if defined(_PATCH_SITE_SUBDIR_DEFAULT)
_S_TEMP=	${_PATCH_SITES_DEFAULT:M*%SUBDIR%/*}
.	if empty(_S_TEMP)
PATCH_SITES_TMP=	${_PATCH_SITES_DEFAULT}
.	else
PATCH_SITES_TMP=
.		for site in ${_PATCH_SITES_DEFAULT}
_S_TEMP_TEMP=		${site:M*%SUBDIR%/*}
.			if empty(_S_TEMP_TEMP)
PATCH_SITES_TMP+=	${site}
.			else
.				for dir in ${_PATCH_SITE_SUBDIR_DEFAULT}
PATCH_SITES_TMP+=	${site:S^%SUBDIR%^\${dir}^}
.				endfor
.			endif
.		endfor
.	endif
.else
PATCH_SITES_TMP=	${_PATCH_SITES_DEFAULT:S^%SUBDIR%/^^}
.endif
_PATCH_SITES_DEFAULT:=	${PATCH_SITES_TMP}
PATCH_SITES_TMP=

# The primary backup site.
MASTER_SITE_BACKUP?=	\
	ftp://ftp.FreeBSD.org/pub/FreeBSD/ports/distfiles/${DIST_SUBDIR}/
MASTER_SITE_BACKUP:=	${MASTER_SITE_BACKUP:S^\${DIST_SUBDIR}/^^}

# If the user has MASTER_SITE_FREEBSD set, go to the FreeBSD repository
# for everything, but don't search it twice by appending it to the end.
.if defined(MASTER_SITE_FREEBSD)
_MASTER_SITE_OVERRIDE:=	${MASTER_SITE_BACKUP}
_MASTER_SITE_BACKUP:=	# empty
.else
_MASTER_SITE_OVERRIDE=	${MASTER_SITE_OVERRIDE}
_MASTER_SITE_BACKUP=	${MASTER_SITE_BACKUP}
.endif

# Search CDROM first if mounted, symlink instead of copy if
# FETCH_SYMLINK_DISTFILES is set
.for MOUNTPT in ${CD_MOUNTPTS}
.if exists(${MOUNTPT}/ports/distfiles)
_MASTER_SITE_OVERRIDE:=	file:${MOUNTPT}/ports/distfiles/${DIST_SUBDIR}/ ${_MASTER_SITE_OVERRIDE}
.if defined(FETCH_SYMLINK_DISTFILES)
FETCH_BEFORE_ARGS+=	-l
.endif
.endif
.endfor

# Organize DISTFILES, PATCHFILES, _MASTER_SITES_ALL, _PATCH_SITES_ALL
# according to grouping rules (:something)
DISTFILES?=		${DISTNAME}${EXTRACT_SUFX}
_MASTER_SITES_ALL=	${_MASTER_SITES_DEFAULT}
_PATCH_SITES_ALL=	${_PATCH_SITES_DEFAULT}
_G_TEMP=	DEFAULT
.for _D in ${DISTFILES}
_D_TEMP=	${_D:S/^${_D:C/:[^:]+$//}//}
.	if !empty(_D_TEMP)
.		for _group in ${_D_TEMP:S/^://:S/,/ /g}
.			if !defined(_MASTER_SITES_${_group})
_G_TEMP_TEMP=	${_G_TEMP:M/${_group}/}
.				if empty(_G_TEMP_TEMP)
_G_TEMP+=	${_group}
_MASTER_SITES_ALL+=	${_MASTER_SITES_${_group}}
.				endif
.			endif
.		endfor
_DISTFILES+=	${_D:C/:[^:]+$//}
.	else
_DISTFILES+=	${_D}
.	endif
.endfor
_G_TEMP=	DEFAULT
.for _P in ${PATCHFILES}
_P_TEMP=	${_P:S/^${_P:C/:[^:]+$//}//}
.	if !empty(_P_TEMP)
.		for _group in ${_P_TEMP:S/^://:S/,/ /g}
.			if !defined(_PATCH_SITES_${_group})
_G_TEMP_TEMP=	${_G_TEMP:M/${_group}/}
.				if empty(_G_TEMP_TEMP)
_G_TEMP+=	${_group}
_PATCH_SITES_ALL+=	${_PATCH_SITES_${_group}}
.				endif
.			endif
.		endfor
_PATCHFILES+=	${_P:C/:[^:]+$//}
.	else
_PATCHFILES+=	${_P}
.	endif
.endfor
_G_TEMP=
_G_TEMP_TEMP=
ALLFILES?=	${_DISTFILES} ${_PATCHFILES}

#
# Sort the master site list according to the patterns in MASTER_SORT
#
MASTER_SORT?=
MASTER_SORT_REGEX?=
MASTER_SORT_REGEX+=	${MASTER_SORT:S|.|\\.|g:S|^|://[^/]*|:S|$|/|}

MASTER_SORT_AWK=	BEGIN { RS = " "; ORS = " "; IGNORECASE = 1 ; gl = "${MASTER_SORT_REGEX:S|\\|\\\\|g}"; }
.for srt in ${MASTER_SORT_REGEX}
MASTER_SORT_AWK+=	/${srt:S|/|\\/|g}/ { good["${srt:S|\\|\\\\|g}"] = good["${srt:S|\\|\\\\|g}"] " " $$0 ; next; }
.endfor
MASTER_SORT_AWK+=	{ rest = rest " " $$0; } END { n=split(gl, gla); for(i=1;i<=n;i++) { print good[gla[i]]; } print rest; }

SORTED_MASTER_SITES_DEFAULT_CMD=	cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} master-sites-DEFAULT
SORTED_PATCH_SITES_DEFAULT_CMD=		cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} patch-sites-DEFAULT
SORTED_MASTER_SITES_ALL_CMD=	cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} master-sites-ALL
SORTED_PATCH_SITES_ALL_CMD=	cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} patch-sites-ALL

#
# Sort the master site list according to the patterns in MASTER_SORT
# according to grouping rules (:something)
#
# for use in the fetch targets
.for _S in ${MASTER_SITES}
_S_TEMP=	${_S:S/^${_S:C@/:[^/:]+$@/@}//}
.	if !empty(_S_TEMP)
.		for _group in ${_S_TEMP:S/^://:S/,/ /g}
.			if !target(master-sites-${_group})
SORTED_MASTER_SITES_${_group}_CMD=	cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} master-sites-${_group}
master-sites-${_group}:
	@echo ${_MASTER_SITE_OVERRIDE} `echo '${_MASTER_SITES_${_group}}' | ${AWK} '${MASTER_SORT_AWK:S|\\|\\\\|g}'` ${_MASTER_SITE_BACKUP}
.			endif
.		endfor
.	endif
.endfor
.for _S in ${PATCH_SITES}
_S_TEMP=	${_S:S/^${_S:C@/:[^/:]+$@/@}//}
.	if !empty(_S_TEMP)
.		for _group in ${_S_TEMP:S/^://:S/,/ /g}
.			if !target(patch-sites-${_group})
SORTED_PATCH_SITES_${_group}_CMD=	cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} patch-sites-${_group}
patch-sites-${_group}:
	@echo ${_MASTER_SITE_OVERRIDE} `echo '${_PATCH_SITES_${_group}}' | ${AWK} '${MASTER_SORT_AWK:S|\\|\\\\|g}'` ${_MASTER_SITE_BACKUP}
.			endif
.		endfor
.	endif
.endfor

#
# Hackery to enable simple fetch targets with several dynamic MASTER_SITES
#
_MASTER_SITES_ENV=	_MASTER_SITES_DEFAULT="${_MASTER_SITES_DEFAULT}"
.for _F in ${DISTFILES}
_F_TEMP=	${_F:S/^${_F:C/:[^:]+$//}//:S/^://}
.	if !empty(_F_TEMP)
.		for _group in ${_F_TEMP:S/,/ /g}
.			if defined(_MASTER_SITES_${_group})
_MASTER_SITES_ENV+=	_MASTER_SITES_${_group}="${_MASTER_SITES_${_group}}"
.			endif
.		endfor
.	endif
.endfor
_PATCH_SITES_ENV=	_PATCH_SITES_DEFAULT="${_PATCH_SITES_DEFAULT}"
.for _F in ${PATCHFILES}
_F_TEMP=	${_F:S/^${_F:C/:[^:]+$//}//:S/^://}
.	if !empty(_F_TEMP)
.		for _group in ${_F_TEMP:S/,/ /g}
.			if defined(_PATCH_SITES_${_group})
_PATCH_SITES_ENV+=	_PATCH_SITES_${_group}="${_PATCH_SITES_${_group}}"
.			endif
.		endfor
.	endif
.endfor

master-sites-ALL:
	@echo ${_MASTER_SITE_OVERRIDE} `echo '${_MASTER_SITES_ALL}' | ${AWK} '${MASTER_SORT_AWK:S|\\|\\\\|g}'` ${_MASTER_SITE_BACKUP}
patch-sites-ALL:
	@echo ${_MASTER_SITE_OVERRIDE} `echo '${_PATCH_SITES_ALL}' | ${AWK} '${MASTER_SORT_AWK:S|\\|\\\\|g}'` ${_MASTER_SITE_BACKUP}
# has similar effect to old targets, i.e., access only {MASTER,PATCH}_SITES, not working with the new _n variables
master-sites-DEFAULT:
	@echo ${_MASTER_SITE_OVERRIDE} `echo '${_MASTER_SITES_DEFAULT}' | ${AWK} '${MASTER_SORT_AWK:S|\\|\\\\|g}'` ${_MASTER_SITE_BACKUP}
patch-sites-DEFAULT:
	@echo ${_MASTER_SITE_OVERRIDE} `echo '${_PATCH_SITES_DEFAULT}' | ${AWK} '${MASTER_SORT_AWK:S|\\|\\\\|g}'` ${_MASTER_SITE_BACKUP}

# synonyms, mnemonics
master-sites-all: master-sites-ALL
patch-sites-all: patch-sites-ALL
master-sites-default: master-sites-DEFAULT
patch-sites-default: patch-sites-DEFAULT

# compatibility with old behavior
master-sites: master-sites-DEFAULT
patch-sites: patch-sites-DEFAULT

.if defined(IGNOREFILES)
.if !defined(CKSUMFILES)
CKSUMFILES!=	\
	for file in ${ALLFILES}; do \
		ignore=0; \
		for tmp in ${IGNOREFILES}; do \
			if [ "$$file" = "$$tmp" ]; then \
				ignore=1; \
			fi; \
		done; \
		if [ "$$ignore" = 0 ]; then \
			echo "$$file"; \
		fi; \
	done
.endif
.else
CKSUMFILES=		${ALLFILES}
.endif

# List of all files, with ${DIST_SUBDIR} in front.  Used for checksum.
.if defined(DIST_SUBDIR)
_CKSUMFILES?=	${CKSUMFILES:S/^/${DIST_SUBDIR}\//}
_IGNOREFILES?=	${IGNOREFILES:S/^/${DIST_SUBDIR}\//}
.else
_CKSUMFILES?=	${CKSUMFILES}
_IGNOREFILES?=	${IGNOREFILES}
.endif

# This is what is actually going to be extracted, and is overridable
#  by user.
EXTRACT_ONLY?=	${_DISTFILES}

# Documentation
MAINTAINER?=	ports@FreeBSD.org

.if !target(maintainer)
maintainer:
	@${ECHO_CMD} "${MAINTAINER}"
.endif

.if !defined(CATEGORIES)
.BEGIN:
	@${ECHO_CMD} "${PKGNAME}: CATEGORIES is mandatory."
	@${FALSE}
.else

VALID_CATEGORIES+= accessibility afterstep archivers astro audio \
	benchmarks biology cad chinese comms converters databases \
	deskutils devel editors elisp emulators finance french ftp \
	games german gnome graphics haskell hebrew hungarian \
	ipv6 irc japanese java kde korean lang linux \
	mail math mbone misc multimedia net news \
	offix palm parallel perl5 picobsd plan9 portuguese print python \
	ruby russian \
	scheme science security shells sysutils \
	tcl76 tcl80 tcl81 tcl82 tcl83 tcl84 textproc \
	tk42 tk80 tk82 tk83 tk84 tkstep80 \
	ukrainian vietnamese windowmaker www \
	x11 x11-clocks x11-fm x11-fonts x11-servers x11-toolkits x11-wm zope

check-categories:
.for cat in ${CATEGORIES}
	@if ${ECHO_CMD} ${VALID_CATEGORIES} | ${GREP} -wq ${cat}; then \
		${TRUE}; \
	else \
		${ECHO_CMD} "${PKGNAME}: category ${cat} not in list of valid categories."; \
		${FALSE}; \
	fi
.endfor
.endif

PKGREPOSITORYSUBDIR?=	All
PKGREPOSITORY?=		${PACKAGES}/${PKGREPOSITORYSUBDIR}
.if exists(${PACKAGES})
PKGFILE?=		${PKGREPOSITORY}/${PKGNAME}${PKG_SUFX}
.else
PKGFILE?=		${.CURDIR}/${PKGNAME}${PKG_SUFX}
.endif

# The "latest version" link -- ${PKGNAME} minus everthing after the last '-'
PKGLATESTREPOSITORY?=	${PACKAGES}/Latest
PKGBASE?=			${PKGNAMEPREFIX}${PORTNAME}${PKGNAMESUFFIX}
LATEST_LINK?=		${PKGBASE}
PKGLATESTFILE=		${PKGLATESTREPOSITORY}/${LATEST_LINK}${PKG_SUFX}

.if defined(PERL_CONFIGURE)
CONFIGURE_ARGS+=	CC="${CC}" CCFLAGS="${CFLAGS}" PREFIX="${PREFIX}" \
			INSTALLPRIVLIB="${PREFIX}/lib" INSTALLARCHLIB="${PREFIX}/lib"
CONFIGURE_SCRIPT?=	Makefile.PL
MAN3PREFIX?=		${PREFIX}/lib/perl5/${PERL_VERSION}
.undef HAS_CONFIGURE
.endif

CONFIGURE_SCRIPT?=	configure
CONFIGURE_TARGET?=	${MACHINE_ARCH}-portbld-freebsd${OSREL}
CONFIGURE_LOG?=		config.log

.if defined(GNU_CONFIGURE)
CONFIGURE_ARGS+=	--prefix=${PREFIX} ${CONFIGURE_TARGET}
HAS_CONFIGURE=		yes
.endif

# Passed to most of script invocations
SCRIPTS_ENV+=	CURDIR=${MASTERDIR} DISTDIR=${DISTDIR} \
		  WRKDIR=${WRKDIR} WRKSRC=${WRKSRC} PATCHDIR=${PATCHDIR} \
		  SCRIPTDIR=${SCRIPTDIR} FILESDIR=${FILESDIR} \
		  PORTSDIR=${PORTSDIR} DEPENDS="${DEPENDS}" \
		  PREFIX=${PREFIX} LOCALBASE=${LOCALBASE} X11BASE=${X11BASE}

.if defined(BATCH)
SCRIPTS_ENV+=	BATCH=yes
.endif

.if ${PREFIX} == /usr
MANPREFIX?=	/usr/share
.else
MANPREFIX?=	${PREFIX}
.endif

.for sect in 1 2 3 4 5 6 7 8 9
MAN${sect}PREFIX?=	${MANPREFIX}
.endfor
MANLPREFIX?=	${MANPREFIX}
MANNPREFIX?=	${MANPREFIX}

MANLANG?=	""	# english only by default

.if !defined(NOMANCOMPRESS)
MANEXT=	.gz
.endif

.if (defined(MLINKS) || defined(_MLINKS_PREPEND)) && !defined(_MLINKS)
__pmlinks!=	${ECHO_CMD} '${MLINKS:S/	/ /}' | ${AWK} \
 '{ if (NF % 2 != 0) { print "broken"; exit; } \
	for (i=1; i<=NF; i++) { \
		if ($$i ~ /^-$$/ && i != 1 && i % 2 != 0) \
			{ $$i = $$(i-2); printf " " $$i " "; } \
		else if ($$i ~ /^[^ ]+\.[1-9ln][^. ]*$$/ || $$i ~ /^\//) \
			printf " " $$i " "; \
		else \
			{ print "broken"; exit; } \
	} \
  }' | ${SED} -e 's \([^/ ][^ ]*\.\(.\)[^. ]*\) $${MAN\2PREFIX}/man/$$$$$$$${__lang}/man\2/\1${MANEXT}g' -e 's/ //g' -e 's/MANlPREFIX/MANLPREFIX/g' -e 's/MANnPREFIX/MANNPREFIX/g'
.if ${__pmlinks:Mbroken} == "broken"
.BEGIN:
	@${ECHO_CMD} "${PKGNAME}: Unable to parse MLINKS."
	@${FALSE}
.endif
_MLINKS=	${_MLINKS_PREPEND}
.for lang in ${MANLANG}
.for ___pmlinks in ${__pmlinks}
.for __lang in ${lang}
_MLINKS+=	${___pmlinks:S// /g}
.endfor
.endfor
.endfor
.endif
_COUNT=0
.for ___tpmlinks in ${_MLINKS}
.if ${_COUNT} == "1"
_TMLINKS+=	${___tpmlinks}
_COUNT=0
.else
_COUNT=1
.endif
.endfor

.for lang in ${MANLANG}

.for sect in 1 2 3 4 5 6 7 8 9
.if defined(MAN${sect})
_MANPAGES+=	${MAN${sect}:S%^%${MAN${sect}PREFIX}/man/${lang}/man${sect}/%}
.endif
.endfor

.if defined(MANL)
_MANPAGES+=	${MANL:S%^%${MANLPREFIX}/man/${lang}/manl/%}
.endif

.if defined(MANN)
_MANPAGES+=	${MANN:S%^%${MANNPREFIX}/man/${lang}/mann/%}
.endif

.endfor

.if !defined(_MLINKS)
_TMLINKS=
.endif

.if defined(_MANPAGES) && defined(NOMANCOMPRESS)
__MANPAGES:=	${_MANPAGES:S^${PREFIX}/^^:S/""//:S^//^/^g}
.elif defined(_MANPAGES)
__MANPAGES:=	${_MANPAGES:S^${PREFIX}/^^:S/""//:S^//^/^g:S/$/.gz/}
.endif

.if defined(_MANPAGES) && ${MANCOMPRESSED} == "yes"
_MANPAGES:=	${_MANPAGES:S/$/.gz/}
.endif

.if ${XFREE86_VERSION} == 3
XFREE86_HTML_MAN=	no
.else
.if defined(USE_IMAKE)
XFREE86_HTML_MAN?=	yes
.else
XFREE86_HTML_MAN?=	no
.endif
.endif

DOCSDIR?=	${PREFIX}/share/doc/${PORTNAME}
EXAMPLESDIR?=	${PREFIX}/share/examples/${PORTNAME}
DATADIR?=	${PREFIX}/share/${PORTNAME}

PLIST_SUB+=	DOCSDIR="${DOCSDIR:S,^${PREFIX}/,,}" \
		EXAMPLESDIR="${EXAMPLESDIR:S,^${PREFIX}/,,}" \
		DATADIR="${DATADIR:S,^${PREFIX}/,,}"

# Put this as far down as possible so it will catch all PLIST_SUB definitions.

.if defined(INSTALLS_SHLIB)
LDCONFIG_DIRS?=	%%PREFIX%%/lib
LDCONFIG_PLIST!=	${ECHO_CMD} ${LDCONFIG_DIRS} | ${SED} ${PLIST_SUB:S/$/!g/:S/^/ -e s!%%/:S/=/%%!/}
LDCONFIG_RUNLIST!=	${ECHO_CMD} ${LDCONFIG_PLIST} | ${SED} -e "s!%D!${PREFIX}!g"
.endif

.MAIN: all

################################################################
# Many ways to disable a port.
#
# If we're in BATCH mode and the port is interactive, or we're
# in interactive mode and the port is non-interactive, skip all
# the important targets.  The reason we have two modes is that
# one might want to leave a build in BATCH mode running
# overnight, then come back in the morning and do _only_ the
# interactive ones that required your intervention.
#
# Ignore ports that can't be resold if building for a CDROM.
#
# Don't build a port if it's restricted and we don't want to get
# into that.
#
# Don't build a port on an ELF machine if it's broken for ELF.
#
# Don't build a port if it's broken, unless we're running a parallel
# build (in case it's fixed).
#
# Don't build a port if it's forbidden for whatever reason.
#
# Don't build a port if the system is too old.
################################################################

.if ${OSVERSION} >= 300000
# You need an upgrade kit or make world newer than this
BSDPORTMKVERSION=	20001103
.if exists(/var/db/port.mkversion)
VERSIONFILE=	/var/db/port.mkversion
.else
VERSIONFILE=	${PKG_DBDIR}/.mkversion
.endif
.if exists(${VERSIONFILE})
.if !defined(SYSTEMVERSION)
SYSTEMVERSION!=	${CAT} ${VERSIONFILE}
.endif
.else
SYSTEMVERSION=	0
.endif
.if ${BSDPORTMKVERSION} > ${SYSTEMVERSION}
IGNORE=	": Your system is too old to use this bsd.port.mk.  You need a fresh make world or an upgrade kit.  Please go to http://www.FreeBSD.org/ports/ or a mirror site and follow the instructions"
.endif
.endif

.if defined(ONLY_FOR_ARCHS)
.for __ARCH in ${ONLY_FOR_ARCHS}
.if ${MACHINE_ARCH:M${__ARCH}} != ""
__ARCH_OK?=     1
.endif
.endfor
.else
__ARCH_OK?=     1
.endif

.if defined(NOT_FOR_ARCHS)
.for __NARCH in ${NOT_FOR_ARCHS}
.if ${MACHINE_ARCH:M${__NARCH}} != ""
.undef __ARCH_OK
.endif
.endfor
.endif

.if !defined(__ARCH_OK)
.if defined(ONLY_FOR_ARCHS)
IGNORE=		"is only for ${ONLY_FOR_ARCHS},"
.else # defined(NOT_FOR_ARCHS)
IGNORE=		"does not run on ${NOT_FOR_ARCHS},"
.endif
IGNORE+=	"and you are running ${ARCH}"
.endif

.if !defined(NO_IGNORE)
.if (defined(IS_INTERACTIVE) && defined(BATCH))
IGNORE=	"is an interactive port"
.elif (!defined(IS_INTERACTIVE) && defined(INTERACTIVE))
IGNORE=	"is not an interactive port"
.elif (defined(NO_CDROM) && defined(FOR_CDROM))
IGNORE=	"may not be placed on a CDROM: ${NO_CDROM}"
.elif (defined(RESTRICTED) && defined(NO_RESTRICTED))
IGNORE=	"is restricted: ${RESTRICTED}"
.elif defined(NO_WRKDIR)
IGNORE=	"defines NO_WRKDIR, which is obsoleted.  If you are defining NO_WRKDIR and NO_EXTRACT, try changing it to NO_WRKSUBDIR=yes and EXTRACT_ONLY= \(the right side intentionally left empty\)"
.elif defined(NO_EXTRACT)
IGNORE=	"defines NO_EXTRACT, which is obsoleted.  Try changing it to EXTRACT_ONLY= \(the right side intentionally left empty\)"
.elif defined(NO_CONFIGURE)
IGNORE=	"defines NO_CONFIGURE, which is obsoleted"
.elif defined(NO_PATCH)
IGNORE=	"defines NO_PATCH, which is obsoleted"
.elif defined(BROKEN_ELF) && (${PORTOBJFORMAT} == "elf") && \
	  !defined(PARALLEL_PACKAGE_BUILD)
IGNORE=	"is broken for ELF: ${BROKEN_ELF}"
.elif defined(BROKEN)
.if defined(PARALLEL_PACKAGE_BUILD)
# try building even if marked BROKEN
TRYBROKEN=	yes
.else
IGNORE=	"is marked as broken: ${BROKEN}"
.endif
.elif defined(FORBIDDEN)
IGNORE=	"is forbidden: ${FORBIDDEN}"
.endif

.if (defined(MANUAL_PACKAGE_BUILD) && defined(PACKAGE_BUILDING) && !defined(PARALLEL_PACKAGE_BUILD))
IGNORE=	"has to be built manually: ${MANUAL_PACKAGE_BUILD}"
clean:
	@${IGNORECMD}
.endif

.if defined(IGNORE)
.if defined(IGNORE_SILENT)
IGNORECMD=	${DO_NADA}
.else
IGNORECMD=	${ECHO_MSG} "===>  ${PKGNAME} ${IGNORE}."
.endif

.for target in fetch checksum extract patch configure all build install reinstall package
${target}:
	@${IGNORECMD}
.if defined(INSTALLS_DEPENDS)
	@${FALSE}
.endif
.endfor

.endif

.endif

.if defined(IGNORE) || defined(NO_PACKAGE)
ignorelist: package-name
.else
ignorelist:
	@${DO_NADA}
.endif

################################################################
# Clean directories for ftp or CDROM.
################################################################

.if defined(RESTRICTED)
clean-restricted:	delete-distfiles delete-package
clean-restricted-list: delete-distfiles-list delete-package-list
RESTRICTED_FILES?=	${_DISTFILES} ${_PATCHFILES}
.else
clean-restricted:
clean-restricted-list:
.endif

.if defined(NO_CDROM)
clean-for-cdrom:	delete-distfiles delete-package
clean-for-cdrom-list:	delete-distfiles-list delete-package-list
RESTRICTED_FILES?=	${_DISTFILES} ${_PATCHFILES}
.else
clean-for-cdrom:
clean-for-cdrom-list:
.endif

.if defined(ALL_HOOK)
all:
	@cd ${.CURDIR} && ${SETENV} CURDIR=${.CURDIR} DISTNAME=${DISTNAME} \
	  DISTDIR=${DISTDIR} WRKDIR=${WRKDIR} WRKSRC=${WRKSRC} \
	  PATCHDIR=${PATCHDIR} SCRIPTDIR=${SCRIPTDIR} \
	  FILESDIR=${FILESDIR} PORTSDIR=${PORTSDIR} PREFIX=${PREFIX} \
	  DEPENDS="${DEPENDS}" BUILD_DEPENDS="${BUILD_DEPENDS}" \
	  RUN_DEPENDS="${RUN_DEPENDS}" X11BASE=${X11BASE} \
	  CONFLICTS="${CONFLICTS}" \
	${ALL_HOOK}
.endif

.if !target(all)
all: build
.endif

.if !defined(DEPENDS_TARGET)
.if make(reinstall)
DEPENDS_TARGET=	reinstall
.else
DEPENDS_TARGET=	install
.endif
.if defined(DEPENDS_CLEAN)
DEPENDS_TARGET+=	clean
DEPENDS_ARGS+=	NOCLEANDEPENDS=yes
.endif
.else
DEPENDS_ARGS+=	FORCE_PKG_REGISTER=yes
.endif
.if defined(DEPENDS)
# pretty much guarantees overwrite of existing installation
.MAKEFLAGS:	FORCE_PKG_REGISTER=yes
.endif

################################################################
# The following are used to create easy dummy targets for
# disabling some bit of default target behavior you don't want.
# They still check to see if the target exists, and if so don't
# do anything, since you might want to set this globally for a
# group of ports in a Makefile.inc, but still be able to
# override from an individual Makefile.
################################################################

# Disable checksum
.if defined(NO_CHECKSUM) && !target(checksum)
checksum: fetch
	@${DO_NADA}
.endif

# Disable build
.if defined(NO_BUILD) && !target(build)
build: configure
	@${TOUCH} ${TOUCH_FLAGS} ${BUILD_COOKIE}
.endif

# Disable install
.if defined(NO_INSTALL) && !target(install)
install: build
	@${TOUCH} ${TOUCH_FLAGS} ${INSTALL_COOKIE}
.endif

# Disable package
.if defined(NO_PACKAGE) && !target(package)
package:
.if defined(IGNORE_SILENT)
	@${DO_NADA}
.else
	@${ECHO_MSG} "===>  ${PKGNAME} may not be packaged: ${NO_PACKAGE}."
.endif
.endif

# Disable describe
.if defined(NO_DESCRIBE) && !target(describe)
describe:
	@${DO_NADA}
.endif

################################################################
# More standard targets start here.
#
# These are the body of the build/install framework.  If you are
# not happy with the default actions, and you can't solve it by
# adding pre-* or post-* targets/scripts, override these.
################################################################

# Pre-everything

.if !target(pre-everything)
pre-everything:
.if defined(TRYBROKEN)
	@${ECHO_MSG} "Trying build of ${PKGNAME} even though it is marked BROKEN."
.else
	@${DO_NADA}
.endif
.if defined(GNOME_OPTION_MSG) && (!defined(PACKAGE_BUILDING) || !defined(BATCH))
	@for m in ${GNOME_OPTION_MSG}; do \
		${ECHO_MSG} $$m; \
	done
.else
	@${DO_NADA}
.endif
.endif

# Fetch

.if !target(do-fetch)
do-fetch:
	@${MKDIR} ${_DISTDIR}
	@(cd ${_DISTDIR}; \
	 ${_MASTER_SITES_ENV} ; \
	 for _file in ${DISTFILES}; do \
		file=`echo $$_file | ${SED} -E -e 's/:[^:]+$$//'` ; \
		select=`echo $${_file#$${file}} | ${SED} -e 's/^://' -e 's/,/ /g'` ; \
		force_fetch=false; \
		filebasename=`${BASENAME} $$file`; \
		for afile in ${FORCE_FETCH}; do \
			afile=`${BASENAME} $$afile`; \
			if [ "x$$afile" = "x$$filebasename" ]; then \
				force_fetch=true; \
			fi; \
		done; \
		if [ ! -f $$file -a ! -f $$filebasename -o "$$force_fetch" = "true" ]; then \
			if [ -L $$file -o -L $$filebasename ]; then \
				${ECHO_MSG} ">> ${_DISTDIR}/$$file is a broken symlink."; \
				${ECHO_MSG} ">> Perhaps a filesystem (most likely a CD) isn't mounted?"; \
				${ECHO_MSG} ">> Please correct this problem and try again."; \
				exit 1; \
			fi ; \
			if [ -f ${MD5_FILE} -a "x${NO_CHECKSUM}" = "x" ]; then \
				if ! ${GREP} -q "^MD5 (.*$$file)" ${MD5_FILE}; then \
					${ECHO_MSG} ">> $$file is not in ${MD5_FILE}."; \
					${ECHO_MSG} ">> Either ${MD5_FILE} is out of date, or"; \
					${ECHO_MSG} ">> $$file is spelled incorrectly."; \
					exit 1; \
				fi; \
			fi; \
			${ECHO_MSG} ">> $$file doesn't seem to exist in ${_DISTDIR}."; \
			if [ ! -w ${DISTDIR} ]; then \
			   ${ECHO_MSG} ">> ${DISTDIR} is not writable by you; cannot fetch."; \
			   exit 1; \
			fi; \
			if [ ! -z "$$select" ] ; then \
				__MASTER_SITES_TMP= ; \
				for group in $$select; do \
					if [ ! -z \$${_MASTER_SITES_$${group}} ] ; then \
						eval ___MASTER_SITES_TMP="\$${_MASTER_SITES_$${group}}" ; \
						__MASTER_SITES_TMP="$${__MASTER_SITES_TMP} $${___MASTER_SITES_TMP}" ; \
					fi \
				done; \
				___MASTER_SITES_TMP= ; \
				SORTED_MASTER_SITES_CMD_TMP="echo ${_MASTER_SITE_OVERRIDE} `echo $${__MASTER_SITES_TMP} | ${AWK} '${MASTER_SORT_AWK:S|\\|\\\\|g}'` ${_MASTER_SITE_BACKUP}" ; \
			else \
				SORTED_MASTER_SITES_CMD_TMP="${SORTED_MASTER_SITES_DEFAULT_CMD}" ; \
			fi ; \
			for site in `eval $$SORTED_MASTER_SITES_CMD_TMP`; do \
			    ${ECHO_MSG} ">> Attempting to fetch from $${site}."; \
				DIR=${DIST_SUBDIR}; \
				CKSIZE=`${GREP} "^SIZE ($${DIR:+$$DIR/}$$file)" ${MD5_FILE} | ${AWK} '{print $$4}'`; \
				case $${file} in \
				*/*)	${MKDIR} $${file%/*}; \
						args="-o $${file} $${site}$${file}";; \
				*)		args=$${site}$${file};; \
				esac; \
				if ${SETENV} ${FETCH_ENV} ${FETCH_CMD} ${FETCH_BEFORE_ARGS} $${args} ${FETCH_AFTER_ARGS}; then \
					continue 2; \
				fi \
			done; \
			${ECHO_MSG} ">> Couldn't fetch it - please try to retrieve this";\
			${ECHO_MSG} ">> port manually into ${_DISTDIR} and try again."; \
			exit 1; \
	    fi \
	 done)
.if defined(PATCHFILES)
	@(cd ${_DISTDIR}; \
	 ${_PATCH_SITES_ENV} ; \
	 for _file in ${PATCHFILES}; do \
		file=`echo $$_file | ${SED} -E -e 's/:[^:]+$$//'` ; \
		select=`echo $${_file#$${file}} | ${SED} -e 's/^://' -e 's/,/ /g'` ; \
		force_fetch=false; \
		filebasename=`${BASENAME} $$file`; \
		for afile in ${FORCE_FETCH}; do \
			afile=`${BASENAME} $$afile`; \
			if [ "x$$afile" = "x$$filebasename" ]; then \
				force_fetch=true; \
			fi; \
		done; \
		if [ ! -f $$file -a ! -f $$filebasename -o "$$force_fetch" = "true" ]; then \
			if [ -L $$file -o -L `${BASENAME} $$file` ]; then \
				${ECHO_MSG} ">> ${_DISTDIR}/$$file is a broken symlink."; \
				${ECHO_MSG} ">> Perhaps a filesystem (most likely a CD) isn't mounted?"; \
				${ECHO_MSG} ">> Please correct this problem and try again."; \
				exit 1; \
			fi ; \
			${ECHO_MSG} ">> $$file doesn't seem to exist in ${_DISTDIR}."; \
			if [ ! -z "$$select" ] ; then \
				__PATCH_SITES_TMP= ; \
				for group in $$select; do \
					if [ ! -z \$${_PATCH_SITES_$${group}} ] ; then \
						eval ___PATCH_SITES_TMP="\$${_PATCH_SITES_$${group}}" ; \
						__PATCH_SITES_TMP="$${__PATCH_SITES_TMP} $${___PATCH_SITES_TMP}" ; \
					fi \
				done; \
				___PATCH_SITES_TMP= ; \
				SORTED_PATCH_SITES_CMD_TMP="echo ${_MASTER_SITE_OVERRIDE} `echo $${__PATCH_SITES_TMP} | ${AWK} '${MASTER_SORT_AWK:S|\\|\\\\|g}'` ${_MASTER_SITE_BACKUP}" ; \
			else \
				SORTED_PATCH_SITES_CMD_TMP="${SORTED_PATCH_SITES_DEFAULT_CMD}" ; \
			fi ; \
			for site in `eval $$SORTED_PATCH_SITES_CMD_TMP`; do \
			    ${ECHO_MSG} ">> Attempting to fetch from $${site}."; \
				DIR=${DIST_SUBDIR}; \
				CKSIZE=`${GREP} "^SIZE ($${DIR:+$$DIR/}$$file)" ${MD5_FILE} | ${AWK} '{print $$4}'`; \
				case $${file} in \
				*/*)	${MKDIR} $${file%/*}; \
						args="-o $${file} $${site}$${file}";; \
				*)		args=$${site}$${file};; \
				esac; \
				if ${SETENV} ${FETCH_ENV} ${FETCH_CMD} ${FETCH_BEFORE_ARGS} $${args} ${FETCH_AFTER_ARGS}; then \
					continue 2; \
				fi \
			done; \
			${ECHO_MSG} ">> Couldn't fetch it - please try to retrieve this";\
			${ECHO_MSG} ">> port manually into ${_DISTDIR} and try again."; \
			exit 1; \
	    fi \
	 done)
.endif
.endif

# Extract

.if !target(do-extract)
do-extract:
	@${RM} -rf ${WRKDIR}
	@${MKDIR} ${WRKDIR}
	@for file in ${EXTRACT_ONLY}; do \
		if ! (cd ${WRKDIR} && ${EXTRACT_CMD} ${EXTRACT_BEFORE_ARGS} ${_DISTDIR}/$$file ${EXTRACT_AFTER_ARGS});\
		then \
			exit 1; \
		fi \
	done
.if !defined(EXTRACT_PRESERVE_OWNERSHIP)
	@if [ `id -u` = 0 ]; then \
		${CHMOD} -R ug-s ${WRKDIR}; \
		${CHOWN} -R 0:0 ${WRKDIR}; \
	fi
.endif
.endif

# Patch

.if !target(do-patch)
do-patch:
.if defined(PATCHFILES)
	@${ECHO_MSG} "===>  Applying distribution patches for ${PKGNAME}"
	@(cd ${_DISTDIR}; \
	  for i in ${_PATCHFILES}; do \
		if [ ${PATCH_DEBUG_TMP} = yes ]; then \
			${ECHO_MSG} "===>   Applying distribution patch $$i" ; \
		fi; \
		case $$i in \
			*.Z|*.gz) \
				${GZCAT} $$i | ${PATCH} ${PATCH_DIST_ARGS}; \
				;; \
			*.bz2) \
				${BZCAT} $$i | ${PATCH} ${PATCH_DIST_ARGS}; \
				;; \
			*) \
				${PATCH} ${PATCH_DIST_ARGS} < $$i; \
				;; \
		esac; \
	  done)
.endif
.if defined(EXTRA_PATCHES)
	@for i in ${EXTRA_PATCHES}; do \
		${ECHO_MSG} "===>  Applying extra patch $$i"; \
		${PATCH} ${PATCH_ARGS} < $$i; \
	done
.endif
	@if [ -d ${PATCHDIR} ]; then \
		if [ "`echo ${PATCHDIR}/patch-*`" != "${PATCHDIR}/patch-*" ]; then \
			${ECHO_MSG} "===>  Applying ${OPSYS} patches for ${PKGNAME}" ; \
			PATCHES_APPLIED="" ; \
			for i in ${PATCHDIR}/patch-*; do \
				case $$i in \
					*.orig|*.rej|*~|*,v) \
						${ECHO_MSG} "===>   Ignoring patchfile $$i" ; \
						;; \
					*) \
						if [ ${PATCH_DEBUG_TMP} = yes ]; then \
							${ECHO_MSG} "===>   Applying ${OPSYS} patch $$i" ; \
						fi; \
						if ${PATCH} ${PATCH_ARGS} < $$i ; then \
							PATCHES_APPLIED="$$PATCHES_APPLIED $$i" ; \
						else \
							${ECHO_MSG} `${ECHO_CMD} ">> Patch $$i failed to apply cleanly." | ${SED} "s|${PATCHDIR}/||"` ; \
							if [ x"$$PATCHES_APPLIED" != x"" ]; then \
								${ECHO_MSG} `${ECHO_CMD} ">> Patch(es) $$PATCHES_APPLIED applied cleanly." | ${SED} "s|${PATCHDIR}/||g"` ; \
							fi; \
							${FALSE} ; \
						fi; \
						;; \
				esac; \
			done; \
		fi; \
	fi
.endif

# Configure

.if !target(do-configure)
do-configure:
.if defined(USE_AUTOMAKE)
	@(cd ${CONFIGURE_WRKSRC} && ${SETENV} ${AUTOMAKE_ENV} ${AUTOMAKE} \
		${AUTOMAKE_ARGS})
.endif
.if defined(USE_AUTOCONF)
	@(cd ${CONFIGURE_WRKSRC} && ${SETENV} ${AUTOCONF_ENV} ${AUTOCONF} \
		${AUTOCONF_ARGS})
.endif
.if defined(USE_AUTOHEADER)
	@(cd ${CONFIGURE_WRKSRC} && ${SETENV} ${AUTOHEADER_ENV} ${AUTOHEADER} \
		${AUTOHEADER_ARGS})
.endif
	@if [ -f ${SCRIPTDIR}/configure ]; then \
		cd ${.CURDIR} && ${SETENV} ${SCRIPTS_ENV} ${SH} \
		  ${SCRIPTDIR}/configure; \
	fi
.if defined(GNU_CONFIGURE)
	@CONFIG_GUESS_DIRS=$$(${FIND} ${WRKDIR} -name config.guess -o -name config.sub \
		| ${XARGS} -n 1 /usr/bin/dirname); \
	for _D in $${CONFIG_GUESS_DIRS}; do \
		${CP} -f ${TEMPLATES}/config.guess $${_D}/config.guess; \
		${CHMOD} a+rx $${_D}/config.guess; \
	    ${CP} -f ${TEMPLATES}/config.sub $${_D}/config.sub; \
		${CHMOD} a+rx $${_D}/config.sub; \
	done
.endif
.if defined(HAS_CONFIGURE)
	@(cd ${CONFIGURE_WRKSRC} && \
		if ! ${SETENV} CC="${CC}" CXX="${CXX}" \
	    CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" \
	    INSTALL="/usr/bin/install -c ${_BINOWNGRP}" \
	    INSTALL_DATA="${INSTALL_DATA}" \
	    INSTALL_PROGRAM="${INSTALL_PROGRAM}" \
	    INSTALL_SCRIPT="${INSTALL_SCRIPT}" \
	    ${CONFIGURE_ENV} ./${CONFIGURE_SCRIPT} ${CONFIGURE_ARGS}; then \
			 ${ECHO_CMD} "===>  Script \"${CONFIGURE_SCRIPT}\" failed unexpectedly."; \
			(${ECHO_CMD} "      Please report the problem to ${MAINTAINER} [maintainer] and"; \
			 ${ECHO_CMD} "      attach the \"${CONFIGURE_WRKSRC}/${CONFIGURE_LOG}\" including"; \
			 ${ECHO_CMD} "      the output of the failure of your make command. Also, it might"; \
			 ${ECHO_CMD} "      be a good idea to provide an overview of all packages installed"; \
			 ${ECHO_CMD} "      on your system (e.g. an \`ls ${PKG_DBDIR}\`).") | /usr/bin/fmt 75 79 ; \
			 ${FALSE}; \
		fi)
.endif
.if defined(PERL_CONFIGURE)
	@cd ${CONFIGURE_WRKSRC} && \
		${SETENV} ${CONFIGURE_ENV} \
		${PERL5} ./${CONFIGURE_SCRIPT} ${CONFIGURE_ARGS}
	@cd ${CONFIGURE_WRKSRC} && \
		${PERL5} -pi -e 's/ doc_(perl|site|\$$\(INSTALLDIRS\))_install$$//' Makefile
.endif
.if defined(USE_IMAKE)
	@(cd ${CONFIGURE_WRKSRC}; ${SETENV} ${MAKE_ENV} ${XMKMF})
.endif
.endif

# Build

.if !target(do-build)
do-build:
.if defined(USE_GMAKE)
	@(cd ${BUILD_WRKSRC}; ${SETENV} ${MAKE_ENV} ${GMAKE} ${MAKE_FLAGS} ${MAKEFILE} ${MAKE_ARGS} ${ALL_TARGET})
.else
	@(cd ${BUILD_WRKSRC}; ${SETENV} ${MAKE_ENV} ${MAKE} ${MAKE_FLAGS} ${MAKEFILE} ${MAKE_ARGS} ${ALL_TARGET})
.endif
.endif

# Check conflicts

.if !target(check-conflicts)
check-conflicts:
.if defined(CONFLICTS) && !defined(DISABLE_CONFLICTS)
	@${RM} -f ${WRKDIR}/.CONFLICTS
.for conflict in ${CONFLICTS}
	@found="`${LS} -d ${PKG_DBDIR}/${conflict} 2>/dev/null || ${TRUE}`"; \
	if [ X"$$found" != X"" ]; then \
		${ECHO} "$$found" >> ${WRKDIR}/.CONFLICTS; \
	fi
.endfor
	@if [ -s ${WRKDIR}/.CONFLICTS ]; then \
		found=`cat ${WRKDIR}/.CONFLICTS | ${SED} -e s'|${PKG_DBDIR}/||g' | tr '\012' ' '`; \
		${ECHO_MSG} "===>  ${PKGNAME} conflicts with installed package(s): "; \
		for entry in $$found; do \
			${ECHO_MSG} "      $$entry"; \
		done; \
		${ECHO_MSG}; \
		${ECHO_MSG} "      They install files into the same place."; \
		${ECHO_MSG} "      Please remove them first with pkg_delete(1)."; \
		${RM} -f ${WRKDIR}/.CONFLICTS; \
		exit 1; \
	fi
.endif  # CONFLICTS
.endif

# Install

.if !target(do-install)
do-install:
.if defined(USE_GMAKE)
	@(cd ${INSTALL_WRKSRC} && ${SETENV} ${MAKE_ENV} ${GMAKE} ${MAKE_FLAGS} ${MAKEFILE} ${MAKE_ARGS} ${INSTALL_TARGET})
.if defined(USE_IMAKE) && !defined(NO_INSTALL_MANPAGES)
	@(cd ${INSTALL_WRKSRC} && ${SETENV} ${MAKE_ENV} ${GMAKE} ${MAKE_FLAGS} ${MAKEFILE} ${MAKE_ARGS} install.man)
.if ${XFREE86_HTML_MAN:L} == yes
	@${MKHTMLINDEX} ${PREFIX}/lib/X11/doc/html
.endif
.endif
.else defined(USE_GMAKE)
	@(cd ${INSTALL_WRKSRC} && ${SETENV} ${MAKE_ENV} ${MAKE} ${MAKE_FLAGS} ${MAKEFILE} ${MAKE_ARGS} ${INSTALL_TARGET})
.if defined(USE_IMAKE) && !defined(NO_INSTALL_MANPAGES)
	@(cd ${INSTALL_WRKSRC} && ${SETENV} ${MAKE_ENV} ${MAKE} ${MAKE_FLAGS} ${MAKEFILE} ${MAKE_ARGS} install.man)
.if ${XFREE86_HTML_MAN:L} == yes
	@${MKHTMLINDEX} ${PREFIX}/lib/X11/doc/html
.endif
.endif
.endif
.endif

# Package

.if !target(do-package)
do-package: ${TMPPLIST}
	@if [ -d ${PACKAGES} ]; then \
		if [ ! -d ${PKGREPOSITORY} ]; then \
			if ! ${MKDIR} ${PKGREPOSITORY}; then \
				${ECHO_MSG} ">> Can't create directory ${PKGREPOSITORY}."; \
				exit 1; \
			fi; \
		fi; \
	fi
	@__softMAKEFLAGS='${__softMAKEFLAGS:S/'/'\''/g}'; \
	if ${PKG_CMD} ${PKG_ARGS} ${PKGFILE}; then \
		if [ -d ${PACKAGES} ]; then \
			eval ${MAKE} $${__softMAKEFLAGS} package-links; \
		fi; \
	else \
		eval ${MAKE} $${__softMAKEFLAGS} delete-package; \
		exit 1; \
	fi
.endif

# Some support rules for do-package

.if !target(package-links)
package-links: delete-package-links
	@for cat in ${CATEGORIES}; do \
		if [ ! -d ${PACKAGES}/$$cat ]; then \
			if ! ${MKDIR} ${PACKAGES}/$$cat; then \
				${ECHO_MSG} ">> Can't create directory ${PACKAGES}/$$cat."; \
				exit 1; \
			fi; \
		fi; \
		${LN} -sf `${ECHO_CMD} $$cat | ${SED} -e 'sa[^/]*a..ag'`/${PKGREPOSITORYSUBDIR}/${PKGNAME}${PKG_SUFX} ${PACKAGES}/$$cat; \
	done
.if !defined(NO_LATEST_LINK)
	@if [ ! -d ${PKGLATESTREPOSITORY} ]; then \
		if ! ${MKDIR} ${PKGLATESTREPOSITORY}; then \
			${ECHO_MSG} ">> Can't create directory ${PKGLATESTREPOSITORY}."; \
			exit 1; \
		fi; \
	fi
	@${LN} -s ../${PKGREPOSITORYSUBDIR}/${PKGNAME}${PKG_SUFX} ${PKGLATESTFILE}
.endif
.endif

.if !target(delete-package-links)
delete-package-links:
	@for cat in ${CATEGORIES}; do \
		${RM} -f ${PACKAGES}/$$cat/${PKGNAME}${PKG_SUFX}; \
	done
.if !defined(NO_LATEST_LINK)
	@${RM} -f ${PKGLATESTFILE}
.endif
.endif

.if !target(delete-package)
delete-package: delete-package-links
	@${RM} -f ${PKGFILE}
.endif

.if !target(delete-package-links-list)
delete-package-links-list:
	@for cat in ${CATEGORIES}; do \
		${ECHO_CMD} ${RM} -f ${PACKAGES}/$$cat/${PKGNAME}${PKG_SUFX}; \
	done
.if !defined(NO_LATEST_LINK)
	@${ECHO_CMD} ${RM} -f ${PKGLATESTFILE}
.endif
.endif

.if !target(delete-package-list)
delete-package-list: delete-package-links-list
	@${ECHO_CMD} "[ -f ${PKGFILE} ] && (${ECHO_CMD} deleting ${PKGFILE}; ${RM} -f ${PKGFILE})"
.endif

# Utility targets follow

.if !target(check-already-installed)
check-already-installed:
.if !defined(NO_PKG_REGISTER) && !defined(FORCE_PKG_REGISTER)
.if ${OSVERSION} >= 460102
		@${ECHO_MSG} "===>  Checking if ${PKGORIGIN} already installed"
		@already_installed=`${PKG_INFO} -q -O ${PKGORIGIN} 2> /dev/null`; \
		if [ -n "$${already_installed}" ]; then \
				for p in $${already_installed}; do \
						prfx=`${PKG_INFO} -q -p $${p} 2> /dev/null | ${HEAD} -n 1 | ${SED} -ne '1s|^@cwd ||p'`; \
						if [ "x${PREFIX}" = "x$${prfx}" ]; then \
								df=`${PKG_INFO} -q -f $${p} 2> /dev/null | ${GREP} -v "^@" | ${COMM} -12 - ${TMPPLIST}`; \
								if [ -n "$${df}" ]; then \
										found_package=$${p}; \
										break; \
								fi; \
						fi; \
				done; \
		fi;
.endif
		@if [ -d ${PKG_DBDIR}/${PKGNAME} -o -n "$${found_package}" ]; then \
				if [ -d ${PKG_DBDIR}/${PKGNAME} ]; then \
						${ECHO_CMD} "===>   ${PKGNAME} is already installed"; \
				else \
						${ECHO_CMD} "===>   An older version of ${PKGORIGIN} is already installed ($${found_package})"; \
				fi; \
				${ECHO_CMD} "      You may wish to \`\`make deinstall'' and install this port again"; \
				${ECHO_CMD} "      by \`\`make reinstall'' to upgrade it properly."; \
				${ECHO_CMD} "      If you really wish to overwrite the old port of ${PKGORIGIN}"; \
				${ECHO_CMD} "      without deleting it first, set the variable \"FORCE_PKG_REGISTER\""; \
				${ECHO_CMD} "      in your environment or the \"make install\" command line."; \
				exit 1; \
		fi
.else
	@${DO_NADA}
.endif
.endif

.if !target(check-umask)
check-umask:
	@if [ `${SH} -c umask` != 0022 ]; then \
		${ECHO_MSG} "===>  Warning: your umask is \"`${SH} -c umask`"\".; \
		${ECHO_MSG} "      If this is not desired, set it to an appropriate value"; \
		${ECHO_MSG} "      and install this port again by \`\`make reinstall''."; \
	fi
.endif

.if !target(install-mtree)
install-mtree:
	@${MKDIR} ${PREFIX}
	@if [ `id -u` != 0 ]; then \
		if [ -w ${PREFIX}/ ]; then \
			${ECHO_MSG} "Warning: not superuser, you may get some errors during installation."; \
		else \
			${ECHO_MSG} "Error: ${PREFIX}/ not writable."; \
			${FALSE}; \
		fi; \
	fi
.if !defined(NO_MTREE)
	@if [ `id -u` = 0 ]; then \
		if [ ! -f ${MTREE_FILE} ]; then \
			${ECHO_CMD} "Error: mtree file \"${MTREE_FILE}\" is missing."; \
			${ECHO_CMD} "Copy it from a suitable location (e.g., /usr/src/etc/mtree) and try again."; \
			exit 1; \
		else \
			${MTREE_CMD} ${MTREE_ARGS} ${PREFIX}/ >/dev/null; \
			if [ ${MTREE_FILE} = "/etc/mtree/BSD.local.dist" ]; then \
				cd ${PREFIX}/share/nls; \
				${LN} -sf C POSIX; \
				${LN} -sf C en_US.US-ASCII; \
			fi; \
		fi; \
	else \
		${ECHO_MSG} "Warning: not superuser, can't run mtree."; \
		${ECHO_MSG} "You may want to become root and try again to ensure correct permissions."; \
	fi
.endif
.endif

.if !target(run-ldconfig)
run-ldconfig:
.if defined(INSTALLS_SHLIB)
	@${ECHO_MSG} "===>   Running ldconfig"
	${LDCONFIG} -m ${LDCONFIG_RUNLIST}
.else
	@${DO_NADA}
.endif
.endif

.if !target(security-check)
security-check:
# Scan PLIST for:
#   1.  setugid files
#   2.  accept()/recvfrom() which indicates network listening capability
#   3.  insecure functions (gets/mktemp/tempnam/[XXX])
#   4.  startup scripts, in conjunction with 2.
#   5.  world-writable files/dirs
#
	-@rm -f ${WRKDIR}/.PLIST.setuid ${WRKDIR}/.PLIST.stupid \
		${WRKDIR}/.PLIST.network ${WRKDIR}/.PLIST.writable; \
	if [ -n "$$PORTS_AUDIT" ]; then \
		stupid_functions_regexp=' (gets|mktemp|tempnam|tmpnam|strcpy|strcat|sprintf)$$'; \
	else \
		stupid_functions_regexp=' (gets|mktemp|tempnam|tmpnam)$$'; \
	fi; \
	for i in `${GREP} -v '^@' ${TMPPLIST}`; do \
		if [ ! -L "${PREFIX}/$$i" -a -f "${PREFIX}/$$i" ]; then \
			/usr/bin/objdump -R ${PREFIX}/$$i > \
				${WRKDIR}/.PLIST.objdump 2> /dev/null; \
			if [ -s ${WRKDIR}/.PLIST.objdump ] ; then \
				${EGREP} " $$stupid_functions_regexp" \
					${WRKDIR}/.PLIST.objdump | awk '{print " " $$3}' | tr -d '\n' \
					> ${WRKDIR}/.PLIST.stupid; \
				if [ -n "`${EGREP} ' (accept|recvfrom)$$' ${WRKDIR}/.PLIST.objdump`" ] ; then \
					if [ -s ${WRKDIR}/.PLIST.stupid ]; then \
						echo -n "${PREFIX}/$$i (USES POSSIBLY INSECURE FUNCTIONS:" >> ${WRKDIR}/.PLIST.network; \
						cat ${WRKDIR}/.PLIST.stupid >> ${WRKDIR}/.PLIST.network; \
						echo ")" >> ${WRKDIR}/.PLIST.network; \
					else \
						echo ${PREFIX}/$$i >> ${WRKDIR}/.PLIST.network; \
					fi; \
				fi; \
			fi; \
			if [ -n "`/usr/bin/find ${PREFIX}/$$i -prune \( -perm -4000 -o -perm -2000 \) \( -perm -0010 -o -perm -0001 \) 2>/dev/null`" ]; then \
				if [ -s ${WRKDIR}/.PLIST.stupid ]; then \
					echo -n "${PREFIX}/$$i (USES POSSIBLY INSECURE FUNCTIONS:" >> ${WRKDIR}/.PLIST.setuid; \
					cat ${WRKDIR}/.PLIST.stupid >> ${WRKDIR}/.PLIST.setuid; \
					echo ")" >> ${WRKDIR}/.PLIST.setuid; \
				else \
					echo ${PREFIX}/$$i >> ${WRKDIR}/.PLIST.setuid; \
				fi; \
			fi; \
		fi; \
		if [ ! -L "${PREFIX}/$$i" ]; then \
			if [ -n "`/usr/bin/find ${PREFIX}/$$i -prune -perm -0002 2>/dev/null`" ]; then \
				 echo ${PREFIX}/$$i >> ${WRKDIR}/.PLIST.writable; \
			fi; \
		fi; \
	done; \
	${GREP} '^etc/rc.d/' ${TMPPLIST} > ${WRKDIR}/.PLIST.startup; \
	if [ -s ${WRKDIR}/.PLIST.setuid -o -s ${WRKDIR}/.PLIST.network -o -s ${WRKDIR}/.PLIST.writable ]; then \
		if [ -n "$$PORTS_AUDIT" ]; then \
			echo "===>  SECURITY REPORT (PARANOID MODE): "; \
		else \
			echo "===>  SECURITY REPORT: "; \
		fi; \
		if [ -s ${WRKDIR}/.PLIST.setuid ] ; then \
			echo "      This port has installed the following binaries which execute with"; \
			echo "      increased privileges."; \
			${CAT} ${WRKDIR}/.PLIST.setuid; \
			echo; \
		fi; \
		if [ -s ${WRKDIR}/.PLIST.network ] ; then \
			echo "      This port has installed the following files which may act as network"; \
			echo "      servers and may therefore pose a remote security risk to the system."; \
			${CAT} ${WRKDIR}/.PLIST.network; \
			echo; \
			if [ -s ${WRKDIR}/.PLIST.startup ] ; then \
				echo "      This port has installed the following startup scripts which may cause"; \
				echo "      these network services to be started at boot time."; \
				${SED} s,^,${PREFIX}/, < ${WRKDIR}/.PLIST.startup; \
				echo; \
			fi; \
		fi; \
		if [ -s ${WRKDIR}/.PLIST.writable ] ; then \
			echo "      This port has installed the following world-writable files/directories."; \
			${CAT} ${WRKDIR}/.PLIST.writable; \
			echo; \
		fi; \
		echo "      If there are vulnerabilities in these programs there may be a security"; \
		echo "      risk to the system. FreeBSD makes no guarantee about the security of"; \
		echo "      ports included in the Ports Collection. Please type 'make deinstall'"; \
		echo "      to deinstall the port if this is a concern."; \
	    if [ ! -z "`make www-site`" ]; then \
			echo; \
			echo "      For more information, and contact details about the security"; \
			echo "      status of this software, see the following webpage: "; \
			${MAKE} www-site; \
		fi; \
	fi
.endif

################################################################
# Skeleton targets start here
# 
# You shouldn't have to change these.  Either add the pre-* or
# post-* targets/scripts or redefine the do-* targets.  These
# targets don't do anything other than checking for cookies and
# call the necessary targets/scripts.
################################################################

# Please note that the order of the following targets is important, and
# should not be modified.

_FETCH_SEQ=		pre-everything fetch-depends pre-fetch pre-fetch-script \
				do-fetch post-fetch post-fetch-script
_EXTRACT_DEP=	fetch
_EXTRACT_SEQ=	extract-message checksum extract-depends pre-extract \
				pre-extract-script do-extract \
				post-extract post-extract-script
_PATCH_DEP=		extract
_PATCH_SEQ=		patch-message patch-depends pre-patch pre-patch-script \
				do-patch post-patch post-patch-script
_CONFIGURE_DEP=	patch
_CONFIGURE_SEQ=	build-depends lib-depends misc-depends configure-message \
				patch-libtool pre-configure pre-configure-script \
				do-configure post-configure post-configure-script
_BUILD_DEP=		configure
_BUILD_SEQ=		build-message pre-build pre-build-script do-build \
				post-build post-build-script
_INSTALL_DEP=	build
_INSTALL_SEQ=	install-message check-categories check-conflicts \
			    run-depends lib-depends pre-install pre-install-script \
				generate-plist check-already-installed
_INSTALL_SUSEQ= check-umask install-mtree pre-su-install \
				pre-su-install-script do-install post-install \
				post-install-script compress-man run-ldconfig fake-pkg \
				security-check
_PACKAGE_DEP=	install
_PACKAGE_SEQ=	package-message pre-package pre-package-script \
				do-package post-package-script

.if !target(fetch)
fetch: ${_FETCH_SEQ}
.endif

# Main logic. The loop generates 6 main targets and using cookies
# ensures that those already completed are skipped.

.for target in extract patch configure build install package

.if !target(${target})
${target}: ${${target:U}_COOKIE}
.endif

.if !exists(${${target:U}_COOKIE})

.if ${UID} != 0 && defined(_${target:U}_SUSEQ)
.if defined(USE_SUBMAKE)
${${target:U}_COOKIE}: ${_${target:U}_DEP}
	@cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} ${_${target:U}_SEQ}
.else
${${target:U}_COOKIE}: ${_${target:U}_DEP} ${_${target:U}_SEQ}
.endif
	@echo "===>  Switching to root credentials for '${target}' target"
	@cd ${.CURDIR} && \
		${SU} root -c "${MAKE} ${__softMAKEFLAGS} ${_${target:U}_SUSEQ}"
	@echo "===>  Returning to user credentials"
	@${TOUCH} ${TOUCH_FLAGS} ${.TARGET}
.elif defined(USE_SUBMAKE)
${${target:U}_COOKIE}: ${_${target:U}_DEP}
	@cd ${.CURDIR} && \
		${MAKE} ${__softMAKEFLAGS} ${_${target:U}_SEQ} ${_${target:U}_SUSEQ}
	@${TOUCH} ${TOUCH_FLAGS} ${.TARGET}
.else
${${target:U}_COOKIE}: ${_${target:U}_DEP} ${_${target:U}_SEQ} ${_${target:U}_SUSEQ}
	@${TOUCH} ${TOUCH_FLAGS} ${.TARGET}
.endif

.else
${${target:U}_COOKIE}::
	@if [ -e ${.TARGET} ]; then \
		${DO_NADA}; \
	else \
		cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} ${.TARGET}; \
	fi
.endif

.endfor

# Enforce order for -jN builds

.ORDER: ${_FETCH_SEQ}
.ORDER: ${_EXTRACT_DEP} ${_EXTRACT_SEQ}
.ORDER: ${_PATCH_DEP} ${_PATCH_SEQ}
.ORDER: ${_CONFIGURE_DEP} ${_CONFIGURE_SEQ}
.ORDER: ${_BUILD_DEP} ${_BUILD_SEQ}
.ORDER: ${_INSTALL_DEP} ${_INSTALL_SEQ}
.ORDER: ${_PACKAGE_DEP} ${_PACKAGE_SEQ}

extract-message:
	@${ECHO_MSG} "===>  Extracting for ${PKGNAME}"
patch-message:
	@${ECHO_MSG} "===>  Patching for ${PKGNAME}"
configure-message:
	@${ECHO_MSG} "===>  Configuring for ${PKGNAME}"
build-message:
	@${ECHO_MSG} "===>  Building for ${PKGNAME}"
install-message:
	@${ECHO_MSG} "===>  Installing for ${PKGNAME}"
package-message:
	@${ECHO_MSG} "===>  Building package for ${PKGNAME}"

# Empty pre-* and post-* targets

.for stage in pre post
.for name in fetch extract patch configure build install package

.if !target(${stage}-${name})
${stage}-${name}:
	@${DO_NADA}
.endif

.if !target(${stage}-${name}-script)
${stage}-${name}-script:
	@if [ -f ${SCRIPTDIR}/${.TARGET:S/-script$//} ]; then \
		cd ${.CURDIR} && ${SETENV} ${SCRIPTS_ENV} ${SH} \
			${SCRIPTDIR}/${.TARGET:S/-script$//}; \
	fi
.endif

.endfor
.endfor

# Special cases for su
.if !target(pre-su-install)
pre-su-install:
	@${DO_NADA}
.endif

.if !target(pre-su-install-script)
pre-su-install-script:
	@${DO_NADA}
.endif

# Patch-libtool
#
# Special target to automatically make libtool using ports use the
# libtool port.  See above for default values of LIBTOOLFILES.
#
# This target works by first checking the version of the installed
# libtool shell script, which is not actually used.  Rather its path
# is determined, and used to find the path to ltconfig and ltmain.sh
# (which is ../share/libtool/).  Then the configure script is copied
# and the default paths for ltconfig and ltmain.sh (normally ./) is
# replaced.  The port's configure script therefore uses the files
# installed by the libtool port in place of it's own.
#
# Also passed to ltconfig are ${LIBTOOLFLAGS}, which can be used to
# customise the behaviour of the port.  Besides the normal flags the
# freebsd port of libtool supports three special flags:
#  --disable-ltlibs		Don't install the .la files. (on by default)
#  --release-ignore		Ignore any -release flags. (off by default)
#  --release-suffix		Add the -release to all libraries, not just
#						the shared library. (off by default)
#

.if !target(patch-libtool)
patch-libtool:
.if defined(USE_LIBTOOL)
	 @(cd ${PATCH_WRKSRC}; \
	 for file in ${LIBTOOLFILES}; do \
		${CP} $$file $$file.tmp; \
		${SED} -e "s^\$$ac_aux_dir/ltconfig^${LIBTOOL_SHAREDIR}/ltconfig${LIBTOOL_VERSION}^g" \
			-e "/^ltmain=/!s^\$$ac_aux_dir/ltmain.sh^${LIBTOOLFLAGS} ${LIBTOOL_SHAREDIR}/ltmain.sh^g" \
			$$file.tmp > $$file; \
	 done);
.else
	@${DO_NADA}
.endif
.endif

.if !target(pretty-print-www-site)
pretty-print-www-site:
	@www_site=$$(cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} www-site); \
	if [ -n "$${www_site}" ]; then \
		${ECHO} -n " and/or visit the "; \
		${ECHO} -n "<a href=\"$${www_site}\">web site</a>"; \
		${ECHO} " for futher informations"; \
	fi
.endif

################################################################
# Some more targets supplied for users' convenience
################################################################

# Checkpatch
#
# Special target to verify patches

.if !target(checkpatch)
checkpatch:
	@cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} PATCH_CHECK_ONLY=yes ${_PATCH_DEP} ${_PATCH_SEQ}
.endif

# Reinstall
#
# Special target to re-run install

.if !target(reinstall)
reinstall:
	@${RM} -f ${INSTALL_COOKIE} ${PACKAGE_COOKIE}
	@cd ${.CURDIR} && DEPENDS_TARGET="${DEPENDS_TARGET}" ${MAKE} install
.endif

# Deinstall
#
# Special target to remove installation

.if !target(deinstall)
deinstall:
	@${ECHO_MSG} "===>  Deinstalling for ${PKGORIGIN}"
.if ${OSVERSION} >= 460102
	@found_names=`${PKG_INFO} -q -O ${PKGORIGIN} 2> /dev/null`; \
	for p in $${found_names}; do \
			check_name=`${ECHO} $${p} | ${SED} -e 's/-[^-]*$$//'`; \
			if [ "$${check_name}" = "${PKGBASE}" ]; then \
					prfx=`${PKG_INFO} -q -p $${p} 2> /dev/null | ${HEAD} -n 1 | ${SED} -ne '1s|^@cwd ||p'`; \
					if [ "x${PREFIX}" = "x$${prfx}" ]; then \
							${ECHO_MSG} "===>   Deinstalling $${p}"; \
							${PKG_DELETE} -f $${p}; \
					else \
							${ECHO_MSG} "===>   $${p} has a different PREFIX: $${prfx}, skipping"; \
					fi; \
			fi; \
	done; \
	if [ -z "$${found_names}" ]; then \
			${ECHO_MSG} "===>   ${PKGBASE} not installed, skipping"; \
	fi
.else
	@if ${PKG_INFO} -e ${PKGNAME}; then \
		${PKG_DELETE} -f ${PKGNAME}; \
	 else \
		${ECHO_MSG} "===>   ${PKGNAME} not installed, skipping"; \
	 fi
.endif
	@${RM} -f ${INSTALL_COOKIE} ${PACKAGE_COOKIE}
.endif

# Deinstall-all
#
# Special target to remove installation of all ports of the same origin

.if !target(deinstall-all)
deinstall-all:
.if ${OSVERSION} >= 460102
	@${ECHO_MSG} "===>  Deinstalling for ${PKGORIGIN}"
	@deinstall_names=`${PKG_INFO} -q -O ${PKGORIGIN} 2> /dev/null`; \
	if [ -n "$${deinstall_names}" ]; then \
		for d in $${deinstall_names}; do \
			${ECHO_MSG} "===>   Deinstalling $${d}"; \
			${PKG_DELETE} -f $${d}; \
		done; \
	else \
		${ECHO_MSG} "===>   ${PKGORIGIN} not installed, skipping"; \
	fi
	@${RM} -f ${INSTALL_COOKIE} ${PACKAGE_COOKIE}
.endif
.endif

# Cleaning up

.if !target(do-clean)
do-clean:
	@if [ -d ${WRKDIR} ]; then \
		if [ -w ${WRKDIR} ]; then \
			${RM} -rf ${WRKDIR}; \
		else \
			${ECHO_MSG} "===>   ${WRKDIR} not writable, skipping"; \
		fi; \
	fi
.endif

.if !target(clean)
clean:
.if !defined(NOCLEANDEPENDS)
	@cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} clean-depends
.endif
	@${ECHO_MSG} "===>  Cleaning for ${PKGNAME}"
.if target(pre-clean)
	@cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} pre-clean
.endif
	@cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} do-clean
.if target(post-clean)
	@cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} post-clean
.endif
.endif

.if !target(pre-distclean)
pre-distclean:
	@${DO_NADA}
.endif

.if !target(distclean)
distclean: pre-distclean clean
	@cd ${.CURDIR} && ${MAKE} delete-distfiles RESTRICTED_FILES="${_DISTFILES} ${_PATCHFILES}"
.endif

.if !target(delete-distfiles)
delete-distfiles:
	@${ECHO_MSG} "===>  Deleting distfiles for ${PKGNAME}"
	@(if [ "X${RESTRICTED_FILES}" != "X" -a -d ${_DISTDIR} ]; then \
		cd ${_DISTDIR}; \
		for file in ${RESTRICTED_FILES}; do \
			${RM} -f $${file}; \
			dir=$${file%/*}; \
			if [ "$${dir}" != "$${file}" ]; then \
				${RMDIR} -p $${dir} >/dev/null 2>&1 || :; \
			fi; \
		done; \
	fi)
.if defined(DIST_SUBDIR)
	-@${RMDIR} ${_DISTDIR} >/dev/null 2>&1 || ${TRUE}
.endif
.endif

.if !target(delete-distfiles-list)
delete-distfiles-list:
	@${ECHO_CMD} "# ${PKGNAME}"
	@if [ "X${RESTRICTED_FILES}" != "X" ]; then \
		for file in ${RESTRICTED_FILES}; do \
			${ECHO_CMD} "[ -f ${_DISTDIR}/$$file ] && (${ECHO_CMD} deleting ${_DISTDIR}/$$file; ${RM} -f ${_DISTDIR}/$$file)"; \
			dir=$${file%/*}; \
			if [ "$${dir}" != "$${file}" ]; then \
				${ECHO_CMD} "(cd ${_DISTDIR} && ${RMDIR} -p $${dir} 2>/dev/null)"; \
			fi; \
		done; \
	fi
.if defined(DIST_SUBDIR)
	@${ECHO_CMD} "${RMDIR} ${_DISTDIR} 2>/dev/null || ${TRUE}"
.endif
.endif

# Prints out a list of files to fetch (useful to do a batch fetch)

.if !target(fetch-list)
fetch-list:
	@${MKDIR} ${_DISTDIR}
	@(cd ${_DISTDIR}; \
	 ${_MASTER_SITES_ENV} ; \
	 for _file in ${DISTFILES}; do \
		file=`echo $$_file | ${SED} -E -e 's/:[^:]+$$//'` ; \
		select=`echo $${_file#$${file}} | ${SED} -e 's/^://' -e 's/,/ /g'` ; \
		if [ ! -f $$file -a ! -f `${BASENAME} $$file` ]; then \
			if [ ! -z "$$select" ] ; then \
				__MASTER_SITES_TMP= ; \
				for group in $$select; do \
					if [ ! -z \$${_MASTER_SITES_$${group}} ] ; then \
						eval ___MASTER_SITES_TMP=\$${_MASTER_SITES_$${group}} ; \
						__MASTER_SITES_TMP="$${__MASTER_SITES_TMP} $${___MASTER_SITES_TMP}" ; \
					fi \
				done; \
				___MASTER_SITES_TMP= ; \
				SORTED_MASTER_SITES_CMD_TMP="echo ${_MASTER_SITE_OVERRIDE} `echo $${__MASTER_SITES_TMP} | ${AWK} '${MASTER_SORT_AWK:S|\\|\\\\|g}'` ${_MASTER_SITE_BACKUP}" ; \
			else \
				SORTED_MASTER_SITES_CMD_TMP="${SORTED_MASTER_SITES_DEFAULT_CMD}" ; \
			fi ; \
			for site in `eval $$SORTED_MASTER_SITES_CMD_TMP`; do \
				DIR=${DIST_SUBDIR}; \
				CKSIZE=`${GREP} "^SIZE ($${DIR:+$$DIR/}$$file)" ${MD5_FILE} | ${AWK} '{print $$4}'`; \
				case $${file} in \
				*/*)	args="-o $${file} $${site}$${file}";; \
				*)		args=$${site}$${file};; \
				esac; \
				${ECHO_CMD} -n ${SETENV} ${FETCH_ENV} ${FETCH_CMD} ${FETCH_BEFORE_ARGS} $${args} "${FETCH_AFTER_ARGS}" '|| ' ; \
			done; \
			${ECHO_CMD} "echo $${file} not fetched" ; \
		fi \
	done)
.if defined(PATCHFILES)
	@(cd ${_DISTDIR}; \
	 ${_PATCH_SITES_ENV} ; \
	 for _file in ${PATCHFILES}; do \
		file=`echo $$_file | ${SED} -E -e 's/:[^:]+$$//'` ; \
		select=`echo $${_file#$${file}} | ${SED} -e 's/^://' -e 's/,/ /g'` ; \
		if [ ! -f $$file -a ! -f `${BASENAME} $$file` ]; then \
			if [ ! -z "$$select" ] ; then \
				__PATCH_SITES_TMP= ; \
				for group in $$select; do \
					if [ ! -z \$${_PATCH_SITES_$${group}} ] ; then \
						eval ___PATCH_SITES_TMP=\$${_PATCH_SITES_$${group}} ; \
						__PATCH_SITES_TMP="$${__PATCH_SITES_TMP} $${___PATCH_SITES_TMP}" ; \
					fi \
				done; \
				___PATCH_SITES_TMP= ; \
				SORTED_PATCH_SITES_CMD_TMP="echo ${_MASTER_SITE_OVERRIDE} `echo $${__PATCH_SITES_TMP} | ${AWK} '${MASTER_SORT_AWK:S|\\|\\\\|g}'` ${_MASTER_SITE_BACKUP}" ; \
			else \
				SORTED_PATCH_SITES_CMD_TMP="${SORTED_PATCH_SITES_DEFAULT_CMD}" ; \
			fi ; \
			for site in `eval $$SORTED_PATCH_SITES_CMD_TMP`; do \
				DIR=${DIST_SUBDIR}; \
				CKSIZE=`${GREP} "^SIZE ($${DIR:+$$DIR/}$$file)" ${MD5_FILE} | ${AWK} '{print $$4}'`; \
				case $${file} in \
				*/*)	args="-o $${file} $${site}$${file}";; \
				*)		args=$${site}$${file};; \
				esac; \
				${ECHO_CMD} -n ${SETENV} ${FETCH_ENV} ${FETCH_CMD} ${FETCH_BEFORE_ARGS} $${args} "${FETCH_AFTER_ARGS}" '|| ' ; \
			done; \
			${ECHO_CMD} "echo $${file} not fetched" ; \
		fi \
	 done)
.endif
.endif

# Generates patches.

update-patches:
	@toedit=`PATCH_WRKSRC=${PATCH_WRKSRC} \
		PATCHDIR=${PATCHDIR} \
		PATCH_LIST=${PATCHDIR}/patch-* \
		DIFF_ARGS=${DIFF_ARGS} \
		DISTORIG=${DISTORIG} \
		${SH} ${PORTSDIR}/Tools/scripts/update-patches`; \
	case $$toedit in "");; \
	*) ${ECHO} -n 'edit patches: '; read i; \
	cd ${PATCHDIR} && $${VISUAL:-$${EDIT:-/usr/bin/vi}} $$toedit;; esac

# Checksumming utilities

.if !target(makesum)
makesum:
	@cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} fetch NO_CHECKSUM=yes
	@if [ -f ${MD5_FILE} ]; then ${CAT} /dev/null > ${MD5_FILE}; fi
	@(cd ${DISTDIR}; \
	 for file in ${_CKSUMFILES}; do \
		${MD5} $$file >> ${MD5_FILE}; \
	 done)
	@for file in ${_IGNOREFILES}; do \
		${ECHO_CMD} "MD5 ($$file) = IGNORE" >> ${MD5_FILE}; \
	done
.endif
# this line goes after the ${MD5} above
#		echo "SIZE ($$file) = "`wc -c < $$file` >> ${MD5_FILE}; \


.if !target(checksum)
checksum: fetch
	@if [ ! -f ${MD5_FILE} ]; then \
		${ECHO_MSG} ">> No MD5 checksum file."; \
	else \
		(cd ${DISTDIR}; OK="true"; \
		  for file in ${_CKSUMFILES}; do \
			CKSUM=`${MD5} < $$file`; \
			CKSUM2=`${GREP} "^MD5 ($$file)" ${MD5_FILE} | ${AWK} '{print $$4}'`; \
			if [ "$$CKSUM2" = "" ]; then \
				${ECHO_MSG} ">> No checksum recorded for $$file."; \
				OK="false"; \
			elif [ "$$CKSUM2" = "IGNORE" ]; then \
				${ECHO_MSG} ">> Checksum for $$file is set to IGNORE in distinfo file even though"; \
				${ECHO_MSG} "   the file is not in the "'$$'"{IGNOREFILES} list."; \
				OK="false"; \
			elif ${EXPR} "$$CKSUM2" : ".*$$CKSUM" > /dev/null; then \
				${ECHO_MSG} ">> Checksum OK for $$file."; \
			else \
				${ECHO_MSG} ">> Checksum mismatch for $$file."; \
				refetchlist="$$refetchlist$$file "; \
				OK="false"; \
			fi; \
		  done; \
		  for file in ${_IGNOREFILES}; do \
			CKSUM2=`${GREP} "($$file)" ${MD5_FILE} | ${AWK} '{print $$4}'`; \
			if [ "$$CKSUM2" = "" ]; then \
				${ECHO_MSG} ">> No checksum recorded for $$file, file is in "'$$'"{IGNOREFILES} list."; \
				OK="false"; \
			elif [ "$$CKSUM2" != "IGNORE" ]; then \
				${ECHO_MSG} ">> Checksum for $$file is not set to IGNORE in distinfo file even though"; \
				${ECHO_MSG} "   the file is in the "'$$'"{IGNOREFILES} list."; \
				OK="false"; \
			fi; \
		  done; \
		  if [ "$$OK" != "true" ] && [ ${FETCH_REGET} -gt 0 ]; then \
			  ${ECHO_MSG} "===>  Refetch for ${FETCH_REGET} more times files: $$refetchlist"; \
			  if ( cd ${.CURDIR} && \
			    ${MAKE} ${.MAKEFLAGS} FORCE_FETCH="$$refetchlist" FETCH_REGET="`expr ${FETCH_REGET} - 1`" fetch); then \
			  	  if ( cd ${.CURDIR} && \
			        ${MAKE} ${.MAKEFLAGS} FETCH_REGET="`expr ${FETCH_REGET} - 1`" checksum ); then \
			  	      OK="true"; \
			  	  fi; \
			  fi; \
			fi ; \
		  if [ "$$OK" != "true" -a ${FETCH_REGET} -eq 0 ]; then \
			  ${ECHO_MSG} "===>  Giving up on fetching files: $$refetchlist"; \
			  ${ECHO_MSG} "Make sure the Makefile and distinfo file (${MD5_FILE})"; \
			  ${ECHO_MSG} "are up to date.  If you are absolutely sure you want to override this"; \
			  ${ECHO_MSG} "check, type \"make NO_CHECKSUM=yes [other args]\"."; \
			  exit 1; \
		  fi; \
		  if [ "$$OK" != "true" ]; then \
			  exit 1; \
		  fi); \
	fi
.endif

################################################################
# The special package-building targets
# You probably won't need to touch these
################################################################

# Nobody should want to override this unless PKGNAME is simply bogus.

.if !target(package-name)
package-name:
	@${ECHO_CMD} ${PKGNAME}
.endif

# Build a package but don't check the package cookie

.if !target(repackage)
repackage: pre-repackage package

pre-repackage:
	@${RM} -f ${PACKAGE_COOKIE}
.endif

# Build a package but don't check the cookie for installation, also don't
# install package cookie

.if !target(package-noinstall)
package-noinstall:
	@${MKDIR} ${WRKDIR}
	@cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} pre-package \
		pre-package-script do-package post-package-script
	@${RM} -f ${TMPPLIST}
	-@${RMDIR} ${WRKDIR}
.endif

################################################################
# Dependency checking
################################################################

.if !target(depends)
depends: extract-depends patch-depends lib-depends misc-depends fetch-depends build-depends run-depends

.if defined(ALWAYS_BUILD_DEPENDS)
_DEPEND_ALWAYS=	1
.else
_DEPEND_ALWAYS=	0
.endif

.for deptype in EXTRACT PATCH FETCH BUILD RUN
${deptype:L}-depends:
.if defined(${deptype}_DEPENDS)
.if !defined(NO_DEPENDS)
	@for i in ${${deptype}_DEPENDS}; do \
		prog=`${ECHO_CMD} $$i | ${SED} -e 's/:.*//'`; \
		dir=`${ECHO_CMD} $$i | ${SED} -e 's/[^:]*://'`; \
		if ${EXPR} "$$dir" : '.*:' > /dev/null; then \
			target=`${ECHO_CMD} $$dir | ${SED} -e 's/.*://'`; \
			dir=`${ECHO_CMD} $$dir | ${SED} -e 's/:.*//'`; \
		else \
			target="${DEPENDS_TARGET}"; \
			depends_args="${DEPENDS_ARGS}"; \
		fi; \
		if ${EXPR} "$$prog" : \\/ >/dev/null; then \
			if [ -e "$$prog" ]; then \
				${ECHO_MSG} "===>   ${PKGNAME} depends on file: $$prog - found"; \
				if [ ${_DEPEND_ALWAYS} = 1 ]; then \
					${ECHO_MSG} "       (but building it anyway)"; \
					notfound=1; \
				else \
					notfound=0; \
				fi; \
			else \
				${ECHO_MSG} "===>   ${PKGNAME} depends on file: $$prog - not found"; \
				notfound=1; \
			fi; \
		else \
			if ${WHICH} "$$prog" > /dev/null 2>&1 ; then \
				${ECHO_MSG} "===>   ${PKGNAME} depends on executable: $$prog - found"; \
				if [ ${_DEPEND_ALWAYS} = 1 ]; then \
					${ECHO_MSG} "       (but building it anyway)"; \
					notfound=1; \
				else \
					notfound=0; \
				fi; \
			else \
				${ECHO_MSG} "===>   ${PKGNAME} depends on executable: $$prog - not found"; \
				notfound=1; \
			fi; \
		fi; \
		if [ $$notfound != 0 ]; then \
			${ECHO_MSG} "===>    Verifying $$target for $$prog in $$dir"; \
			if [ ! -d "$$dir" ]; then \
				${ECHO_MSG} "     >> No directory for $$prog.  Skipping.."; \
			else \
				if [ X${USE_PACKAGE_DEPENDS} != "X" ]; then \
					subpkgfile=`(cd $$dir; ${MAKE} $$depends_args -V PKGFILE)`; \
					if [ -r "$${subpkgfile}" -a "$$target" = "${DEPENDS_TARGET}" ]; then \
						${ECHO_MSG} "===>   Installing existing package $${subpkgfile}"; \
						${PKG_ADD} $${subpkgfile}; \
					else \
					  (cd $$dir; ${MAKE} -DINSTALLS_DEPENDS $$target $$depends_args) ; \
					fi; \
				else \
					(cd $$dir; ${MAKE} -DINSTALLS_DEPENDS $$target $$depends_args) ; \
				fi ; \
				${ECHO_MSG} "===>   Returning to build of ${PKGNAME}"; \
			fi; \
		fi; \
	done
.endif
.else
	@${DO_NADA}
.endif
.endfor

lib-depends:
.if defined(LIB_DEPENDS) && !defined(NO_DEPENDS)
	@for i in ${LIB_DEPENDS}; do \
		lib=$${i%%:*}; \
		case $$lib in \
			*.*.*)	pattern=$$lib ;;\
			*.*)	pattern="$${lib%%.*}\.$${lib#*.}" ;;\
			*)		pattern=$$lib ;;\
		esac; \
		dir=$${i#*:}; \
		target=$${i##*:}; \
		if ${TEST} $$dir = $$target; then \
			target="${DEPENDS_TARGET}"; \
			depends_args="${DEPENDS_ARGS}"; \
		else \
			dir=$${dir%%:*}; \
		fi; \
		${ECHO_MSG} -n "===>   ${PKGNAME} depends on shared library: $$lib"; \
		if ${LDCONFIG} -r | ${GREP} -qwE -e "-l$$pattern"; then \
			${ECHO_MSG} " - found"; \
			if [ ${_DEPEND_ALWAYS} = 1 ]; then \
				${ECHO_MSG} "       (but building it anyway)"; \
				notfound=1; \
			else \
				notfound=0; \
			fi; \
		else \
			${ECHO_MSG} " - not found"; \
			notfound=1; \
		fi; \
		if [ $$notfound != 0 ]; then \
			${ECHO_MSG} "===>    Verifying $$target for $$lib in $$dir"; \
			if [ ! -d "$$dir" ]; then \
				${ECHO_MSG} "     >> No directory for $$lib.  Skipping.."; \
			else \
				if [ X${USE_PACKAGE_DEPENDS} != "X" ]; then \
					subpkgfile=`(cd $$dir; ${MAKE} $$depends_args -V PKGFILE)`; \
					if [ -r "$${subpkgfile}" -a "$$target" = "${DEPENDS_TARGET}" ]; then \
						${ECHO_MSG} "===>   Installing existing package $${subpkgfile}"; \
						${PKG_ADD} $${subpkgfile}; \
					else \
					  (cd $$dir; ${MAKE} -DINSTALLS_DEPENDS $$target $$depends_args) ; \
					fi; \
				else \
					(cd $$dir; ${MAKE} -DINSTALLS_DEPENDS $$target $$depends_args) ; \
				fi ; \
				${ECHO_MSG} "===>   Returning to build of ${PKGNAME}"; \
				if ! ${LDCONFIG} -r | ${GREP} -qwE -e "-l$$pattern"; then \
					${ECHO_MSG} "Error: shared library \"$$lib\" does not exist"; \
					${FALSE}; \
				fi; \
			fi; \
		fi; \
	done
.endif

misc-depends:
.if defined(DEPENDS)
.if !defined(NO_DEPENDS)
	@for dir in ${DEPENDS}; do \
		if ${EXPR} "$$dir" : '.*:' > /dev/null; then \
			target=`${ECHO_CMD} $$dir | ${SED} -e 's/.*://'`; \
			dir=`${ECHO_CMD} $$dir | ${SED} -e 's/:.*//'`; \
		else \
			target="${DEPENDS_TARGET}"; \
			depends_args="${DEPENDS_ARGS}"; \
		fi; \
		${ECHO_MSG} "===>   ${PKGNAME} depends on: $$dir"; \
		${ECHO_MSG} "===>    Verifying $$target for $$dir"; \
		if [ ! -d $$dir ]; then \
			${ECHO_MSG} "     >> No directory for $$dir.  Skipping.."; \
		else \
			(cd $$dir; ${MAKE} $$target $$depends_args) ; \
		fi \
	done
	@${ECHO_MSG} "===>   Returning to build of ${PKGNAME}"
.endif
.else
	@${DO_NADA}
.endif

.endif

# Dependency lists: both build and runtime, recursive.  Print out directory names.

all-depends-list:
	@${ALL-DEPENDS-LIST}

ALL-DEPENDS-LIST= \
	checked="${PARENT_CHECKED}"; \
	for dir in $$(${ECHO_CMD} "${EXTRACT_DEPENDS} ${PATCH_DEPENDS} ${FETCH_DEPENDS} ${BUILD_DEPENDS} ${LIB_DEPENDS} ${RUN_DEPENDS}" | ${TR} '\040' '\012' | ${SED} -e 's/^[^:]*://' -e 's/:.*//') $$(${ECHO_CMD} ${DEPENDS} | ${TR} '\040' '\012' | ${SED} -e 's/:.*//'); do \
		if [ -d $$dir ]; then \
			if (${ECHO_CMD} $$checked | ${GREP} -qwv "$$dir"); then \
				child=$$(cd $$dir; ${MAKE} PARENT_CHECKED="$$checked" all-depends-list); \
				for d in $$child; do ${ECHO_CMD} $$d; done; \
				${ECHO_CMD} $$dir; \
				checked="$$dir $$child $$checked"; \
			fi; \
		else \
			${ECHO_MSG} "${PKGNAME}: \"$$dir\" non-existent -- dependency list incomplete" >&2; \
		fi; \
	done | sort -u

.if !target(clean-depends)
clean-depends:
	@for dir in $$(${ALL-DEPENDS-LIST}); do \
		(cd $$dir; ${MAKE} NOCLEANDEPENDS=yes clean); \
	done
.endif

.if !target(deinstall-depends)
deinstall-depends:
	@for dir in $$(${ALL-DEPENDS-LIST}); do \
		(cd $$dir; ${MAKE} deinstall); \
	done
.endif

.if !target(fetch-recursive)
fetch-recursive:
	@${ECHO_MSG} "===> Fetching all distfiles for ${PKGNAME} and dependencies"
	@for dir in ${.CURDIR} $$(${ALL-DEPENDS-LIST}); do \
		(cd $$dir; ${MAKE} fetch); \
	done
.endif

.if !target(fetch-recursive-list)
fetch-recursive-list:
	@for dir in ${.CURDIR} $$(${ALL-DEPENDS-LIST}); do \
		(cd $$dir; ${MAKE} fetch-list); \
	done
.endif

.if !target(fetch-required)
fetch-required: fetch
	@${ECHO_MSG} "===> Fetching all required distfiles for ${PKGNAME} and dependencies"
.for deptype in EXTRACT PATCH FETCH BUILD RUN
.if defined(${deptype}_DEPENDS)
.if !defined(NO_DEPENDS)
	@for i in ${${deptype}_DEPENDS}; do \
		prog=`${ECHO_CMD} $$i | ${SED} -e 's/:.*//'`; \
		dir=`${ECHO_CMD} $$i | ${SED} -e 's/[^:]*://'`; \
		if ${EXPR} "$$dir" : '.*:' > /dev/null; then \
			dir=`${ECHO_CMD} $$dir | ${SED} -e 's/:.*//'`; \
			if ${EXPR} "$$prog" : \\/ >/dev/null; then \
				if [ ! -e "$$prog" ]; then \
					(cd $$dir; ${MAKE} fetch); \
				fi; \
			fi; \
		else \
			(cd $$dir; \
			tmp=`${MAKE} -V PKGNAME`; \
			if [ ! -d ${PKG_DBDIR}/$${tmp} ]; then \
				${MAKE} fetch; \
			fi );  \
		fi; \
	done
.endif
.endif
.endfor
.endif

.if !target(fetch-required-list)
fetch-required-list: fetch-list
.for deptype in EXTRACT PATCH FETCH BUILD RUN
.if defined(${deptype}_DEPENDS)
.if !defined(NO_DEPENDS)
	@for i in ${${deptype}_DEPENDS}; do \
		prog=`${ECHO_CMD} $$i | ${SED} -e 's/:.*//'`; \
		dir=`${ECHO_CMD} $$i | ${SED} -e 's/[^:]*://'`; \
		if ${EXPR} "$$dir" : '.*:' > /dev/null; then \
			dir=`${ECHO_CMD} $$dir | ${SED} -e 's/:.*//'`; \
			if ${EXPR} "$$prog" : \\/ >/dev/null; then \
				if [ ! -e "$$prog" ]; then \
					(cd $$dir; ${MAKE} fetch-list); \
				fi; \
			fi; \
		else \
			(cd $$dir; \
			tmp=`${MAKE} -V PKGNAME`; \
			if [ ! -d ${PKG_DBDIR}/$${tmp} ]; then \
				${MAKE} fetch-list; \
			fi );  \
		fi; \
	done
.endif
.endif
.endfor
.endif

.if !target(checksum-recursive)
checksum-recursive:
	@${ECHO_MSG} "===> Fetching and checking checksums for ${PKGNAME} and dependencies"
	@for dir in ${.CURDIR} $$(${ALL-DEPENDS-LIST}); do \
		(cd $$dir; ${MAKE} checksum); \
	done
.endif

# Dependency lists: build and runtime.  Print out directory names.

build-depends-list:
	@${BUILD-DEPENDS-LIST}

BUILD-DEPENDS-LIST= \
	for dir in $$(${ECHO_CMD} "${EXTRACT_DEPENDS} ${PATCH_DEPENDS} ${FETCH_DEPENDS} ${BUILD_DEPENDS} ${LIB_DEPENDS}" | ${TR} '\040' '\012' | ${SED} -e 's/^[^:]*://' -e 's/:.*//' | sort -u) $$(${ECHO_CMD} ${DEPENDS} | ${TR} '\040' '\012' | ${SED} -e 's/:.*//' | sort -u); do \
		if [ -d $$dir ]; then \
			${ECHO_CMD} $$dir; \
		else \
			${ECHO_MSG} "${PKGNAME}: \"$$dir\" non-existent -- dependency list incomplete" >&2; \
		fi; \
	done | sort -u

run-depends-list:
	@${RUN-DEPENDS-LIST}

RUN-DEPENDS-LIST= \
	for dir in $$(${ECHO_CMD} "${LIB_DEPENDS} ${RUN_DEPENDS}" | ${TR} '\040' '\012' | ${SED} -e 's/^[^:]*://' -e 's/:.*//' | sort -u) $$(${ECHO_CMD} ${DEPENDS} | ${TR} '\040' '\012' | ${SED} -e 's/:.*//' | sort -u); do \
		if [ -d $$dir ]; then \
			${ECHO_CMD} $$dir; \
		else \
			${ECHO_MSG} "${PKGNAME}: \"$$dir\" non-existent -- dependency list incomplete" >&2; \
		fi; \
	done | sort -u

# Package (recursive runtime) dependency list.  Print out both directory names
# and package names.

package-depends-list:
	@${PACKAGE-DEPENDS-LIST}

PACKAGE-DEPENDS-LIST?= \
	if [ "${CHILD_DEPENDS}" ]; then \
		installed=$$(${PKG_INFO} -qO ${PKGORIGIN} 2>/dev/null || \
			${TRUE}); \
		if [ "$$installed" ]; then \
			break; \
		fi; \
		if [ -z "$$installed" ]; then \
			installed="${PKGNAME}"; \
		fi; \
		for pkgname in $$installed; do \
			${ECHO_CMD} "$$pkgname ${.CURDIR} ${PKGORIGIN}"; \
		done; \
	fi; \
	checked="${PARENT_CHECKED}"; \
	for dir in $$(${ECHO_CMD} "${LIB_DEPENDS} ${RUN_DEPENDS}" | ${TR} '\040' '\012' | ${SED} -e 's/^[^:]*://' -e 's/:.*//') $$(${ECHO_CMD} ${DEPENDS} | ${TR} '\040' '\012' | ${SED} -e 's/:.*//'); do \
		dir=$$(${REALPATH} $$dir); \
		if [ -d $$dir ]; then \
			if (${ECHO_CMD} $$checked | ${GREP} -qwv "$$dir"); then \
				childout=$$(cd $$dir; ${MAKE} CHILD_DEPENDS=yes PARENT_CHECKED="$$checked" package-depends-list); \
				set -- $$childout; \
				childdir=""; \
				while [ $$\# != 0 ]; do \
					childdir="$$childdir $$2"; \
					${ECHO_CMD} "$$1 $$2 $$3"; \
					shift 3; \
				done; \
				checked="$$dir $$childdir $$checked"; \
			fi; \
		else \
			${ECHO_MSG} "${PKGNAME}: \"$$dir\" non-existent -- dependency list incomplete" >&2; \
		fi; \
	done

# Print out package names.

package-depends:
.if ${OSVERSION} >= 460102
	@${PACKAGE-DEPENDS-LIST} | ${AWK} '{print $$1":"$$3}'
.else
	@${PACKAGE-DEPENDS-LIST} | ${AWK} '{print $$1}'
.endif

# Build packages for port and dependencies

package-recursive: package
	@for dir in $$(${ALL-DEPENDS-LIST}); do \
		(cd $$dir; ${MAKE} package-noinstall); \
	done

################################################################
# Everything after here are internal targets and really
# shouldn't be touched by anybody but the release engineers.
################################################################

# This target generates an index entry suitable for aggregation into
# a large index.  Format is:
#
# distribution-name|port-path|installation-prefix|comment| \
#  description-file|maintainer|categories|build deps|run deps|www site

.if !target(describe)
describe:
	@${ECHO_CMD} -n "`perl -e ' \
		print q{${PKGNAME}|${.CURDIR}|${PREFIX}|}`"
.if defined(COMMENT)
	@${ECHO_CMD} -n ${COMMENT:Q}
.else
	@${ECHO_CMD} -n '** No Description'
.endif
	@${ECHO_CMD} "`perl -e ' \
		if ( -f q{${DESCR}} ) { \
			print q{|${DESCR}}; \
		} else { \
			print q{|/dev/null}; \
		} \
		print q{|${MAINTAINER}|${CATEGORIES}|}; \
		@bdirs = map((split /:/)[1], split(q{ }, q{${EXTRACT_DEPENDS} ${PATCH_DEPENDS} ${FETCH_DEPENDS} ${BUILD_DEPENDS}})); \
		@rdirs = map((split /:/)[1], split(q{ }, q{${RUN_DEPENDS}})); \
		@mdirs = ( \
			map((split /:/)[0], split(q{ }, q{${DEPENDS}})), \
			map((split /:/)[1], split(q{ }, q{${LIB_DEPENDS}})) \
		); \
		for my $$i (\@bdirs, \@rdirs, \@mdirs) { \
			my @dirs = @$$i; \
			@$$i = (); \
			for (@dirs) { \
				if (-d $$_) { \
					push @$$i, $$_; \
				} else { \
					print STDERR qq{${PKGNAME}: \"$$_\" non-existent -- dependency list incomplete\n}; \
				} \
			} \
		} \
		for (@bdirs, @mdirs) { \
			$$x{$$_} = 1; \
		} \
		print join(q{ }, sort keys %x), q{|}; \
		for (@rdirs, @mdirs) { \
			$$y{$$_} = 1; \
		} \
		print join(q{ }, sort keys %y), q{|}; \
		if (open(DESCR, q{${DESCR}})) { \
			while (<DESCR>) { \
				if (/^WWW:\s+(\S+)/) { \
					print $$1; \
					last; \
				} \
			} \
		} \
		print qq{\n};'`"
.endif

www-site:
.if exists(${DESCR})
	@${GREP} '^WWW:[ 	]' ${DESCR} | ${AWK} '{print $$2}' | ${HEAD} -1
.else
	@${ECHO_CMD}
.endif

.if !target(readmes)
readmes:	readme
.endif

.if !target(readme)
readme:
	@rm -f ${.CURDIR}/README.html
	@cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} ${.CURDIR}/README.html
.endif

${.CURDIR}/README.html:
	@${ECHO_MSG} "===>   Creating README.html for ${PKGNAME}"
	@__softMAKEFLAGS='${__softMAKEFLAGS:S/'/'\''/g}'; \
	${SED} -e 's|%%PORT%%|'$$(${ECHO_CMD} ${.CURDIR} | \
							  ${SED} -e 's|.*/\([^/]*/[^/]*\)$$|\1|')'|g' \
			-e 's|%%PKG%%|${PKGNAME}|g' \
			-e 's|%%COMMENT%%|'"$$(${ECHO_CMD} ${COMMENT:Q})"'|' \
			-e '/%%COMMENT%%/d' \
			-e 's|%%DESCR%%|'"$$(${ECHO_CMD} ${DESCR} | \
								 ${SED} -e 's|${.CURDIR}/||')"'|' \
			-e 's|%%EMAIL%%|'"$$(${ECHO_CMD} "${MAINTAINER}" | \
								 ${SED} -e 's/([^)]*)//;s/.*<//;s/>.*//')"'|g' \
			-e 's|%%MAINTAINER%%|${MAINTAINER}|g' \
			-e 's|%%WEBSITE%%|'"$$(cd ${.CURDIR} && eval ${MAKE} \
					$${__softMAKEFLAGS} pretty-print-www-site)"'|' \
			-e 's|%%BUILD_DEPENDS%%|'"$$(cd ${.CURDIR} && eval ${MAKE} \
					$${__softMAKEFLAGS} pretty-print-build-depends-list)"'|' \
			-e 's|%%RUN_DEPENDS%%|'"$$(cd ${.CURDIR} && eval ${MAKE} \
					$${__softMAKEFLAGS} pretty-print-run-depends-list)"'|' \
			-e 's|%%TOP%%|'"$$(${ECHO_CMD} ${CATEGORIES} | \
							   ${SED} -e 's| .*||' -e 's|[^/]*|..|g')"'/..|' \
		${TEMPLATES}/README.port >> $@

# The following two targets require an up-to-date INDEX in ${PORTSDIR}

.if !target(pretty-print-build-depends-list)
pretty-print-build-depends-list:
.if defined(EXTRACT_DEPENDS) || defined(PATCH_DEPENDS) || \
	defined(FETCH_DEPENDS) || defined(BUILD_DEPENDS) || \
	defined(LIB_DEPENDS) || defined(DEPENDS)
	@${ECHO_CMD} -n 'This port requires package(s) "'
	@${ECHO_CMD} -n `${GREP} '^${PKGNAME}|' ${PORTSDIR}/${INDEXFILE} | awk -F\| '{print $$8;}'`
	@${ECHO_CMD} '" to build.'
.endif
.endif

.if !target(pretty-print-run-depends-list)
pretty-print-run-depends-list:
.if defined(RUN_DEPENDS) || defined(LIB_DEPENDS) || defined(DEPENDS)
	@${ECHO_CMD} -n 'This port requires package(s) "'
	@${ECHO_CMD} -n `${GREP} '^${PKGNAME}|' ${PORTSDIR}/${INDEXFILE} | awk -F\| '{print $$9;}'`
	@${ECHO_CMD} '" to run.'
.endif
.endif

# Generate packing list.  Also tests to make sure all required package
# files exist.

.if !target(generate-plist)
generate-plist:
	@${ECHO_MSG} "===>   Generating temporary packing list"
	@${MKDIR} `dirname ${TMPPLIST}`
	@if [ ! -f ${PLIST} -o ! -f ${DESCR} ]; then ${ECHO_CMD} "** Missing package files for ${PKGNAME}."; exit 1; fi
	@>${TMPPLIST}
	@for man in ${__MANPAGES}; do \
		${ECHO_CMD} $${man} >> ${TMPPLIST}; \
	done
.for _PREFIX in ${PREFIX}
.if ${_TMLINKS:M${_PREFIX}*}x != x
	@for i in ${_TMLINKS:M${_PREFIX}*:S,^${_PREFIX}/,,:S,//,/,g}; do \
		${ECHO_CMD} "$$i" >> ${TMPPLIST}; \
	done
.endif
.if ${_TMLINKS:N${_PREFIX}*}x != x
	@${ECHO_CMD} @cwd / >> ${TMPPLIST}
	@for i in ${_TMLINKS:N${_PREFIX}*:S,^/,,}; do \
		${ECHO_CMD} "$$i" >> ${TMPPLIST}; \
	done
	@${ECHO_CMD} '@cwd ${PREFIX}' >> ${TMPPLIST}
.endif
	@for i in $$(${ECHO} ${__MANPAGES} ${_TMLINKS:M${_PREFIX}*:S,^${_PREFIX}/,,:S,//,/,g} ' ' | ${SED} -E -e 's,man([1-9ln])/([^/ ]+) ,cat\1/\2 ,g'); do \
		${ECHO} "@unexec rm -f %D/$${i%.gz} %D/$${i%.gz}.gz" >> ${TMPPLIST}; \
	done
.if ${XFREE86_HTML_MAN:L} == "yes"
.for mansect in 1 2 3 4 5 6 7 8 9 L N
.for man in ${MAN${mansect}}
	@echo lib/X11/doc/html/${man}.html >> ${TMPPLIST}
.endfor
.endfor
	@${ECHO_CMD} "@unexec %D/bin/mkhtmlindex %D/lib/X11/doc/html" >> ${TMPPLIST}
	@${ECHO_CMD} "@exec %D/bin/mkhtmlindex %D/lib/X11/doc/html" >> ${TMPPLIST}
.if defined(MLINKS)
	@${ECHO_CMD} ${MLINKS} | ${AWK} \
	'{ for (i=1; i<=NF; i++) { \
		if (i % 2 == 0) { printf "lib/X11/doc/html/%s.html\n", $$i } \
	} }' >> ${TMPPLIST}
.endif
.endif
.endfor
	@${SED} ${PLIST_SUB:S/$/!g/:S/^/ -e s!%%/:S/=/%%!/} ${PLIST} >> ${TMPPLIST}
.if !defined(NO_MTREE)
	@${ECHO_CMD} "@unexec if [ -f %D/info/dir ]; then if sed -e '1,/Menu:/d' %D/info/dir | grep -q '^[*] '; then true; else rm %D/info/dir; fi; fi" >> ${TMPPLIST}
.endif
.if defined(INSTALLS_SHLIB)
	@${ECHO_CMD} "@exec ${LDCONFIG} -m ${LDCONFIG_PLIST}" >> ${TMPPLIST}
	@${ECHO_CMD} "@unexec ${LDCONFIG} -R" >> ${TMPPLIST}
.endif
.if !defined(NO_FILTER_SHLIBS)
.if (${PORTOBJFORMAT} == "aout")
	@${SED} -e 's,\(/lib.*\.so\.[0-9]*\)$$,\1.0,' ${TMPPLIST} > ${TMPPLIST}.tmp
.else
	@${SED} -e 's,\(/lib.*\.so\.[0-9]*\)\.[0-9]*$$,\1,' ${TMPPLIST} > ${TMPPLIST}.tmp
.endif
	@${MV} -f ${TMPPLIST}.tmp ${TMPPLIST}
.endif
.endif

${TMPPLIST}:
	@cd ${.CURDIR} && ${MAKE} ${__softMAKEFLAGS} generate-plist

# Compress (or uncompress) and symlink manpages.
.if !target(compress-man)
compress-man:
.if defined(_MANPAGES) || defined(_MLINKS)
.if ${MANCOMPRESSED} == yes && defined(NOMANCOMPRESS)
	@${ECHO_MSG} "===>   Uncompressing manual pages for ${PKGNAME}"
	@_manpages='${_MANPAGES:S/'/'\''/g}' && [ "$${_manpages}" != "" ] && ( eval ${GUNZIP_CMD} $${_manpages} ) || ${TRUE}
.elif ${MANCOMPRESSED} == no && !defined(NOMANCOMPRESS)
	@${ECHO_MSG} "===>   Compressing manual pages for ${PKGNAME}"
	@_manpages='${_MANPAGES:S/'/'\''/g}' && [ "$${_manpages}" != "" ] && ( eval ${GZIP_CMD} $${_manpages} ) || ${TRUE}
.endif
.if defined(_MLINKS)
	@set ${_MLINKS:S,"",,g:S,//,/,g}; \
	while :; do \
		[ $$# -eq 0 ] && break || ${TRUE}; \
		${RM} -f $${2%.gz}; ${RM} -f $$2.gz; \
		${LN} -fs `${ECHO_CMD} $$1 $$2 | ${AWK} '{ \
					z=split($$1, a, /\//); x=split($$2, b, /\//); \
					while (a[i] == b[i]) i++; \
					for (q=i; q<x; q++) printf "../"; \
					for (; i<z; i++) printf a[i] "/"; printf a[z]; }'` $$2; \
		shift; shift; \
	done
.endif
.else
	@${DO_NADA}
.endif
.endif

# Fake installation of package so that user can pkg_delete it later.
# Also, make sure that an installed port is recognized correctly in
# accordance to the @pkgdep directive in the packing lists

.if !target(fake-pkg)
fake-pkg:
.if !defined(NO_PKG_REGISTER)
	@if [ ! -d ${PKG_DBDIR} ]; then ${RM} -f ${PKG_DBDIR}; ${MKDIR} ${PKG_DBDIR}; fi
	@${RM} -f /tmp/${PKGNAME}-required-by
.if defined(FORCE_PKG_REGISTER)
	@if [ -e ${PKG_DBDIR}/${PKGNAME}/+REQUIRED_BY ]; then \
		${CP} ${PKG_DBDIR}/${PKGNAME}/+REQUIRED_BY /tmp/${PKGNAME}-required-by; \
	fi
	@${RM} -rf ${PKG_DBDIR}/${PKGNAME}
.endif
	@if [ ! -d ${PKG_DBDIR}/${PKGNAME} ]; then \
		${ECHO_MSG} "===>   Registering installation for ${PKGNAME}"; \
		${MKDIR} ${PKG_DBDIR}/${PKGNAME}; \
		${PKG_CMD} ${PKG_ARGS} -O ${PKGFILE} > ${PKG_DBDIR}/${PKGNAME}/+CONTENTS; \
		${CP} ${DESCR} ${PKG_DBDIR}/${PKGNAME}/+DESC; \
		${ECHO_CMD} ${COMMENT:Q} > ${PKG_DBDIR}/${PKGNAME}/+COMMENT; \
		if [ -f ${PKGINSTALL} ]; then \
			${CP} ${PKGINSTALL} ${PKG_DBDIR}/${PKGNAME}/+INSTALL; \
		fi; \
		if [ -f ${PKGDEINSTALL} ]; then \
			${CP} ${PKGDEINSTALL} ${PKG_DBDIR}/${PKGNAME}/+DEINSTALL; \
		fi; \
		if [ -f ${PKGREQ} ]; then \
			${CP} ${PKGREQ} ${PKG_DBDIR}/${PKGNAME}/+REQUIRE; \
		fi; \
		if [ -f ${PKGMESSAGE} ]; then \
			${CP} ${PKGMESSAGE} ${PKG_DBDIR}/${PKGNAME}/+DISPLAY; \
		fi; \
		for dep in `${PKG_INFO} -qf ${PKGNAME} | ${GREP} -w ^@pkgdep | ${AWK} '{print $$2}' | sort -u`; do \
			if [ -d ${PKG_DBDIR}/$$dep -a -z `${ECHO_CMD} $$dep | ${GREP} -E ${PKG_IGNORE_DEPENDS}` ]; then \
				if ! ${GREP} ^${PKGNAME}$$ ${PKG_DBDIR}/$$dep/+REQUIRED_BY \
					>/dev/null 2>&1; then \
					${ECHO_CMD} ${PKGNAME} >> ${PKG_DBDIR}/$$dep/+REQUIRED_BY; \
				fi; \
			fi; \
		done; \
	fi
.if !defined(NO_MTREE)
	@if [ -f ${MTREE_FILE} ]; then \
		${CP} ${MTREE_FILE} ${PKG_DBDIR}/${PKGNAME}/+MTREE_DIRS; \
	fi
.endif
	@if [ -e /tmp/${PKGNAME}-required-by ]; then \
		${CAT} /tmp/${PKGNAME}-required-by >> ${PKG_DBDIR}/${PKGNAME}/+REQUIRED_BY; \
		${RM} -f /tmp/${PKGNAME}-required-by; \
	fi
.else
	@${DO_NADA}
.endif
.endif

# Depend is generally meaningless for arbitrary ports, but if someone wants
# one they can override this.  This is just to catch people who've gotten into
# the habit of typing `make depend all install' as a matter of course.
#
.if !target(depend)
depend:
.endif

# Same goes for tags
.if !target(tags)
tags:
.endif

.if !defined(NOPRECIOUSMAKEVARS)
.for softvar in CKSUMFILES _MLINKS
.if defined(${softvar})
__softMAKEFLAGS+=      '${softvar}+=${${softvar}:S/'/'\''/g}'
.endif
.endfor
# These won't change, so we can pass them through the environment
.MAKEFLAGS: \
	ARCH="${ARCH:S/"/"'"'"/g:S/\$/\$\$/g:S/\\/\\\\/g}" \
	OPSYS="${OPSYS:S/"/"'"'"/g:S/\$/\$\$/g:S/\\/\\\\/g}" \
	OSREL="${OSREL:S/"/"'"'"/g:S/\$/\$\$/g:S/\\/\\\\/g}" \
	OSVERSION="${OSVERSION:S/"/"'"'"/g:S/\$/\$\$/g:S/\\/\\\\/g}" \
	PORTOBJFORMAT="${PORTOBJFORMAT:S/"/"'"'"/g:S/\$/\$\$/g:S/\\/\\\\/g}" \
	SYSTEMVERSION="${SYSTEMVERSION:S/"/"'"'"/g:S/\$/\$\$/g:S/\\/\\\\/g}"
.endif

.endif
# End of post-makefile section.
