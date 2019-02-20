package controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import service.ProductService;

import com.alibaba.fastjson.JSON;

import entity.Product;
import entity.TakeOut;

@Controller
@RequestMapping("/product")
public class ProductController {

	@Resource
	private ProductService productService;
	
	@RequestMapping("/productList")
	public String getProductList(Model model){
		List<Product> productList = productService.getProductList();
		model.addAttribute("productList", productList);
		return "index";
	}
	
	@ResponseBody
	@RequestMapping("/product")
	public Object getProductById(Integer id){
		Product product = productService.getProductById(id);
		return JSON.toJSONString(product);
	}
	
	@ResponseBody
	@RequestMapping("/addTakeOut")
	public Object addTakeOut(TakeOut takeOut){
		takeOut.setOutDate(new Date());
		Map map = new HashMap<String,String>();
		if(productService.updProductById(takeOut) == 1){
			map.put("result", "t");
		}else{
			map.put("result", "f");
		}
		return JSON.toJSONString(map);
	}
	
}
