package io.swagger.model;

import java.util.Objects;
import com.fasterxml.jackson.annotation.JsonValue;
import org.springframework.validation.annotation.Validated;
import javax.validation.Valid;
import javax.validation.constraints.*;

import com.fasterxml.jackson.annotation.JsonCreator;

/**
 * Gets or Sets SearchField
 */
public enum SearchField {
  HOUSE_NO("HOUSE_NO"),
    NAME("NAME"),
    NIC("NIC"),
    PHONE_NO("PHONE_NO"),
    EMAIL("EMAIL");

  private String value;

  SearchField(String value) {
    this.value = value;
  }

  @Override
  @JsonValue
  public String toString() {
    return String.valueOf(value);
  }

  @JsonCreator
  public static SearchField fromValue(String text) {
    for (SearchField b : SearchField.values()) {
      if (String.valueOf(b.value).equals(text)) {
        return b;
      }
    }
    return null;
  }
}
