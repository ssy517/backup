<%@page import="dto.ProductDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HEALTHY & HAPPY</title>
<%@ include file="../parts/header.jsp" %>
<style type="text/css">
.highcharts-figure, .highcharts-data-table table {
  min-width: 310px; 
  max-width: 800px;
  margin: 1em auto;
}

#container {
  height: 400px;
}

.container {
 	padding-bottom: 100px;
 	margin-top: 10px;
}
.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}
.highcharts-data-table caption {
  padding: 1em 0;
  font-size: 1.2em;
  color: #555;
}
.highcharts-data-table th {
	font-weight: 600;
  padding: 0.5em;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
  padding: 0.5em;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
  background: #f8f8f8;
}
.highcharts-data-table tr:hover {
  background: #f1f7ff;
}

/* 내가 추가함 */
.menu {
	float: left;
	margin-left: 250px;
	margin-top: 50px;
}
.menu table{
	width: 200px;
	height: 250px;
	font-size: 16px;
}
.menu tr{
	border-bottom: 1px solid lightgrey;
}
.menu tr:hover{
	border-bottom: 2px solid #0D6400;
	font-weight: bold;
}
.menu a{
	text-decoration: none;
	color: black;
}
.menu .active{
	border-bottom: 2px solid #0D6400;
	font-weight: bold;
}
.highcharts-figure{
	margin-top: 70px;
}
.charts hr{
	margin-top: 80px;
	width: 1000px;
	border-top-color: lightgrey;
}
</style>

<style type="text/css">
.highcharts-figure2, .highcharts-data-table table {
  min-width: 320px; 
  max-width: 660px;
  margin: 1em auto;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}
.highcharts-data-table caption {
  padding: 1em 0;
  font-size: 1.2em;
  color: #555;
}
.highcharts-data-table th {
  font-weight: 600;
  padding: 0.5em;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
  padding: 0.5em;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
  background: #f8f8f8;
}
.highcharts-data-table tr:hover {
  background: #f1f7ff;
}
.highcharts-figure2{
	margin-top: 100px;
}
</style>

