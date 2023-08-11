package com.hotmart.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;

@Data
@Entity
@Table(name="credito")
public class Credito implements Serializable{
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_credito")
    private Long idCredito;
    
    private double limite;
    
    public Credito(){   
    }
    
    public Credito(double limite){
        this.limite = limite;
    }
}