#ifndef RCT_CONFIG_H
#define RCT_CONFIG_H

#define HAVE_BACKTRACE
#define HAVE_CLOCK_MONOTONIC_RAW
#define HAVE_CLOCK_MONOTONIC
/* #undef HAVE_MACH_ABSOLUTE_TIME */
#define HAVE_INOTIFY
/* #undef HAVE_KQUEUE */
/* #undef HAVE_CHANGENOTIFICATION */
/* #undef HAVE_PROCESSORINFORMATION */
/* #undef HAVE_CYGWIN */
#define HAVE_EPOLL
/* #undef HAVE_NOSIGPIPE */
#define HAVE_NOSIGNAL
/* #undef HAVE_FSEVENTS */
#define HAVE_STATMTIM
#define HAVE_CLOEXEC
#define HAVE_SCHEDIDLE
#define HAVE_SHMDEST
/* #undef HAVE_SCRIPTENGINE */
/* #undef HAVE_HAVE_STRING_ITERATOR_ERASE */
#if !defined(HAVE_EPOLL) && !defined(HAVE_KQUEUE)
#define HAVE_SELECT
#endif

#endif
