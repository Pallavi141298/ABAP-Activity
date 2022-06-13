*GO To SE7.
*
*select goto from menu bar.
*select functions group.
*select create function group.
*
*enter function group.
*short text.
*save it.
*
*Go to SE80.
*select function group from the drop down list.
*Enter the function group name.
*Activate it.
*
*Go to SE37.
*Enter the functional module name.
*Hit on create.
*It will ask for you Functional group name and short text.
*
*This is way to create the functional module.
*note that one function group can contain many number of function module.
*
*To add addition of two numbers.
*
*define Two import parameters to accpect two inputs.
*define export parameters to hold the output.





parameters: x type i,
            y type i.

data: z type i.

*DATA A TYPE I.
*DATA B TYPE I.
*DATA C TYPE I.

CALL FUNCTION 'ZFIRST_FM'
  EXPORTING
    A             = x
    B             = y
 IMPORTING
   C             = z.
