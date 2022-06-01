selection-screen begin of block bk1 with frame title t1.

selection-screen begin of line.
selection-screen comment 6(25) lb1.
parameters p_matnr type mara-matnr.
selection-screen end of line.

selection-screen end of block bk1.

selection-screen skip 2.

selection-screen begin of block bk2 with frame title t2.

selection-screen begin of line.
selection-screen comment 6(25) lb2 modif id id1.
parameters p_mtart type mara-mtart modif id id1.
selection-screen end of line.

selection-screen begin of line.
selection-screen comment 6(25) lb3 modif id id1.
parameters p_mbrsh type mara-mbrsh modif id id1.
selection-screen end of line.

selection-screen begin of line.
selection-screen comment 6(25) lb4 modif id id1.
parameters p_matkl type mara-matkl modif id id1.
selection-screen end of line.

selection-screen end of block bk2.

selection-screen skip 1.

selection-screen pushbutton 12(20) b1 user-command fc1.

types: begin of ty_f4values,
       matnr type mara-matnr,
       mtart type mara-mtart,
  end of ty_f4values.

data t_f4values type table of ty_f4values.


initialization.
lb1 = 'Material Number'.
t1 = 'Input Block'.
lb2 = 'Material Type'.
lb3 = 'Industry sector'.
lb4 = 'Material Group'.
t2 = 'Material Data'.
b1 = 'Get Material Data'.

perform invisibleblock2.

at selection-screen on value-request for p_matnr.
*message 'Custom f4 help for the material no' type 'I'.
 perform getf4values.
"get F4 values"
if t_f4values is not initial.
"populate F4 value"


CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
  EXPORTING

    RETFIELD               = 'matnr'
    DYNPPROG               = sy-repid
   DYNPNR                  = sy-dynnr
   DYNPROFIELD             = 'p_matnr'
   VALUE_ORG               = 's'
  TABLES
    VALUE_TAB              = t_f4values

 EXCEPTIONS
   PARAMETER_ERROR        = 1
   NO_VALUES_FOUND        = 2
  others                  = 3
          .


endif.

at selection-screen.
  case sy-ucomm.
   when 'FC1'.
   if p_matnr is not initial.
     select single mtart mbrsh matkl
         into (p_mtart,p_mbrsh,p_matkl)
      from mara
   where matnr = p_matnr.
  if sy-subrc eq 0.
  message 'material Found' type 'I'.
  else.
 message 'material not found' type 'I'.
clear : p_mtart,
        p_mbrsh,
        p_matkl.
  endif.
  endif.
endcase.

FORM INVISIBLEBLOCK2 .
loop at screen.
if screen-group1 = 'ID1'.
   screen-invisible = '1'.
   screen-input = '0'. "additional field needs to be set for input"
   modify screen.
endif.
endloop.
ENDFORM.

FORM GETF4VALUES .
select matnr mtart
    from mara
   into table t_f4values
   where mtart in ('FRIP','AEM','ERSA').

ENDFORM.
