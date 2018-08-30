<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<script type="text/javascript" src="js/vue.min.js"></script>
		<title>form</title>
		<style type="text/css">
			#table table {
				width: 100%;
				font-size: 14px;
				border: 1px solid #eee
			}
			
			#table {
				padding: 0 10px;
			}
			
			table thead th {
				background: #f5f5f5;
				padding: 10px;
				text-align: left;
			}
			
			table tbody td {
				padding: 10px;
				text-align: left;
				border-bottom: 1px solid #eee;
				border-right: 1px solid #eee;
			}
			
			table tbody td span {
				margin: 0 10px;
				cursor: pointer;
			}
			
			.delete {
				color: red;
			}
			
			.edit {
				color: #008cd5;
			}
			
			.add {
				border: 1px solid #eee;
				margin: 10px 0;
				padding: 15px;
			}
			
			input {
				border: 1px solid #ccc;
				padding: 5px;
				border-radius: 3px;
				margin-right: 15px;
			}
			
			button {
				background: #008cd5;
				border: 0;
				padding: 4px 15px;
				border-radius: 3px;
				color: #fff;
			}
			
			#mask {
				background: rgba(0, 0, 0, .5);
				width: 100%;
				height: 100%;
				position: fixed;
				z-index: 4;
				top: 0;
				left: 0;
			}
			
			.mask {
				width: 300px;
				height: 250px;
				background: rgba(255, 255, 255, 1);
				position: absolute;
				left: 0;
				top: 0;
				right: 0;
				bottom: 0;
				margin: auto;
				z-index: 47;
				border-radius: 5px;
			}
			
			.title {
				padding: 10px;
				border-bottom: 1px solid #eee;
			}
			
			.title span {
				float: right;
				cursor: pointer;
			}
			
			.content {
				padding: 10px;
			}
			
			.content input {
				width: 270px;
				margin-bottom: 5px;
			}
		</style>
	</head>

	<body>
		 <%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 
           uri="http://java.sun.com/jsp/jstl/functions" %>
		<div id="table">
			<div class="add">
				<form action="/adoUserSearch" method = "get">
					<input type="text" name =uname v-model="addDetail.title" name="title" value="" placeholder="请输入要查询的用户名" />
					<input type="submit" value="查询" class="btn-search"/>
				</form>
			</div>
			<table cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<th>用户id</th>
						<th>用户名</th>
						<th>电话</th>
						<th>邮箱</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
			 <c:forEach items="${goods }" var="item" varStatus ="ide">
					<tr >
						<td width="5%">${item.userid}</td>
						<td>${item.account }</td>
						<td width="10%">${item.tel }</td>
						<td width="15%">${email }</td>
						<td width="10%"><span @click="deletelist(item.id,index)" class="delete"><a href ="/doUserDelete?userid=${item.userid }" class="delete">删除</a></span></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<div id="mask" v-if="editlist">
				<div class="mask">
					<div class="title">
						编辑
						<span @click="editlist=false">
							X
						</span>
					</div>
					<div class="content">
						<input type="text" v-model="editDetail.title" name="title" value="" placeholder="用户id" readonly="readonly"/>
						<input type="text" v-model="editDetail.user" name="user" value="" placeholder="用户名" />
						<input type="date" v-model="editDetail.dates" name="date" value="" placeholder="电话" />
						<input type="date" v-model="editDetail.dates" name="date" value="" placeholder="邮箱" />
						<a href="" class="btn btn-default ">更新</button>
						<button @click="editlist=false">取消</button>
					</div>
				</div>
			</div>
		</div>
		<script>
			var app = new Vue({
				el: '#table',
				data: {
					addDetail: {},
					editlist: false,
					editDetail: {},
					newsList: [{
						title: '在移动设备开发',
						user: '张若昀',
						dates: '2018-02-09',
						id: "45211546"
					}, {
						title: '图形及特效特性',
						user: '张若昀',
						dates: '2018-02-09',
						id: "61341341"
					}, {
						title: '设备兼容特性',
						user: '张若昀',
						dates: '2018-02-09',
						id: "62451431"
					}, {
						title: 'W3C将致力于开发用于实时通信',
						user: '张若昀',
						dates: '2018-02-09',
						id: "62345213"
					}, {
						title: '全新的表单输入对象',
						user: '张若昀',
						dates: '2018-02-09',
						id: "23322445"
					}],
					editid:''
				},
				mounted() {

				},
				methods: {

					//新增
					adddetail() {
						//这里的思路应该是把this.addDetail传给服务端，然后加载列表this.newsList
						//this.newsList.push(this.addDetail)
						this.newsList.push({
							title: this.addDetail.title,
							user: this.addDetail.user,
							dates: this.addDetail.dates,
						})

						//axios.post('url',this.addDetail).then((res) =>{
						//若返回正确结果，清空新增输入框的数据
						//this.addDetail.title = ""
						//this.addDetail.user = ""
						//this.addDetail.dates = ""
						//})

					},
					//删除
					deletelist(id, i) {
						this.newsList.splice(i, 1);
						//这边可以传id给服务端进行删除  ID = id
						//axios.get('url',{ID:id}).then((res) =>{
						//			加载列表				
						//})
					},
					//编辑
					edit(item) {
						this.editDetail = {
							title: item.title,
							user: item.user,
							dates: item.dates,
							id: item.id
						}
						this.editlist = true
						this.editid = item.id
						
					},
					//确认更新
					update() {
						//编辑的话，也是传id去服务端
						//axios.get('url',{ID:id}).then((res) =>{
						//			加载列表				
						//})
						let _this= this
						for(let i = 0; i < _this.newsList.length; i++) {
							if(_this.newsList[i].id ==this.editid) {
								_this.newsList[i] = {
									title: _this.editDetail.title,
									title: _this.editDetail.title,
									title: _this.editDetail.title,
									user: _this.editDetail.user,
									dates: _this.editDetail.dates,
									id: this.editid
								}
								this.editlist = false
							}
						}
					}
				}
			})
		</script>
	</body>

</html>