# - find DCMTK libraries
#
#  DCMTK_INCLUDE_DIR   - Directories to include to use DCMTK
#  DCMTK_LIBRARIES     - Files to link against to use DCMTK
#  DCMTK_FOUND         - If false, don't try to use DCMTK
#  DCMTK_DIR           - (optional) Source directory for DCMTK
#
# DCMTK_DIR can be used to make it simpler to find the various include
# directories and compiled libraries if you've just compiled it in the
# source tree. Just set it to the root of the tree where you extracted
# the source.
#
# Written for VXL by Amitha Perera.
#

set(DCMTK_DIR
	""
	CACHE
	PATH
	"Set this to the root of the installed dcmtk files to find include files and libraries.")
mark_as_advanced(DCMTK_DIR)

get_filename_component(module_file_path ${CMAKE_CURRENT_LIST_FILE} PATH)

if(MSVC)
	set(DCMTK_LIBRARY_POSTFIX "_vc7")

	if(MSVC80)
		set(DCMTK_LIBRARY_POSTFIX "_vc8")
	elseif(MSVC90)
		set(DCMTK_LIBRARY_POSTFIX "_vc9")
	elseif(MSVC10)
		set(DCMTK_LIBRARY_POSTFIX "_vc10")
	endif()
endif()

if(CMAKE_CL_64)
	set(LIB "lib64")
else()
	set(LIB "lib32")
endif()

if(NOT WIN32)
	set(DCMTK_HAVE_CONFIG_H
		"NO"
		CACHE
		BOOL
		"On some systems the compile flag -DHAVE_CONFIG_H needs to be defined because of DCMTK. If DCMTK headers are causing problem turn this flag on.")
	if(DCMTK_HAVE_CONFIG_H)
		set(CMAKE_CXX_FLAGS "-DHAVE_CONFIG_H")
	endif()
endif()

find_path(DCMTK_config_INCLUDE_DIR
	NAMES
	dcmtk/config/osconfig.h
	PATHS
	${DCMTK_DIR}/config/include
	${DCMTK_DIR}/include
	$ENV{H3D_EXTERNAL_ROOT}/include
	$ENV{H3D_ROOT}/../External/include
	../../External/include
	${module_file_path}/../../../External/include
	${module_file_path}/../../dcmtk/include
	/usr/local/dicom/include
	DOC
	"Path in which the file dcmtk/config/osconfig.h is located.")
mark_as_advanced(DCMTK_config_INCLUDE_DIR)

find_path(DCMTK_ofstd_INCLUDE_DIR
	NAMES
	dcmtk/ofstd/ofstdinc.h
	PATHS
	${DCMTK_DIR}/ofstd/include
	${DCMTK_DIR}/include/ofstd
	${DCMTK_DIR}/include
	$ENV{H3D_EXTERNAL_ROOT}/include
	$ENV{H3D_ROOT}/../External/include
	../../External/include
	${module_file_path}/../../../External/include
	${module_file_path}/../../dcmtk/include
	/usr/local/dicom/include
	DOC
	"Path in which the file dcmtk/ofstd/ofstdinc.h is located.")
mark_as_advanced(DCMTK_ofstd_INCLUDE_DIR)

find_library(DCMTK_ofstd_LIBRARY
	"ofstd${DCMTK_LIBRARY_POSTFIX}"
	PATHS
	${DCMTK_DIR}/ofstd/libsrc
	${DCMTK_DIR}/ofstd/libsrc/Release
	${DCMTK_DIR}/ofstd/libsrc/Debug
	${DCMTK_DIR}/ofstd/Release
	${DCMTK_DIR}/ofstd/Debug
	${DCMTK_DIR}/lib
	$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
	$ENV{H3D_ROOT}/../External/${LIB}/static
	../../External/${LIB}/static
	${module_file_path}/../../../External/${LIB}/static
	${module_file_path}/../../dcmtk/lib
	/usr/local/dicom/lib
	DOC
	"Path to ofstd${DCMTK_LIBRARY_POSTFIX} library.")
