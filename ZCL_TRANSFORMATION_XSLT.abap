CLASS zcl_transformation_xslt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_transformation_xslt IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: ls_book      TYPE zsbook,
          lt_books     TYPE TABLE OF zsbook,
          lv_error_msg TYPE string.

    DATA(lv_xml) = |<?xml version="1.0" encoding="UTF-8"?><bookstore>| &&
                    |<book id="101" category="cooking"><title lang="en">Everyday Italian</title><author>Giada De Laurentiis</author></book>| &&
                    |<book id="102" category="children"><title lang="en">Harry Potter</title><author>J K. Rowling</author></book>| &&
                    |<book id="103" category="web"><title lang="de">XQuery Kick Start</title><author>James McGovern</author><author>Per Bothner</author><author>Kurt Cagle</author><author>James Linn</author><author>Vaidyanathan Nagarajan</author></book>|
&&
                    |</bookstore>|.


    " Deserialize the XML back to the internal table
    TRY.
        CALL TRANSFORMATION z_my_xslt
          SOURCE XML lv_xml
          RESULT bookstore = lt_books.
      CATCH cx_transformation_error INTO DATA(lv_error).
        lv_error_msg = lv_error->get_text( ).
        cl_demo_output=>write( lv_error_msg ).
        cl_demo_output=>display( ).
        RETURN.
    ENDTRY.

    " Output the deserialized data
    cl_demo_output=>display( lt_books ).

    cl_demo_output=>display( ).

  ENDMETHOD.
ENDCLASS.