types: begin of ty_t550a,
      TPROG type t550a-TPROG,
      SOBEG type t550a-SOBEG,
      SOEND type t550a-SOEND,
      MOTPR type t550a-MOTPR,
 end of ty_t550a.

data: t_data type ty_t550a occurs 0 with header line.

data: begin of wa_header,
        name type c length 30,
  end of wa_header.

data: t_header like table of wa_header.

start-of-selection.
perform f_process_data.
perform f_download.

FORM F_PROCESS_DATA .

t_data-TPROG = '//'.
t_data-SOBEG = '00:00:00'.
t_data-SOEND = '08:00:00'.
t_data-MOTPR = '01'.
append t_data.

t_data-TPROG = 'AFTN'.
t_data-SOBEG = '16:00:00'.
t_data-SOEND = '24:00:00'.
t_data-MOTPR = '01'.
append t_data.

append 'TPROG' to t_header.
append 'SOBEG' to t_header.
append 'SOEND' to t_header.
append 'MOTPR' to t_header.

ENDFORM.

FORM F_DOWNLOAD .
data: lv_filename type string,
      lv_path type string,
      lv_fullpath type string,
      lv_result type i,
      lv_default type string,
      lv_fname type string.

call method cl_gui_frontend_services=>file_save_dialog
exporting
    window_title = 'File Directory'
    DEFAULT_EXTENSION = 'XLS'
      INITIAL_DIRECTORY = 'D:\'
CHANGING
      FILENAME          = LV_FILENAME
      PATH              = LV_PATH
      FULLPATH          = LV_FULLPATH
      USER_ACTION       = LV_RESULT.

  LV_FNAME = LV_FULLPATH.

*DOWNLOAD FILE IN EXCEL*


CALL FUNCTION 'GUI_DOWNLOAD'
  EXPORTING
*   BIN_FILESIZE                    = BIN_FILESIZE
    FILENAME                        = LV_FNAME
   FILETYPE                        = 'DAT'

*   FILELENGTH                      = FILELENGTH
  TABLES
    DATA_TAB                        = t_data
   FIELDNAMES                      = t_header
* EXCEPTIONS
*   FILE_WRITE_ERROR                = 1
*   NO_BATCH                        = 2
*   GUI_REFUSE_FILETRANSFER         = 3
*   INVALID_TYPE                    = 4
*   NO_AUTHORITY                    = 5
*   UNKNOWN_ERROR                   = 6
*   HEADER_NOT_ALLOWED              = 7
*   SEPARATOR_NOT_ALLOWED           = 8
*   FILESIZE_NOT_ALLOWED            = 9
*   HEADER_TOO_LONG                 = 10
*   DP_ERROR_CREATE                 = 11
*   DP_ERROR_SEND                   = 12
*   DP_ERROR_WRITE                  = 13
*   UNKNOWN_DP_ERROR                = 14
*   ACCESS_DENIED                   = 15
*   DP_OUT_OF_MEMORY                = 16
*   DISK_FULL                       = 17
*   DP_TIMEOUT                      = 18
*   FILE_NOT_FOUND                  = 19
*   DATAPROVIDER_EXCEPTION          = 20
*   CONTROL_FLUSH_ERROR             = 21
          .

ENDFORM.
