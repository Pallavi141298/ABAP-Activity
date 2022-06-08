parameters: p_year(4) type c.
data: i type i,
      j type i,
      k type i.

i = p_year mod 4.
j = p_year mod 100.
k = j mod 2.

if i is initial and k is initial.
write: /'This is leap year'.
else.
write: /'This is not leap year'.
endif.
