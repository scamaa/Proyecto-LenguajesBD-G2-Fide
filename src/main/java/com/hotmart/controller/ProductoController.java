package com.hotmart.controller;

import com.hotmart.domain.Producto;
import com.hotmart.services.ProductoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/producto")
public class ProductoController {
    
    @Autowired
    private ProductoService productoService;
    
    @GetMapping("/listado")
    public String inicio(Model model) {
        var productos=productoService.getProductos(false);
        model.addAttribute("productos", productos);
        model.addAttribute("totalProductos", productos.size());
        return "/producto/listado";
    }
    
    @GetMapping("/eliminar/{idProducto}")
    public String eliminaProducto(Producto producto){
        productoService.deleteProducto(producto);
        return "redirect:/producto/listado";
    }
    
    @GetMapping("/nuevo")
    public String nuevoProducto(Producto producto){
        return "/producto/modifica";
    }
    
    @PostMapping("/guardar")
    public String guardarProducto(Producto producto){
        productoService.saveProducto(producto);
        return "redirect:/producto/listado";
    }
    
    @GetMapping("/modificar/{idProducto}")
    public String modificaProducto(Producto producto, Model model){
        producto = productoService.getProducto(producto);
        model.addAttribute("producto", producto);
        return "/producto/modifica";
    }  
}