#!/opt/freeware/bin/bash
echo Building Mariadb
#export CPATH="/opt/freeware/lib/gcc/powerpc-ibm-aix6.1.0.0/4.8.3/include:/opt/freeware/include:/usr/include"
#export LDFLAGS="-Wl,-blibpath:/usr/local/mariadb/lib:/usr/lib:/lib -Wl,-bmaxdata:0x80000000 -Wl,-b64 -Wl,-bexpall,-Wno-attributes -Wl,-bexpfull -Wl,-bnoipath -Wl,-bbigtoc"

export PATH="$PATH"
export OBJECT_MODE=64
export CC="/QOpenSys/xlc/opt/IBM/xlc/13.1.2/bin/xlc_r"
export CFLAGS="-q64 -qsmp -qmaxmem=-1 -qlanglvl=extended:extc89:extc99 -qcpluscmt -DNDEBUG -DSYSV -D_AIX -D_AIX32 -D_AIX41 -D_AIX43 -D_AIX51 -D_AIX52 -D_AIX53 -D_AIX61 -D_AIX71 -D_ALL_SOURCE -DFUNCPROTO=15 -O2 -qnoipa -I/opt/freeware/include -L/opt/freeware/lib64 -L/opt/freeware/lib -bmaxdata:0x80000000 -b64 -blibpath:/usr/local/mariadb/lib:/usr/lib:/lib -bnoipath -bexpall -b64 -ma -w"
export CXX="/QOpenSys/xlcpp/opt/IBM/xlC/13.1.2/bin/xlC_r"
export CXXFLAGS=$CFLAGS
#export LDFLAGS="-L/opt/freeware/lib64 -L/opt/freeware/lib -blibpath:/usr/local/mariadb/dev:/usr/lib:/lib -Wl,-bmaxdata:0x80000000 -Wl,-b64 -Wl,-bexpall -Wl,-bnoipath"

#cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mariadb -DCONNECT_WITH_LIBXML2=OFF -DCMAKE_C_FLAGS="$CFLAGS" -DCMAKE_CXX_FLAGS="$CFLAGS" -DCMAKE_EXE_LINKER_FLAGS="$LDFLAGS" -DCMAKE_SHARED_LINKER_FLAGS="$LDFLAGS" -DCMAKE_C_COMPILER="/opt/IBM/xlC/13.1.0/bin/xlc_r" -DCMAKE_CXX_COMPILER="/opt/IBM/xlC/13.1.0/bin/xlC_r" -DXTRADB_OK=1 -DWITH_SSL=bundled -DWITH_ZLIB=bundled

#gmake


