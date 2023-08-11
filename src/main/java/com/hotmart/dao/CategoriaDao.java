package com.hotmart.dao;

import com.hotmart.domain.Categoria;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoriaDao extends JpaRepository<Categoria,Long> {
    
}
