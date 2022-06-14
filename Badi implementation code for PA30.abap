"The customer requirement is to check the permissibility of a specific absence code
9000 by employee group subgroup combination. SAP configuration does not allow
specifying this restriction."

Implement the AFTER_INPUT method (see Figure 6.37) in BAdI HRPAD00INFTY (as
shown in Figure 6.35 and Figure 6.36) to check for the employee group/subgroup
combination when infotype 2001 is entered; create an error message if absence
code ‘9000’ is used for employees that are not assigned to specifi ed Employee
Group ‘1’ and Employee Subgroup ‘02’. See Listing 6.3.



FiELD-SYMBOLS: <p2001> TYPE p2001.
  DATA: i0001 TYPE TABLE OF p0001,
  w0001 type p0001.

  CASE new_innnn-infty.
  WHEN '2001'.
  ASSIGN new_innnn TO <p2001> CASTING.

 IF <p2001>-subty = '0100'.

CALL FUNCTION 'HR_READ_INFOTYPE'
  EXPORTING
    PERNR                 = <P2001>-pernr
    INFTY                 = '0001'
 TABLES
    INFTY_TAB             = i0001[]
 EXCEPTIONS
   INFTY_NOT_FOUND       = 1.

IF sy-subrc = 0.
LOOP AT i0001 INTO w0001
 WHERE pernr = <P2001>-pernr
 AND begda <= <P2001>-begda
 AND endda >= <P2001>-endda.
 EXIT.
 ENDLOOP.
 ENDIF.

IF sy-subrc = 0.
 IF w0001-persG EQ '1' and
  w0001-persK EQ '02'.
 ELSE.
 MESSAGE e999(ythr).
 ENDIF.
 endif.
 ENDIF.

ENDCASE.
