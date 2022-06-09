Simple Example"

tables: pernr. "Key fields for personnel admin infotypes"
infotypes: 0001. "infotype declaration area"
start-of-selection.
Get pernr.          "get pernr gets all data realted to pernr"
provide * from p0001 between pn-begda and pn-endda.
write: / p0001-pernr,
         p0001-stell,
         p0001-begda,
         p0001-SNAME,
         p0001-ENAME,
         p0001-KOKRS.
endprovide.
