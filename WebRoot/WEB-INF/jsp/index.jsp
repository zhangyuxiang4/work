<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <style>
  		*{
  			margin:0px;
  			padding:0px;
  		}
  		h3{
  			text-align:center;
  			margin-top: 200px;
  		}
  		table{
  			margin:10px auto;
  			text-align:center;
  		}
  		td{
  			width:150px;
  			height:40px;
  		}
  		input,select:not(.submit){
  			width:100%;
  			height:40px;
  		}
  </style>
  
  <body>
  		<c:set value="${pageContext.request.contextPath }" var="ctx" />
  		<h3>商品出库</h3>
  		<form action="${ctx }/product/addTakeOut" class="myForm">
  			<table border="1px" cellspacing="2px" cellpadding="0px">
  				<tr>
  					<td>出库商品：</td>
  					<td>
  						<select name="productId" class="productId">
  							<option value="-1" selected="selected">-请选择出库商品-</option>
  							<c:forEach var="product" items="${productList }">
  								<option value="${product.id }">${product.productName }</option>
  							</c:forEach>
  						</select>
  					</td>
  				</tr>
  				<tr>
  					<td>数量：</td>
  					<td><input type="text" name="quantity" class="quantity" /></td>
  				</tr>
  				<tr>
  					<td>经手人：</td>
  					<td><input type="text" name="handler" class="handler" /></td>
  				</tr>
  				<tr>
  					<td colspan="2"><input type="button" value="提交" class="submit" /> <input type="reset" value="重置" class="set" /></td>
  				</tr>
  			</table>
  		</form>
 	<script src="${ctx }/statics/js/jquery-1.12.4.js"></script>
 	<script>
 		$(function(){
			var $id = $(".productId")
			var $quantity = $(".quantity");
			var $handler = $(".handler");
 		
 			$(".quantity").blur(function(){
 				if($id.val() == -1){
 					alert("请先选择出库商品！");
 					$quantity.val("");
 					$id.focus();
 					return;
 				}
 				if($quantity.val() == ""){
					alert("请填写出库数量！");
					return;
				}
 				getProductById();
 			});
 		
 			function getProductById(){
				$.ajax({
					url:"${ctx}/product/product",
					data:"id="+$id.val(),
					type:"get",
					dataType:"JSON",
					success:function(data){
						var $quantity = $(".quantity");
						if($quantity.val() <= data.quantity){
							alert("库存充足");
						}else{
							alert("所选商品库存不足，库存量为" + data.quantity);
							$quantity.val("");
						}
					},
					error:function(a,b,c){
						alert(c);
					}
				});
			}
			
			function checkForm(){
				var flag = true;
				$.each($id,function(i,e){
					if($(this).val() == -1){
						$id.focus();
						flag = false;
					}
				});
				if(!flag){
					return -1;
				}
				if($quantity.val() == ""){
					$quantity.focus();
					return -2;
				}
				if(isNaN($quantity.val()) == true || $quantity.val() <= 0){
					$quantity.focus();
					return -3;
				}
				if($handler.val() == ""){
					$handler.focus();
					return -4;
				}
				return 1;
			}
			
			$(".submit").click(function(){
				switch(checkForm()){
					case 1:
						$.ajax({
							url:"${ctx}/product/addTakeOut",
							data:"productId="+$id.val()+"&quantity="+$quantity.val()+"&handler="+$handler.val(),
							type:"get",
							dataType:"JSON",
							success:function(data){
								if(data.result == "t"){
									alert("操作成功！");
									$(".myForm").each(function(){
										this.reset();
									});
								}else{
									alert("操作失败！");
								}
							},
							error:function(a,b,c){
								alert(c);
							}
						});
					break;
					case -1:
						alert("请选择出库商品！");
						return false;
					break;
					case -2:
						alert("请填写出库数量！");
						return false;
					break;
					case -3:
						alert("数量必须是大于0的整数！");
						return false;
					break;
					case -4:
						alert("请填写经手人！");
						return false;
					break;
				}
			});
			
 		});
 		
 	</script>
  </body>
</html>
