if(WIN32)
	cmake_minimum_required(VERSION 2.6.0)
	# Macro used to set include directories on windows.
	macro(STRIP_AND_ADD_LIBRARY_DIRECTORIES)
		foreach(TEMP_LIST_ITEM ${ARGV})
			string(REGEX
				REPLACE
				"[/]([^/])*\\.lib$"
				""
				TEMP_LINK_DIR
				${TEMP_LIST_ITEM})
			string(COMPARE
				NOTEQUAL
				${TEMP_LIST_ITEM}
				${TEMP_LINK_DIR}
				LINK_STRING_NOT_EQUAL)
			if(${LINK_STRING_NOT_EQUAL})
				link_directories(${TEMP_LINK_DIR})
			endif()
		endforeach()
	endmacro()
endif()
