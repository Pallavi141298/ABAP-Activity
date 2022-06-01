*parameters p_abc(20) type c as listbox visible length 12 user-command fc1."synatx erroe"

data : gv_abc(15) type c.
parameters p_abc like gv_abc as listbox visible length 12 user-command fc1.

data: t_values type table of vrm_value,
     wa_value type vrm_value.

selection-screen begin of block bk1 with frame title t1.
parameters: p_c1 as checkbox modif id id1,
            p_c2 as checkbox modif id id1,
            p_c3 as checkbox modif id id1.
selection-screen end of block bk1.

selection-screen begin of block bk2 with frame title t2.
parameters: p_r1 radiobutton group grp1 modif id id2,
            p_r2 radiobutton group grp1 modif id id2,
           p_r3 radiobutton group grp1 modif id id2.
selection-screen end of block bk2.

selection-screen begin of block bk3 with frame title t3.
selection-screen comment 3(15) lb1 modif id id3.
selection-screen comment /3(15) lb2 modif id id3.
selection-screen comment /3(15) lb3 modif id id3.
selection-screen end of block bk3.

data gv_flag type i.

initialization.

perform preparevalues.
perform invisibleblocks.
t1 = 'courses'.
t2 = 'Insititue'.
t3 = 'Locations'.
lb1 = 'Banglore'.
lb2 = 'India'.
lb3 = 'Korea'.

at selection-screen.
case sy-ucomm.
when 'FC1'.
 if p_abc = 'k1'.
    gv_flag = 1.
 elseif p_abc = 'k2'.
    gv_flag = 2.
 elseif p_abc = 'k3'.
    gv_flag = 3.
  endif.
endcase.

at selection-screen output.
   if gv_flag = 1.
   perform visibleblock1.
elseif gv_flag = 2.
  perform visibleblock2.
 elseif gv_flag = 3.
perform visibleblock3.
endif.

at selection-screen on help-request for p_abc.
*   message 'f1 help for drop down' type 'I'.
CALL FUNCTION 'POPUP_TO_INFORM'
  EXPORTING
    TITEL         = 'F1 help form dropdown'
    TXT1          = 'select value from the dropdown'
    TXT2          = 'on selectig displays appropriate block'.



at selection-screen on help-request for p_c1.
*   message 'f1 help checkbox' type 'I'.
   message I000(zprogram22).

at selection-screen on help-request for p_r1.
*   message 'f1 help first radiobutton' type 'I'.
   message S001(Zprogram22).

at selection-screen on help-request for p_r2.
   message 'f1 help scond radiobutton' type 'I'.

at selection-screen on help-request for p_r3.
   message 'f1 help third radiobutton' type 'I'.


FORM PREPAREVALUES .
clear wa_value.
wa_value-key = 'k1'.
wa_value-text = 'Courses'.
append wa_value to t_values.

 clear wa_value.
wa_value-key = 'K2'.
wa_value-text = 'Insititue'.
append wa_value to t_values.

 clear wa_value.
wa_value-key = 'K3'.
wa_value-text = 'Locations'.
append wa_value to t_values.



CALL FUNCTION 'VRM_SET_VALUES'
  EXPORTING
    ID                    = 'p_abc'
    VALUES                = t_values
 EXCEPTIONS
   ID_ILLEGAL_NAME       = 1
          .

if sy-subrc eq 1.
    message 'Excepation Id illegal rasied' type 'I'.
elseif sy-subrc eq 2.
   message 'Unknown excepation' type 'I'.
endif.


ENDFORM.

FORM INVISIBLEBLOCKS .
loop at screen.
   if screen-group1 = 'ID1' or
     screen-group1 = 'ID2' or
    screen-group1 = 'ID3'.

*   if screen-name = 'bk1' or
*      screen-name = 't1' or
*      screen-name = 'p_c1' or
*      screen-name = 'p_c2' or
*      screen-name = 'p_c3' or
*      screen-name = 'bk2' or
*      screen-name = 't2' or
*      screen-name = 'p_r1' or
*      screen-name = 'p_r2' or
*      screen-name = 'p_r3' or
*      screen-name = 'bk3' or
*      screen-name = 't3' or
*      screen-name = 'lb1' or
*      screen-name = 'lb2' or
*      screen-name = 'lb3'.


screen-invisible = '1'. "upadets in header"
modify screen. "updates the corresponding row in int.table"
endif.

endloop.

ENDFORM.

form visibleblock1.
loop at screen.
   if screen-group1 = 'ID1' or
       screen-name = 'bk2' or
      screen-name = 't1' or
        screen-name = 'p_abc'.
screen-invisible = '0'.
modify screen.
else.
 screen-invisible = '1'.
modify screen.
endif.
endloop.
endform.

form visibleblock2.
loop at screen.
   if screen-name = 'bk2' or
      screen-name = 't1' or
      screen-name = 'p_r1' or
      screen-name = 'p_r2' or
      screen-name = 'p_r3' or
      screen-name = 'p_abc'.
screen-invisible = '0'.
modify screen.
else.
 screen-invisible = '1'.
modify screen.
endif.
endloop.
endform.

form visibleblock3.
loop at screen.
   if screen-name = 'bk3' or
      screen-name = 't3' or
      screen-name = 'lb1' or
      screen-name = 'lb2' or
      screen-name = 'lb3' or
       screen-name = 'p_abc'.
screen-invisible = '0'.
modify screen.
else.
 screen-invisible = '1'.
modify screen.
endif.
endloop.
endform.
