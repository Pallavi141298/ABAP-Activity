"step 1: structure declaration"
types: begin of ty_t550a,
       MOTPR type  MOTPR,
       MANDT type MANDT,
     TPROG type TPROG,
    VARIA type VARIA,
end of ty_t550a.

"step 2: Int.table and workarea declaration"
data: it_t550a type table of ty_t550a,
     wa_t550a type ty_t550a,
     lv_motpr type motpr,
     it_fcat type SLIS_T_FIELDCAT_ALV,
     wa_fcat type SLIS_FIELDCAT_ALV.

"step 3: select screen desiging"
select-options: so_motpr for lv_motpr.

"step 4: Fetching the data from database table into int.table"
select MOTPR  MANDT TPROG VARIA
     from t550a
    into table it_t550a
   where motpr in so_motpr.

"step 5: Fieldcatlog designing"
wa_fcat-COL_POS = '1'.
wa_fcat-FIELDNAME = 'MOTPR'.
wa_fcat-SELTEXT_L = 'Psg for dws'.
append wa_fcat to it_fcat.

wa_fcat-COL_POS = '2'.
wa_fcat-FIELDNAME = 'MANDT'.
wa_fcat-SELTEXT_L = 'client'.
append wa_fcat to it_fcat.

wa_fcat-COL_POS = '3'.
wa_fcat-FIELDNAME = 'TPROG'.
wa_fcat-SELTEXT_L = 'DWS'.
append wa_fcat to it_fcat.

wa_fcat-COL_POS = '4'.
wa_fcat-FIELDNAME = 'VARIA'.
wa_fcat-SELTEXT_L = 'DWS Variant'.
append wa_fcat to it_fcat.

"step 6: Display the data"

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
*   IS_LAYOUT                         = IS_LAYOUT
   IT_FIELDCAT                       = it_fcat
*   IT_EXCLUDING                      = IT_EXCLUDING
*   IT_SPECIAL_GROUPS                 = IT_SPECIAL_GROUPS
*   IT_SORT                           = IT_SORT
*   IT_FILTER                         = IT_FILTER
*   IS_SEL_HIDE                       = IS_SEL_HIDE
*   I_DEFAULT                         = 'X'
*   I_SAVE                            = ' '
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
    T_OUTTAB                          = it_t550a
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
          .
