package com.wso2.archmindmeld.resident.owner;

import java.util.ArrayList;
import java.util.List;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.wso2.entity.Owner;

@SpringBootApplication
@RestController
public class OwnerApplication {

	public static void main(String[] args) {
		SpringApplication.run(OwnerApplication.class, args);
	}

	// Get all owners of the appartment complex.
	@GetMapping("/owners")
	public List<Owner> getOwners() {
		Owner owner1 = new Owner();
		owner1.setName("Nuwan Dias");
		owner1.setEmail("nuwan@gmail.com");
		owner1.setNic("123");
		owner1.setPhoneNo("0777236184");
		owner1.setHouseNo("6");

		List<Owner> owners = new ArrayList<>();
		owners.add(owner1);
		return owners;
	}

	@GetMapping("/owners/search")
	public List<Owner> searchOwners(@RequestParam(value = "searchField", required = true) String searchField,
									@RequestParam(value = "value", required = true) String value) {

		System.out.println("Search Field : " + searchField);
		System.out.println("Value : " + value);
		Owner owner1 = new Owner();
		owner1.setName("Nuwan Dias");
		owner1.setEmail("nuwan@gmail.com");
		owner1.setNic("123");
		owner1.setPhoneNo("0777236184");
		owner1.setHouseNo("6");

		List<Owner> owners = new ArrayList<>();
		owners.add(owner1);
		return owners;
	}

}
