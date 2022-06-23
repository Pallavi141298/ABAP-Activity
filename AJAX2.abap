"SE24"
"CONSTRUCTOR"

METHOD CONSTRUCTOR.
    ms_input_data = is_input_data.
  ENDMETHOD.
  
"EXECUTE" =  METHOD EXECUTE.
    fetch_pa0000( ).
     fetch_pa0041( ).
    fetch_pa0001( ).
    fetch_pa0002( ).
    fetch_pa0008( ).
    fetch_t527x( ).
    fetch_pa0185( ).
    collect_data( ).
    display( ).

  ENDMETHOD.
  
"FETCH_PA0000"
METHOD FETCH_PA0000.
    SELECT * FROM pa0000 INTO TABLE mt_pa0000
      WHERE pernr IN ms_input_data-pernr[] and
            endda = '99991231'.
    SORT mt_pa0000 BY pernr.
  ENDMETHOD.
  
 "FETCH_PA0001"
 METHOD FETCH_PA0001.
    SELECT * FROM pa0001 INTO TABLE mt_pa0001
    FOR ALL ENTRIES IN mt_pa0000
      WHERE pernr = mt_pa0000-pernr AND
            endda = mt_pa0000-endda.

    SORT mt_pa0001 BY pernr.
  ENDMETHOD.
  
  "FETCH_PA0002"
  METHOD FETCH_PA0002.
    SELECT * FROM pa0002 INTO TABLE mt_pa0002
    FOR ALL ENTRIES IN mt_pa0000
      WHERE pernr = mt_pa0000-pernr AND
            endda = mt_pa0000-endda.

    SORT mt_pa0002 BY pernr.
  ENDMETHOD.
  
  "FETCH_PA0185"
  METHOD FETCH_PA0185.
    SELECT * FROM pa0185 INTO TABLE mt_pa0185
    FOR ALL ENTRIES IN mt_pa0000
      WHERE pernr = mt_pa0000-pernr AND
            endda = mt_pa0000-endda.
    SORT mt_pa0185 BY pernr.
  ENDMETHOD.
  
  "FETCH_PA0008"
  METHOD FETCH_PA0008.
    SELECT * FROM pa0008 INTO TABLE mt_pa0008
    FOR ALL ENTRIES IN mt_pa0000
      WHERE pernr = mt_pa0000-pernr AND
            endda = mt_pa0000-endda.
    SORT mt_pa0008 BY pernr.
  ENDMETHOD.
  
  "FETCH_T527X"
  METHOD FETCH_T527X.
    SELECT * FROM t527x INTO TABLE mt_t527x
    FOR ALL ENTRIES IN mt_pa0001
      WHERE sprsl = sy-langu AND
            orgeh =  mt_pa0001-orgeh AND
            endda = mt_pa0001-endda.
    SORT mt_t527x BY orgeh.
  ENDMETHOD.
  
  "DISPLAY"
    METHOD DISPLAY.
    CLEAR : mt_pa0000,mt_pa0001,mt_pa0002,mt_pa0008,mt_pa0041.
    "Instantiation
    TRY .
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table = DATA(lo_alv)
          CHANGING
            t_table      = mt_output ).
      CATCH cx_salv_msg.
    ENDTRY.
    lo_alv->get_columns( )->set_optimize( abap_true ).

    "Enable default ALV toolbar functions
    lo_alv->get_functions( )->set_all( abap_true ).

    "Change column name dynaically
    DATA: first_month_gross  TYPE scrtext_l,
          second_month_gross TYPE scrtext_l,
          third_month_gross  TYPE scrtext_l,
          first_month_tds    TYPE scrtext_l,
          second_month_tds   TYPE scrtext_l,
          third_month_tds    TYPE scrtext_l.
    CASE ms_input_data-quarter[ 1 ]-low.
      WHEN '01'.
        first_month_gross = 'April ' && ms_input_data-year[ 1 ]-low && ' Gross' .
        second_month_gross = 'May ' && ms_input_data-year[ 1 ]-low && ' Gross' .
        third_month_gross = 'June ' && ms_input_data-year[ 1 ]-low && ' Gross' .
        first_month_tds = 'April ' && ms_input_data-year[ 1 ]-low && ' TDS' .
        second_month_tds = 'May ' && ms_input_data-year[ 1 ]-low && ' TDS' .
        third_month_tds = 'June ' && ms_input_data-year[ 1 ]-low && ' TDS' .
      WHEN '02'.
        first_month_gross = 'July ' && ms_input_data-year[ 1 ]-low && ' Gross' .
        second_month_gross = 'August ' && ms_input_data-year[ 1 ]-low && ' Gross' .
        third_month_gross = 'September ' && ms_input_data-year[ 1 ]-low && ' Gross' .
        first_month_tds = 'July ' && ms_input_data-year[ 1 ]-low && ' TDS' .
        second_month_tds = 'August ' && ms_input_data-year[ 1 ]-low && ' TDS' .
        third_month_tds = 'September ' && ms_input_data-year[ 1 ]-low && ' TDS' .
      WHEN '03'.
        first_month_gross = 'October ' && ms_input_data-year[ 1 ]-low && ' Gross' .
        second_month_gross = 'November ' && ms_input_data-year[ 1 ]-low && ' Gross' .
        third_month_gross = 'December ' && ms_input_data-year[ 1 ]-low && ' Gross' .
        first_month_tds = 'October ' && ms_input_data-year[ 1 ]-low && ' TDS' .
        second_month_tds = 'November ' && ms_input_data-year[ 1 ]-low && ' TDS' .
        third_month_tds = 'December ' && ms_input_data-year[ 1 ]-low && ' TDS' .
      WHEN '04'.
        first_month_gross = 'January ' && ms_input_data-year[ 1 ]-low && ' Gross' .
        second_month_gross = 'February ' && ms_input_data-year[ 1 ]-low && ' Gross' .
        third_month_gross = 'March ' && ms_input_data-year[ 1 ]-low && ' Gross' .
        first_month_tds = 'January ' && ms_input_data-year[ 1 ]-low && ' TDS' .
        second_month_tds = 'February ' && ms_input_data-year[ 1 ]-low && ' TDS' .
        third_month_tds = 'March ' && ms_input_data-year[ 1 ]-low && ' TDS' .
    ENDCASE.
    DATA(lr_columns)  =  lo_alv->get_columns( ).

    DATA(lr_column)   =  lr_columns->get_column( 'FMG' ).

    lr_column->set_long_text( first_month_gross ).
