Dropdown listbox in selection screen"

type-pool vrm. " required in some version"
parameters p_course(20) type c as listbox. "syantx error"

parameters p_course(20) type c as listbox visible length 15.

selection-screen skip 2.

selection-screen pushbutton 32(15) b1 user-command fc1.


data : t_values type table of vrm_Value,
       wa_value type vrm_value.
Initialization.
b1 = 'Identify'.
perform prepareddropdown.
if t_values is not initial."not empty"
perform displaydropdown.
endif.

at SELECTION-SCREEN.
 case sy-ucomm.
  when 'FC1'.
    if p_course = 'k1'.
     message 'Core ABAP is selected' type 'I'.
   elseif p_course = 'k2'.
      message 'Oops ABAP is selected' type 'I'.
   elseif p_course = 'k3'.
       message 'Cross Apps is selceted' type 'I'.
   else.
       message 'None is selected' type 'I'.
  endif.
endcase.


FORM PREPAREDDROPDOWN .
clear wa_value.
wa_value-key = 'k1'.
wa_value-text = 'Core ABAP'.
append wa_value to t_values.

clear wa_value.
wa_value-key = 'k2'.
wa_value-text = 'oops ABAP'.
append wa_value to t_values.

clear wa_value.
wa_value-key = 'k3'.
wa_value-text = 'Cross ABAP'.
append wa_value to t_values.

ENDFORM.

FORM DISPLAYDROPDOWN.


CALL FUNCTION 'VRM_SET_VALUES'
  EXPORTING
    ID                    = 'p_course'
    VALUES                = t_values
 EXCEPTIONS
   ID_ILLEGAL_NAME       = 1.


if sy-subrc eq 1.
    message 'Illegal dropdown listbox name' type 'I'.
elseif sy-subrc eq 2.
   message 'Unknown error' type 'I'.
endif.

ENDFORM.
