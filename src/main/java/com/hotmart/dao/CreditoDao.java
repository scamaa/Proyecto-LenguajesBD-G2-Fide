package com.hotmart.dao;

import com.hotmart.domain.Credito;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CreditoDao extends JpaRepository<Credito,Long> {
    
}
