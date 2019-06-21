var selectedCity = false;
function activatePlacesSearch() { // google api가 이 함수로 들어옴.
    var cityElem = document.forms[0].city;
    var countryElem = document.forms[0].country;
    var option = {
        types: ['(cities)'] // 도시 정보만 가져오는 옵션
    }
    var autocomplete = new google.maps.places.Autocomplete(cityElem, option); // autocomplete 객체 생성

   // countryElem.onchange = function () { // 나라 선택
        cityElem.value = '';
        
        if (countryElem.value != '') { // 선택했을 시
            cityElem.disabled = false;
            autocomplete.setComponentRestrictions({ 'country': countryElem.value }); // 해당 국가만
            google.maps.event.addListener(autocomplete, 'place_changed', function () { // 도시 정보를 자동 완성
                cityElem.value = autocomplete.getPlace().name;
                selectedCity = true;
                
            })
        } else {
            cityElem.disabled = true;
            selectedCity = false;
        }
    //}

    cityElem.onkeypress = function () {
        google.maps.event.trigger(autocomplete, 'place_changed');
        selectedCity = false;
        
    }
}
