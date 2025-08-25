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
            initializeMap(mapElement);
            mapElement.setAttribute('data-initialized', 'true');
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
        
        var mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667),
            level: 3
        };

        var map = new kakao.maps.Map(mapElement, mapOption);
        var geocoder = new kakao.maps.services.Geocoder();

        // 주소로 좌표 검색
        var address = document.querySelector('.hospital_address').textContent;
        console.log('검색할 주소:', address); // 디버깅용
        
        geocoder.addressSearch(address, function(result, status) {
            console.log('주소 검색 결과:', result, '상태:', status); // 디버깅용
            
            if (status === kakao.maps.services.Status.OK) {
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="width:150px;text-align:center;padding:6px 0;">병원</div>'
                });
                infowindow.open(map, marker);

                map.setCenter(coords);
                console.log('지도 초기화 완료'); // 디버깅용
            } else {
                console.error('주소 검색 실패:', status);
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
