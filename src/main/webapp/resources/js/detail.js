// 게시글 상세내용 토글 함수
function toggleDetail(element) {
    console.log('toggleDetail 함수 호출됨'); // 디버깅용
    
    const detail = element.querySelector('.hospital-detail');
    const arrow = element.querySelector('.hospital-arrow');
    
    console.log('detail 요소:', detail); // 디버깅용
    console.log('현재 display 상태:', detail.style.display); // 디버깅용
    
    // 다른 모든 게시글 닫기
    const allItems = document.querySelectorAll('.hospital-item');
    allItems.forEach(item => {
        if (item !== element) {
            item.classList.remove('active');
            const otherDetail = item.querySelector('.hospital-detail');
            if (otherDetail) {
                otherDetail.style.display = 'none';
            }
        }
    });
    
    // 현재 게시글 토글
    if (detail.style.display === 'none' || detail.style.display === '') {
        console.log('상세내용 열기'); // 디버깅용
        element.classList.add('active');
        detail.style.display = 'block';
        detail.classList.add('show');
        
        // 지도가 있는 경우 지도 초기화
        const mapElement = detail.querySelector('#map');
        if (mapElement && !mapElement.hasAttribute('data-initialized')) {
            console.log('지도 초기화 시작'); // 디버깅용
            console.log('mapElement:', mapElement); // 디버깅용
            console.log('kakao.maps:', typeof kakao !== 'undefined' ? kakao : 'undefined'); // 디버깅용
            initializeMap(mapElement);
            mapElement.setAttribute('data-initialized', 'true');
        }

        // 운영시간 정보 업데이트 (카카오맵에서 가져온 데이터로)
        const timeElement = detail.querySelector('.hospital_time');
        if (timeElement && (!timeElement.textContent || timeElement.textContent === '')) {
            // 3초 후에도 비어있으면 픽셀랩성형외과 운영시간 설정
            setTimeout(() => {
                if (!timeElement.textContent || timeElement.textContent === '') {
                    console.log('운영시간 기본값 설정');
                    timeElement.textContent = '월~금: 10:00 ~ 20:00, 토: 10:00 ~ 17:00, 일: 휴무일';
                    timeElement.style.color = '#666';
                    timeElement.style.fontStyle = 'normal';
                }
            }, 3000);
        }
    } else {
        console.log('상세내용 닫기'); // 디버깅용
        element.classList.remove('active');
        detail.style.display = 'none';
        detail.classList.remove('show');
    }
}

// 지도 초기화 함수
function initializeMap(mapElement) {
    try {
        console.log('지도 초기화 함수 실행'); // 디버깅용
        
        // 현재 열린 상세내용에서 병원 정보 가져오기
        var detail = mapElement.closest('.hospital-detail');
        var hospitalTitleEl = detail.querySelector('.hospital_title');
        var hospitalAddressEl = detail.querySelector('.hospital_address');
        var hospitalPhoneEl = detail.querySelector('.hospital_phonenumber');
        var hospitalWebsiteEl = detail.querySelector('.hospital_website');
        var hospitalTimeEl = detail.querySelector('.hospital_time');
        var locationEl = detail.querySelector('.location');

        var hospitalTitle = hospitalTitleEl ? hospitalTitleEl.textContent : '픽셀랩성형외과';
        var hospitalAddress = hospitalAddressEl ? hospitalAddressEl.textContent : '서울 서초구 서초대로73길 42 강남역리가스퀘어 3층';

        var mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667),
            level: 3
        };

        var map = new kakao.maps.Map(mapElement, mapOption);
        var places = new kakao.maps.services.Places();

        // 병원 업체명으로 직접 검색
        console.log('검색할 병원명:', hospitalTitle); // 디버깅용
        places.keywordSearch(hospitalTitle, function(result, status) {
            console.log('병원 검색 결과:', result, '상태:', status);
            if (status === kakao.maps.services.Status.OK && result.length > 0) {
                var place = result[0]; // 첫 번째 결과 사용
                var coords = new kakao.maps.LatLng(place.y, place.x);

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

                // 전화번호, 홈페이지, 운영시간 업데이트
                updatePlaceInfo(place, hospitalPhoneEl, hospitalWebsiteEl, hospitalTimeEl);

                // 지하철 정보 가져오기
                getSubwayInfo(coords, locationEl);
                
                // 각 병원별 운영시간 강제 설정 (백업)
                if (hospitalTimeEl && (!hospitalTimeEl.textContent || hospitalTimeEl.textContent === '')) {
                    if (hospitalTitle.includes('픽셀랩')) {
                        console.log('픽셀랩성형외과 운영시간 강제 설정');
                        hospitalTimeEl.textContent = '월~금: 10:00 ~ 20:00, 토: 10:00 ~ 17:00, 일: 휴무일';
                        hospitalTimeEl.style.color = '#666';
                        hospitalTimeEl.style.fontStyle = 'normal';
                    } else if (hospitalTitle.includes('강남성형외과')) {
                        console.log('강남성형외과 운영시간 강제 설정');
                        hospitalTimeEl.textContent = '월~금: 09:00 ~ 18:00, 토: 09:00 ~ 14:00, 일: 휴무일';
                        hospitalTimeEl.style.color = '#666';
                        hospitalTimeEl.style.fontStyle = 'normal';
                    } else if (hospitalTitle.includes('부산치과')) {
                        console.log('부산치과 운영시간 강제 설정');
                        hospitalTimeEl.textContent = '월~금: 08:30 ~ 19:00, 토: 08:30 ~ 16:00, 일: 휴무일';
                        hospitalTimeEl.style.color = '#666';
                        hospitalTimeEl.style.fontStyle = 'normal';
                    }
                }
            } else {
                console.error('병원 검색 실패:', status);
                // 검색 실패 시 주소로 지도만 표시
                var geocoder = new kakao.maps.services.Geocoder();
                geocoder.addressSearch(hospitalAddress, function(result, status) {
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
                        
                        // 지하철 정보만 가져오기
                        getSubwayInfo(coords, locationEl);
                    }
                });
            }
        });
    } catch (error) {
        console.error('지도 초기화 중 오류:', error);
    }
}

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    console.log('페이지 로드 완료'); // 디버깅용
    
    // 클릭 이벤트 리스너 추가 (onclick 대신 addEventListener 사용)
    const hospitalItems = document.querySelectorAll('.hospital-item');
    hospitalItems.forEach(item => {
        item.addEventListener('click', function(e) {
            console.log('게시글 클릭됨'); // 디버깅용
            toggleDetail(this);
        });
    });
    
    // 첫 번째 게시글 자동 열기 (선택사항)
    // const firstItem = document.querySelector('.hospital-item');
    // if (firstItem) {
    //     setTimeout(() => {
    //         toggleDetail(firstItem);
    //     }, 1000);
    // }
});

// 간단한 테스트 함수
function testToggle() {
    console.log('테스트 함수 실행');
    const firstItem = document.querySelector('.hospital-item');
    if (firstItem) {
        toggleDetail(firstItem);
    }
}
