DATA: it_spfli TYPE TABLE OF spfli.

SELECT * FROM spfli INTO TABLE it_spfli.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    i_structure_name = 'SPFLI'
  TABLES
    t_outtab         = it_spfli.
