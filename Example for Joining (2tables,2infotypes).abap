"Declaration"
*tables: pernr,
*        t555v.
*infotypes: 0002,
*          0007.
*data: name like pernr-ename.
*
*"processing"
*
*GET pernr.
*   provide NACHN VORNA from p0002
*     ZTERF  from p0007 between pn-begda and pn-endda.
*if p0007_valid ne 'x'.
*concatenate p0002-nachn p0002-vorna into name
* separated by space.
*perform re555v using p0007-zterf.
*write: / pernr-pernr,
*        name,
*        (20) t555v-ztext,
*        p0007-begda,
*        p0007-endda.
*endif.
*endprovide.
*
*"Read time management status"
*
*form re555v using value(tm_status).
*check sy-langu ne t555v-sprsl or
*   tm_status ne t555v-zterf.
*
*select single * from t555v where sprsl eq sy-langu
*                           and zterf eq tm_status.
*
*if sy-subrc ne 0.
*move space to t555v.
*endif.
*endform.
