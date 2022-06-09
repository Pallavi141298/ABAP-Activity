
TABLES: T550A.

TYPE-POOLS: SLIS.

TYPES: BEGIN OF TY_T550A,
         MOTPR TYPE T550A-MOTPR,
         TPROG TYPE T550A-TPROG,
         BEGDA TYPE T550A-BEGDA,
         ENDDA TYPE T550A-ENDDA,
       END OF TY_T550A.

DATA: IT_T550A TYPE TABLE OF TY_T550A,
      WA_T550A TYPE TY_T550A.

DATA : IT_FCAT TYPE SLIS_T_FIELDCAT_ALV .
DATA : WA_FCAT LIKE LINE OF IT_FCAT .

PARAMETERS : P_MOTPR TYPE T550A-MOTPR.

START-OF-SELECTION.

  SELECT MOTPR TPROG BEGDA ENDDA
      FROM T550A
   INTO TABLE IT_T550A.

  WA_FCAT-COL_POS = '1' .
  WA_FCAT-FIELDNAME = 'MOTPR' .
  WA_FCAT-TABNAME = 'IT_T550A' .
  WA_FCAT-SELTEXT_M = 'PSG for DWS' .
  APPEND WA_FCAT TO IT_FCAT .
  CLEAR WA_FCAT .


  WA_FCAT-COL_POS = '2' .
  WA_FCAT-FIELDNAME = 'TPROG' .
  WA_FCAT-TABNAME = 'IT_T550A' .
  WA_FCAT-SELTEXT_M = 'Daily Work Schedule' .
  APPEND WA_FCAT TO IT_FCAT .
  CLEAR WA_FCAT .


  WA_FCAT-COL_POS = '3' .
  WA_FCAT-FIELDNAME = 'BEGDA' .
  WA_FCAT-TABNAME = 'IT_T550A' .
  WA_FCAT-SELTEXT_M = 'Start Date' .
  APPEND WA_FCAT TO IT_FCAT .
  CLEAR WA_FCAT .


  WA_FCAT-COL_POS = '4' .
  WA_FCAT-FIELDNAME = 'ENDDA' .
  WA_FCAT-TABNAME = 'IT_T550A' .
  WA_FCAT-SELTEXT_M = 'End Date' .
  APPEND WA_FCAT TO IT_FCAT .
  CLEAR WA_FCAT .

 DATA: ALV_PRINT TYPE SLIS_PRINT_ALV.
  ALV_PRINT-NO_PRINT_LISTINFOS = 'X'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK        = ' '
*     I_BYPASSING_BUFFER       = ' '
*     I_BUFFER_ACTIVE          = ' '
      I_CALLBACK_PROGRAM       = SY-REPID
      I_CALLBACK_PF_STATUS_SET = 'FORM_MENU '
     I_CALLBACK_USER_COMMAND  = 'USER_COMMAND '
*     I_CALLBACK_TOP_OF_PAGE   = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME         = I_STRUCTURE_NAME
*     I_BACKGROUND_ID          = ' '
*     I_GRID_TITLE             = I_GRID_TITLE
*     I_GRID_SETTINGS          = I_GRID_SETTINGS
*     IS_LAYOUT                = IS_LAYOUT
      IT_FIELDCAT              = IT_FCAT
*     IT_EXCLUDING             = IT_EXCLUDING
*     IT_SPECIAL_GROUPS        = IT_SPECIAL_GROUPS
*     IT_SORT                  = IT_SORT
*     IT_FILTER                = IT_FILTER
*     IS_SEL_HIDE              = IS_SEL_HIDE
*     I_DEFAULT                = 'X'
     I_SAVE                   = 'X'
*     IS_VARIANT               = IS_VARIANT
*     IT_EVENTS                = IT_EVENTS
*     IT_EVENT_EXIT            = IT_EVENT_EXIT
     IS_PRINT                 = ALV_PRINT
*     IS_REPREP_ID             = IS_REPREP_ID
*     I_SCREEN_START_COLUMN    = 0
*     I_SCREEN_START_LINE      = 0
*     I_SCREEN_END_COLUMN      = 0
*     I_SCREEN_END_LINE        = 0
*     I_HTML_HEIGHT_TOP        = 0
*     I_HTML_HEIGHT_END        = 0
*     IT_ALV_GRAPHICS          = IT_ALV_GRAPHICS
*     IT_HYPERLINK             = IT_HYPERLINK
*     IT_ADD_FIELDCAT          = IT_ADD_FIELDCAT
*     IT_EXCEPT_QINFO          = IT_EXCEPT_QINFO
*     IR_SALV_FULLSCREEN_ADAPTER        = IR_SALV_FULLSCREEN_ADAPTER
*     O_PREVIOUS_SRAL_HANDLER  = O_PREVIOUS_SRAL_HANDLER
* IMPORTING
*     E_EXIT_CAUSED_BY_CALLER  = E_EXIT_CAUSED_BY_CALLER
*     ES_EXIT_CAUSED_BY_USER   = ES_EXIT_CAUSED_BY_USER
    TABLES
      T_OUTTAB                 = IT_T550A
