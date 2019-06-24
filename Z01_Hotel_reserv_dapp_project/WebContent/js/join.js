/*
 join.html에 쓰이는 javascript 파일.
*/

function z(hotelid){ return document.getElementById(hotelid); }
		var idValid = false;
		
		function chkValid(){ // 비밀번호 내용이 불일치할 때, submit 못하게 함.
			if(!idValid){
				alert('아이디를 확인하십시오.');
				event.preventDefault(); // submit event를 막아줌?
			}
			else if(document.forms[0].password.value != document.forms[0].pw2.value){
				alert('비밀번호 확인이 필요합니다.');
				event.preventDefault();
			} else if(!selectedCity){
				alert('도시 선택을 해야합니다.');
				event.preventDefault();
			} else if(document.forms[0].hwallet.value.length != 42 
					  || document.forms[0].hwallet.value.substring(0,2) != '0x'){
				alert('지갑 주소를 정확히 입력해주세요.');
				event.preventDefault();
			}
		}
		
		function chkValid2(){ // 비밀번호 내용이 불일치할 때, submit 못하게 함.
			if(document.forms[0].password.value != document.forms[0].pw2.value){
				alert('비밀번호 확인이 필요합니다.');
				event.preventDefault();
			} else if(!selectedCity){
				alert('도시 선택을 해야합니다.');
				event.preventDefault();
			} else if(document.forms[0].hwallet.value.length != 42 
					  || document.forms[0].hwallet.value.substring(0,2) != '0x'){
				alert('지갑 주소를 정확히 입력해주세요.');
				event.preventDefault();
			}
		}
		
		function chkMatchPw(){ // 비밀번호 input의 내용이 다르면, 미리 만들어놓은 div에 표시해줌.
			if(document.forms[0].password.value != document.forms[0].pw2.value){
				z('matchPw').style.color = 'red';
				z('matchPw').style.width = '350px';
				z('matchPw').innerHTML = '비밀번호가 일치하지 않습니다.';
				//document.getElementsByClassName('emptyDiv')[1].style.height = '0px';
			} else {
				z('matchPw').style.color = 'green';
				z('matchPw').style.width = '350px';
				z('matchPw').innerHTML = '비밀번호가 일치합니다.';
				//document.getElementsByClassName('emptyDiv')[1].style.height = '21.6px';
			}
		}
		
		function chkMatchPw2() {
			document.forms[0].password.value = document.forms[0].password.value.replace(" ","");
			document.forms[0].pw2.value = document.forms[0].pw2.value.replace(" ","");
			if(event.data == ' '){  }
			
			if (document.forms[0].pw.value != document.forms[0].pw2.value) {
				z('matchPw').style.color = 'red';
				z('matchPw').innerHTML = '비밀번호 불일치!';
			}else if(document.forms[0].pw.value == document.forms[0].pw2.value) {
				z('matchPw').style.color = '#17b514';
				z('matchPw').innerHTML = '일치..';
			}
		}
		
		function ajaxChkDuplicate(hotelid){ // 아이디 중복 확인
			$.ajax({
				url:"ajax/chkIdDuplicate.jsp",
				data: {'hotelid':hotelid},
				success: function(data, statusTxt, xhr){
					eval(data);
				},
				error: function(xhr,statusTxt,c){ console.log("통신에 실패했습니다."); }
			}); //$.ajax(object); => object에 url, data 같은 key에 value를 넣어 보내면 success라는 key에 value로 callback함수를 받아옴.
		}
		
		function ajaxResult(param){
			if(param) {// ajaxResult(1)일경우, 이미 있는 아이디
				z('duplicateResult').style.color = 'red';
				z('duplicateResult').innerHTML = '이미 있는 ID입니다.';
				idValid = false;
			} else { // ajaxResult(0)
				z('duplicateResult').style.color = 'green';
				z('duplicateResult').innerHTML = '사용 가능한 ID입니다.';
				idValid = true;
			}
			//document.getElementsByClassName('emptyDiv')[0].style.height = '0px';
		}
		
		function getAccount(checked){ // 메타마스크에서 지갑 가져오기
			if(checked){
				// web3 인식 여부
				if(typeof web3 !== 'undefined'){ // !==는 타입까지 체크
					console.log("web3 인식 성공");
					web3js = new Web3(web3.currentProvider);
				}
				else{
					console.log("web3 인식 실패");
					alert('메타마스크를 설치해주십시오. \n만약 브라우저가 Chrome이 아니라면 실행할 수 없습니다.');
				}
				
				// 메타마스크에 접속되어 있는지 여부(접속되었으면 출력)
				if(web3js.eth.accounts[0] != null){
					console.log(web3js.eth.accounts[0]);
					if(confirm('지갑에서 주소를 불러옵니까?\n주소가 맞는지 잘 확인하세요!'))
						document.forms[0].hwallet.value = web3js.eth.accounts[0];
				}
				else {
					alert('메타마스크에 먼저 로그인 해야합니다.');
					z('chkBox').checked = false;
				}
			} 
			else { // 체크 해제시
				document.forms[0].hwallet.value = '';
			}
		}
		
		var selectedCity = false;
		function activatePlacesSearch(){ // google api가 이 함수로 들어옴.
			var cityElem = document.forms[0].city;
			var countryElem = document.forms[0].country;
			var option = {
					types: ['(cities)'] // 도시 정보만 가져오는 옵션
			}
			var autocomplete = new google.maps.places.Autocomplete(cityElem, option); // autocomplete 객체 생성
			
			if(cityElem.value != ''){ // 회원수정 창일 때
				selectedCity = true;
				chkSelectCity();
			}
			
			countryElem.onchange = function(){ // 나라를 선택하면
				cityElem.value = '';
				selectedCity = false;
				chkSelectCity();
				if(countryElem.value != ''){ // 선택했을 시
					cityElem.disabled = false;
					autocomplete.setComponentRestrictions({'country': countryElem.value}); // 국가 선택시, 해당 국가 내의 지역만 검색.
				} else{ // 국가 선택 안 했을 시
					cityElem.disabled = true;
				}
			}
			
			google.maps.event.addListener(autocomplete, 'place_changed', function(){ // 주소가 클릭될 때마다 이벤트가 발생
				if((typeof autocomplete.getPlace()) != 'undefined'){
					cityElem.value = autocomplete.getPlace().name;
					console.log('클릭으로 getPlace()에 문자가 담김.');
					selectedCity = true;
					chkSelectCity();
				}
			})
			
			cityElem.onkeyup = function(){ // city input에 입력이 들어왔을 때
				if(event.keyCode === 13){ // 엔터는 안 씀.
					cityElem.value = "";
				}
				selectedCity = false; // 클릭으로 선택한 도시 말고는 다 못 씀.
				chkSelectCity();
			}
		}

		
		function chkSelectCity(){
			if(!selectedCity){
				z('selectCity').style.color = 'red';
				z('selectCity').style.width = '350px';
				z('selectCity').innerHTML = '도시를 선택해야합니다.';
				//document.getElementsByClassName('emptyDiv')[2].style.height = '0px';
			} else {
				z('selectCity').style.color = 'green';
				z('selectCity').style.width = '350px';
				z('selectCity').innerHTML = '도시 선택 완료';
				//document.getElementsByClassName('emptyDiv')[2].style.height = '0px';
			}
		}