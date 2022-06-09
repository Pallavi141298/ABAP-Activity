Example with logical database PNP(2 table, 2infotypes)"

tables: pernr,t528t.

infotypes: 0001,0008.

data: begin of itab occurs 0,
pernr like p0001-pernr,
sname like p0001-sname,
plans like p0001-plans,
begda like p0001-begda,
endda like p0001-endda,
ptext like t528t-plstx,
ansal like p0008-ansal,
end of itab.

start-of-selection.
Get pernr.

rp_provide_from_frst p0001 space pn-begda pn-endda.
if pnp-sw-found = 1.
itab-sname = p0001-sname.
itab-plans = p0001-plans.
itab-begda = p0001-begda.
itab-endda = p0001-endda.
endif.

rp_provide_from_frst p0008 space pn-begda pn-endda.
if pnp-sw-found = 1.
itab-ansal = p0008-ansal.
endif.

data: vtext(50) type c.
select single plstx into vtext
   from t528t
where plans = itab-plans and sprsl = 'EN'.
if sy-subrc eq 0.
itab-ptext = vtext.
endif.

append itab.
end-of-selection.

clear itab.
loop at itab.
write: / itab-pernr,
        itab-sname,
        itab-plans,
        itab-begda,
        itab-endda,
        itab-ansal.
endloop.
