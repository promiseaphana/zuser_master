class ZCL_USER_MASTER_DATA definition
  public
  create public .

public section.

  methods CREATE_USER
    importing
      !USER_DATA type ZUSER_MASTER .
  methods READ_USER
    importing
      !USER_ID type XUBNAME
    returning
      value(USER_DATA) type ZUSER_MASTER .
  methods UPDATE_USER
    importing
      !USER_DATA type ZUSER_MASTER .
  methods DELETE_USER
    importing
      !USER_ID type XUBNAME .
  PRIVATE SECTION.
    DATA: lt_user_master TYPE TABLE OF zuser_master.
ENDCLASS.



CLASS ZCL_USER_MASTER_DATA IMPLEMENTATION.


  METHOD create_user.
    INSERT zuser_master FROM user_data.
    IF sy-subrc NE 0.
      MESSAGE 'Error creating user' TYPE 'E'.
    ENDIF.
  ENDMETHOD.


  METHOD read_user.
    SELECT SINGLE *
      INTO CORRESPONDING FIELDS OF user_data
      FROM zuser_master
      WHERE user_id = user_id.
    IF sy-subrc NE 0.
      CLEAR user_data.
      MESSAGE 'User not found' TYPE 'E'.
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
      MESSAGE 'Error updating user' TYPE 'E'.
    ENDIF.
  ENDMETHOD.


  METHOD delete_user.
    DELETE FROM zuser_master
      WHERE user_id = user_id.
    IF sy-subrc NE 0.
      MESSAGE 'Error deleting user' TYPE 'E'.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
