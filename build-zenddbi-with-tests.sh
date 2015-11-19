echo Building Mariadb
#pushd ~/server
export LDFLAGS="-Wl,-blibpath:/usr/local/mariadb/lib:/usr/lib:/lib -Wl,-bmaxdata:0x80000000 -Wl,-bexpall -Wl,-bexpfull -Wl,-bnoipath -Wl,-bbigtoc"
export M4=/usr/local/bin/m4
#Use perzl binaries where available
echo $PATH |grep freeware || export PATH=/opt/freeware/bin:$PATH
cmake . -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_CXX_FLAGS_DEBUG="-O0 -g -mminimal-toc -mcpu=power7 -Wno-attributes" \
    -DCMAKE_C_FLAGS_DEBUG="-O0 -g -mminimal-toc -mcpu=power7 -Wno-attributes" \
    -DCMAKE_EXE_LINKER_FLAGS_DEBUG="-Wl,-blibpath:/usr/local/mariadb/lib:/usr/lib:/lib -Wl,-bmaxdata:0x80000000 -Wl,-bexpfull -Wl,-bnoipath -Wl,-bbigtoc" \
    -DCMAKE_MODULE_LINKER_FLAGS_DEBUG="-Wl,-blibpath:/usr/local/mariadb/lib:/usr/lib:/lib -Wl,-bmaxdata:0x80000000 -Wl,-bexpfull -Wl,-bnoipath -Wl,-bbigtoc" \
    -DCMAKE_SHARED_LINKER_FLAGS_DEBUG="-Wl,-blibpath:/usr/local/mariadb/lib:/usr/lib:/lib -Wl,-bmaxdata:0x80000000 -Wl,-bexpfull -Wl,-bnoipath -Wl,-bbigtoc" \
    -DCMAKE_INSTALL_PREFIX=/usr/local/mariadb \
    -DMYSQL_DATADIR=/usr/local/mariadbdata \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=TRUE \
    -DCMAKE_INSTALL_RPATH=/usr/local/mariadb/lib \
    -DWITH_EMBEDDED_SERVER=OFF \
    -DWITH_UNIT_TESTS=OFF \
    -DINSTALL_MYSQLTESTDIR=mysql-test \
    -DPLUGIN_FEEDBACK=DYNAMIC \
    -DPLUGIN_EXAMPLE=AUTO \
    -DPLUGIN_FILE_KEY_MANAGEMENT=NO \
    -DPLUGIN_FTEXAMPLE=DYNAMIC \
    -DPLUGIN_HANDLERSOCKET=DYNAMIC \
    -DPLUGIN_LOCALES=DYNAMIC \
    -DPLUGIN_METADATA_LOCK_INFO=DYNAMIC \
    -DPLUGIN_MYSQL_CLEAR_PASSWORD=DYNAMIC \
    -DPLUGIN_PERFSCHEMA=AUTO \
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
    -DPLUGIN_SPIDER=NO \
    -DPLUGIN_XTRADB=STATIC \
    -DPLUGIN_CONNECT=NO \
    -DPLUGIN_AUTH_PAM=NO \
    -DDISABLE_SHARED=OFF \
    -DPLUGIN_FEDERATED=NO \
    -DWITH_READLINE=OFF \
    -DCURSES_CURSES_H_PATH=/usr/include \
    -DCURSES_CURSES_LIBRARY=/usr/lib/libcurses.a \
    -DCURSES_EXTRA_LIBRARY=CURSES_EXTRA_LIBRARY-NOTFOUND \
    -DCURSES_FORM_LIBRARY=/usr/lib/libform.a \
    -DCURSES_HAVE_CURSES_H=/usr/include/curses.h \
    -DCURSES_INCLUDE_PATH=/usr/include \
    -DCURSES_LIBRARY=/usr/lib/libcurses.a \
    -DCURSES_NCURSES_LIBRARY=/usr/lib/libncurses.a
    #-DCURSES_NCURSES_LIBRARY= \
    #-DREADLINE_INCLUDE_DIR= \
    #-DREADLINE_LIBRARY= \
    # // Path to a file.
    #    -DCURSES_CURSES_H_PATH= \
    #-DCURSES_CURSES_LIBRARY= \
    #-DCURSES_EXTRA_LIBRARY=CURSES_EXTRA_LIBRARY-NOTFOUND \
    #-DCURSES_FORM_LIBRARY= \
    #-DCURSES_HAVE_CURSES_H= \
    #-DCURSES_INCLUDE_PATH= \
    #-DCURSES_LIBRARY= \

    # READLINE_INCLUDE_DIR:PATH=/usr/include/readline
    #
    # // Path to a library.
    # READLINE_LIBRARY:FILEPATH=/usr/lib/libreadline.a
    #
    # CURSES_CURSES_H_PATH:PATH=/usr/include
    #
    # // Path to a library.
    # CURSES_CURSES_LIBRARY:FILEPATH=/usr/lib/libcurses.a
    #
    # // Path to a library.
    # CURSES_EXTRA_LIBRARY:FILEPATH=CURSES_EXTRA_LIBRARY-NOTFOUND
    #
    # // Path to a library.
    # CURSES_FORM_LIBRARY:FILEPATH=/usr/lib/libform.a
    #
    # // Path to a file.
    # CURSES_HAVE_CURSES_H:FILEPATH=/usr/include/curses.h
    #
    # // The curses include path
    # CURSES_INCLUDE_PATH:FILEPATH=/usr/include
    #
    # // The curses library
    # CURSES_LIBRARY:FILEPATH=/usr/lib/libcurses.a
    #
    # // Path to a library.
    # CURSES_NCURSES_LIBRARY:FILEPATH=/usr/lib/libncurses.a
    #
    #


make
make package

echo Adding dependent libraries to archive...
#gzip -d mariadb-10.1.9-os400-powerpc.tar.gz && cp mariadb-10.1.9-os400-powerpc.tar /tmp/mariadb_i5os_install.tar
#Extracting library to temporary directory
cp mariadb-10.1.9-os400-powerpc.tar.gz /tmp
pushd /tmp && rm -rf /tmp/mariadb-10.1.9-os400-powerpc
tar xzf mariadb-10.1.9-os400-powerpc.tar.gz && cp /usr/zlocal/zenddbi/mariadb-libdeps/* mariadb-10.1.9-os400-powerpc/lib
tar -cf mariadb_i5os_install.tar mariadb-10.1.9-os400-powerpc/
echo Packaging mariadb...
system MARIADBPCK
echo Mariadb is packaged at QGPL/ZMYSQL
