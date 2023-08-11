package com.hotmart.services;

import com.hotmart.domain.Producto;
import java.util.List;

public interface ProductoService {
    
    public List<Producto> getProductos(boolean activos);

    public Producto getProducto(Producto producto);

    public void deleteProducto(Producto producto);

    public void saveProducto(Producto producto);
    
}