mark_as_advanced(DCMTK_ofstd_LIBRARY)

find_path(DCMTK_dcmjpeg_INCLUDE_DIR
	NAMES
	dcmtk/dcmjpeg/djdecode.h
	PATHS
	${DCMTK_DIR}/dcmjpeg/include
	${DCMTK_DIR}/include/dcmjpeg
	${DCMTK_DIR}/include
	$ENV{H3D_EXTERNAL_ROOT}/include
	$ENV{H3D_ROOT}/../External/include
	../../External/include
	${module_file_path}/../../../External/include
	${module_file_path}/../../dcmtk/include
	/usr/local/dicom/include
	DOC
	"Path in which the file dcmtk/dcmjpeg/djdecode.h is located.")
mark_as_advanced(DCMTK_dcmjpeg_INCLUDE_DIR)

find_library(DCMTK_dcmjpeg_LIBRARY
	dcmjpeg${DCMTK_LIBRARY_POSTFIX}
	PATHS
	${DCMTK_DIR}/dcmjpeg/libsrc
	${DCMTK_DIR}/dcmjpeg/libsrc/Release
	${DCMTK_DIR}/dcmjpeg/libsrc/Debug
	${DCMTK_DIR}/dcmjpeg/Release
	${DCMTK_DIR}/dcmjpeg/Debug
	${DCMTK_DIR}/lib
	$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
	$ENV{H3D_ROOT}/../External/${LIB}/static
	../../External/${LIB}/static
	${module_file_path}/../../../External/${LIB}/static
	${module_file_path}/../../dcmtk/lib
	/usr/local/dicom/lib
	DOC
	"Path to dcmjpeg${DCMTK_LIBRARY_POSTFIX} library.")
mark_as_advanced(DCMTK_dcmjpeg_LIBRARY)


find_library(DCMTK_ijg8_LIBRARY
	ijg8${DCMTK_LIBRARY_POSTFIX}
	PATHS
	${DCMTK_DIR}/dcmjpeg/libijg8/libsrc
	${DCMTK_DIR}/dcmjpeg/libijg8/libsrc/Release
	${DCMTK_DIR}/dcmjpeg/libijg8/libsrc/Debug
	${DCMTK_DIR}/dcmjpeg/libijg8/Release
	${DCMTK_DIR}/dcmjpeg/libijg8/Debug
	${DCMTK_DIR}/lib
	$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
	$ENV{H3D_ROOT}/../External/${LIB}/static
	../../External/${LIB}/static
	${module_file_path}/../../../External/${LIB}/static
	${module_file_path}/../../dcmtk/lib
	/usr/local/dicom/lib
	DOC
	"Path to ijg8${DCMTK_LIBRARY_POSTFIX} library.")
mark_as_advanced(DCMTK_ijg8_LIBRARY)

find_library(DCMTK_ijg12_LIBRARY
	ijg12${DCMTK_LIBRARY_POSTFIX}
	PATHS
	${DCMTK_DIR}/dcmjpeg/libijg12/libsrc
	${DCMTK_DIR}/dcmjpeg/libijg12/libsrc/Release
	${DCMTK_DIR}/dcmjpeg/libijg12/libsrc/Debug
	${DCMTK_DIR}/dcmjpeg/libijg12/Release
	${DCMTK_DIR}/dcmjpeg/libijg12/Debug
	${DCMTK_DIR}/lib
	$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
	$ENV{H3D_ROOT}/../External/${LIB}/static
	../../External/${LIB}/static
	${module_file_path}/../../../External/${LIB}/static
	${module_file_path}/../../dcmtk/lib
	/usr/local/dicom/lib
	DOC
	"Path to ijg12${DCMTK_LIBRARY_POSTFIX} library.")
mark_as_advanced(DCMTK_ijg12_LIBRARY)

