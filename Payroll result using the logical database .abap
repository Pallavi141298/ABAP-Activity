TABLES: pernr, pyorgscreen, pytimescreen.

NODES:  payroll TYPE pay99_result.

Data: g_result_counter type i.

GET pernr.

WRITE: / 'Currently working on:', pernr-pernr.

ULINE.

GET payroll.

g_result_counter =  g_result_counter + 1.

WRITE: / 'Seq No. = ',     payroll-evp-seqnr,

         'In period =',  payroll-inter-versc-inper,

         'For period =', payroll-inter-versc-fpper,

         'Pay date =',   payroll-inter-versc-paydt.
         
         
         
         
  "Example for logical database dispalying the payroll result"
TABLES: pernr, pyorgscreen, pytimescreen, t512t.
NODES: payroll TYPE pay99_result.
INFOTYPES: 0001. "Organizational Assignment
DATA: rt_header TYPE LINE OF hrpay99_rt.
GET pernr.
 rp_provide_from_last p0001 space pn-begps pn-endps.
 WRITE: / p0001-pernr,
 p0001-ename(15),
 p0001-werks,
 p0001-btrtl.
 SKIP 1.

GET payroll.
 WRITE: / 'For-period:'(001),
 15 payroll-inter-versc-fpper+4(2),
 payroll-inter-versc-fpper+0(4),
 / 'In-Period: '(002),
 15 payroll-inter-versc-inper+4(2),
 payroll-inter-versc-inper+0(4).
 SKIP 1.
 WRITE: 'Results table: '(003).
 SKIP 1.

 LOOP AT payroll-inter-rt INTO rt_header.
 PERFORM re512t USING payroll-inter-versc-molga
 rt_header-lgart.
 WRITE: / rt_header-lgart,
 t512t-lgtxt,
 rt_header-betrg CURRENCY rt_header-amt_curr.
 ENDLOOP.

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
