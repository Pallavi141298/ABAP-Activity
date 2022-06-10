REPORT ZPROGRAM22.
"step 1: Prepare the eamil sub/body
"step 2: ADD attachment cl_document_bcs
"step 3: Create and get instance of lc_bcs
"step 4: set the document in lc_bcs from step1 and step2
"step 5: Create sender/recipient instance cl_cam_address_bcs
"step 6: set sender/recipient lc_bcs
"step 7: send and commit.


DATA: LV_STRING      TYPE STRING,
      LV_DATA_STRING TYPE STRING,
      LV_XSTRING     TYPE XSTRING,
      LT_BIN         TYPE SOLIX_TAB,
      LT_BODY        TYPE SOLI_TAB,
      LS_BODY       TYPE SOLI.

START-OF-SELECTION.
  SELECT MOTPR, MANDT, TPROG
    FROM T550A
    INTO TABLE @DATA(lt_t550a)
   up to 10 rows.

  BREAK-POINT.
  "convert ittab into string"
  LOOP AT LT_T550A ASSIGNING FIELD-SYMBOL(<LS_T550A>).
    CONCATENATE <LS_T550A>-MOTPR <LS_T550A>-MANDT  <LS_T550A>-TPROG
    INTO LV_STRING SEPARATED BY CL_ABAP_CHAR_UTILITIES=>HORIZONTAL_TAB.
    CONCATENATE LV_STRING LV_DATA_STRING INTO LV_DATA_STRING
    SEPARATED BY CL_ABAP_CHAR_UTILITIES=>NEWLINE.
  ENDLOOP.

  "convert string to xstring"
  CALL FUNCTION 'SCMS_STRING_TO_XSTRING'
    EXPORTING
      TEXT   = LV_DATA_STRING
    IMPORTING
      BUFFER = LV_XSTRING.

  "convert xstring to binary"
  CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
    EXPORTING
      BUFFER     = LV_XSTRING
    TABLES
      BINARY_TAB = LT_BIN.

  LS_BODY-LINE = 'Please find the attachment'.
  APPEND LS_BODY TO LT_BODY.

  "Just new method use"
*append value #( line = 'Please find the attachment') to lt_body.

*TRY.
  CALL METHOD CL_DOCUMENT_BCS=>CREATE_DOCUMENT
    EXPORTING
      I_TYPE    = 'txt'
      I_SUBJECT = 'Emplyee details'
      I_TEXT    = LT_BODY
    RECEIVING
      RESULT    = DATA(LO_DOC).


  CALL METHOD LO_DOC->ADD_ATTACHMENT
    EXPORTING
      I_ATTACHMENT_TYPE    = 'XLS'
      I_ATTACHMENT_SUBJECT = 'Excel file'
      I_ATT_CONTENT_HEX    = LT_BIN.


  CALL METHOD CL_BCS=>CREATE_PERSISTENT
    RECEIVING
      RESULT = DATA(LO_SEND_REQUEST).


  CALL METHOD LO_SEND_REQUEST->SET_DOCUMENT
    EXPORTING
      I_DOCUMENT = LO_DOC.


  CALL METHOD CL_CAM_ADDRESS_BCS=>CREATE_INTERNET_ADDRESS
    EXPORTING
      I_ADDRESS_STRING = 'pallavihurakadli14@gmail.com'
    RECEIVING
      RESULT           = DATA(LO_SENDER).


  CALL METHOD CL_CAM_ADDRESS_BCS=>CREATE_INTERNET_ADDRESS
    EXPORTING
      I_ADDRESS_STRING = 'pallavihurakadli14@gmail.com'
    RECEIVING
      RESULT           = DATA(LO_RECIPIENT).


  CALL METHOD LO_SEND_REQUEST->SET_SENDER
    EXPORTING
      I_SENDER = LO_SENDER.


  CALL METHOD LO_SEND_REQUEST->ADD_RECIPIENT
    EXPORTING
      I_RECIPIENT = LO_RECIPIENT
      I_EXPRESS   = ABAP_TRUE.


  CALL METHOD LO_SEND_REQUEST->SEND
    RECEIVING
      RESULT = DATA(LV_STATUS).

  COMMIT WORK.

  BREAK-POINT.
