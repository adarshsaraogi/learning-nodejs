NODE_HOME ?= /Users/danielbevenius/work/nodejs/node
node_build_dir = $(NODE_HOME)/out/Release
node_include_dir = $(NODE_HOME)/src
node_obj_dir = $(node_build_dir)/obj.target/node/src
v8_build_dir = $(node_build_dir)
v8_include_dir = $(NODE_HOME)/deps/v8/include
cares_include_dir = $(NODE_HOME)/deps/cares/include

gtest_dont_defines = -D GTEST_DONT_DEFINE_ASSERT_EQ        \
		     -D GTEST_DONT_DEFINE_ASSERT_NE        \
		     -D GTEST_DONT_DEFINE_ASSERT_LE        \
		     -D GTEST_DONT_DEFINE_ASSERT_LT        \
		     -D GTEST_DONT_DEFINE_ASSERT_GE        \
		     -D GTEST_DONT_DEFINE_ASSERT_GT

v8_libs = $(v8_build_dir)/libv8_base.a                     \
	  $(v8_build_dir)/libv8_libbase.a                  \
	  $(v8_build_dir)/libv8_snapshot.a                 \
	  $(v8_build_dir)/libv8_libplatform.a              \
	  $(v8_build_dir)/libicuucx.a                      \
	  $(v8_build_dir)/libicui18n.a                     \
	  $(v8_build_dir)/libicudata.a                     \
	  $(v8_build_dir)/libicustubdata.a                 \
	  $(v8_build_dir)/libv8_inspector_stl.a            \
	  $(v8_build_dir)/libuv.a                          \
	  $(v8_build_dir)/libv8_snapshot.a                 \
	  $(v8_build_dir)/libhttp_parser.a                 \
	  $(v8_build_dir)/libopenssl.a                     \
	  $(v8_build_dir)/libcares.a                       \
	  $(v8_build_dir)/libzlib.a                        \
	  $(v8_build_dir)/libv8_libsampler.a

node_obj = $(node_obj_dir)/async-wrap.o                    \
	$(node_obj_dir)/backtrace_posix.o                  \
	$(node_obj_dir)/cares_wrap.o                       \
	$(node_obj_dir)/connection_wrap.o                  \
	$(node_obj_dir)/connect_wrap.o                     \
	$(node_obj_dir)/debug-agent.o                      \
	$(node_obj_dir)/env.o                              \
	$(node_obj_dir)/fs_event_wrap.o                    \
	$(node_obj_dir)/handle_wrap.o                      \
	$(node_obj_dir)/inspector_agent.o                  \
	$(node_obj_dir)/inspector_socket.o                 \
	$(node_obj_dir)/js_stream.o                        \
	$(node_obj_dir)/node.o                             \
	$(node_obj_dir)/node_buffer.o                      \
	$(node_obj_dir)/node_config.o                      \
	$(node_obj_dir)/node_constants.o                   \
	$(node_obj_dir)/node_contextify.o                  \
	$(node_obj_dir)/node_crypto.o                      \
	$(node_obj_dir)/node_crypto_bio.o                  \
	$(node_obj_dir)/node_crypto_clienthello.o          \
	$(node_obj_dir)/node_dtrace.o                      \
	$(node_obj_dir)/node_file.o                        \
	$(node_obj_dir)/node_http_parser.o                 \
	$(node_obj_dir)/node_i18n.o                        \
	$(node_obj_dir)/node_javascript.o                  \
	$(node_obj_dir)/node_os.o                          \
	$(node_obj_dir)/node_revert.o                      \
	$(node_obj_dir)/node_stat_watcher.o                \
	$(node_obj_dir)/node_util.o                        \
	$(node_obj_dir)/node_v8.o                          \
	$(node_obj_dir)/node_watchdog.o                    \
	$(node_obj_dir)/node_zlib.o                        \
	$(node_obj_dir)/pipe_wrap.o                        \
	$(node_obj_dir)/process_wrap.o                     \
	$(node_obj_dir)/signal_wrap.o                      \
	$(node_obj_dir)/spawn_sync.o                       \
	$(node_obj_dir)/stream_base.o                      \
	$(node_obj_dir)/stream_wrap.o                      \
	$(node_obj_dir)/string_bytes.o                     \
	$(node_obj_dir)/string_search.o                    \
	$(node_obj_dir)/tcp_wrap.o                         \
	$(node_obj_dir)/timer_wrap.o                       \
	$(node_obj_dir)/tls_wrap.o                         \
	$(node_obj_dir)/tty_wrap.o                         \
	$(node_obj_dir)/udp_wrap.o                         \
	$(node_obj_dir)/util.o                             \
	$(node_obj_dir)/uv.o

node_defs = -D_DARWIN_USE_64_BIT_INODE=1                   \
	    -DNODE_WANT_INTERNALS=1                        \
	    -DV8_DEPRECATION_WARNINGS=1                    \
	    -DNODE_USE_V8_PLATFORM=1                       \
	    -DNODE_HAVE_I18N_SUPPORT=1                     \
	    -DNODE_HAVE_SMALL_ICU=1                        \
	    -DHAVE_INSPECTOR=1                             \
	    -DV8_INSPECTOR_USE_STL=1                       \
	    -DHAVE_OPENSSL=1                               \
	    -DHAVE_DTRACE=1                                \
	    -D__POSIX__                                    \
	    -DNODE_PLATFORM="darwin"                       \
	    -DUCONFIG_NO_TRANSLITERATION=1                 \
	    -DUCONFIG_NO_SERVICE=1                         \
	    -DUCONFIG_NO_REGULAR_EXPRESSIONS=1             \
	    -DU_ENABLE_DYLOAD=0                            \
	    -DU_STATIC_IMPLEMENTATION=1                    \
	    -DU_HAVE_STD_STRING=0                          \
	    -DUCONFIG_NO_BREAK_ITERATION=0                 \
	    -DUCONFIG_NO_LEGACY_CONVERSION=1               \
	    -DUCONFIG_NO_CONVERSION=1                      \
	    -DHTTP_PARSER_STRICT=0                         \
	    -D_LARGEFILE_SOURCE                            \
	    -D_FILE_OFFSET_BITS=64                         \
	    -DDEBUG                                        \
	    -D_DEBUG 

node_cc = c++ $(gtest_dont_defines)                        \
	  $(node_defs)                                     \
	  -g                                               \
	  -std=gnu++0x                                     \
          -stdlib=libc++                                   \
	  -O0                                              \
	  -gdwarf-2                                        \
	  -mmacosx-version-min=10.7                        \
	  -arch x86_64                                     \
	  -Wall                                            \
	  -Wendif-labels                                   \
	  -W                                               \
	  -Wno-unused-parameter                            \
	  -fno-rtti                                        \
	  -fno-exceptions                                  \
	  -fno-threadsafe-statics                          \
	  -fno-strict-aliasing                             \
	  -I`pwd`/deps/googletest/googletest/include       \
	  -I$(node_include_dir)                            \
	  -I$(cares_include_dir)                           \
	  -I$(v8_include_dir)                              \
	  $(v8_libs)                                       \
	  $(node_obj)                                      \
	  -pthread                                         \
	  lib/libgtest.a test/main.cc

check: test/base-object_test
	./test/base-object_test

test/base-object_test: test/base-object_test.cc
	$ $(node_cc) test/base-object_test.cc -o test/base-object_test

test/environment_test: test/environment_test.cc
	$ $(node_cc) -o test/environment_test

src/import.wasm: src/import.wat
	wat2wasm $< -o $@

.PHONY: clean

clean: 
	rm -rf test/base-object_test
	rm -rf test/environment_test