* EXCEPTIONS
*     PROGRAM_ERROR            = 1
    .

CALL FUNCTION 'GUI_DOWNLOAD'
  EXPORTING
*   BIN_FILESIZE                    = BIN_FILESIZE
    FILENAME                        = it_t550a
   FILETYPE                        = 'ASC'
*   APPEND                          = ' '
*   WRITE_FIELD_SEPARATOR           = ' '
*   HEADER                          = '00'
*   TRUNC_TRAILING_BLANKS           = ' '
*   WRITE_LF                        = 'X'
*   COL_SELECT                      = ' '
*   COL_SELECT_MASK                 = ' '
*   DAT_MODE                        = ' '
*   CONFIRM_OVERWRITE               = ' '
*   NO_AUTH_CHECK                   = ' '
*   CODEPAGE                        = ' '
*   IGNORE_CERR                     = ABAP_TRUE
*   REPLACEMENT                     = '#'
*   WRITE_BOM                       = ' '
*   TRUNC_TRAILING_BLANKS_EOL       = 'X'
*   WK1_N_FORMAT                    = ' '
*   WK1_N_SIZE                      = ' '
*   WK1_T_FORMAT                    = ' '
*   WK1_T_SIZE                      = ' '
*   WRITE_LF_AFTER_LAST_LINE        = ABAP_TRUE
*   SHOW_TRANSFER_STATUS            = ABAP_TRUE
*   VIRUS_SCAN_PROFILE              = '/SCET/GUI_DOWNLOAD'
* IMPORTING
*   FILELENGTH                      = FILELENGTH
  TABLES
    DATA_TAB                        = it_t550a
*   FIELDNAMES                      = FIELDNAMES
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


FORM FORM_MENU USING RT_EXTAB TYPE SLIS_T_EXTAB.
SET PF-STATUS 'MENU'.
ENDFORM.

FORM USER_COMMAND USING R_UCOMM LIKE SY-UCOMM
                        RS_SELFIELD TYPE SLIS_SELFIELD.
  CASE R_UCOMM.
    WHEN 'EPDF'. "Function code for export which we created in MENU
**submit the same program in background and store
      TYPES: BEGIN OF TY_TSP01,
            RQIDENT   TYPE TSP01-RQIDENT,           " spool number
            RQ2NAME TYPE TSP01-RQ2NAME,           " Spool request: Suffix 2
            RQCRETIME TYPE TSP01-RQCRETIME,         " User name
            END OF TY_TSP01.
      DATA: LV_JOBCNT TYPE TBTCJOB-JOBCOUNT,         " job number
            LV_JOBNAME TYPE TBTCJOB-JOBNAME.         " job name
      DATA: LV_LEN TYPE I,
          LS_PARAM TYPE RSPARAMS,                  " selection work area
          LS_TSP01 TYPE TY_TSP01,                  " Spool Requests work area
          LT_TSP01 TYPE STANDARD TABLE OF TY_TSP01, " Spool Requests internal table
          LT_PARAM TYPE RSPARAMS_TT.                " Selection table
* ********* Derive job counter
      LV_JOBNAME = 'ZALV2PDF'. "Background job name
      CALL FUNCTION 'JOB_OPEN' "open a job
        EXPORTING
          JOBNAME          = LV_JOBNAME
        IMPORTING
          JOBCOUNT         = LV_JOBCNT
        EXCEPTIONS
          CANT_CREATE_JOB  = 1
          INVALID_JOB_DATA = 2
          JOBNAME_MISSING  = 3
          OTHERS           = 4.
      IF SY-SUBRC EQ 0.
        DATA : LV_RQDEST TYPE TSP01-RQDEST VALUE 'LP01',
              LV_LINSZ TYPE SYLINSZ VALUE '9999999'.

        SUBMIT (SY-REPID) "submit the same program
        WITH P_MOTPR = P_MOTPR
          TO SAP-SPOOL  DESTINATION LV_RQDEST
          LINE-SIZE LV_LINSZ
          IMMEDIATELY 'X'
          KEEP IN SPOOL 'X'
          USER SY-UNAME VIA JOB LV_JOBNAME NUMBER LV_JOBCNT
          WITHOUT SPOOL DYNPRO
          WITH SELECTION-TABLE LT_PARAM
          AND RETURN.

        CALL FUNCTION 'JOB_CLOSE' "job close
          EXPORTING
            JOBCOUNT             = LV_JOBCNT
            JOBNAME              = LV_JOBNAME
            STRTIMMED            = 'X'
          EXCEPTIONS
            CANT_START_IMMEDIATE = 1
            INVALID_STARTDATE    = 2
            JOBNAME_MISSING      = 3
            JOB_CLOSE_FAILED     = 4
            JOB_NOSTEPS          = 5
            JOB_NOTEX            = 6
            LOCK_FAILED          = 7
            INVALID_TARGET       = 8
            OTHERS               = 9.
        IF SY-SUBRC <> 0.
          RAISE JOB_CANNOT_BE_CLOSED.                    " Raise exception
        ENDIF.
      ELSE.
        RAISE JOB_CANNOT_BE_SUBMITTED.
      ENDIF.
