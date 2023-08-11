package com.hotmart.service.impl;

import com.hotmart.dao.ClienteDao;
import com.hotmart.dao.CreditoDao;
import com.hotmart.domain.Cliente;
import com.hotmart.domain.Credito;
import com.hotmart.services.ClienteService;
import org.springframework.stereotype.Service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

@Service
public class ClienteServiceImpl implements ClienteService {
    
    //Esto crea una unica copia de un objeto
    @Autowired
    private ClienteDao clienteDao;

    @Autowired
    private CreditoDao creditoDao;
    
    @Override
    public List<Cliente> getClientes(){
        return (List<Cliente>) clienteDao.findAll();
    }

    @Override
    public Cliente getCliente(Cliente cliente) {
        return clienteDao.findById(cliente.getIdCliente()).orElse(null);
    }

    @Override
    public void deleteCliente(Cliente cliente) {
        clienteDao.delete(cliente);
    }

    @Override
    public void saveCliente(Cliente cliente) {
        Credito credito = cliente.getCredito();
        credito=creditoDao.save(credito);
        cliente.setCredito(credito);
        
        clienteDao.save(cliente);
    }
    
}