</head>
<body>
<%
	List<ProductDto> list = (List<ProductDto>)request.getAttribute("list");
	
	// 판매량 percentage 구하기
	int sum = 0, fruit01 = 0, fruit02 = 0, vegi01 = 0, vegi02 = 0, vegi03=0;
	for(int i=0; i<list.size(); i++){
		sum += list.get(i).getSell();
	}
	
	String f01Sell = "[", f02Sell = "[", v01Sell = "[", v02Sell = "[", v03Sell = "[";
	String f01Rate = "[", f02Rate = "[", v01Rate = "[", v02Rate = "[", v03Rate = "[";
	
	//카테고리별 판매량
	for(int i=0; i<list.size(); i++){
		ProductDto dto = list.get(i);
		
		if(dto.getPrd_num() > 110 && dto.getPrd_num() < 121 ){
			fruit01 += dto.getSell();
			f01Sell += "{ name:'" + dto.getName() + "', y:" + dto.getSell() + "}, ";
		}else if( dto.getPrd_num() > 120 && dto.getPrd_num() < 131 ){
			fruit02 += dto.getSell();
			f02Sell += "{ name:'" + dto.getName() + "', y:" + dto.getSell() + "}, ";
		}else if( dto.getPrd_num() > 210 && dto.getPrd_num() < 221 ){
			vegi01 += dto.getSell();
			v01Sell += "{ name:'" + dto.getName() + "', y:" + dto.getSell() + "}, ";
		}else if( dto.getPrd_num() > 220 && dto.getPrd_num() < 231 ){
			vegi02 += dto.getSell();
			v02Sell += "{ name:'" + dto.getName() + "', y:" + dto.getSell() + "}, ";
		}else if( dto.getPrd_num() > 230 && dto.getPrd_num() < 241 ){
			vegi03 += dto.getSell();
			v03Sell += "{ name:'" + dto.getName() + "', y:" + dto.getSell() + "}, ";
		}
	}
	
	f01Sell = f01Sell.substring(0, f01Sell.lastIndexOf(",")) + "]"; // 0~ 마지막전까지 
	f02Sell = f02Sell.substring(0, f02Sell.lastIndexOf(",")) + "]";
	v01Sell = v01Sell.substring(0, v01Sell.lastIndexOf(",")) + "]";
	v02Sell = v02Sell.substring(0, v02Sell.lastIndexOf(",")) + "]";
	v03Sell = v03Sell.substring(0, v03Sell.lastIndexOf(",")) + "]";
	
	request.setAttribute("f01Sell", f01Sell);
	request.setAttribute("f02Sell", f02Sell);
	request.setAttribute("v01Sell", v01Sell);
	request.setAttribute("v02Sell", v02Sell);
	request.setAttribute("v03Sell", v03Sell);
	
	//판매율 구하기
	System.out.println("프룻" + fruit01 + " " + sum );
	double ratef01 = (double)fruit01 * 100 / sum;
	double ratef02 = (double)fruit02 * 100 / sum;
	double ratev01 = (double)vegi01 * 100 / sum;
	double ratev02 = (double)vegi02 * 100 / sum;
	double ratev03 = (double)vegi03 * 100 / sum;
	
	//제품별 판매율
	for(int i=0; i<list.size(); i++){
		ProductDto dto = list.get(i);
		double rateDto = 0;
		
		if(dto.getPrd_num() > 110 && dto.getPrd_num() < 121 ){
			rateDto = (double)dto.getSell() * 100 / fruit01;
			f01Rate += "{ name:'" + dto.getName() + "', y:" + rateDto + "}, ";
		}else if( dto.getPrd_num() > 120 && dto.getPrd_num() < 131 ){
			rateDto = (double)dto.getSell() * 100 / fruit02;
			f02Rate += "{ name:'" + dto.getName() + "', y:" + rateDto + "}, ";
		}else if( dto.getPrd_num() > 210 && dto.getPrd_num() < 221 ){
			rateDto = (double)dto.getSell() * 100 / vegi01;
			v01Rate += "{ name:'" + dto.getName() + "', y:" + rateDto + "}, ";
		}else if( dto.getPrd_num() > 220 && dto.getPrd_num() < 231 ){
			rateDto = (double)dto.getSell() * 100 / vegi02;
			v02Rate += "{ name:'" + dto.getName() + "', y:" + rateDto + "}, ";
		}else if( dto.getPrd_num() > 230 && dto.getPrd_num() < 241 ){
			rateDto = (double)dto.getSell() * 100 / vegi03;
			v03Rate += "{ name:'" + dto.getName() + "', y:" + rateDto + "}, ";
		}
	}
	
	f01Rate = f01Rate.substring(0, f01Rate.lastIndexOf(",")) + "]";
	f02Rate = f02Rate.substring(0, f02Rate.lastIndexOf(",")) + "]";
	v01Rate = v01Rate.substring(0, v01Rate.lastIndexOf(",")) + "]";
	v02Rate = v02Rate.substring(0, v02Rate.lastIndexOf(",")) + "]";
	v03Rate = v03Rate.substring(0, v03Rate.lastIndexOf(",")) + "]";
	
	request.setAttribute("f01Rate", f01Rate);
	request.setAttribute("f02Rate", f02Rate);
	request.setAttribute("v01Rate", v01Rate);
	request.setAttribute("v02Rate", v02Rate);
	request.setAttribute("v03Rate", v03Rate);