find_library(DCMTK_ijg16_LIBRARY
	ijg16${DCMTK_LIBRARY_POSTFIX}
	PATHS
	${DCMTK_DIR}/dcmjpeg/libijg16/libsrc
	${DCMTK_DIR}/dcmjpeg/libijg16/libsrc/Release
	${DCMTK_DIR}/dcmjpeg/libijg16/libsrc/Debug
	${DCMTK_DIR}/dcmjpeg/libijg16/Release
	${DCMTK_DIR}/dcmjpeg/libijg16/Debug
	${DCMTK_DIR}/lib
	$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
	$ENV{H3D_ROOT}/../External/${LIB}/static
	../../External/${LIB}/static
	${module_file_path}/../../../External/${LIB}/static
	${module_file_path}/../../dcmtk/lib
	/usr/local/dicom/lib
	DOC
	"Path to ijg16${DCMTK_LIBRARY_POSTFIX} library.")
mark_as_advanced(DCMTK_ijg16_LIBRARY)

find_path(DCMTK_dcmdata_INCLUDE_DIR
	dcmtk/dcmdata/dctypes.h
	PATHS
	${DCMTK_DIR}/dcmdata/include
	${DCMTK_DIR}/include/dcmdata
	${DCMTK_DIR}/include
	$ENV{H3D_EXTERNAL_ROOT}/include
	$ENV{H3D_ROOT}/../External/include
	../../External/include
	${module_file_path}/../../../External/include
	${module_file_path}/../../dcmtk/include
	/usr/local/dicom/include
	DOC
	"Path in which the file dcmtk/dcmdata/dctypes.h is located.")
mark_as_advanced(DCMTK_dcmdata_INCLUDE_DIR)

find_library(DCMTK_dcmdata_LIBRARY
	dcmdata${DCMTK_LIBRARY_POSTFIX}
	PATHS
	${DCMTK_DIR}/dcmdata/libsrc
	${DCMTK_DIR}/dcmdata/libsrc/Release
	${DCMTK_DIR}/dcmdata/libsrc/Debug
	${DCMTK_DIR}/dcmdata/Release
	${DCMTK_DIR}/dcmdata/Debug
	${DCMTK_DIR}/lib
	$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
	$ENV{H3D_ROOT}/../External/${LIB}/static
	../../External/${LIB}/static
	${module_file_path}/../../../External/${LIB}/static
	${module_file_path}/../../dcmtk/lib
	/usr/local/dicom/lib
	DOC
	"Path to dcmdata${DCMTK_LIBRARY_POSTFIX} library.")
mark_as_advanced(DCMTK_dcmdata_LIBRARY)


find_path(DCMTK_dcmimgle_INCLUDE_DIR
	dcmtk/dcmimgle/dcmimage.h
	PATHS
	${DCMTK_DIR}/dcmimgle/include
	${DCMTK_DIR}/include/dcmimgle
	${DCMTK_DIR}/include
	$ENV{H3D_EXTERNAL_ROOT}/include
	$ENV{H3D_ROOT}/../External/include
	../../External/include
	${module_file_path}/../../../External/include
	${module_file_path}/../../dcmtk/include
	/usr/local/dicom/include
	DOC
	"Path in which the file dcmtk/dcmimgle/dcmimage.h is located.")
mark_as_advanced(DCMTK_dcmimgle_INCLUDE_DIR)

find_library(DCMTK_dcmimgle_LIBRARY
	dcmimgle${DCMTK_LIBRARY_POSTFIX}
	PATHS
	${DCMTK_DIR}/dcmimgle/libsrc
	${DCMTK_DIR}/dcmimgle/libsrc/Release
	${DCMTK_DIR}/dcmimgle/libsrc/Debug
	${DCMTK_DIR}/dcmimgle/Release
	${DCMTK_DIR}/dcmimgle/Debug
	${DCMTK_DIR}/lib
	$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
	$ENV{H3D_ROOT}/../External/${LIB}/static
	../../External/${LIB}/static
	${module_file_path}/../../../External/${LIB}/static
	${module_file_path}/../../dcmtk/lib
	/usr/local/dicom/lib
	DOC
	"Path to dcmimgle${DCMTK_LIBRARY_POSTFIX} library.")
