package io.swagger.repo;

import io.swagger.model.Resident;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ResidentRepo extends JpaRepository<Resident, Integer> {

}
