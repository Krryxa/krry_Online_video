<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<meta name="Keywords" content="关键词,关键词">
		<meta name="Description" content="网页描述">
		<title>在线视频直播系统 --krry</title>
		<link rel="stylesheet" href="css/三横线.css"/>
		<style type="text/css">
			*{margin:0;padding:0}
			body{background:url("images/4.jpg");background-size:cover;font-size:12px;font-family:"微软雅黑";}
			.video{width:610px;height:450px;margin:30px auto;background:#ccc;border-radius:5px 5px 0px 0px;}
			.video .v_title{border-radius:5px 5px 0px 0px;font-size:16px;height:50px;line-height:50px;width:100%;background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0,#f2f3f3),color-stop(1,#dddfe1));border-bottom:1px solid #ced1d3;}
			.video .v_title .v_btn a{width:15px;height:15px;float:left;margin-right:20px;margin-top: 19px;margin-left:14px;}
			.video .v_bottom{width:100%;height:50px;background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0,#f2f3f3),color-stop(1,#dddfe1));border-bottom:1px solid #ced1d3;}
			.video .v_bottom .v_play a{width:32px;height:42px;float:left;margin-right:20px;background:url("images/t049oRLO.png")-456px -1043px;margin-left:15px;margin-top:4px;}
		</style>
	</head>
	<body>
		<div class="video">
			<div class="v_title">
				<div class="v_btn">
					<a title="拍照截图" href="#" onclick="getPhoto();"><span class="u-icon-detail"><i></i></span></a>
				</div>
				小其Krry -- 在线视频直播系统
			</div>
			<div class="v_con">
				<video id="video" width="610" height="350" autoplay="autoplay"></video>
			</div>
			<div class="v_bottom">
				<div class="v_play">
					<a href="#" id="b_a" onclick="getMedia();"></a>
				</div>
			</div>
			<canvas id="canvas" width="610" height="455"></canvas>
		</div>
		<script src="js/jquery-1.10.2.min.js"></script>
		<script>
			//获取本地视频播放器
			var video = document.getElementById("video");
			video.volume = 0;//设置静音
			
			var ba = document.getElementById("b_a");
			var close = true;

			var canvas = document.getElementById("canvas");
			var context = canvas.getContext("2d");

			//获取系统用户的摄像头信息
			navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
			window.URL = window.URL || window.webkitURL || window.mozURL || window.msURL;

			var exArray = [];//存储设备源ID
			MediaStreamTrack.getSources(function(sourceInfos){
				for(var i = 0;i != sourceInfos.length;++i){
					var sourceInfo = sourceInfos[i];
					//这里遍历audio，video，所以要加以区分
					if(sourceInfo.kind === 'video'){
						exArray.push(sourceInfo.id);
					}
				}
			});

			//调用摄像头
			function getMedia(){
				if(navigator.getUserMedia){
					navigator.getUserMedia({
						'video':{
							'optional':[{
								'sourceId':exArray[0] //0为前置摄像头，1为后置
							}]
						},
						'audio':true
					},successFn,errorFn);
				}else{
					alert("你当前的浏览器不支持摄像头的功能...");
				}
				if(close){
					ba.style.backgroundPosition = '-336px -1079px';
					close = false;
				}else{
					ba.style.backgroundPosition = '-456px -1043px';
					close = true;
				}
			}

			//摄像头调用成功执行的函数，stream是视频流对象，也就是每一帧的突破信息
			function successFn(stream){
				if(video.mozSrcObject !== undefined){ //如果是Firefox执行，直接把流给播放器
					video.mozSrcObject = stream;
				}else{
					//其他浏览器根据兼容性来解决
					video.src = window.URL && window.URL.createObjectURL(stream) || stream;
				}
			}

			function errorFn(e){
				alert("出错啦！"+e);
			}

			//将video对象内指定的区域捕捉到绘制画布上指定的区域，实现拍照
			function getPhoto(){
				context.drawImage(video,0,0,610,455);
			}
		</script>
	</body>
</html>
