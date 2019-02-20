package service;

import java.util.List;


import entity.Product;
import entity.TakeOut;

public interface ProductService {

	List<Product> getProductList();
	
	Product getProductById(Integer id);
	
	Integer updProductById(TakeOut takeOut);
}
