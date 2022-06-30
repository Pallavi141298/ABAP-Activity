TABLES: pernr, t512t.

INFOTYPES: 0001.

*Table data containing directory to PCL2 payroll results file
DATA: BEGIN OF rgdir OCCURS 100.
 INCLUDE STRUCTURE pc261.
DATA: END OF rgdir.

DATA: payroll TYPE pay99_result.
DATA: rt_header TYPE LINE OF hrpay99_rt.
DATA: country LIKE t001p-molga,
 number LIKE pc261-seqnr,
  relid type pcl2-relid,
  client type pcl2-client.


GET pernr.
 rp_provide_from_last p0001 space pn-begda pn-endda.

"read table RGDIR from cluster cu
 CALL FUNCTION 'CU_READ_RGDIR'
 EXPORTING
     persnr               = p0001-pernr
 IMPORTING
    molga                = country
 TABLES
   in_rgdir            = rgdir
 EXCEPTIONS
 no_record_found         = 1
 OTHERS = 2.

 IF sy-subrc = 1.
 WRITE: / 'No records found for '(001), pernr-pernr.
 REJECT.
 ENDIF.

"sequential number for the last payroll result, transfer table RGDIR to below function module"

 CALL FUNCTION 'CD_READ_LAST'
 EXPORTING
    begin_date       = pn-begda
    end_date        = pn-endda
 IMPORTING
    out_seqnr      = number
 TABLES
    rgdir         = rgdir
 EXCEPTIONS
  no_record_found   = 1
 OTHERS = 2.

 IF sy-subrc = 1.
 WRITE: / 'No payroll result found for'(002), pn-paper.
 ELSE.

   "read the payroll result for the sequential number

   CALL FUNCTION 'PYXX_READ_PAYROLL_RESULT'
     EXPORTING
      CLUSTERID                          = relid
       EMPLOYEENUMBER                     = p0001-pernr
       SEQUENCENUMBER                     = number
*      READ_ONLY_BUFFER                   = 'x '
      READ_ONLY_INTERNATIONAL            = 'x'
*      ARC_GROUP                          =  arc_group
*      CHECK_READ_AUTHORITY               = 'X'
*      FILTER_CUMULATIONS                 = 'X'
*      CLIENT                             = CLIENT
*    IMPORTING
*     VERSION_NUMBER_PAYVN               = VERSION_NUMBER_PAYVN
*      VERSION_NUMBER_PCL2                = VERSION_NUMBER_PCL2
     CHANGING
       PAYROLL_RESULT                     = payroll
    EXCEPTIONS
      ILLEGAL_ISOCODE_OR_CLUSTERID       = 1
      ERROR_GENERATING_IMPORT            = 2
      IMPORT_MISMATCH_ERROR              = 3
      SUBPOOL_DIR_FULL                   = 4
      NO_READ_AUTHORITY                  = 5
      NO_RECORD_FOUND                    = 6
      VERSIONS_DO_NOT_MATCH              = 7
      ERROR_READING_ARCHIVE              = 8
      ERROR_READING_RELID                = 9.


* IF sy-subrc = 0.
 PERFORM print_kr.
* ELSE.
* WRITE: / 'Result could not be read (003)'.
* ENDIF.
 ENDIF.

 FORM print_kr.
 FORMAT INTENSIFIED ON.
 WRITE: / p0001-pernr,
 p0001-ename(15),
 p0001-werks,
 p0001-btrtl.
 FORMAT INTENSIFIED OFF.
 SKIP 1.
 WRITE: / 'For period: '(004),
 30 payroll-inter-versc-fpper+4(2),
 payroll-inter-versc-fpper+0(4),
 payroll-inter-versc-abkrs,
 / 'In-period: '(005),
 30 payroll-inter-versc-inper+4(2),
 payroll-inter-versc-inper+0(4),
 payroll-inter-versc-iabkrs.
 SKIP 1.
 WRITE: 'Results table: '(006).
 SKIP 1.
 LOOP AT payroll-inter-rt INTO rt_header.
 PERFORM re512t USING payroll-inter-versc-molga
 rt_header-lgart.
 WRITE: / rt_header-lgart,
 t512t-lgtxt,
 rt_header-betrg CURRENCY rt_header-amt_curr.
 ENDLOOP.
ENDFORM.

FORM re512t USING value(country_grouping)
 value(wtype).
 CHECK t512t-sprsl NE sy-langu
 OR t512t-molga NE country_grouping
 OR t512t-lgart NE wtype.
 SELECT SINGLE * FROM t512t
 WHERE sprsl EQ sy-langu
 AND molga EQ country_grouping
 AND lgart EQ wtype.
 IF sy-subrc NE 0.
 CLEAR t512t.
 ENDIF.
ENDFORM.
