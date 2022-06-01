parameters p_land1(3) type c. "not recommended"

parameters p_land1 type land1_gp."ref data element"(or)

parameters p_land1 type kna1-land1. "ref db structure fields"

types: begin of ty_customer,
      kunnr type kna1-kunnr,
      name1 type kna1-name1,
      ort01 type kna1-ort01,
  end of ty_customer.

data: t_customer type table of ty_customer,
     wa_customer type ty_customer.

start-of-selection.
"retrive the data"
perform getcustomers.

FORM GETCUSTOMERS .
select kunnr name1 ort01
    from kna1
    into table t_customer
*   where land1 = 'AR' or land1 = 'AU' or land1 = 'IN'.
*    where land1 in ('AR','AU','IN').
    where land1 = p_land1.
*    order by name1."sorting in asscending order"
*    order by name1 descending.
if sy-subrc eq 0."atleast one record is retrived"
*write :/'No of records retrived', sy-dbcnt.(or)
describe table t_customer.
write :/'No of records retrived:',sy-tfill.
sort t_customer by name1.
loop at t_customer into wa_customer.
write :/ wa_customer-kunnr,
       / wa_customer-name1,
      / wa_customer-ort01.

endloop.
else.
message 'No data for given country key' type 'I'.
endif.
ENDFORM.
