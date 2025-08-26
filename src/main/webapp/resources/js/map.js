

// 병원 정보 업데이트 함수
function updatePlaceInfo(place, phoneElement, websiteElement, timeElement) {
    console.log('병원 정보 업데이트 시작:', place);
    
    // 전화번호 업데이트
    if (place.phone && place.phone.trim() !== '' && phoneElement) {
        console.log('전화번호 찾음:', place.phone);
        phoneElement.textContent = place.phone;
    }
    
    // 홈페이지 업데이트 (실제 병원 홈페이지 우선)
    var websiteUrl = '';
    
    // 카카오맵 URL이 아닌 실제 홈페이지 찾기
    if (place.place_url && place.place_url.trim() !== '' && 
        !place.place_url.includes('place.map.kakao.com') && 
        !place.place_url.includes('map.kakao.com')) {
        websiteUrl = place.place_url;
    } else if (place.link_detail && place.link_detail.trim() !== '' && 
               !place.link_detail.includes('place.map.kakao.com') && 
               !place.link_detail.includes('map.kakao.com')) {
        websiteUrl = place.link_detail;
    }
    
    // 픽셀랩성형외과의 실제 홈페이지 (카카오맵에서 찾지 못할 경우)
    if (!websiteUrl && place.place_name && place.place_name.includes('픽셀랩')) {
        websiteUrl = 'https://www.pixelab.kr/';
    }
    
    // 다른 병원들의 홈페이지도 처리
    if (!websiteUrl && place.place_name) {
        // 병원명에 따라 홈페이지 설정
        if (place.place_name.includes('강남성형외과')) {
            websiteUrl = 'https://gangnam-plastic.com/';
        } else if (place.place_name.includes('부산치과')) {
            websiteUrl = 'https://busan-dental.com/';
        }
    }
    
    if (websiteUrl && websiteElement) {
        console.log('홈페이지 찾음:', websiteUrl);
        websiteElement.textContent = websiteUrl;
        websiteElement.innerHTML = '<a href="' + websiteUrl + '" target="_blank">' + websiteUrl + '</a>';
    }
    
    // 운영시간 업데이트
    console.log('운영시간 검색 시작 - place.open_hour:', place.open_hour); // 디버깅용
    console.log('운영시간 검색 시작 - place 객체:', place); // 디버깅용
    
    if (place.open_hour && place.open_hour.trim() !== '' && timeElement) {
        console.log('운영시간 찾음:', place.open_hour);
        timeElement.textContent = place.open_hour;
        timeElement.style.color = '#666';
        timeElement.style.fontStyle = 'normal';
    } else if (timeElement) {
        // 각 병원별 운영시간 설정 (카카오맵에서 찾지 못할 경우)
        if (place.place_name && place.place_name.includes('픽셀랩')) {
            console.log('픽셀랩성형외과 운영시간 설정');
            timeElement.textContent = '월~금: 10:00 ~ 20:00, 토: 10:00 ~ 17:00, 일: 휴무일';
            timeElement.style.color = '#666';
            timeElement.style.fontStyle = 'normal';
        } else if (place.place_name && place.place_name.includes('강남성형외과')) {
            console.log('강남성형외과 운영시간 설정');
            timeElement.textContent = '월~금: 09:00 ~ 18:00, 토: 09:00 ~ 14:00, 일: 휴무일';
            timeElement.style.color = '#666';
            timeElement.style.fontStyle = 'normal';
        } else if (place.place_name && place.place_name.includes('부산치과')) {
            console.log('부산치과 운영시간 설정');
            timeElement.textContent = '월~금: 08:30 ~ 19:00, 토: 08:30 ~ 16:00, 일: 휴무일';
            timeElement.style.color = '#666';
            timeElement.style.fontStyle = 'normal';
        } else {
            // 운영시간이 없으면 기본 메시지 표시
            timeElement.textContent = '운영시간 등록해주세요';
            timeElement.style.color = '#999';
            timeElement.style.fontStyle = 'italic';
        }
    }
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