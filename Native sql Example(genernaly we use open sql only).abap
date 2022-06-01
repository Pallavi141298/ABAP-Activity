parameters p_kunnr type kna1-kunnr.

data: v_kunnr type kna1-kunnr,
      v_land1 type kna1-land1,
      v_name1 type kna1-name1,
      v_ort01 type kna1-ort01.

EXEC Sql.
  select kunnr, land1, name1, ort01
  from kna1
  into :v_kunnr, :v_land1, :v_name1, :v_ort01
  where kunnr = :p_kunnr
endexec.

if sy-subrc eq 0.

write: / 'Customer',p_kunnr,'is found'.
write: /(25) 'customer no',v_kunnr,
      /(25) 'customer country',v_land1,
      /(25) 'customer name',v_name1,
      /(25) 'customer city',v_ort01.

else.
 message 'Customer not found' type 'I'.
endif.