*
    lr_column->set_medium_text( 'first_month_gross' ).

    lr_column->set_short_text( 'FMG' ).

    lr_column->set_optimized( ).

    lr_column  =  lr_columns->get_column( 'FMTDS' ).

    lr_column->set_long_text( first_month_tds ).
*
    lr_column->set_medium_text( 'first_month_tds' ).

    lr_column->set_short_text( 'FMTDS' ).

    lr_column->set_optimized( ).


    lr_column   =  lr_columns->get_column( 'SMG' ).

    lr_column->set_long_text( second_month_gross ).

    lr_column->set_medium_text( 'second_month_gross' ).

    lr_column->set_short_text( 'SMG' ).

    lr_column->set_optimized( ).

    lr_column   =  lr_columns->get_column( 'SMTDS' ).

    lr_column->set_long_text( second_month_tds ).

    lr_column->set_medium_text( 'second_month_tds' ).

    lr_column->set_short_text( 'SMTDS' ).

    lr_column->set_optimized( ).


    lr_column   =  lr_columns->get_column( 'TMG' ).

    lr_column->set_long_text( third_month_gross ).

    lr_column->set_medium_text( 'third_month_gross' ).

    lr_column->set_short_text( 'TMG' ).

    lr_column->set_optimized( ).

    lr_column   =  lr_columns->get_column( 'TMTDS' ).

    lr_column->set_long_text( third_month_tds ).

    lr_column->set_medium_text( 'third_month_tds' ).

    lr_column->set_short_text( 'TMTDS' ).

    lr_column->set_optimized( ).

    lr_column   =  lr_columns->get_column( 'GRAND_TOTAL_GROSS' ).

    lr_column->set_long_text( 'Grand Total Gross' ).

    lr_column->set_medium_text( 'Grand Total Gross' ).

    lr_column->set_short_text( 'GTG' ).

    lr_column->set_optimized( ).

    lr_column   =  lr_columns->get_column( 'TOTAL_TDS_DEDUCTED' ).

    lr_column->set_long_text( 'Total TDS deducted' ).

    lr_column->set_medium_text( 'Total TDS deducted' ).

    lr_column->set_short_text( 'TTD' ).

    lr_column->set_optimized( ).

    lr_column   =  lr_columns->get_column( 'WAERS' ).

    lr_column->set_visible( abap_false ).

    "Display the ALV Grid
    lo_alv->display( ).
  ENDMETHOD.
  
  "COLLECT_DATA"
  METHOD collect_data.
    LOOP AT mt_pa0000 INTO DATA(ls_pa0000) GROUP BY ( pernr = ls_pa0000-pernr )
      ASCENDING
       ASSIGNING FIELD-SYMBOL(<lt_emp_grp>).
      LOOP AT GROUP <lt_emp_grp> INTO DATA(ls_group).
        READ TABLE mt_pa0002 INTO DATA(ls_pa0002) WITH KEY pernr = ls_group-pernr
        BINARY SEARCH.
        IF sy-subrc IS INITIAL.
          "Get empid and name and Gender
          APPEND INITIAL LINE TO mt_output ASSIGNING FIELD-SYMBOL(<fs_output>).
          <fs_output>-emp_name = ls_pa0002-vorna && | | && ls_pa0002-nachn.
          <fs_output>-pernr = ls_pa0002-pernr.
          IF sy-subrc EQ 0.
            IF ls_pa0002-gesch EQ '1'.
              <fs_output>-gender = 'M'.
