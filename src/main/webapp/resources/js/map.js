window.onload = function() {
    var mapContainer = document.getElementById('map');
    if (!mapContainer) {
        console.error('지도 div가 존재하지 않습니다. id="map" 확인해주세요.');
        return;
    }

    // HTML에서 병원 이름, 주소, 전화번호, 홈페이지 요소 가져오기
    var hospitalTitleEl = document.querySelector('.hospital_title');
    var hospitalAddressEl = document.querySelector('.hospital_address');
    var hospitalPhoneEl = document.querySelector('.hospital_phonenumber');
    var hospitalWebsiteEl = document.querySelector('.hospital_website');
    var locationEl = document.querySelector('.location');

    var hospitalTitle = hospitalTitleEl ? hospitalTitleEl.textContent : '우리회사';
    var hospitalAddress = hospitalAddressEl ? hospitalAddressEl.textContent : '서울';

    var mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 3
    };

    var map = new kakao.maps.Map(mapContainer, mapOption);
    var geocoder = new kakao.maps.services.Geocoder();

    geocoder.addressSearch(hospitalAddress, function(result, status) {
        console.log('검색 결과:', result, '상태:', status);
        if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });

            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="width:150px;text-align:center;padding:6px 0;">'
                         + hospitalTitle + '</div>'
            });
            infowindow.open(map, marker);

            map.setCenter(coords);

            // 전화번호와 홈페이지 가져오기 (여러 방법 시도)
            getPlaceInfoMultipleMethods(coords, hospitalTitle, hospitalPhoneEl, hospitalWebsiteEl);

            // 지하철 정보 가져오기
            getSubwayInfo(coords, locationEl);
        } else {
            console.error('주소 검색 실패:', status);
        }
    });
};

// 여러 방법으로 장소 정보(전화번호, 홈페이지) 가져오기
function getPlaceInfoMultipleMethods(coords, placeName, phoneElement, websiteElement) {
    // 방법 1: 키워드 검색
    getPlaceInfoByKeyword(coords, placeName, phoneElement, websiteElement);

    // 방법 2: 주변 의료기관 검색 (1초 후)
    setTimeout(function() {
        if (!phoneElement.textContent || phoneElement.textContent === '031-123-4567') {
            getPlaceInfoByCategory(coords, phoneElement, websiteElement);
        }
    }, 1000);

    // 방법 3: 주변 모든 장소 검색 (2초 후)
    setTimeout(function() {
        if (!phoneElement.textContent || phoneElement.textContent === '031-123-4567') {
            getPlaceInfoByNearby(coords, phoneElement, websiteElement);
        }
    }, 2000);
}

// 방법 1: 키워드로 장소 정보 검색
function getPlaceInfoByKeyword(coords, placeName, phoneElement, websiteElement) {
    var places = new kakao.maps.services.Places();

    places.keywordSearch(placeName, function(result, status) {
        console.log('키워드 검색 결과:', result);
        if (status === kakao.maps.services.Status.OK && result.length > 0) {
            for (var i = 0; i < result.length; i++) {
                var place = result[i];

                // 전화번호 업데이트
                if (place.phone && place.phone.trim() !== '' &&
                    (!phoneElement.textContent || phoneElement.textContent === '031-123-4567')) {
                    console.log('키워드 검색으로 전화번호 찾음:', place.phone);
                    phoneElement.textContent = place.phone;
                }

                // 홈페이지 업데이트
                if (place.place_url && place.place_url.trim() !== '' &&
                    (!websiteElement.textContent || websiteElement.textContent === 'http://www.healngo.kr')) {
                    console.log('키워드 검색으로 홈페이지 찾음:', place.place_url);
                    websiteElement.textContent = place.place_url;
                    // 클릭 가능한 링크로 만들기
                    websiteElement.innerHTML = '<a href="' + place.place_url + '" target="_blank">' + place.place_url + '</a>';
                }
            }
        }
    }, {
        location: coords,
        radius: 1000
    });
}

