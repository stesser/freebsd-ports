# Created by: Palle Girgensohn <girgen@FreeBSD.org>

PORTNAME=	postgresql
PORTREVISION=	0

COMMENT=	PostgreSQL database (client)

MASTERDIR=	${.CURDIR}/../postgresql14-server

INSTALL_DIRS=	config src/interfaces src/port src/common \
		src/bin/pg_dump src/bin/psql src/bin/scripts src/bin/pg_config \
		src/bin/pgbench doc src/makefiles src/test/regress
BUILD_DIRS=	src/include ${INSTALL_DIRS}
PKGNAMESUFFIX=	${COMPONENT}

CLIENT_ONLY=	yes
COMPONENT=	-client
USE_LDCONFIG=	yes
USES=		pkgconfig

#PG_SUFFIX=
#PG_INCLUDE_DIR=	include
#PG_LIB_DIR=	lib

CONFLICTS+=	${PORTNAME}9?-client ${PORTNAME}1[^${PORTVERSION:R:C/.*([0-9]$)/\\1/}]-client

.include "${MASTERDIR}/Makefile"
