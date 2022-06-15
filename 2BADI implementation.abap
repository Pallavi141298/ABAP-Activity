" I am doing PA30 (Maintain HR Master Data) , entry Personnel no. (e.g. 1733), typing Infotype 2001 (Absences) and select Sty 1040 Maternity Leave  ( in SPRO -> Time Management -> Time Data Recording and Administration -> Absences -> Absence Catalog -> Define Absence Type ). then click Create button to Create Absence.

I want to validate data input when click Create button, If the Gender of 1733 = female  it can be created absence but when the gender is male it can't be processed.

Or we could show the message "Select Error"  after selecting Subtype Maternity Leave if the gender = male"
 
 
 
 
 method IF_EX_HRPAD00INFTY~BEFORE_OUTPUT.
*  break-point.
  FiELD-SYMBOLS: <p2001> TYPE p2001.

  data: i0002 type table of p0002,
        w0002 type p0002.

 CASE innnn-infty.
  WHEN '2001'.
  ASSIGN innnn TO <p2001> CASTING.

 IF <p2001>-subty = '0100'.

CALL FUNCTION 'HR_READ_INFOTYPE'
  EXPORTING
    PERNR                 = <P2001>-pernr
    INFTY                 = '0002'
 TABLES
    INFTY_TAB             = i0002
 EXCEPTIONS
   INFTY_NOT_FOUND       = 1.

if sy-subrc = 0.
LOOP AT i0002 INTO w0002
 WHERE pernr = <P2001>-pernr
 AND begda <= <P2001>-begda
 AND endda >= <P2001>-endda.
 EXIT.
 ENDLOOP.
endif.


*IF sy-subrc = 0.
* IF w0002-GESCH EQ '2'.
*elseif
*  w0002-GESCH eq '1'.
* ELSE.
* MESSAGE e999(ythr).
* ENDIF.
* endif.

IF sy-subrc = 0.
 IF w0002-GESCH EQ '2'.
 elseif
  w0002-GESCH eq '1'.
 MESSAGE e999(ythr).
else.
 Message 'EXIT' type 'I'.
 ENDIF.
 endif.

endif.
endcase.
 endmethod.
