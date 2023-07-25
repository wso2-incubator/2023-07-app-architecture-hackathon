package io.swagger.model;

import java.util.Objects;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import io.swagger.v3.oas.annotations.media.Schema;
import org.springframework.validation.annotation.Validated;
import javax.validation.Valid;
import javax.validation.constraints.*;

/**
 * Resident
 */
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2023-07-25T04:20:14.086140772Z[GMT]")


public class Resident   {
  @JsonProperty("houseNo")
  private String houseNo = null;

  @JsonProperty("name")
  private String name = null;

  @JsonProperty("nic")
  private String nic = null;

  @JsonProperty("phoneNo")
  private String phoneNo = null;

  @JsonProperty("email")
  private String email = null;

  public Resident houseNo(String houseNo) {
    this.houseNo = houseNo;
    return this;
  }

  /**
   * Get houseNo
   * @return houseNo
   **/
  @Schema(required = true, description = "")
      @NotNull

    public String getHouseNo() {
    return houseNo;
  }

  public void setHouseNo(String houseNo) {
    this.houseNo = houseNo;
  }

  public Resident name(String name) {
    this.name = name;
    return this;
  }

  /**
   * Get name
   * @return name
   **/
  @Schema(required = true, description = "")
      @NotNull

    public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public Resident nic(String nic) {
    this.nic = nic;
    return this;
  }

  /**
   * Get nic
   * @return nic
   **/
  @Schema(required = true, description = "")
      @NotNull

    public String getNic() {
    return nic;
  }

  public void setNic(String nic) {
    this.nic = nic;
  }

  public Resident phoneNo(String phoneNo) {
    this.phoneNo = phoneNo;
    return this;
  }

  /**
   * Get phoneNo
   * @return phoneNo
   **/
  @Schema(required = true, description = "")
      @NotNull

    public String getPhoneNo() {
    return phoneNo;
  }

  public void setPhoneNo(String phoneNo) {
    this.phoneNo = phoneNo;
  }

  public Resident email(String email) {
    this.email = email;
    return this;
  }

  /**
   * Get email
   * @return email
   **/
  @Schema(required = true, description = "")
      @NotNull

    public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }


  @Override
  public boolean equals(java.lang.Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    Resident resident = (Resident) o;
    return Objects.equals(this.houseNo, resident.houseNo) &&
        Objects.equals(this.name, resident.name) &&
        Objects.equals(this.nic, resident.nic) &&
        Objects.equals(this.phoneNo, resident.phoneNo) &&
        Objects.equals(this.email, resident.email);
  }

  @Override
  public int hashCode() {
    return Objects.hash(houseNo, name, nic, phoneNo, email);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class Resident {\n");
    
    sb.append("    houseNo: ").append(toIndentedString(houseNo)).append("\n");
    sb.append("    name: ").append(toIndentedString(name)).append("\n");
    sb.append("    nic: ").append(toIndentedString(nic)).append("\n");
    sb.append("    phoneNo: ").append(toIndentedString(phoneNo)).append("\n");
    sb.append("    email: ").append(toIndentedString(email)).append("\n");
    sb.append("}");
    return sb.toString();
  }

  /**
   * Convert the given object to string with each line indented by 4 spaces
   * (except the first line).
   */
  private String toIndentedString(java.lang.Object o) {
    if (o == null) {
      return "null";
    }
    return o.toString().replace("\n", "\n    ");
  }
}