%>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<br><br>
<div class="container">
	<div class="menu">
		<table>
			<tr class="active"><td><a href="authProduct?work=chart">제품차트</a></td></tr>
			<tr><td><a href="authProduct?work=list">제품관리</a></td></tr>
			<tr><td><a href="authProduct?work=order">주문관리</a></td></tr>
			<tr><td><a href="Manager?action=list">회원정보관리</a></td></tr>
		</table>
	</div>
	
	<div class="charts">
	<figure class="highcharts-figure">
	  <div id="container"></div>
	  <p class="highcharts-description">
	  </p>
	</figure>
	<hr>
	
	<!-- 차트1 데이터 -->
	<script type="text/javascript">
	
	//Create the chart
	Highcharts.chart('container', {
	  chart: {
	    type: 'column'
	  },
	  title: {
	    text: 'Healthy & Happy 제품 카테고리별 판매량, 2020'
	  },
	  subtitle: {
	    text: '제품별 상세 판매량을 보려면 막대 그래프를 클릭하세요.'
	  },
	  accessibility: {
	    announceNewData: {
	      enabled: true
	    }
	  },
	  xAxis: {
	    type: 'category'
	  },
	  yAxis: {
	    title: {
	      text: '판매량'
	    }
	
	  },
	  legend: {
	    enabled: false
	  },
	  plotOptions: {
	    series: {
	      borderWidth: 0,
	      dataLabels: {
	        enabled: true
	    //    format: '{point.y:.1f}%'
	      }
	    }
	  },
	
	  tooltip: {
	    headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
	    pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}</b> of total<br/>' //.y:.2f}%  
	  },
	
	  series: [
	    {
	      name: "Category",
	      colorByPoint: true,
	      data: [
	        {
	          name: "생과일",
	          y: <%=fruit01%>,
	          drilldown: "Chrome"
	        },
	        {
	          name: "냉동과일",
	          y: <%=fruit02%>,
	          drilldown: "Firefox"
	        },
	        {
	          name: "잎채소",
	          y: <%=vegi01%>,
	          drilldown: "Internet Explorer"
	        },
	        {
	          name: "뿌리채소",
	          y: <%=vegi02%>,
	          drilldown: "Safari"
	        },
	        {
	          name: "열매채소",
	          y: <%=vegi03%>,
	          drilldown: "Edge"
	        }
	      ]
	    }
	  ],
	  drilldown: {
	    series: [
	      {
	        name: "생과일",
	        id: "Chrome",
	        data: <%=request.getAttribute("f01Sell")%>
	      },
	      {
	        name: "냉동과일",
	        id: "Firefox",
	        data: <%=request.getAttribute("f02Sell")%>
	      },
	      {
	        name: "잎채소",
	        id: "Internet Explorer",
	        data: <%=request.getAttribute("v01Sell")%>
	      },
	      {
	  	    name: "뿌리채소",
	        id: "Safari",
	        data: <%=request.getAttribute("v02Sell")%>
	      },
	      {
	        name: "열매채소",
	        id: "Edge",
	        data: <%=request.getAttribute("v03Sell")%>
	      }
	 
	    ]
	  }
	});
	</script>
	
	
	<figure class="highcharts-figure2">
	  <div id="container2"></div>
	  <p class="highcharts-description2">
	  </p>
	</figure>
	</div>
</div>
<!-- 차트2 데이터 -->
<script type="text/javascript">
//Create the chart
Highcharts.chart('container2', {
  chart: {
    type: 'pie'
  },
  title: {
    text: 'Healthy & Happy 제품 카테고리별 판매율, 2020'
  },
  subtitle: {
    text: '제품별 상세 판매율을 보려면 막대 그래프를 클릭하세요.'
  },

  accessibility: {
    announceNewData: {
      enabled: true
    },
    point: {
      valueSuffix: '%'
    }
  },

  plotOptions: {
    series: {
      dataLabels: {
        enabled: true,
        format: '{point.name}: {point.y:.1f}%'
      }
    }
  },

  tooltip: {
    headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
    pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
  },

  series: [
    {
      name: "Category",
      colorByPoint: true,
      data: [
        {
          name: "생과일",
          y: <%=ratef01%>,
          drilldown: "Chrome"
        },
        {
          name: "냉동과일",
          y: <%=ratef02%>,
          drilldown: "Firefox"
        },
        {
          name: "잎채소",
          y: <%=ratev01%>,
          drilldown: "Internet Explorer"
        },
        {
          name: "뿌리채소",
          y: <%=ratev02%>,
          drilldown: "Safari"
        },
        {
          name: "열매채소",
          y: <%=ratev03%>,
          drilldown: "Edge"
        }
      ]
    }
  ],
  drilldown: {
    series: [
      {
        name: "생과일",
        id: "Chrome",
        data: <%=request.getAttribute("f01Rate")%>
      },
      {
        name: "냉동과일",
        id: "Firefox",
        data: <%=request.getAttribute("f02Rate")%>
      },
      {
        name: "잎채소",
        id: "Internet Explorer",
        data: <%=request.getAttribute("v01Rate")%>
      },
      {
        name: "뿌리채소",
        id: "Safari",
        data: <%=request.getAttribute("v02Rate")%>
      },
      {
        name: "열매채소",
        id: "Edge",
        data: <%=request.getAttribute("v03Rate")%>
      }
    ]
  }
});
</script>

<%@ include file="../parts/footer.jsp" %>  
</body>
</html>