*********** confirm job status if finished
      DATA: LV_JOB    TYPE TBTCV-FIN.                " Job status
      DO 120 TIMES.
        CALL FUNCTION 'BDL_READ_JOB_STATUS' "get job status
          EXPORTING
            JOBNAME       = LV_JOBNAME
            JOBNUMBER     = LV_JOBCNT
          IMPORTING
            JOBSTATUS     = LV_JOB
          EXCEPTIONS
            JOB_NOT_FOUND = 1
            OTHERS        = 2.
        IF LV_JOB NE 'F'. "job finished
          WAIT UP TO 1 SECONDS.
          CONTINUE.
        ELSE.
          EXIT.
        ENDIF.
      ENDDO.
**calculate report name in Spool table
      DATA:  LV_RQ2NAME TYPE TSP01-RQ2NAME.           " Spool request
      DATA: LV_TMP(14) TYPE C,                       " temp
          LV_STRING TYPE STRING,                   " store program name
          LV_TEMP TYPE TSP01-RQ2NAME,              " Spool request
          LV_SPOOL TYPE TSP01-RQIDENT.             " spool number
      IF LV_JOB EQ 'F'. "job finished
        LV_LEN = STRLEN( SY-REPID ) .
        IF LV_LEN >= 9 .
          CONCATENATE SY-REPID+0(9)
                      SY-UNAME+0(3) INTO LV_RQ2NAME .
        ELSE.
          LV_LEN = 9 - LV_LEN.
          DO LV_LEN TIMES .
            CONCATENATE LV_TEMP '_' INTO LV_TEMP .
          ENDDO.
          CONCATENATE SY-REPID LV_TEMP
                      SY-UNAME INTO LV_RQ2NAME .
        ENDIF.

*Get spool request from SPOOL table TSP01
        SELECT RQIDENT RQ2NAME RQCRETIME FROM TSP01 INTO TABLE LT_TSP01
                WHERE RQ2NAME = LV_RQ2NAME AND RQOWNER = SY-UNAME .
*sort table to find latest spool no
        SORT  LT_TSP01 BY RQCRETIME DESCENDING .
*read table to find latest spool no
        READ TABLE LT_TSP01 INTO LS_TSP01 INDEX 1.
*get user desktop
        CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_DESKTOP_DIRECTORY
          CHANGING
            DESKTOP_DIRECTORY    = LV_STRING
          EXCEPTIONS
            CNTL_ERROR           = 1
            ERROR_NO_GUI         = 2
            NOT_SUPPORTED_BY_GUI = 3
            OTHERS               = 4.
        IF SY-SUBRC <> 0.
* Implement suitable error handling here
        ENDIF.
        CALL METHOD CL_GUI_CFW=>UPDATE_VIEW.
        CONCATENATE LV_STRING TEXT-001 INTO LV_STRING.

*Prepare selection table for PDF download
        LS_PARAM-SELNAME = 'SPOOLNO'.
        LS_PARAM-SIGN    = 'I'.
        LS_PARAM-OPTION  = 'EQ'.
        LS_PARAM-LOW     = LS_TSP01-RQIDENT.
        LS_PARAM-HIGH    = ''.
        APPEND LS_PARAM TO LT_PARAM.

        LS_PARAM-SELNAME = 'P_FILE'.
        LS_PARAM-SIGN    = 'I'.
        LS_PARAM-OPTION  = 'EQ'.
        LS_PARAM-LOW     = LV_STRING.
        LS_PARAM-HIGH    = ''.
        APPEND LS_PARAM TO LT_PARAM.

* Submit to PDF converted and download
        SUBMIT RSTXPDFT4 WITH SELECTION-TABLE LT_PARAM
        AND RETURN.
        IF SY-SUBRC <> 0.

        MESSAGE  'PDF convert not possible' TYPE 'I'.
        ENDIF.
      ELSE.
        MESSAGE  'PDF Can not be downloaded, you have selected huge data. Reduce data and try again' TYPE 'I'.
      ENDIF.
  ENDCASE.
ENDFORM.                    "user command
