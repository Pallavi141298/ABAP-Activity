tables: t551a,t550a.

types: begin of ty_client,
      TPRog type t550a-tprog,
      SOBEG type t550a-SOBEG,
  end of ty_client.

data: t_client type table of ty_client,
      wa_client type ty_client.

start-of-selection.
perform getclients.


FORM GETCLIENTS .
*write: /(21) 'ID', (21) 'In_time', (21) 'Out_time', (21) 'Day_index', (21) 'shift', (21) 'Time-Interval'.
select   tprog sobeg
    from t550a
    into table t_client
   where MOTPR = '24'.
if sy-subrc eq 0.
write: /'No of records retrived by',sy-dbcnt.
loop at t_client into wa_client.
write: /  wa_client-tprog,
          wa_client-sobeg.
endloop.
else.
message 'No data found for the given key' type 'I'.
endif.
ENDFORM.
