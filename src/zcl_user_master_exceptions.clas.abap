CLASS zcl_user_master_exceptions DEFINITION
  public
  inheriting from CX_STATIC_CHECK
  final
  create public .

public section.

  interfaces IF_T100_DYN_MSG .
  interfaces IF_T100_MESSAGE .

  constants:
    begin of CREATION_ERROR,
      msgid type symsgid value 'BLE_RUNTIME_SUPPORT',
      msgno type symsgno value '000',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of CREATION_ERROR .
  constants:
    begin of READ_ERROR,
      msgid type symsgid value 'BLE_RUNTIME_SUPPORT',
      msgno type symsgno value '101',
      attr1 type scx_attrname value 'USERNAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of READ_ERROR .
  constants:
    begin of UPDATE_ERROR,
      msgid type symsgid value 'BLE_RUNTIME_SUPPORT',
      msgno type symsgno value '102',
      attr1 type scx_attrname value 'USERNAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of UPDATE_ERROR .
  constants:
    begin of DELETE_ERROR,
      msgid type symsgid value 'BLE_RUNTIME_SUPPORT',
      msgno type symsgno value '102',
      attr1 type scx_attrname value 'USERNAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of DELETE_ERROR .
  data USERNAME type STRING .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !USERNAME type STRING optional .
protected section.
private section.
ENDCLASS.



CLASS zcl_user_master_exceptions IMPLEMENTATION.


  method CONSTRUCTOR ##ADT_SUPPRESS_GENERATION.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->USERNAME = USERNAME .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
