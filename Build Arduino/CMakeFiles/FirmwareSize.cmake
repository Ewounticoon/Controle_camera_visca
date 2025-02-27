
        set(AVRSIZE_PROGRAM C:/Users/eweng/Documents/Camera/Camera/arduino/hardware/tools/avr/bin/avr-size.exe)
        set(AVRSIZE_FLAGS -C --mcu=${MCU})

        execute_process(COMMAND ${AVRSIZE_PROGRAM} ${AVRSIZE_FLAGS} ${FIRMWARE_IMAGE} ${EEPROM_IMAGE}
                        OUTPUT_VARIABLE SIZE_OUTPUT)


        string(STRIP "${SIZE_OUTPUT}" RAW_SIZE_OUTPUT)

        # Convert lines into a list
        string(REPLACE "\n" ";" SIZE_OUTPUT_LIST "${SIZE_OUTPUT}")

        set(SIZE_OUTPUT_LINES)
        foreach(LINE ${SIZE_OUTPUT_LIST})
            if(NOT "${LINE}" STREQUAL "")
                list(APPEND SIZE_OUTPUT_LINES "${LINE}")
            endif()
        endforeach()

        function(EXTRACT LIST_NAME INDEX VARIABLE)
            list(GET "${LIST_NAME}" ${INDEX} RAW_VALUE)
            string(STRIP "${RAW_VALUE}" VALUE)

            set(${VARIABLE} "${VALUE}" PARENT_SCOPE)
        endfunction()
        function(PARSE INPUT VARIABLE_PREFIX)
            if(${INPUT} MATCHES "([^:]+):[ \t]*([0-9]+)[ \t]*([^ \t]+)[ \t]*[(]([0-9.]+)%.*")
                set(ENTRY_NAME      ${CMAKE_MATCH_1})
                set(ENTRY_SIZE      ${CMAKE_MATCH_2})
                set(ENTRY_SIZE_TYPE ${CMAKE_MATCH_3})
                set(ENTRY_PERCENT   ${CMAKE_MATCH_4})
            endif()

            set(${VARIABLE_PREFIX}_NAME      ${ENTRY_NAME}      PARENT_SCOPE)
            set(${VARIABLE_PREFIX}_SIZE      ${ENTRY_SIZE}      PARENT_SCOPE)
            set(${VARIABLE_PREFIX}_SIZE_TYPE ${ENTRY_SIZE_TYPE} PARENT_SCOPE)
            set(${VARIABLE_PREFIX}_PERCENT   ${ENTRY_PERCENT}   PARENT_SCOPE)
        endfunction()

        list(LENGTH SIZE_OUTPUT_LINES SIZE_OUTPUT_LENGTH)
        #message("${SIZE_OUTPUT_LINES}")
        #message("${SIZE_OUTPUT_LENGTH}")
        if (${SIZE_OUTPUT_LENGTH} STREQUAL 14)
            EXTRACT(SIZE_OUTPUT_LINES 3 FIRMWARE_PROGRAM_SIZE_ROW)
            EXTRACT(SIZE_OUTPUT_LINES 5 FIRMWARE_DATA_SIZE_ROW)
            PARSE(FIRMWARE_PROGRAM_SIZE_ROW FIRMWARE_PROGRAM)
            PARSE(FIRMWARE_DATA_SIZE_ROW  FIRMWARE_DATA)

            set(FIRMWARE_STATUS "Firmware Size: ")
            set(FIRMWARE_STATUS "${FIRMWARE_STATUS} [${FIRMWARE_PROGRAM_NAME}: ${FIRMWARE_PROGRAM_SIZE} ${FIRMWARE_PROGRAM_SIZE_TYPE} (${FIRMWARE_PROGRAM_PERCENT}%)] ")
            set(FIRMWARE_STATUS "${FIRMWARE_STATUS} [${FIRMWARE_DATA_NAME}: ${FIRMWARE_DATA_SIZE} ${FIRMWARE_DATA_SIZE_TYPE} (${FIRMWARE_DATA_PERCENT}%)]")
            set(FIRMWARE_STATUS "${FIRMWARE_STATUS} on ${MCU}")

            EXTRACT(SIZE_OUTPUT_LINES 10 EEPROM_PROGRAM_SIZE_ROW)
            EXTRACT(SIZE_OUTPUT_LINES 12 EEPROM_DATA_SIZE_ROW)
            PARSE(EEPROM_PROGRAM_SIZE_ROW EEPROM_PROGRAM)
            PARSE(EEPROM_DATA_SIZE_ROW  EEPROM_DATA)

            set(EEPROM_STATUS "EEPROM   Size: ")
            set(EEPROM_STATUS "${EEPROM_STATUS} [${EEPROM_PROGRAM_NAME}: ${EEPROM_PROGRAM_SIZE} ${EEPROM_PROGRAM_SIZE_TYPE} (${EEPROM_PROGRAM_PERCENT}%)] ")
            set(EEPROM_STATUS "${EEPROM_STATUS} [${EEPROM_DATA_NAME}: ${EEPROM_DATA_SIZE} ${EEPROM_DATA_SIZE_TYPE} (${EEPROM_DATA_PERCENT}%)]")
            set(EEPROM_STATUS "${EEPROM_STATUS} on ${MCU}")

            message("${FIRMWARE_STATUS}")
            message("${EEPROM_STATUS}\n")

            if($ENV{VERBOSE})
                message("${RAW_SIZE_OUTPUT}\n")
            elseif($ENV{VERBOSE_SIZE})
                message("${RAW_SIZE_OUTPUT}\n")
            endif()
        else()
            message("${RAW_SIZE_OUTPUT}")
        endif()
    