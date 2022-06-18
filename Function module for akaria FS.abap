FUNCTION ZTABLE3_3.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(INPUT_LOCATION) TYPE  CHAR30
*"  EXPORTING
*"     REFERENCE(OUTPUT_PERSONALAREA) TYPE  CHAR30
*"     REFERENCE(OUTPUT_PSA) TYPE  CHAR30
*"  EXCEPTIONS
*"      NOT_SUPPORTED
*"----------------------------------------------------------------------

"creation of the functional module with hard coding"
*types: begin of ty_ztable3,
*      location type ztable3-location,
*      personalarea type ztable3-personalarea,
*      personalsubarea type ztable3-personalsubarea,
*   end of ty_ztable3.
*
*
*data: it_ztable3 type table of ty_ztable3,
*      wa_ztable3 type ty_ztable3.
*
*select location personalarea personalsubarea
*     from ztable3
*  into table it_ztable3
*   where location = '05000006'.
*
*if sy-subrc eq 0.
**write: /'No records found',sy-dbcnt.
*loop at it_ztable3 into wa_ztable3.
*write: / wa_ztable3-personalarea,
*         wa_ztable3-personalsubarea.
*endloop.
*else.
*message 'No data found for the given location' type 'I'.
*endif.

"Creation of the functional module without hardcoding"
types: begin of ty_ztable3,
      location type ztable3-location,
      personalarea type ztable3-personalarea,
      personalsubarea type ztable3-personalsubarea,
   end of ty_ztable3.

data: it_ztable3 type table of ty_ztable3,
      wa_ztable3 type ty_ztable3.

data: r_location type range of ztable3-location.

select location  personalarea personalsubarea
   from ztable3
 into table it_ztable3
 where location eq INPUT_LOCATION.


if sy-subrc eq 0.
*loop at it_ztable3 into wa_ztable3.
*write: / wa_ztable3-personalarea,
*         wa_ztable3-personalsubarea.

loop at it_ztable3 into wa_ztable3.

OUTPUT_PERSONALAREA  = wa_ztable3-personalarea. 
OUTPUT_PSA =  wa_ztable3-personalsubarea. 

endloop.
else.
message 'No data found for the given location' type 'I'.
endif.

ENDFUNCTION.