mark_as_advanced(DCMTK_dcmimgle_LIBRARY)

find_library(DCMTK_dcmimage_LIBRARY
	dcmimage${DCMTK_LIBRARY_POSTFIX}
	PATHS
	${DCMTK_DIR}/dcmimage/libsrc
	${DCMTK_DIR}/dcmimage/libsrc/Release
	${DCMTK_DIR}/dcmimage/libsrc/Debug
	${DCMTK_DIR}/dcmimage/Release
	${DCMTK_DIR}/dcmimage/Debug
	${DCMTK_DIR}/lib
	$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
	$ENV{H3D_ROOT}/../External/${LIB}/static
	../../External/${LIB}/static
	${module_file_path}/../../../External/${LIB}/static
	${module_file_path}/../../dcmtk/lib
	/usr/local/dicom/lib
	DOC
	"Path to dcmimage${DCMTK_LIBRARY_POSTFIX} library.")
mark_as_advanced(DCMTK_dcmimage_LIBRARY)

if(MSVC10)
	# Visual Studio 2010 needs debug versions to compile in debug
	find_library(DCMTK_ofstd_DEBUG_LIBRARY
		"ofstd${DCMTK_LIBRARY_POSTFIX}_d"
		PATHS
		${DCMTK_DIR}/ofstd/libsrc
		${DCMTK_DIR}/ofstd/libsrc/Release
		${DCMTK_DIR}/ofstd/libsrc/Debug
		${DCMTK_DIR}/ofstd/Release
		${DCMTK_DIR}/ofstd/Debug
		${DCMTK_DIR}/lib
		$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
		$ENV{H3D_ROOT}/../External/${LIB}/static
		../../External/${LIB}/static
		${module_file_path}/../../../External/${LIB}/static
		${module_file_path}/../../dcmtk/lib
		/usr/local/dicom/lib
		DOC
		"Path to ofstd${DCMTK_LIBRARY_POSTFIX}_d library.")
	mark_as_advanced(DCMTK_ofstd_DEBUG_LIBRARY)

	find_library(DCMTK_dcmjpeg_DEBUG_LIBRARY
		dcmjpeg${DCMTK_LIBRARY_POSTFIX}_d
		PATHS
		${DCMTK_DIR}/dcmjpeg/libsrc
		${DCMTK_DIR}/dcmjpeg/libsrc/Release
		${DCMTK_DIR}/dcmjpeg/libsrc/Debug
		${DCMTK_DIR}/dcmjpeg/Release
		${DCMTK_DIR}/dcmjpeg/Debug
		${DCMTK_DIR}/lib
		$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
		$ENV{H3D_ROOT}/../External/${LIB}/static
		../../External/${LIB}/static
		${module_file_path}/../../../External/${LIB}/static
		${module_file_path}/../../dcmtk/lib
		/usr/local/dicom/lib
		DOC
		"Path to dcmjpeg${DCMTK_LIBRARY_POSTFIX}_d library.")
	mark_as_advanced(DCMTK_dcmjpeg_DEBUG_LIBRARY)


	find_library(DCMTK_ijg8_DEBUG_LIBRARY
		ijg8${DCMTK_LIBRARY_POSTFIX}_d
		PATHS
		${DCMTK_DIR}/dcmjpeg/libijg8/libsrc
		${DCMTK_DIR}/dcmjpeg/libijg8/libsrc/Release
		${DCMTK_DIR}/dcmjpeg/libijg8/libsrc/Debug
		${DCMTK_DIR}/dcmjpeg/libijg8/Release
		${DCMTK_DIR}/dcmjpeg/libijg8/Debug
		${DCMTK_DIR}/lib
		$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
		$ENV{H3D_ROOT}/../External/${LIB}/static
		../../External/${LIB}/static
		${module_file_path}/../../../External/${LIB}/static
		${module_file_path}/../../dcmtk/lib
		/usr/local/dicom/lib
		DOC
		"Path to ijg8${DCMTK_LIBRARY_POSTFIX}_d library.")
	mark_as_advanced(DCMTK_ijg8_DEBUG_LIBRARY)

	find_library(DCMTK_ijg12_DEBUG_LIBRARY
		ijg12${DCMTK_LIBRARY_POSTFIX}_d
		PATHS
		${DCMTK_DIR}/dcmjpeg/libijg12/libsrc
		${DCMTK_DIR}/dcmjpeg/libijg12/libsrc/Release
		${DCMTK_DIR}/dcmjpeg/libijg12/libsrc/Debug
		${DCMTK_DIR}/dcmjpeg/libijg12/Release
		${DCMTK_DIR}/dcmjpeg/libijg12/Debug
		${DCMTK_DIR}/lib
		$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
		$ENV{H3D_ROOT}/../External/${LIB}/static
		../../External/${LIB}/static
		${module_file_path}/../../../External/${LIB}/static
		${module_file_path}/../../dcmtk/lib
		/usr/local/dicom/lib
		DOC
		"Path to ijg12${DCMTK_LIBRARY_POSTFIX}_d library.")
	mark_as_advanced(DCMTK_ijg12_DEBUG_LIBRARY)

	find_library(DCMTK_ijg16_DEBUG_LIBRARY
		ijg16${DCMTK_LIBRARY_POSTFIX}_d
		PATHS
		${DCMTK_DIR}/dcmjpeg/libijg16/libsrc
		${DCMTK_DIR}/dcmjpeg/libijg16/libsrc/Release
		${DCMTK_DIR}/dcmjpeg/libijg16/libsrc/Debug
		${DCMTK_DIR}/dcmjpeg/libijg16/Release
		${DCMTK_DIR}/dcmjpeg/libijg16/Debug
		${DCMTK_DIR}/lib
		$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
		$ENV{H3D_ROOT}/../External/${LIB}/static
		../../External/${LIB}/static
		${module_file_path}/../../../External/${LIB}/static
		${module_file_path}/../../dcmtk/lib
		/usr/local/dicom/lib
		DOC
		"Path to ijg16${DCMTK_LIBRARY_POSTFIX}_d library.")
	mark_as_advanced(DCMTK_ijg16_DEBUG_LIBRARY)

	find_library(DCMTK_dcmdata_DEBUG_LIBRARY
		dcmdata${DCMTK_LIBRARY_POSTFIX}_d
		PATHS
		${DCMTK_DIR}/dcmdata/libsrc
		${DCMTK_DIR}/dcmdata/libsrc/Release
		${DCMTK_DIR}/dcmdata/libsrc/Debug
		${DCMTK_DIR}/dcmdata/Release
		${DCMTK_DIR}/dcmdata/Debug
		${DCMTK_DIR}/lib
		$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
		$ENV{H3D_ROOT}/../External/${LIB}/static
		../../External/${LIB}/static
		${module_file_path}/../../../External/${LIB}/static
		${module_file_path}/../../dcmtk/lib
		/usr/local/dicom/lib
		DOC
		"Path to dcmdata${DCMTK_LIBRARY_POSTFIX}_d library.")
	mark_as_advanced(DCMTK_dcmdata_DEBUG_LIBRARY)

	find_library(DCMTK_dcmimgle_DEBUG_LIBRARY
		dcmimgle${DCMTK_LIBRARY_POSTFIX}_d
		PATHS
		${DCMTK_DIR}/dcmimgle/libsrc
		${DCMTK_DIR}/dcmimgle/libsrc/Release
		${DCMTK_DIR}/dcmimgle/libsrc/Debug
		${DCMTK_DIR}/dcmimgle/Release
		${DCMTK_DIR}/dcmimgle/Debug
		${DCMTK_DIR}/lib
		$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
		$ENV{H3D_ROOT}/../External/${LIB}/static
		../../External/${LIB}/static
		${module_file_path}/../../../External/${LIB}/static
		${module_file_path}/../../dcmtk/lib
		/usr/local/dicom/lib
		DOC
		"Path to dcmimgle${DCMTK_LIBRARY_POSTFIX}_d library.")
	mark_as_advanced(DCMTK_dcmimgle_DEBUG_LIBRARY)

	find_library(DCMTK_dcmimage_DEBUG_LIBRARY
		dcmimage${DCMTK_LIBRARY_POSTFIX}_d
		PATHS
		${DCMTK_DIR}/dcmimage/libsrc
		${DCMTK_DIR}/dcmimage/libsrc/Release
		${DCMTK_DIR}/dcmimage/libsrc/Debug
		${DCMTK_DIR}/dcmimage/Release
		${DCMTK_DIR}/dcmimage/Debug
		${DCMTK_DIR}/lib
		$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
		$ENV{H3D_ROOT}/../External/${LIB}/static
		../../External/${LIB}/static
		${module_file_path}/../../../External/${LIB}/static
		${module_file_path}/../../dcmtk/lib
		/usr/local/dicom/lib
		DOC
		"Path to dcmimage${DCMTK_LIBRARY_POSTFIX}_d library.")
	mark_as_advanced(DCMTK_dcmimage_DEBUG_LIBRARY)
