tables: t551a,t550a.

type-pools: slis.

types: begin of ty_t551a,
      TPRG3 type t551a-TPRG3,
      ZMODN type t551a-ZMODN,
       MOTPR type t550a-MOTPR,
          lv_id type i,
    end of ty_t551a,

 begin of ty_t550a,
      TPROG type t550a-TPROG,
      SOBEG type t550a-SOBEG,
      SOEND type t550a-SOEND,
      MOTPR type t550a-MOTPR,
     lv_dayindex type i,
  end of ty_t550a,

begin of ty_all,
    lv_id type i,
      TPRG3 type t551a-TPRG3,
      ZMODN type t551a-ZMODN,
     TPROG type t550a-TPROG,
      SOBEG type t550a-SOBEG,
      SOEND type t550a-SOEND,
      MOTPR type t550a-MOTPR,
     lv_dayindex type i,
end of ty_all.

data: gt_t551a type standard table of ty_t551a,
      wa_t551a type ty_t551a,

      lv_number type i,

     gt_t550a type standard table of ty_t550a,
     wa_t550a type ty_t550a,

     gt_all type standard table of ty_all,
     wa_all type ty_all.

data: gt_fcat type SLIS_T_FIELDCAT_ALV,
    wa_fcat like line of gt_fcat,
   gt_layout TYPE slis_layout_alv.

selection-screen begin of line.
selection-screen pushbutton 32(15) b1 user-command fc1.
selection-screen end of line.

Initialization.
b1 = 'Download'.

select
       TPRG3
       ZMODN
from t551a
into table gt_t551a.

select TPROG
       SOBEG
*       SOEND
from t550a
into table gt_t550a
where  MOTPR = '24'.

loop at gt_t550a into wa_t550a.
wa_all-TPROG = wa_t550a-TPROG.
wa_all-SOBEG = wa_t550a-SOBEG.
wa_all-SOEND = wa_t550a-SOEND.
wa_all-MOTPR = wa_t550a-MOTPR.


read table gt_t551a into wa_t551a with key MOTPR = wa_t551a-MOTPR.

if sy-subrc eq 0.
wa_all-TPRG3 = wa_t551a-TPRG3.
wa_all-ZMODN = wa_t551a-ZMODN.

endif.
append wa_all to gt_all.
clear: wa_t551a,wa_t550a,wa_all.
endloop.


wa_fcat-COL_POS = '1'.
wa_fcat-FIELDNAME = 'lv_ID'.
wa_fcat-SELTEXT_L = 'ID'.
wa_fcat-NO_ZERO = 'x'.
append wa_fcat to gt_fcat.
CLEAR wa_fcat.

wa_fcat-COL_POS = '2'.
wa_fcat-FIELDNAME = 'TPRG3'.
wa_fcat-SELTEXT_L = 'Daily Work Schedule'.
append wa_fcat to gt_fcat.
CLEAR wa_fcat.

wa_fcat-COL_POS = '3'.
wa_fcat-FIELDNAME = 'ZMODN'.
wa_fcat-SELTEXT_L = 'Period Work Schedule(Shift)'.
append wa_fcat to gt_fcat.
CLEAR wa_fcat.

wa_fcat-COL_POS = '4'.
wa_fcat-FIELDNAME = 'TPROG'.
wa_fcat-SELTEXT_L = 'Daily Work Schedule'.
append wa_fcat to gt_fcat.
CLEAR wa_fcat.

wa_fcat-COL_POS = '5'.
wa_fcat-FIELDNAME = 'SOBEG'.
wa_fcat-SELTEXT_L = 'Start of planned working time(in_time)'.
append wa_fcat to gt_fcat.
CLEAR wa_fcat.

wa_fcat-COL_POS = '6'.
wa_fcat-FIELDNAME = 'SOEND'.
wa_fcat-SELTEXT_L = 'End of planned working time(out_time)'.
append wa_fcat to gt_fcat.
CLEAR wa_fcat.

wa_fcat-COL_POS = '7'.
wa_fcat-FIELDNAME = 'MOTPR '.
wa_fcat-SELTEXT_L = 'Personnel Subarea Grouping for Daily Work Schedules'.
append wa_fcat to gt_fcat.
CLEAR wa_fcat.

wa_fcat-COL_POS = '8'.
wa_fcat-FIELDNAME = 'lv_dayindex'.
wa_fcat-SELTEXT_L = 'Day_Index'.
append wa_fcat to gt_fcat.
CLEAR wa_fcat.

gt_layout-colwidth_optimize = 'x'.
gt_layout-edit = 'x'.


CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
*   I_INTERFACE_CHECK                 = ' '
*   I_BYPASSING_BUFFER                = ' '
*   I_BUFFER_ACTIVE                   = ' '
*   I_CALLBACK_PROGRAM                = ' '
*   I_CALLBACK_PF_STATUS_SET          = ' '
*   I_CALLBACK_USER_COMMAND           = ' '
*   I_CALLBACK_TOP_OF_PAGE            = ' '
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
*   I_STRUCTURE_NAME                  = I_STRUCTURE_NAME
*   I_BACKGROUND_ID                   = ' '
*   I_GRID_TITLE                      = I_GRID_TITLE
*   I_GRID_SETTINGS                   = I_GRID_SETTINGS
   IS_LAYOUT                         =  gt_layout
   IT_FIELDCAT                       = gt_fcat
*   IT_EXCLUDING                      = IT_EXCLUDING
*   IT_SPECIAL_GROUPS                 = IT_SPECIAL_GROUPS
*   IT_SORT                           = IT_SORT
*   IT_FILTER                         = IT_FILTER
*   IS_SEL_HIDE                       = IS_SEL_HIDE
*   I_DEFAULT                         = 'X'
   I_SAVE                            = 'x'
*   IS_VARIANT                        = IS_VARIANT
*   IT_EVENTS                         = IT_EVENTS
*   IT_EVENT_EXIT                     = IT_EVENT_EXIT
*   IS_PRINT                          = IS_PRINT
*   IS_REPREP_ID                      = IS_REPREP_ID
*   I_SCREEN_START_COLUMN             = 0
*   I_SCREEN_START_LINE               = 0
*   I_SCREEN_END_COLUMN               = 0
*   I_SCREEN_END_LINE                 = 0
*   I_HTML_HEIGHT_TOP                 = 0
*   I_HTML_HEIGHT_END                 = 0
*   IT_ALV_GRAPHICS                   = IT_ALV_GRAPHICS
*   IT_HYPERLINK                      = IT_HYPERLINK
*   IT_ADD_FIELDCAT                   = IT_ADD_FIELDCAT
*   IT_EXCEPT_QINFO                   = IT_EXCEPT_QINFO
*   IR_SALV_FULLSCREEN_ADAPTER        = IR_SALV_FULLSCREEN_ADAPTER
*   O_PREVIOUS_SRAL_HANDLER           = O_PREVIOUS_SRAL_HANDLER
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           = E_EXIT_CAUSED_BY_CALLER
*   ES_EXIT_CAUSED_BY_USER            = ES_EXIT_CAUSED_BY_USER
  TABLES
    T_OUTTAB                          =  gt_all
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
          .
at selection-screen.
case sy-ucomm.
when 'FC1'.

 CALL FUNCTION 'SAP_CONVERT_TO_XLS_FORMAT'
        EXPORTING
          I_FIELD_SEPERATOR = '#'
          I_LINE_HEADER     = 'X'
          I_FILENAME        = 'Export.xls'
        TABLES
          I_TAB_SAP_DATA    = gt_all
        EXCEPTIONS
          CONVERSION_FAILED = 1.

endcase.