#unset CPATH
#unset LDPATH
cmake . -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_C_COMPILER="/QOpenSys/xlcpp/opt/IBM/xlc/13.1.2/bin/xlc_r" \
    -DCMAKE_CXX_COMPILER="/QOpenSys/xlcpp/opt/IBM/xlC/13.1.2/bin/xlC_r" \
    -DCONNECT_WITH_LIBXML2=OFF \
    -DCMAKE_INSTALL_PREFIX=/usr/local/mariadb \
    -DMYSQL_DATADIR=/usr/local/mariadbdata \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=TRUE \
    -DCMAKE_INSTALL_RPATH=/usr/local/mariadb/lib \
    -DWITH_EMBEDDED_SERVER=OFF \
    -DWITH_UNIT_TESTS=OFF \
    -DINSTALL_MYSQLTESTDIR=mysql-test \
    -DPLUGIN_AUTH_PAM=NO \
    -DPLUGIN_FEEDBACK=DYNAMIC \
    -DPLUGIN_EXAMPLE=AUTO \
    -DPLUGIN_FILE_KEY_MANAGEMENT=NO \
    -DPLUGIN_FTEXAMPLE=DYNAMIC \
    -DPLUGIN_HANDLERSOCKET=DYNAMIC \
    -DPLUGIN_LOCALES=DYNAMIC \
    -DPLUGIN_METADATA_LOCK_INFO=DYNAMIC \
    -DPLUGIN_MYSQL_CLEAR_PASSWORD=DYNAMIC \
    -DPLUGIN_PERFSCHEMA=NO \
    -DPLUGIN_QA_AUTH_CLIENT=DYNAMIC \
    -DPLUGIN_QA_AUTH_INTERFACE=DYNAMIC \
    -DPLUGIN_QA_AUTH_SERVER=DYNAMIC \
    -DPLUGIN_QUERY_CACHE_INFO=DYNAMIC \
    -DPLUGIN_QUERY_RESPONSE_TIME=DYNAMIC \
    -DPLUGIN_SEMISYNC_MASTER=DYNAMIC \
    -DPLUGIN_SEMISYNC_SLAVE=DYNAMIC \
    -DPLUGIN_SEQUENCE=DYNAMIC \
    -DPLUGIN_SERVER_AUDIT=DYNAMIC \
    -DPLUGIN_SIMPLE_PASSWORD_CHECK=DYNAMIC \
    -DPLUGIN_SPHINX=NO \
    -DPLUGIN_SQL_ERRLOG=DYNAMIC \
    -DPLUGIN_TEST_SQL_DISCOVERY=DYNAMIC \
    -DPLUGIN_WSREP_INFO=DYNAMIC \
    -DPLUGIN_XTRADB=STATIC \
    -DDISABLE_SHARED=OFF \
    -DWITH_READLINE=OFF \
    -DCURSES_CURSES_H_PATH=/usr/include \
    -DCURSES_CURSES_LIBRARY=/usr/lib/libcurses.a \
    -DCURSES_EXTRA_LIBRARY=CURSES_EXTRA_LIBRARY-NOTFOUND \
    -DCURSES_FORM_LIBRARY=/usr/lib/libform.a \
    -DCURSES_HAVE_CURSES_H=/usr/include/curses.h \
    -DCURSES_INCLUDE_PATH=/usr/include \
    -DCURSES_LIBRARY=/usr/lib/libcurses.a \
    -DCURSES_NCURSES_LIBRARY=/usr/lib/libncurses.a \
    -DPLUGIN_ARCHIVE=NO \
    -DPLUGIN_AUDIT_NULL=NO \
    -DLUGIN_AUTH_0X0100=NO \
    -DPLUGIN_AUTH_0X0100=NO \
    -DPLUGIN_BLACKHOLE=NO \
    -DPLUGIN_CONNECT=NO \
    -DPLUGIN_DAEMON_EXAMPLE=NO \
    -DPLUGIN_DEBUG_KEY_MANAGEMENT=NO \
    -DPLUGIN_DIALOG=NO \
    -DPLUGIN_DIALOG_EXAMPLES=NO \
    -DPLUGIN_FEDERATED=NO \
    -DPLUGIN_FEEDBACK=NO \
    -DPLUGIN_FTEXAMPLE=NO \
    -DPLUGIN_INNOBASE=NO \
    -DPLUGIN_PARTITION=NO \
    -DPLUGIN_QA_AUTH_CLIENT=NO \
    -DPLUGIN_QA_AUTH_INTERFACE=NO \
    -DPLUGIN_QA_AUTH_SERVER=NO \
    -DPLUGIN_SPIDER=NO



make
make package

echo Adding dependent libraries to archive...
#gzip -d mariadb-10.1.8-os400-powerpc.tar.gz && cp mariadb-10.1.8-os400-powerpc.tar /tmp/mariadb_i5os_install.tar
#Extracting library to temporary directory
cp mariadb-10.1.8-os400-powerpc.tar.gz /tmp
pushd /tmp && rm -rf /tmp/mariadb-10.1.8-os400-powerpc
tar xzf mariadb-10.1.8-os400-powerpc.tar.gz && cp /usr/zlocal/zenddbi/mariadb-libdeps/* mariadb-10.1.8-os400-powerpc/lib
tar -cf mariadb_i5os_install.tar mariadb-10.1.8-os400-powerpc/
echo Packaging mariadb...
system MARIADBPCK
echo Mariadb is packaged at QGPL/ZMYSQL
