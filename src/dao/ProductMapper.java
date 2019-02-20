package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import entity.Product;

public interface ProductMapper {

	List<Product> getProductList();
	
	Product getProductById(@Param("id")Integer id);
	
	Integer updProductById(@Param("id")Integer id,@Param("quantity")Integer quantity);
}
