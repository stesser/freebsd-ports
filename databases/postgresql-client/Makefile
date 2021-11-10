# Created by: Palle Girgensohn <girgen@FreeBSD.org>

PORTNAME=	postgresql
PORTREVISION=	0

COMMENT=	PostgreSQL database (client)

MASTERDIR=	${.CURDIR}/../postgresql14-server

BUILD_DIRS=	config src/include src/interfaces src/port src/common \
		src/bin/pg_dump src/bin/psql src/bin/scripts src/bin/pg_config \
		src/bin/pgbench doc src/makefiles src/test/regress
INSTALL_DIRS=	${BUILD_DIRS}
PKGNAMESUFFIX=	${COMPONENT}

CLIENT_ONLY=	yes
COMPONENT=	-client
USE_LDCONFIG=	yes
USES=		pkgconfig

CONFLICTS+=	${PORTNAME}9?-client ${PORTNAME}1[^${PORTVERSION:R:C/.*([0-9]$)/\\1/}]-client

.include "${MASTERDIR}/Makefile"
