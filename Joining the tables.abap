Examples Of Joining the table tables"

tables: pernr,
        t555v.
infotypes: 0002,
          0007.
data: name like pernr-ename.

GET pernr.
   provide CNAME TITEL GBDAT GBORT from p0002
     ZTERF  from p0007 between pn-begda and pn-endda.
if p0007_valid ne 'x'.
concatenate p0002-CNAME p0002-TITEL p0002-GBDAT p0002-GBORT into name
 separated by space.
perform re555v using p0007-zterf.
write: / pernr-pernr,
        name,
        (20) t555v-ztext,
        p0007-begda,
        p0007-endda.
endif.
endprovide.

form re555v using value(tm_status).
check sy-langu ne t555v-sprsl or
   tm_status ne t555v-zterf.

select single * from t555v where sprsl eq sy-langu
                           and zterf eq tm_status.

if sy-subrc ne 0.
move space to t555v.
endif.
endform.

Example 2"

tables: pernr.
Infotypes: 0002,
           0006.
data: name like pernr-ename.

Get pernr.
  provide * from p0002
          * from p0006 between pn-begda and pn-endda
            where p0006-subty = '1'.
   if p0006_valid ne 'x'.
   concatenate p0002-nachn p0002-vorna into name
   separated by space.
  perform print_data.
endif.
endprovide.

form print_data.
write: / p0002-pernr no-zero,
         sy-vline,
        p0002-begda,
        sy-vline,
        p0002-endda,
        sy-vline,
        (30) name,
        sy-vline,
        (20) p0006-ort01.
endform.

Example 3"

tables: t511,
        pernr.
infotypes: 0015,
           0003.

data: name like pernr-ename.

Get pernr.
provide * from p0015
        * from p0003 between pn-begda and pn-endda
       where p0003-subty = '1'.
   if p0003_valid ne 'x'.
concatenate p0015-WAERS p0015-ESTDT into name
 separated by space.
perform print_data.
endif.
endprovide.

form print_data.
write: / p0015-pernr no-zero,
         sy-vline,
        p0015-begda,
        sy-vline,
        p0015-endda,
        sy-vline,
        (30) name,
        sy-vline,
        (20) p0003-ORDEX.
endform.

Example 3"

tables: pernr,
        t555v.
infotypes: 0007,
          0002.
data: name like pernr-ename.


GET pernr.
   provide WOSTD ARBST WKWDY JRSTD WKWDY from p0007
   NAMZ2  from p0002 between pn-begda and pn-endda.
if p0007_valid ne 'x'.
concatenate  p0007-WOSTD p0007-ARBST p0007-WKWDY p0007-JRSTD p0007-WKWDY into name
 separated by space.
perform re555v using p0002-NAMZ2.
write: / pernr-pernr,
        name,
        (20) t555v-ztext,
        p0002-begda,
        p0002-endda.
endif.
endprovide.


form re555v using value(tm_status).
check sy-langu ne t555v-sprsl or
   tm_status ne t555v-zterf.

select single * from t555v where sprsl eq sy-langu
                           and zterf eq tm_status.

if sy-subrc ne 0.
move space to t555v.
endif.
endform.

example 4"

tables: pernr.
Infotypes: 0022,
           0006.
data: name like pernr-ename.

Get pernr.
  provide * from p0022
          * from p0006 between pn-begda and pn-endda
            where p0006-subty = '1'.
   if p0006_valid ne 'x'.
   concatenate p0022-KSBEZ p0022-DPTMT into name
   separated by space.
  perform print_data.
endif.
endprovide.

form print_data.
write: / p0022-pernr no-zero,
         sy-vline,
        p0022-begda,
        sy-vline,
        p0022-endda,
        sy-vline,
        (30) name,
        sy-vline,
        (20) p0006-ort01.
endform.

example 5"

tables: pernr,
        t77s0.
infotypes: 0008,
          0007.
data: name like pernr-ename.


GET pernr.
   provide UNAME TRFGR from p0008
     ZTERF  from p0007 between pn-begda and pn-endda.
if p0007_valid ne 'x'.
concatenate p0008-UNAME p0008-TRFGR into name
 separated by space.
perform re555v using p0007-zterf.
write: / pernr-pernr,
        name,
        (20) t77s0-GSVAL,
        p0007-begda,
        p0007-endda.
endif.
endprovide.

form re555v using value(tm_status).
check sy-langu ne t77s0-SEMID or
   tm_status ne t77s0-GRPID.

select single * from t77s0 where SEMID eq sy-langu
                           and GRPID eq tm_status.

if sy-subrc ne 0.
move space to t77s0.
endif.
endform.
