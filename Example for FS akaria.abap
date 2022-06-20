REPORT ZPROGRAM23 .

types: begin of ty_ztable3,
       location type ztable3-location,
       personalarea type ztable3-personalarea,
      personalsubarea type ztable3-personalsubarea,
   end of ty_ztable3.

data: it_ztable3 type table of ty_ztable3,
      wa_ztable3 type ty_ztable3,
     lv_location type ztable3-location.

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.

SELECT-OPTIONS: location for lv_location.

SELECTION-SCREEN END OF BLOCK B1.


START-OF-SELECTION.
perform selection_3.

FORM selection_3.

select location personalarea personalsubarea
   from ztable3
 into table it_ztable3  where location in location.

if sy-subrc eq 0.
*write: /'No records found',sy-dbcnt.
loop at it_ztable3 into wa_ztable3.
write: / wa_ztable3-personalarea,
         wa_ztable3-personalsubarea.
endloop.
else.
*message 'No data found for the given location' type 'I'.
endif.
endform.