*                write: / 'M'.
            ELSEIF
             ls_pa0002-gesch EQ '2'.
              <fs_output>-gender = 'F'.
*                 write: /'F'.
            ENDIF.
          ENDIF.


*          <fs_output>-gender = ls_pa0002-gesch.
        ENDIF.
        "Get orgid
        READ TABLE mt_pa0001 INTO DATA(ls_pa0001) WITH KEY pernr = ls_group-pernr
        BINARY SEARCH.
        IF sy-subrc IS INITIAL.
          READ TABLE mt_t527x INTO DATA(ls_t527x) WITH KEY orgeh = ls_pa0001-orgeh BINARY SEARCH.
          IF sy-subrc IS INITIAL.
            <fs_output>-dep_name = ls_t527x-orgtx.
          ENDIF.
        ENDIF.
        "Get Grade of an employee
        READ TABLE mt_pa0008 INTO DATA(ls_pa0008) WITH KEY pernr = ls_group-pernr BINARY SEARCH.
        IF sy-subrc IS INITIAL.
          <fs_output>-trfgr = ls_pa0008-trfgr.
        ENDIF.
        "Get date of joining
*        READ TABLE mt_pa0000 INTO DATA(ls_doj) WITH KEY pernr = ls_group-pernr
*                                                           massn = '05'.
*        IF sy-subrc IS INITIAL.
*          <fs_output>-doj = ls_doj-begda.
*        ENDIF.
*        Read table mt_pa0041 into data(ls_doj) with key pernr = ls_group-pernr
*                                                       dar01 = 'OH'.
*
*          if sy-subrc is initial.
*            <fs_output>-doj = ls_doj-begda.
*          endif.
        "Get date of Leaving
