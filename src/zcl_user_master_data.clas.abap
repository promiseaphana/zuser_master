CLASS zcl_user_master_data DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS create_user
      IMPORTING
        !user_data TYPE zuser_master
      RAISING
        zcl_user_master_exceptions .
    METHODS read_user
      IMPORTING
        !user_id         TYPE zuser_master-user_id
      RETURNING
        VALUE(user_data) TYPE zuser_master
      RAISING
        zcl_user_master_exceptions .
    METHODS update_user
      IMPORTING
        !user_data TYPE zuser_master
      RAISING
        zcl_user_master_exceptions .
    METHODS delete_user
      IMPORTING
        !user_id TYPE zuser_master-user_id
      RAISING
        zcl_user_master_exceptions.
  PRIVATE SECTION.
    DATA: lt_user_master TYPE TABLE OF zuser_master.
ENDCLASS.



CLASS zcl_user_master_data IMPLEMENTATION.


  METHOD create_user.
    INSERT zuser_master FROM @user_data.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE zcl_user_master_exceptions EXPORTING textid = zcl_user_master_exceptions=>creation_error.
    ENDIF.
  ENDMETHOD.


  METHOD read_user.
    SELECT SINGLE *
      FROM zuser_master
      WHERE user_id = @user_id
            INTO CORRESPONDING FIELDS OF @user_data.
    IF sy-subrc NE 0.
      CLEAR user_data.
      RAISE EXCEPTION TYPE zcl_user_master_exceptions
        EXPORTING
          textid   = zcl_user_master_exceptions=>read_error
          username = CONV #( USER_ID ).
    ENDIF.
  ENDMETHOD.


  METHOD update_user.
    UPDATE zuser_master
      SET user_type       = @user_data-user_type,
          first_name      = @user_data-first_name,
          last_name       = @user_data-last_name,
          user_group      = @user_data-user_group,
          email_address   = @user_data-email_address,
          department_name = @user_data-department_name,
          lock_status     = @user_data-lock_status,
          valid_from      = @user_data-valid_from,
          valid_to        = @user_data-valid_to
      WHERE user_id = @user_data-user_id.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE zcl_user_master_exceptions
        EXPORTING
          textid   = zcl_user_master_exceptions=>update_error
          username = CONV #( user_data-user_id ).
    ENDIF.
  ENDMETHOD.


  METHOD delete_user.
    DELETE FROM zuser_master
      WHERE user_id = @user_id.
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE zcl_user_master_exceptions
        EXPORTING
          textid   = zcl_user_master_exceptions=>delete_error
          username = CONV #( user_id ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
