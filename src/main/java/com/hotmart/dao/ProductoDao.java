package com.hotmart.dao;

import com.hotmart.domain.Producto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductoDao extends JpaRepository<Producto,Long>{
    
}
