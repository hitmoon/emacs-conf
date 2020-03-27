# Install script for directory: /home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  message("Installing rtags...")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/share/bash-completion/completions/rtags")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/share/bash-completion/completions" TYPE FILE PERMISSIONS OWNER_WRITE OWNER_READ GROUP_READ WORLD_READ RENAME "rtags" FILES "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/rtags-bash-completion.bash")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/share/bash-completion/completions/rc;/usr/local/share/bash-completion/completions/rdm")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/share/bash-completion/completions" TYPE FILE FILES
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/completions/rc"
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/completions/rdm"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xrtagsx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rdm" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rdm")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rdm"
         RPATH "/usr/local/lib:/usr/lib/llvm-9/lib")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/bin/rdm")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rdm" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rdm")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rdm"
         OLD_RPATH "/usr/lib/llvm-9/lib:::::::::::::::"
         NEW_RPATH "/usr/local/lib:/usr/lib/llvm-9/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rdm")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xrtagsx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rc" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rc")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rc"
         RPATH "/usr/local/lib:/usr/lib/llvm-9/lib")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/bin/rc")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rc" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rc")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rc"
         OLD_RPATH "/usr/lib/llvm-9/lib:::::::::::::::"
         NEW_RPATH "/usr/local/lib:/usr/lib/llvm-9/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rc")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xrtagsx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rp" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rp")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rp"
         RPATH "/usr/local/lib:/usr/lib/llvm-9/lib")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/bin/rp")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rp" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rp")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rp"
         OLD_RPATH "/usr/lib/llvm-9/lib:::::::::::::::"
         NEW_RPATH "/usr/local/lib:/usr/lib/llvm-9/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rp")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE FILE PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE FILES "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/../bin/gcc-rtags-wrapper.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/man/man7" TYPE FILE FILES
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/../man/man7/rc.7"
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/../man/man7/rdm.7"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/share/emacs/site-lisp/rtags/rtags.el;/usr/local/share/emacs/site-lisp/rtags/rtags.elc;/usr/local/share/emacs/site-lisp/rtags/ac-rtags.el;/usr/local/share/emacs/site-lisp/rtags/ac-rtags.elc;/usr/local/share/emacs/site-lisp/rtags/helm-rtags.el;/usr/local/share/emacs/site-lisp/rtags/helm-rtags.elc;/usr/local/share/emacs/site-lisp/rtags/ivy-rtags.el;/usr/local/share/emacs/site-lisp/rtags/ivy-rtags.elc;/usr/local/share/emacs/site-lisp/rtags/company-rtags.el;/usr/local/share/emacs/site-lisp/rtags/company-rtags.elc;/usr/local/share/emacs/site-lisp/rtags/flycheck-rtags.el;/usr/local/share/emacs/site-lisp/rtags/flycheck-rtags.elc;/usr/local/share/emacs/site-lisp/rtags/rtags-xref.el;/usr/local/share/emacs/site-lisp/rtags/rtags-xref.elc")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/share/emacs/site-lisp/rtags" TYPE FILE FILES
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/rtags.el"
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/rtags.elc"
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/ac-rtags.el"
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/ac-rtags.elc"
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/helm-rtags.el"
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/helm-rtags.elc"
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/ivy-rtags.el"
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/ivy-rtags.elc"
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/company-rtags.el"
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/company-rtags.elc"
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/flycheck-rtags.el"
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/flycheck-rtags.elc"
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/rtags-xref.el"
    "/home/kevin/.emacs.d/elpa/rtags-20200221.36/rtags-2.38/src/rtags-xref.elc"
    )
endif()