// 방법 2: 의료기관 카테고리로 장소 정보 검색
function getPlaceInfoByCategory(coords, phoneElement, websiteElement) {
    var places = new kakao.maps.services.Places();

    // 의료기관 카테고리 검색 (HP8: 병원)
    places.categorySearch('HP8', function(result, status) {
        console.log('의료기관 검색 결과:', result);
        if (status === kakao.maps.services.Status.OK && result.length > 0) {
            for (var i = 0; i < result.length; i++) {
                var place = result[i];

                // 전화번호 업데이트
                if (place.phone && place.phone.trim() !== '' &&
                    (!phoneElement.textContent || phoneElement.textContent === '031-123-4567')) {
                    console.log('의료기관 검색으로 전화번호 찾음:', place.phone);
                    phoneElement.textContent = place.phone;
                }

                  // URL이 실제 웹사이트인지 확인
                  function isValidWebsite(url) {
                      return url && (url.startsWith('http://') || url.startsWith('https://'));
                  }

                  // 홈페이지 업데이트 (place_url과 link_detail 모두 확인)
                  var websiteUrl = '';
                  if (place.place_url && place.place_url.trim() !== '') {
                      websiteUrl = place.place_url;
                  } else if (place.link_detail && place.link_detail.trim() !== '') {
                      websiteUrl = place.link_detail;
                  }

                  if (websiteUrl && (!websiteElement.textContent || websiteElement.textContent === 'http://www.healngo.kr')) {
                      console.log('의료기관 검색으로 홈페이지 찾음:', websiteUrl);
                      websiteElement.textContent = websiteUrl;
                      websiteElement.innerHTML = '<a href="' + websiteUrl + '" target="_blank">' + websiteUrl + '</a>';
                  }
            }
        }
    }, {
        location: coords,
        radius: 1000
    });
}

// 방법 3: 주변 모든 장소에서 장소 정보 검색
function getPlaceInfoByNearby(coords, phoneElement, websiteElement) {
    var places = new kakao.maps.services.Places();

    // 주변 모든 장소 검색
    places.keywordSearch('병원', function(result, status) {
        console.log('주변 검색 결과:', result);
        if (status === kakao.maps.services.Status.OK && result.length > 0) {
            for (var i = 0; i < result.length; i++) {
                var place = result[i];

                // 전화번호 업데이트
                if (place.phone && place.phone.trim() !== '' &&
                    (!phoneElement.textContent || phoneElement.textContent === '031-123-4567')) {
                    console.log('주변 검색으로 전화번호 찾음:', place.phone);
                    phoneElement.textContent = place.phone;
                }

                // 홈페이지 업데이트
                if (place.place_url && place.place_url.trim() !== '' &&
                    (!websiteElement.textContent || websiteElement.textContent === 'http://www.healngo.kr')) {
                    console.log('주변 검색으로 홈페이지 찾음:', place.place_url);
                    websiteElement.textContent = place.place_url;
                    websiteElement.innerHTML = '<a href="' + place.place_url + '" target="_blank">' + place.place_url + '</a>';
                }
            }
        }
    }, {
        location: coords,
        radius: 500
    });
}

// 지하철 정보를 가져오는 함수
function getSubwayInfo(coords, locationElement) {
    var places = new kakao.maps.services.Places();

    places.categorySearch('SW8', function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            var nearestStation = null;
            var minDistance = Infinity;

            for (var i = 0; i < result.length; i++) {
                var stationCoords = new kakao.maps.LatLng(result[i].y, result[i].x);
                var distance = getDistance(coords, stationCoords);

                if (distance < minDistance) {
                    minDistance = distance;
                    nearestStation = result[i];
                }
            }

            if (nearestStation && minDistance <= 1000) {
                var distanceText = minDistance < 1000 ? Math.round(minDistance) + 'm' : (minDistance / 1000).toFixed(1) + 'km';
                var walkTime = Math.round(minDistance / 80);

                var subwayInfo = nearestStation.place_name + ' ' + distanceText + ' · 도보 ' + walkTime + '분';

                if (locationElement) {
                    locationElement.textContent = subwayInfo;
                }
            }
        }
    }, {
        location: coords,
        radius: 1000
    });
}

// 두 좌표 간의 거리 계산 함수
function getDistance(latLng1, latLng2) {
    var R = 6371000;
    var dLat = (latLng2.getLat() - latLng1.getLat()) * Math.PI / 180;
    var dLon = (latLng2.getLng() - latLng1.getLng()) * Math.PI / 180;
    var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.cos(latLng1.getLat() * Math.PI / 180) * Math.cos(latLng2.getLat() * Math.PI / 180) *
            Math.sin(dLon/2) * Math.sin(dLon/2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    return R * c;
}