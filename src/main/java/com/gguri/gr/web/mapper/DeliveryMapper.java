package com.gguri.gr.web.mapper;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.gguri.gr.web.vo.DeliveryVO;

@SuppressWarnings("rawtypes")
@MapperScan
public interface DeliveryMapper {

	List<DeliveryVO> getMenuID(DeliveryVO deliveryVO);
	List<DeliveryVO> getMenu(DeliveryVO deliveryVO);
	List<DeliveryVO> getRestaurantInfo(DeliveryVO deliveryVO);
	List<DeliveryVO> getMenuInfo(DeliveryVO deliveryVO);
	
}
