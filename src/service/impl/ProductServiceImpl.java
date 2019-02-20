package service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import service.ProductService;
import dao.ProductMapper;
import dao.TakeOutMapper;
import entity.Product;
import entity.TakeOut;

@Service
public class ProductServiceImpl implements ProductService {

	@Resource
	private ProductMapper productMapper;
	@Resource
	private TakeOutMapper takeOutMapper;
	
	@Override
	public List<Product> getProductList() {
		return productMapper.getProductList();
	}

	@Override
	public Product getProductById(Integer id) {
		return productMapper.getProductById(id);
	}

	@Override
	public Integer updProductById(TakeOut takeOut) {
		Product product = getProductById(takeOut.getProductId());
		Integer quantity = product.getQuantity() - takeOut.getQuantity();
		if(takeOutMapper.addTakeOut(takeOut) == 1 && productMapper.updProductById(takeOut.getProductId(), quantity) == 1){
			return 1;
		}
		return -1;
	}


	
}