*        READ TABLE mt_pa0000 INTO DATA(ls_dol) WITH KEY pernr = ls_group-pernr
*                                                           massn = '60'.
*        IF sy-subrc IS INITIAL.
*          <fs_output>-dol = ls_dol-begda - 1.
*        ENDIF.
*         read table mt_pa0041 into data(ls_dol) with key pernr = ls_group-pernr
*                                                             dar02 = 'U6'.
*            if sy-subrc is initial.
*             <fs_output>-dol = ls_dol-endda.
*           endif.
        LOOP AT mt_pa0041 INTO DATA(ls_mt_pa0041).
          DO 6 TIMES VARYING ls_mt_pa0041-dar01 FROM ls_mt_pa0041-dar01 NEXT ls_mt_pa0041-dar02
             VARYING ls_mt_pa0041-dat01 FROM ls_mt_pa0041-dat01 NEXT ls_mt_pa0041-dat02 .
            CASE ls_mt_pa0041-dar01.
              WHEN 'OH'.
                <fs_output>-doj = ls_mt_pa0041-dat01.
              WHEN 'U6'.
                <fs_output>-dol = ls_mt_pa0041-dat01.
            ENDCASE.
          ENDDO.

        ENDLOOP.
        "Get date of birtday
        READ TABLE mt_pa0002 INTO DATA(ls_dob) WITH KEY pernr = ls_group-pernr BINARY SEARCH.
        IF sy-subrc IS INITIAL.
          <fs_output>-dob = ls_dob-gbdat.
        ENDIF.
        "PAN
        READ TABLE mt_pa0185 INTO DATA(ls_pa0185) WITH KEY pernr = ls_group-pernr
                                                           subty = '02'.
        IF sy-subrc IS INITIAL.
          <fs_output>-pan = ls_pa0185-icnum.
        ENDIF.
        "Get payroll
        get_payroll_results( CHANGING cs_output = <fs_output>  ).
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.
  
  "FIRST_MONTH_GROSS"
  METHOD FIRST_MONTH_GROSS.
    LOOP AT is_payin_result-inter-rt INTO DATA(ls_rt).
      CASE ls_rt-lgart.
        WHEN '/101' OR '8710'.
          cs_output-fmg = ls_rt-betrg + cs_output-fmg.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.
  
  "FIRST_MONTH_TDS"
  METHOD FIRST_MONTH_TDS.
    LOOP AT is_payin_result-inter-rt INTO DATA(ls_rt).
      CASE ls_rt-lgart.
        WHEN '/460'.
          cs_output-fmtds = ls_rt-betrg + cs_output-fmtds.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.
  
  "SECOND_MONTH_GROSS"
  METHOD SECOND_MONTH_GROSS.
    LOOP AT is_payin_result-inter-rt INTO DATA(ls_rt).
      CASE ls_rt-lgart.
        WHEN '/101' OR '8710'.
          cs_output-smg = ls_rt-betrg + cs_output-smg.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.
  
  "SECOND_MONTH_TDS"
  METHOD SECOND_MONTH_TDS.
    LOOP AT is_payin_result-inter-rt INTO DATA(ls_rt).
      CASE ls_rt-lgart.
        WHEN '/460'.
          cs_output-smtds = ls_rt-betrg + cs_output-smtds.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.
  
  "THIRD_MONTH_GROSS"
  METHOD THIRD_MONTH_GROSS.
    LOOP AT is_payin_result-inter-rt INTO DATA(ls_rt).
      CASE ls_rt-lgart.
        WHEN '/101' OR '8710'.
          cs_output-tmg = ls_rt-betrg + cs_output-tmg.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.
  
  "THIRD_MONTH_TDS"
  METHOD THIRD_MONTH_TDS.
    LOOP AT is_payin_result-inter-rt INTO DATA(ls_rt).
      CASE ls_rt-lgart.
        WHEN '/460'.
          cs_output-tmtds = ls_rt-betrg + cs_output-tmtds.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.
  
  "GRAND_TOTAL_GROSS"
   METHOD GRAND_TOTAL_GROSS.
    cs_output-grand_total_gross = cs_output-fmg + cs_output-smg + cs_output-tmg.
  ENDMETHOD.
  
  "TOTAL_TDS_DEDUCTED"
   METHOD TOTAL_TDS_DEDUCTED.
    cs_output-total_tds_deducted = cs_output-fmtds + cs_output-smtds + cs_output-tmtds.
  ENDMETHOD.
  
  "READ_PAYROLL_RESULT"
  method READ_PAYROLL_RESULT.

    CALL FUNCTION 'PYXX_READ_PAYROLL_RESULT'
      EXPORTING
        clusterid                    = IV_RELID
        employeenumber               = iv_pernr
        sequencenumber               = iv_seqnr
      CHANGING
        payroll_result               = rs_payin_result
      EXCEPTIONS
        illegal_isocode_or_clusterid = 1
        error_generating_import      = 2
        import_mismatch_error        = 3
        subpool_dir_full             = 4
        no_read_authority            = 5
        no_record_found              = 6
        versions_do_not_match        = 7
        error_reading_archive        = 8
        error_reading_relid          = 9
        OTHERS                       = 10.
  endmethod.
  
  "FETCH_PA0041"
   method FETCH_PA0041.
 select * from pa0041 into table mt_pa0041
   for all entries in mt_pa0000
    where pernr = mt_pa0000-pernr.

    sort mt_pa0041 by pernr.
  endmethod.
  
  "READ_PA0041_RESULT"
  method READ_PA0041_RESULT.

*DATA PERNR           TYPE PERNR_D.
*DATA KEYDT           TYPE DATUM.
*DATA DATAR           TYPE DATAR.
*DATA MESSAGE_HANDLER TYPE REF TO IF_HRPA_MESSAGE_HANDLER.
*DATA DATE            TYPE P0041-DAT01.
*DATA IS_OK           TYPE BOOLE_D.

CALL FUNCTION 'HR_ECM_GET_DATETYP_FROM_IT0041'
  EXPORTING
    pernr                 = pernr
    keydt                 = keydt
    datar                 = datar
    message_handler       = message_handler
* IMPORTING
*   DATE                  = DATE
*   IS_OK                 = IS_OK
          .


  endmethod.
  
"SE38"
REPORT zhr_quarterly_tax_report.
DATA:lv_year     TYPE gjahr,
     lv_pernr    TYPE pernr_d,
     lv_quarters TYPE zhr_quarters_de.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
SELECT-OPTIONS:s_pernr FOR lv_pernr,
               s_year FOR lv_year NO INTERVALS NO-EXTENSION OBLIGATORY,
               s_quart FOR lv_quarters NO INTERVALS NO-EXTENSION OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.
  NEW ZCL_QUARTERLY_TAX2( VALUE #( pernr   = s_pernr[]
                                         year    = s_year[]
                                         quarter = s_quart[] ) )->execute( ).
                                         
