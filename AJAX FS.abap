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
      "chance made by me"
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
"Chance made by me"
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
