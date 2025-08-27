// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    console.log('병원 목록 페이지 로드 완료');

    initializeEventListeners();
    updateTotalCount();

    // 하트 상태 복원
    restoreHeartStates();

    // detail-content 초기 상태를 숨김으로 설정
    const detailContent = document.querySelector('.detail-content');
    const detailPlaceholder = document.querySelector('.detail-placeholder');

    if (detailContent) {
        detailContent.style.display = 'none';
    }
    if (detailPlaceholder) {
        detailPlaceholder.style.display = 'block';
    }
});

// 이벤트 리스너 초기화
function initializeEventListeners() {
    // 필터 체크박스 이벤트
    const filterCheckboxes = document.querySelectorAll('.filter-checkbox input[type="checkbox"]');
    filterCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            filterHospitals();
        });
    });

    // 병원 아이템 클릭 이벤트
    const hospitalItems = document.querySelectorAll('.hospital-item');
    hospitalItems.forEach(item => {
        item.addEventListener('click', function(e) {
            // 하트 클릭 시 이벤트 전파 방지
            if (e.target.closest('.hospital-heart')) {
                e.stopPropagation();
                toggleHeart(this);
            } else {
                selectHospital(this);
                // 선택된 경우에만 상세 정보 표시
                if (this.classList.contains('active')) {
                    showHospitalDetail(this);
                }
            }
        });
    });

    // 페이지네이션 이벤트
    const pageLinks = document.querySelectorAll('.page-link');
    pageLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            handlePagination(this);
        });
    });
}

// 병원 상세 정보 표시
function showHospitalDetail(hospitalItem) {
    const hospitalName = hospitalItem.dataset.hospital;
    const detailContent = document.querySelector('.detail-content');
    const detailPlaceholder = document.querySelector('.detail-placeholder');

    // 플레이스홀더 숨기기
    detailPlaceholder.style.display = 'none';

    // 상세 정보 로드 및 표시
    detailContent.style.display = 'block';
    detailContent.innerHTML = generateHospitalDetailHTML(hospitalName);

    // 지도 초기화 (카카오맵이 로드된 경우)
    setTimeout(() => {
        const mapElement = detailContent.querySelector('#map');
        if (mapElement && typeof kakao !== 'undefined' && kakao.maps) {
            const hospitalData = getHospitalData(hospitalName);
            console.log('지도 초기화 시작 - 병원:', hospitalName, '주소:', hospitalData.address);
            // map.js의 initializeMap 함수 사용
            initializeMap(mapElement, hospitalName, hospitalData.address);
        } else {
            console.error('카카오맵 API가 로드되지 않았습니다.');
        }
    }, 500);

    console.log('상세 정보 표시:', hospitalName);
}

// 병원 상세 정보 HTML 생성
function generateHospitalDetailHTML(hospitalName) {
    const hospitalData = getHospitalData(hospitalName);

    return `
        <div class="hospital-detail-info">
            <div class="hospital-header">
                <h2 class="hospital-title">${hospitalName}</h2>
                <div class="hospital-image">
                    <img src="/resources/images/detail/hospital.jpg" alt="${hospitalName}">
                </div>
            </div>

            <div class="hospital-info-table">
                <table>
                    <tr>
                        <th>홈페이지</th>
                        <td class="hospital_website">${hospitalData.website}</td>
                    </tr>
                    <tr>
                        <th>연락처</th>
                        <td class="hospital_phonenumber">${hospitalData.phone}</td>
                    </tr>
                    <tr>
                        <th>위치 및 교통정보</th>
                        <td class="hospital_address">${hospitalData.address}</td>
                    </tr>
                    <tr>
                        <th>지하철</th>
                        <td class="location">${hospitalData.subway}</td>
                    </tr>
                </table>
            </div>

            <div class="hospital-map">
                <h3>지도</h3>
                <div id="map" class="map"></div>
            </div>
        </div>
    `;
}

