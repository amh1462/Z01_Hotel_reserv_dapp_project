
function activatePlacesSearch() { // google api가 이 함수로 들어옴.
    var cityElem = document.forms[0].city;
    var countryElem = document.forms[0].country;
    var option = {
        types: ['(cities)'] // 도시 정보만 가져오는 옵션
    }
    var autocomplete = new google.maps.places.Autocomplete(cityElem, option); // autocomplete 객체 생성
    var isExistCityElem = cityElem.value;
    
    countryElem.onchange = function(){ // 나라를 선택하면
	    cityElem.value = '';
		autocomplete.setComponentRestrictions({'country': countryElem.value}); // 국가 선택시, 해당 국가 내의 지역만 검색.
    }
    autocomplete.setComponentRestrictions({'country': countryElem.value}); // 국가 선택시, 해당 국가 내의 지역만 검색.
    google.maps.event.addListener(autocomplete, 'place_changed', function () { // 도시 정보를 자동 완성
        cityElem.value = autocomplete.getPlace().name;
    })

    
    cityElem.onkeyup = function () {
    	if(event.keyCode === 13){ // 엔터는 안 씀.
			cityElem.value = "";
		}
        
    }
}
