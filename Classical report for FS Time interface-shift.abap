Example according to the FS Time interface-shift"
tables: t551a,t550a.

types: begin of ty_periodworkschedule,
      TPRG3 type t551a-tprg3,
  end of ty_periodworkschedule.

data: t_periodworkschedule type table of ty_periodworkschedule,
      wa_periodworkschedule type ty_periodworkschedule.

types: begin of ty_dailyworkscgedule,
      tprog type t550a-tprog,
     sobeg type t550a-sobeg,
     motpr type t550a-motpr,
  end of ty_dailyworkscgedule.

data: t_dailyworkscgedule type table of ty_dailyworkscgedule,
      wa_dailyworkscgedule type ty_dailyworkscgedule.

start-of-selection.
perform periodworkschedule.
perform dailyworkscgedule.

FORM periodworkschedule .
select   tprg3
    from t551a
    into table t_periodworkschedule.
 t_periodworkschedule = t_dailyworkscgedule.
*   where MOTPR = '24'.
if sy-subrc eq 0.
write: /'No of records retrived by',sy-dbcnt.
loop at t_periodworkschedule into wa_periodworkschedule.
write: /  wa_periodworkschedule-tprg3.
endloop.
else.
message 'No data found for the given key' type 'I'.
endif.
ENDFORM.


Form dailyworkscgedule.
select tprog sobeg motpr
     from t550a
   into table t_dailyworkscgedule
   where motpr = '24'.
if sy-subrc eq 0.
write: /'No of records retrived by',sy-dbcnt.
loop at t_dailyworkscgedule into wa_dailyworkscgedule.
write: / wa_dailyworkscgedule-tprog,
         wa_dailyworkscgedule-sobeg.

endloop.
endif.
endform.
