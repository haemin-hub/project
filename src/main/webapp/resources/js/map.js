

// 주소 기반 지도 초기화 함수
function initializeMap(mapElement, hospitalName, address) {
    try {
        console.log('주소 기반 지도 초기화 시작 - 병원:', hospitalName, '주소:', address);

        // 카카오맵 API 로드 상태 확인
        if (typeof kakao === 'undefined' || !kakao.maps) {
            console.error('카카오맵 API가 로드되지 않았습니다. 잠시 후 다시 시도합니다.');
            setTimeout(() => {
                initializeMap(mapElement, hospitalName, address);
            }, 1000);
            return;
        }

        // 지도를 표시할 div
        var mapContainer = mapElement;

        // 지도 옵션 설정 (기본 중심좌표)
        var mapOption = {
            center: new kakao.maps.LatLng(37.5665, 126.9780), // 서울시청 기본 중심좌표
            level: 3 // 지도의 확대 레벨
        };

        // 지도를 생성합니다
        var map = new kakao.maps.Map(mapContainer, mapOption);

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

        // 주소로 좌표를 검색합니다
        geocoder.addressSearch(address, function(result, status) {
            console.log('주소 검색 결과:', status, result);

            // 정상적으로 검색이 완료됐으면
            if (status === kakao.maps.services.Status.OK && result && result.length > 0) {
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                console.log('찾은 좌표:', coords.getLat(), coords.getLng());

                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);

                console.log('주소 기반 지도 초기화 완료');

            } else {
                console.error('주소를 찾을 수 없습니다:', address, '상태:', status);
                // 주소 검색 실패 시 간단한 주소로 재시도
                retryWithSimplifiedAddress(map, hospitalName, address);
            }
        });

    } catch (error) {
        console.error('지도 초기화 중 오류:', error);
    }
}

// 간단한 주소로 재시도하는 함수
function retryWithSimplifiedAddress(map, hospitalName, originalAddress) {
    try {
        console.log('간단한 주소로 재시도 - 병원:', hospitalName);

        // 주소를 간단하게 변환
        var simplifiedAddress = '';

        if (originalAddress.includes('부산')) {
            simplifiedAddress = '부산 해운대구';
        } else if (originalAddress.includes('서울')) {
            if (originalAddress.includes('강남')) {
                simplifiedAddress = '서울 강남구';
            } else if (originalAddress.includes('서초')) {
                simplifiedAddress = '서울 서초구';
            } else {
                simplifiedAddress = '서울 강남구';
            }
        } else {
            simplifiedAddress = '서울 강남구';
        }

        console.log('간단한 주소로 재시도:', simplifiedAddress);

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

        // 간단한 주소로 좌표를 검색합니다
        geocoder.addressSearch(simplifiedAddress, function(result, status) {
            console.log('간단한 주소 검색 결과:', status, result);

            if (status === kakao.maps.services.Status.OK && result && result.length > 0) {
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                console.log('간단한 주소로 찾은 좌표:', coords.getLat(), coords.getLng());

                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);

                console.log('간단한 주소로 지도 초기화 완료');

            } else {
                console.error('간단한 주소도 찾을 수 없습니다:', simplifiedAddress);
            }
        });

    } catch (error) {
        console.error('간단한 주소 재시도 중 오류:', error);
    }
}

// 병원 정보 업데이트 함수
function updatePlaceInfo(place, phoneElement, websiteElement) {
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
        if (place.place_name.includes('JY피부과')) {
            websiteUrl = 'https://jy-dermatology.com/';
        } else if (place.place_name.includes('부산치과')) {
            websiteUrl = 'https://busan-dental.com/';
        }
    }
    
    if (websiteUrl && websiteElement) {
        console.log('홈페이지 찾음:', websiteUrl);
        websiteElement.textContent = websiteUrl;
        websiteElement.innerHTML = '<a href="' + websiteUrl + '" target="_blank">' + websiteUrl + '</a>';
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