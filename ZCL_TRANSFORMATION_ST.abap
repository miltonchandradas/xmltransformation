CLASS zcl_transformation_st DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_transformation_st IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: ls_person  TYPE zsperson,
          lt_persons TYPE TABLE OF zsperson,
          lv_xml     TYPE string.

    ls_person = VALUE #( name = 'John Doe' age = 30 ).
    lt_persons = VALUE #( ( name = 'John Doe' age = 30 ) ( name = 'Jane Doe' age = 45 ) ).

    " Serialize the structure to XML
    CALL TRANSFORMATION z_my_simple_transformation
      SOURCE person = ls_person
      RESULT XML lv_xml.

    " Output the XML string
    cl_demo_output=>write( lv_xml ).

    " Serialize the internal table to XML
    CALL TRANSFORMATION z_my_simple_transformation_2
      SOURCE persons = lt_persons
      RESULT XML lv_xml.


    " Output the XML string
    cl_demo_output=>write( lv_xml ).

    " Deserialize the XML back to the internal table
    CALL TRANSFORMATION z_my_simple_transformation_2
      SOURCE XML lv_xml
      RESULT persons = lt_persons.

    " Output the deserialized data
    cl_demo_output=>display( lt_persons ).

    cl_demo_output=>display( ).

  ENDMETHOD.
ENDCLASS.