// 병원 데이터 가져오기
function getHospitalData(hospitalName) {
    const hospitalData = {
        '더고운성형외과의원': {
            website: 'http://www.daegoon.com',
            phone: '02-123-4567',
            address: '서울특별시 강남구 테헤란로 123',
            subway: '2호선 강남역 3번 출구 150m'
        },
        '더뷰티성형외과의원': {
            website: 'http://www.daebeauty.com',
            phone: '02-234-5678',
            address: '서울특별시 강남구 테헤란로 456',
            subway: '2호선 강남역 5번 출구 200m'
        },
        '더바디성형외과의원': {
            website: 'http://www.daebody.com',
            phone: '02-345-6789',
            address: '서울특별시 강남구 테헤란로 789',
            subway: '2호선 강남역 7번 출구 300m'
        },
        '픽셀랩성형외과의원': {
            website: 'http://www.healngo.kr',
            phone: '031-123-4567',
            address: '서울특별시 서초구 서초대로73길 42',
            subway: '신분당 신논현역 7번 출구 239m · 도보 6분'
        },
        'JY피부과의원': {
            website: 'http://www.jy-dermatology.com',
            phone: '02-456-7890',
            address: '서울특별시 강남구 테헤란로 123',
            subway: '2호선 강남역 3번 출구 150m · 도보 3분'
        },
        '부산치과의원': {
            website: 'http://www.busan-dental.com',
            phone: '051-123-4567',
            address: '부산광역시 해운대구 해운대로 264',
            subway: '2호선 해운대역 1번 출구 300m · 도보 5분'
        }
    };

    return hospitalData[hospitalName] || {
        website: 'http://www.example.com',
        phone: '02-000-0000',
        address: '서울특별시 강남구',
        subway: '지하철 정보 없음'
    };
}

// 병원 필터링
function filterHospitals() {
    const selectedCategories = getSelectedCategories();
    const hospitalItems = document.querySelectorAll('.hospital-item');

    hospitalItems.forEach(item => {
        const hospitalName = item.querySelector('.hospital-name').textContent;
        const shouldShow = selectedCategories.length === 0 ||
                          selectedCategories.some(category =>
                              hospitalName.includes(getCategoryKeyword(category))
                          );

        if (shouldShow) {
            item.style.display = 'flex';
        } else {
            item.style.display = 'none';
        }
    });

    updateTotalCount();
}

// 선택된 카테고리 가져오기
function getSelectedCategories() {
    const checkboxes = document.querySelectorAll('.filter-checkbox input[type="checkbox"]:checked');
    return Array.from(checkboxes).map(checkbox => checkbox.value);
}

// 카테고리별 키워드 매핑
function getCategoryKeyword(category) {
    const keywords = {
        'eye': '눈',
        'nose': '코',
        'chin': '턱',
        'mouth': '입',
        'chest': '가슴',
        'liposuction': '지방흡입'
    };
    return keywords[category] || '';
}

// 하트 토글
function toggleHeart(hospitalItem) {
    const heartIcon = hospitalItem.querySelector('.hospital-heart i');

    if (heartIcon.classList.contains('far')) {
        // 빈 하트 → 채워진 하트
        heartIcon.classList.remove('far');
        heartIcon.classList.add('fas');
        heartIcon.style.color = '#ff4757';
        console.log('즐겨찾기 추가:', hospitalItem.dataset.hospital);
    } else {
        // 채워진 하트 → 빈 하트
        heartIcon.classList.remove('fas');
        heartIcon.classList.add('far');
        heartIcon.style.color = '#ccc';
        console.log('즐겨찾기 제거:', hospitalItem.dataset.hospital);
    }

    // 하트 상태를 localStorage에 저장
    saveHeartState(hospitalItem.dataset.hospital, heartIcon.classList.contains('fas'));
}

// 병원 선택
function selectHospital(hospitalItem) {
    // 현재 선택된 병원이 다시 클릭된 경우 선택 취소
    if (hospitalItem.classList.contains('active')) {
        hospitalItem.classList.remove('active');
        console.log('병원 선택 취소:', hospitalItem.dataset.hospital);

        // detail-content 숨기고 placeholder 표시
        const detailContent = document.querySelector('.detail-content');
        const detailPlaceholder = document.querySelector('.detail-placeholder');

        if (detailContent) {
            detailContent.style.display = 'none';
        }
        if (detailPlaceholder) {
            detailPlaceholder.style.display = 'block';
        }
    } else {
        // 기존 선택 해제
        const activeItems = document.querySelectorAll('.hospital-item.active');
        activeItems.forEach(item => {
            item.classList.remove('active');
        });

        // 새로운 선택
        hospitalItem.classList.add('active');
        console.log('병원 선택:', hospitalItem.dataset.hospital);
    }
}

