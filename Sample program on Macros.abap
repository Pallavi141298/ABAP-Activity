Simple program on macros"

tables: pernr.
infotypes: 0001.

start-of-selection.
get pernr.
write: /'Result from macros'.

format color 3.
rp-provide-from-frst p0001 space pn-begda pn-endda.
if pnp-sw-found = 1.
write: /'Result from rp-provide frst'.
write: / p0001-pernr, p0001-begda, p0001-endda.
endif.
format color off.

format color 4.
rp-provide-from-last p0001 space pn-begda pn-endda.
if pnp-sw-found = 1.
write: /'Result from rp-provide last'.
write: / p0001-pernr, p0001-begda, p0001-endda.
endif.
format color off.

format color 5.
rp-read-infotype pernr-pernr 0001 p0001 pn-begda pn-endda.
if pnp-sw-found = 1.
write: /'Result from rp-read-infotype'.

loop at p0001.
write: / p0001-pernr, p0001-begda, p0001-endda.
endloop.

endif.
format color off.
end-of-selection.