endif()


#FIND_LIBRARY(DCMTK_dcmnet_LIBRARY dcmnet${DCMTK_LIBRARY_POSTFIX}
#${DCMTK_DIR}/dcmnet/libsrc/Release
#${DCMTK_DIR}/dcmnet/libsrc/Debug
#${DCMTK_DIR}/dcmnet/libsrc/
#$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
#$ENV{H3D_ROOT}/../External/${LIB}/static
#../../External/${LIB}/static
#${module_file_path}/../../../External/${LIB}/static
#)


set(HAVE_INCLUDE_DIRS "FALSE")
set(HAVE_RELEASE_LIBS "FALSE")
set(HAVE_DEBUG_LIBS "FALSE")

# check that we have all include dirs
if(DCMTK_config_INCLUDE_DIR
	AND
	DCMTK_ofstd_INCLUDE_DIR
	AND
	DCMTK_dcmdata_INCLUDE_DIR
	AND
	DCMTK_dcmimgle_INCLUDE_DIR
	AND
	DCMTK_dcmjpeg_INCLUDE_DIR)
	set(HAVE_INCLUDE_DIRS "TRUE")
endif()

# check that we have all release libs
if(DCMTK_ofstd_LIBRARY
	AND
	DCMTK_dcmdata_LIBRARY
	AND
	DCMTK_dcmimgle_LIBRARY
	AND
	DCMTK_dcmimage_LIBRARY
	AND
	DCMTK_dcmjpeg_LIBRARY)
	set(HAVE_RELEASE_LIBS "TRUE")
