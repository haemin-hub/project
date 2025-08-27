// 전역 변수로 지도 객체 저장
let map = null;
let currentMarker = null;

// 기존 initMap 함수 (페이지 로드 시 기본 지도 초기화)
function initMap() {
    const mapElement = document.getElementById("map");
    if (!mapElement) {
        console.log("지도 요소가 없습니다. 병원을 선택해주세요.");
        return;
    }

    map = new google.maps.Map(mapElement, {
        zoom: 15,
        center: { lat: 37.5665, lng: 126.9780 }, // 기본 위치(서울)
    });

    const service = new google.maps.places.PlacesService(map);

    // 근처 장소 검색
    service.nearbySearch(
        {
            location: { lat: 37.5665, lng: 126.9780 }, // 검색 중심(서울)
            radius: 1000, // 반경 1km
            type: "restaurant", // 레스토랑
        },
        (results, status) => {
            if (status === google.maps.places.PlacesServiceStatus.OK) {
                results.forEach((place) => {
                    // 마커 추가
                    const marker = new google.maps.Marker({
                        position: place.geometry.location,
                        map: map,
                    });

                    // 장소 이름 표시용 InfoWindow
                    const infoWindow = new google.maps.InfoWindow({
                        content: `<div><strong>${place.name}</strong><br>${place.vicinity}</div>`,
                    });

                    // 마커 클릭 시 InfoWindow 열기
                    marker.addListener("click", () => {
                        infoWindow.open(map, marker);
                    });
                });
            } else {
                console.error("Places request failed: " + status);
            }
        }
    );
}

// 병원 상세 정보용 지도 초기화 함수
function initializeMap(mapElement, hospitalName, address) {
    if (!mapElement) {
        console.error('지도 요소를 찾을 수 없습니다.');
        return;
    }

    // 기존 마커 제거
    if (currentMarker) {
        currentMarker.setMap(null);
    }

    // 지도를 새로 생성 (매번 새로운 지도 객체 생성)
    map = new google.maps.Map(mapElement, {
        zoom: 15,
        center: { lat: 37.5665, lng: 126.9780 }, // 기본 위치
    });

    // 주소를 좌표로 변환 (DB에서 가져온 실제 주소 사용)
    const geocoder = new google.maps.Geocoder();
    
    // 주소가 유효한지 확인
    if (!address || address === '주소 정보 없음' || address === '-') {
        console.error('유효하지 않은 주소입니다:', address);
        // 실패 시 기본 위치에 마커 표시
        const defaultLocation = { lat: 37.5665, lng: 126.9780 };
        map.setCenter(defaultLocation);
        
        currentMarker = new google.maps.Marker({
            position: defaultLocation,
            map: map,
            title: hospitalName
        });
        return;
    }
    
    geocoder.geocode({ address: address }, (results, status) => {
        if (status === 'OK') {
            const location = results[0].geometry.location;
            
            // 지도 중심을 병원 위치로 이동
            map.setCenter(location);
            
            // 병원 마커 추가
            currentMarker = new google.maps.Marker({
                position: location,
                map: map,
                title: hospitalName,
                icon: {
                    url: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png',
                    scaledSize: new google.maps.Size(32, 32)
                }
            });



            // 마커 클릭 시 정보창 표시
            currentMarker.addListener('click', () => {
                infoWindow.open(map, currentMarker);
            });

            // 자동으로 정보창 표시
            infoWindow.open(map, currentMarker);

            console.log('지도 초기화 완료:', hospitalName, '실제 주소:', address);
        } else {
            console.error('주소를 좌표로 변환할 수 없습니다:', status, '주소:', address);
            // 실패 시 기본 위치에 마커 표시
            const defaultLocation = { lat: 37.5665, lng: 126.9780 };
            map.setCenter(defaultLocation);
            
            currentMarker = new google.maps.Marker({
                position: defaultLocation,
                map: map,
                title: hospitalName
            });
        }
    });
}