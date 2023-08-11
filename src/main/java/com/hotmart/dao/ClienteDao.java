package com.hotmart.dao;

import com.hotmart.domain.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClienteDao extends JpaRepository<Cliente,Long> {
    
}