// BEST 병원 표시
function showBestHospitals() {
    const hospitalItems = document.querySelectorAll('.hospital-item');
    const bestHospitals = ['더바디성형외과의원', '픽셀랩성형외과의원', 'JY피부과의원'];

    hospitalItems.forEach(item => {
        const hospitalName = item.dataset.hospital;
        if (bestHospitals.includes(hospitalName)) {
            item.style.display = 'flex';
            item.style.order = bestHospitals.indexOf(hospitalName);
        } else {
            item.style.display = 'none';
        }
    });

    updateTotalCount();
    console.log('BEST 병원 필터 적용');
}

// 페이지네이션 처리
function handlePagination(clickedLink) {
    const pageLinks = document.querySelectorAll('.page-link');
    pageLinks.forEach(link => {
        link.classList.remove('active');
    });

    clickedLink.classList.add('active');

    const pageNumber = clickedLink.textContent;
    console.log('페이지 이동:', pageNumber);

    // 실제 페이지네이션 로직 구현 (서버 요청 등)
    // loadPage(pageNumber);
}

// 총 개수 업데이트
function updateTotalCount() {
    const visibleItems = document.querySelectorAll('.hospital-item[style*="flex"], .hospital-item:not([style*="none"])');
    const totalCount = visibleItems.length;

    const totalCountElement = document.querySelector('.total-count');
    if (totalCountElement) {
        totalCountElement.textContent = `총 ${totalCount}건`;
    }
}

// 검색 기능 (추가 기능)
function searchHospitals(keyword) {
    const hospitalItems = document.querySelectorAll('.hospital-item');

    hospitalItems.forEach(item => {
        const hospitalName = item.querySelector('.hospital-name').textContent.toLowerCase();
        const shouldShow = hospitalName.includes(keyword.toLowerCase());

        if (shouldShow) {
            item.style.display = 'flex';
        } else {
            item.style.display = 'none';
        }
    });

    updateTotalCount();
}

// 필터 초기화
function resetFilters() {
    const checkboxes = document.querySelectorAll('.filter-checkbox input[type="checkbox"]');
    checkboxes.forEach(checkbox => {
        checkbox.checked = false;
    });

    const hospitalItems = document.querySelectorAll('.hospital-item');
    hospitalItems.forEach(item => {
        item.style.display = 'flex';
        item.style.order = '';
    });

    updateTotalCount();
    console.log('필터 초기화');
}

// 즐겨찾기 목록 가져오기
function getFavoriteHospitals() {
    const favoriteItems = document.querySelectorAll('.hospital-item .fas.fa-heart');
    return Array.from(favoriteItems).map(heart =>
        heart.closest('.hospital-item').dataset.hospital
    );
}

// 즐겨찾기만 표시
function showFavoritesOnly() {
    const hospitalItems = document.querySelectorAll('.hospital-item');

    hospitalItems.forEach(item => {
        const heartIcon = item.querySelector('.hospital-heart i');
        if (heartIcon.classList.contains('fas')) {
            item.style.display = 'flex';
        } else {
            item.style.display = 'none';
        }
    });

    updateTotalCount();
    console.log('즐겨찾기만 표시');
}

// 하트 상태를 localStorage에 저장
function saveHeartState(hospitalName, isActive) {
    try {
        const heartStates = JSON.parse(localStorage.getItem('hospitalHeartStates') || '{}');
        heartStates[hospitalName] = isActive;
        localStorage.setItem('hospitalHeartStates', JSON.stringify(heartStates));
        console.log('하트 상태 저장:', hospitalName, isActive);
    } catch (error) {
        console.error('하트 상태 저장 중 오류:', error);
    }
}

// 하트 상태를 localStorage에서 복원
function restoreHeartStates() {
    try {
        const heartStates = JSON.parse(localStorage.getItem('hospitalHeartStates') || '{}');
        const hospitalItems = document.querySelectorAll('.hospital-item');

        hospitalItems.forEach(item => {
            const hospitalName = item.dataset.hospital;
            const heartIcon = item.querySelector('.hospital-heart i');

            if (heartStates[hospitalName] && heartIcon) {
                // 저장된 상태가 true이면 채워진 하트로 설정
                heartIcon.classList.remove('far');
                heartIcon.classList.add('fas');
                heartIcon.style.color = '#ff4757';
                console.log('하트 상태 복원:', hospitalName, '활성화');
            } else if (heartIcon) {
                // 저장된 상태가 false이거나 없으면 빈 하트로 설정
                heartIcon.classList.remove('fas');
                heartIcon.classList.add('far');
                heartIcon.style.color = '#ccc';
            }
        });

        console.log('하트 상태 복원 완료');
    } catch (error) {
        console.error('하트 상태 복원 중 오류:', error);
    }
}