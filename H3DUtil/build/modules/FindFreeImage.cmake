# - Find FREEIMAGE
# Find the native FREEIMAGE headers and libraries.
#
#  FREEIMAGE_INCLUDE_DIR -  where to find FREEIMAGE.h, etc.
#  FREEIMAGE_LIBRARIES    - List of libraries when using FREEIMAGE.
#  FREEIMAGE_FOUND        - True if FREEIMAGE found.

get_filename_component(module_file_path ${CMAKE_CURRENT_LIST_FILE} PATH)

if(CMAKE_CL_64)
	set(LIB "lib64")
else()
	set(LIB "lib32")
endif()

# Look for the header file.
find_path(FREEIMAGE_INCLUDE_DIR
	NAMES
	FreeImage.h
	PATHS
	$ENV{H3D_EXTERNAL_ROOT}/include
	$ENV{H3D_EXTERNAL_ROOT}/include/FreeImage/Dist
	$ENV{H3D_ROOT}/../External/include
	$ENV{H3D_ROOT}/../External/include/FreeImage/Dist
	../../External/include
	../../External/include/FreeImage/Dist
	${module_file_path}/../../../External/include
	${module_file_path}/../../../External/include/FreeImage/Dist
	DOC
	"Path in which the file FreeImage.h is located.")

mark_as_advanced(FREEIMAGE_INCLUDE_DIR)

# Look for the library.
find_library(FREEIMAGE_LIBRARY
	NAMES
	freeimage
	PATHS
	$ENV{H3D_EXTERNAL_ROOT}/${LIB}
	$ENV{H3D_ROOT}/../External/${LIB}
	../../External/${LIB}
	${module_file_path}/../../../External/${LIB}
	DOC
	"Path to freeimage library.")
mark_as_advanced(FREEIMAGE_LIBRARY)

if(WIN32 AND PREFER_STATIC_LIBRARIES)
	set(FREEIMAGE_STATIC_LIBRARY_NAME FreeImage_vc7)

	if(MSVC80)
		set(FREEIMAGE_STATIC_LIBRARY_NAME FreeImage_vc8)
	elseif(MSVC90)
		set(FREEIMAGE_STATIC_LIBRARY_NAME FreeImage_vc9)
	elseif(MSVC10)
		set(FREEIMAGE_STATIC_LIBRARY_NAME FreeImage_vc10)
	endif()

	find_library(FREEIMAGE_STATIC_LIBRARY
		NAMES
		${FREEIMAGE_STATIC_LIBRARY_NAME}
		PATHS
		$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
		$ENV{H3D_ROOT}/../External/${LIB}/static
		../../External/${LIB}/static
		${module_file_path}/../../../External/${LIB}/static
		DOC
		"Path to freeimage static release library (windows only). For this configuration it might be called ${FREEIMAGE_STATIC_LIBRARY_NAME}")
	mark_as_advanced(FREEIMAGE_STATIC_LIBRARY)

	if(FREEIMAGE_STATIC_LIBRARY)
		set(FREEIMAGE_STATIC_LIBRARIES_FOUND 1)
	endif()

	find_library(FREEIMAGE_STATIC_DEBUG_LIBRARY
		NAMES
		${FREEIMAGE_STATIC_LIBRARY_NAME}_d
		PATHS
		$ENV{H3D_EXTERNAL_ROOT}/${LIB}/static
		$ENV{H3D_ROOT}/../External/${LIB}/static
		../../External/${LIB}/static
		${module_file_path}/../../../External/${LIB}/static
		DOC
		"Path to freeimage static debug library (windows only). For this configuration it might be called ${FREEIMAGE_STATIC_LIBRARY_NAME}_d")
	mark_as_advanced(FREEIMAGE_STATIC_DEBUG_LIBRARY)

	if(FREEIMAGE_STATIC_DEBUG_LIBRARY)
		set(FREEIMAGE_STATIC_LIBRARIES_FOUND 1)
	endif()
endif()

if(FREEIMAGE_LIBRARY OR FREEIMAGE_STATIC_LIBRARIES_FOUND)
	set(FREEIMAGE_LIBRARIES_FOUND 1)
endif()

# Copy the results to the output variables.
if(FREEIMAGE_INCLUDE_DIR AND FREEIMAGE_LIBRARIES_FOUND)
	set(FREEIMAGE_FOUND 1)

	if(WIN32
		AND
		PREFER_STATIC_LIBRARIES
		AND
		FREEIMAGE_STATIC_LIBRARIES_FOUND)
		if(FREEIMAGE_STATIC_LIBRARY)
			set(FREEIMAGE_LIBRARIES optimized ${FREEIMAGE_STATIC_LIBRARY})
		else()
			set(FREEIMAGE_LIBRARIES optimized ${FREEIMAGE_STATIC_LIBRARY_NAME})
			message(STATUS
				"FreeImage static release libraries not found. Release build might not work.")
		endif()

		if(FREEIMAGE_STATIC_DEBUG_LIBRARY)
			set(FREEIMAGE_LIBRARIES
				${FREEIMAGE_LIBRARIES}
				debug
				${FREEIMAGE_STATIC_DEBUG_LIBRARY})
		else()
			set(FREEIMAGE_LIBRARIES
				${FREEIMAGE_LIBRARIES}
				debug
				${FREEIMAGE_STATIC_LIBRARY_NAME}_d)
			message(STATUS
				"FreeImage static debug libraries not found. Debug build might not work.")
		endif()

		set(FREEIMAGE_LIB 1)
	else()
		set(FREEIMAGE_LIBRARIES ${FREEIMAGE_LIBRARY})
	endif()

	set(FREEIMAGE_INCLUDE_DIR ${FREEIMAGE_INCLUDE_DIR})
else()
	set(FREEIMAGE_FOUND 0)
	set(FREEIMAGE_LIBRARIES)
	set(FREEIMAGE_INCLUDE_DIR)
endif()

# Report the results.
if(NOT FREEIMAGE_FOUND)
	set(FREEIMAGE_DIR_MESSAGE
		"FREEIMAGE was not found. Make sure FREEIMAGE_LIBRARY")
	if(WIN32)
		set(FREEIMAGE_DIR_MESSAGE
			"${FREEIMAGE_DIR_MESSAGE} ( and/or FREEIMAGE_STATIC_LIBRARY/FREEIMAGE_STATIC_DEBUG_LIBRARY )")
	endif()
	set(FREEIMAGE_DIR_MESSAGE
		"${FREEIMAGE_DIR_MESSAGE} and FREEIMAGE_INCLUDE_DIR are set.")
	if(FreeImage_FIND_REQUIRED)
		set(FREEIMAGE_DIR_MESSAGE
			"${FREEIMAGE_DIR_MESSAGE} FREEIMAGE is required to build.")
		message(FATAL_ERROR "${FREEIMAGE_DIR_MESSAGE}")
	elseif(NOT FreeImage_FIND_QUIETLY)
		set(FREEIMAGE_DIR_MESSAGE
			"${FREEIMAGE_DIR_MESSAGE} If you do not have it many image formats will not be available to use as textures.")
		message(STATUS "${FREEIMAGE_DIR_MESSAGE}")
	endif()
endif()
