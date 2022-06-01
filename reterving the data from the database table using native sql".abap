reterving the data from the database table using native sql"

programming variables refereing the data elements"

data : f1 type kunnr,
       f2 type land1_gp,
       f3 type name1_gp,
       f4 type ort01_gp.(or)

programming variables refereing the data fields directly"

data : f1 type kna1-kunnr,
       f2 type kna1-land1,
       f3 type kna1-name1,
       f4 type kna1-ort01.(or)

programming variables refereing the data fields directly"

data : kunnr type kna1-kunnr,
       land1 type kna1-land1,
       name1 type kna1-name1,
       ort01 type kna1-ort01.

parameters p_kunnr type kna1-kunnr.

select single kunnr land1 name1 ort01
  from Kna1
into (kunnr,land1,name1,ort01)
  where kunnr = p_kunnr.

if sy-subrc eq 0.
 message 'Customer Found' type 'I'.
write: /(30) 'Customer Number',kunnr.
write: /(30) 'Customer Country',land1.
write: /(30) 'Customer name',name1.
write: /(30) 'Customer city',ort01.

else.
 message 'Customer not found' type 'I'.
endif.
---------------------------------------------------------------------------------------------------------------------
inside of using 4 fields go for workarea"

parameters p_kunnr type kna1-kunnr.

types : begin of ty_customer,
        kunnr type kna1-kunnr,
        land1 type kna1-land1,
        name1 type kna1-name1,
        ort01 type kna1-ort01,
 end of ty_customer.

data wa_customer type ty_customer.

select single kunnr land1 name1 ort01
  from Kna1
into wa_customer
  where kunnr = p_kunnr.
if sy-subrc eq 0.

write: / 'Customer',p_kunnr,'is found'.
write: /(25) 'customer no',wa_customer-kunnr,
      /(25) 'customer country',wa_customer-land1,
      /(25) 'customer name',wa_customer-name1,
      /(25) 'customer city',wa_customer-ort01.

else.
 message 'Customer not found' type 'I'.
endif.