endif()

# check if we have the debug libs
if(DCMTK_ofstd_DEBUG_LIBRARY
	AND
	DCMTK_dcmdata_DEBUG_LIBRARY
	AND
	DCMTK_dcmimgle_DEBUG_LIBRARY
	AND
	DCMTK_dcmimage_DEBUG_LIBRARY
	AND
	DCMTK_dcmjpeg_DEBUG_LIBRARY)
	set(HAVE_DEBUG_LIBS "TRUE")
endif()
if(HAVE_INCLUDE_DIRS AND HAVE_RELEASE_LIBS)
	set(DCMTK_FOUND "YES")
	set(DCMTK_INCLUDE_DIR
		${DCMTK_config_INCLUDE_DIR}
		${DCMTK_ofstd_INCLUDE_DIR}
		${DCMTK_dcmdata_INCLUDE_DIR}
		${DCMTK_dcmimgle_INCLUDE_DIR}
		${DCMTK_dcmjpeg_INCLUDE_DIR})

	if(MSVC10 AND HAVE_DEBUG_LIBS)
		# MSVC10 needs debug libraries since it cannot compile with
		# the release versions
		set(DCMTK_LIBRARIES
			optimized
			${DCMTK_dcmimgle_LIBRARY}
			optimized
			${DCMTK_dcmdata_LIBRARY}
			optimized
			${DCMTK_ofstd_LIBRARY}
			optimized
			${DCMTK_dcmimage_LIBRARY}
			optimized
			${DCMTK_dcmjpeg_LIBRARY}
			optimized
			${DCMTK_ijg8_LIBRARY}
			optimized
			${DCMTK_ijg12_LIBRARY}
			optimized
			${DCMTK_ijg16_LIBRARY})

		set(DCMTK_LIBRARIES
			${DCMTK_LIBRARIES}
			debug
			${DCMTK_dcmimgle_DEBUG_LIBRARY}
			debug
			${DCMTK_dcmdata_DEBUG_LIBRARY}
			debug
			${DCMTK_ofstd_DEBUG_LIBRARY}
			debug
			${DCMTK_dcmimage_DEBUG_LIBRARY}
			debug
			${DCMTK_dcmjpeg_DEBUG_LIBRARY}
			debug
			${DCMTK_ijg8_DEBUG_LIBRARY}
			debug
			${DCMTK_ijg12_DEBUG_LIBRARY}
			debug
			${DCMTK_ijg16_DEBUG_LIBRARY})

	else()

		if(MSVC10)
			message(STATUS
				"DCMTK debug libraries not found. Debug compilation might not work with DCMTK.")
		endif()


		set(DCMTK_LIBRARIES
			${DCMTK_dcmimgle_LIBRARY}
			${DCMTK_dcmdata_LIBRARY}
			${DCMTK_ofstd_LIBRARY}
			${DCMTK_dcmimage_LIBRARY}
			${DCMTK_dcmjpeg_LIBRARY}
			${DCMTK_ijg8_LIBRARY}
			${DCMTK_ijg12_LIBRARY}
			${DCMTK_ijg16_LIBRARY})
	endif()

	if(DCMTK_imagedb_LIBRARY)
		set(DCMTK_LIBRARIES ${DCMTK_LIBRARIES} ${DCMTK_imagedb_LIBRARY})
	endif()

	if(DCMTK_dcmnet_LIBRARY)
		set(DCMTK_LIBRARIES ${DCMTK_LIBRARIES} ${DCMTK_dcmnet_LIBRARY})
	endif()

	if(WIN32)
		set(DCMTK_LIBRARIES ${DCMTK_LIBRARIES} netapi32 ws2_32)
	endif()

endif()

# Report the results.
if(NOT DCMTK_FOUND)
	set(DCMTK_DIR_MESSAGE
		"DCMTK was not found. Make sure all cmake variables with prefix DCMTK_ set, see each one for description.")
	if(DCMTK_FIND_REQUIRED)
		set(DCMTK_DIR_MESSAGE
			"${DCMTK_DIR_MESSAGE} You need the Dicom Toolkit libraries and headers to compile.")
		message(FATAL_ERROR "${DCMTK_DIR_MESSAGE}")
	elseif(NOT DCMTK_FIND_QUIETLY)
		set(DCMTK_DIR_MESSAGE
			"${DCMTK_DIR_MESSAGE} If you do not have the Dicom Toolkit libraries and headers you will not be able to load dicom images.")
		message(STATUS "${DCMTK_DIR_MESSAGE}")
	endif()
endif()

