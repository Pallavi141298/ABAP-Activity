*case 1:
*tables vbak."creats the workarea based on dic.str vbak - not reccomend"
*select-options so_netwr for vbak-netwr.

*case 2:
*data v_netwr type netwr_ak."data element"
*select-options so_netwr for v_netwr.

*case 3:
data v_netwr type vbak-netwr."db field"
select-options so_netwr for v_netwr default 1000 to 1200.

types : begin of ty_sales,
       vbeln type vbak-vbeln,
       erdat type vbak-erdat,
       erzet type vbak-erzet,
       ernam type vbak-ernam,
      netwr type vbak-netwr,
  end of ty_sales.

data : t_sales type table of ty_sales,
      wa_sales type ty_sales.

start-of-selection.
perform getsalesorders.
if t_sales is not initial.
describe table t_sales.
write: /'No of sales order in net value range',sy-tfill.
perform displaysalesorders.
else.
message 'No of sales order in net value range' type 'I'.
endif.

FORM GETSALESORDERS .
select vbeln erdat erzet ernam netwr
  from vbak
 into table t_sales
where netwr in so_netwr.

ENDFORM.

FORM DISPLAYSALESORDERS .
loop at t_sales into wa_sales.
write: / wa_sales-vbeln,
         wa_sales-erdat,
         wa_sales-erzet,
        wa_sales-ernam,
        wa_sales-netwr.
endloop.

ENDFORM.
