// 즐겨찾기 관리
let favorites = [];

// localStorage에서 favoriteHospitals 데이터 가져오기
function loadFavoriteHospitals() {
    try {
        const favoriteHospitalNames = JSON.parse(localStorage.getItem('favoriteHospitals') || '[]');
        console.log('localStorage에서 읽은 favoriteHospitals:', favoriteHospitalNames);
        
        const hospitalData = getHospitalData();
        
        favorites = favoriteHospitalNames.map(name => {
            const data = hospitalData[name];
            if (data) {
                return {
                    id: name,
                    name: name,
                    address: data.address,
                    phone: data.phone,
                    hours: '운영시간 정보 없음',
                    image: '/resources/images/detail/hospital.jpg',
                    tags: ['병원']
                };
            }
            return null;
        }).filter(item => item !== null);
        
        console.log('즐겨찾기 병원 로드 완료:', favorites);
    } catch (error) {
        console.error('즐겨찾기 병원 로드 중 오류:', error);
        favorites = [];
    }
}

// 병원 데이터 가져오기 (list.js와 동일한 데이터)
function getHospitalData() {
    return {
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
}

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    console.log('즐겨찾기 페이지 로드 완료');
    loadFavoriteHospitals(); // 먼저 favoriteHospitals 데이터 로드
    loadFavorites();
    setupModal();
});

// 즐겨찾기 목록 로드
function loadFavorites() {
    const favoriteList = document.querySelector('.favorite-list');
    if (!favoriteList) {
        console.log('favorite-list 요소를 찾을 수 없습니다.');
        return;
    }

    console.log('loadFavorites 실행 - favorites 배열:', favorites);

    // 기존 항목들 제거
    favoriteList.innerHTML = '';

    if (favorites.length === 0) {
        console.log('즐겨찾기 목록이 비어있습니다. 빈 상태 메시지를 표시합니다.');
        favoriteList.innerHTML = `
            <div class="empty-favorites">
                <i class="fas fa-heart-broken"></i>
                <h3>즐겨찾기한 병원이 없습니다</h3>
                <p>병원을 검색하고 즐겨찾기에 추가해보세요!</p>
                <button onclick="goToMain()" class="btn-go-main">메인으로 가기</button>
            </div>
        `;
        return;
    }

    console.log('즐겨찾기 항목들을 생성합니다. 개수:', favorites.length);

    // 즐겨찾기 항목들 생성
    favorites.forEach((favorite, index) => {
        console.log(`항목 ${index + 1} 생성:`, favorite);
        const favoriteItem = createFavoriteItem(favorite, index + 1);
        favoriteList.appendChild(favoriteItem);
    });
}

// 즐겨찾기 항목 생성
function createFavoriteItem(favorite, number) {
    const item = document.createElement('div');
    item.className = 'favorite-item';
    item.setAttribute('data-id', favorite.id);

    item.innerHTML = `
        <div class="item-banner">
            <span class="day-number">${number}</span>
        </div>
        <div class="item-content">
            <div class="item-info">
                <h3 class="hospital-name">${favorite.name}</h3>
                <div class="hospital-details">
                    <p class="hospital-address"><i class="fas fa-map-marker-alt"></i> ${favorite.address}</p>
                    <p class="hospital-phone"><i class="fas fa-phone"></i> ${favorite.phone}</p>
                    <p class="hospital-hours"><i class="fas fa-clock"></i> ${favorite.hours}</p>
                </div>
                <div class="hospital-tags">
                    ${favorite.tags.map(tag => `<span class="tag">${tag}</span>`).join('')}
                </div>
            </div>
            <div class="item-image">
                <img src="${favorite.image}" alt="${favorite.name}">
            </div>
        </div>
        <div class="item-actions">
            <button class="btn-detail" onclick="showDetail('${favorite.id}')">상세보기</button>
            <button class="btn-remove" onclick="removeFavorite('${favorite.id}')">
                <i class="fas fa-trash"></i>
            </button>
        </div>
    `;

    return item;
}

// 상세보기 모달 설정
function setupModal() {
    const modal = document.getElementById('detailModal');
    const closeBtn = document.querySelector('.close');

    if (closeBtn) {
        closeBtn.onclick = function() {
            modal.style.display = 'none';
        }
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function(event) {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    }
}

// 상세보기 표시 - 해당 병원이 있는 list 페이지로 이동
function showDetail(id) {
    const favorite = favorites.find(f => f.id === id);
    if (!favorite) return;

    console.log('상세보기 클릭 - 병원:', favorite.name);
    
    // 병원 이름에 따라 적절한 list 페이지로 이동
    const hospitalName = favorite.name;
    
    // 병원 카테고리별 페이지 매핑
    const categoryMapping = {
        '더고운성형외과의원': '/plastic_list',
        '더뷰티성형외과의원': '/plastic_list', 
        '더바디성형외과의원': '/plastic_list',
        '픽셀랩성형외과의원': '/plastic_list',
        'JY피부과의원': '/skin_list',
        '부산치과의원': '/dental_list'
    };
    
    const targetPage = categoryMapping[hospitalName];
    
    if (targetPage) {
        console.log(`${hospitalName}을(를) 찾기 위해 ${targetPage}로 이동합니다.`);
        window.location.href = targetPage;
    } else {
        console.log(`${hospitalName}에 대한 매핑이 없습니다. 메인 페이지로 이동합니다.`);
        window.location.href = '/main';
    }
}

// 즐겨찾기 제거
function removeFavorite(id) {
    if (confirm('정말로 즐겨찾기에서 제거하시겠습니까?')) {
        // favorites 배열에서 제거
        favorites = favorites.filter(f => f.id !== id);
        
        // favoriteHospitals localStorage에서도 제거
        try {
            const favoriteHospitalNames = JSON.parse(localStorage.getItem('favoriteHospitals') || '[]');
            const updatedFavorites = favoriteHospitalNames.filter(name => name !== id);
            localStorage.setItem('favoriteHospitals', JSON.stringify(updatedFavorites));
            console.log('favoriteHospitals에서 제거:', id);
        } catch (error) {
            console.error('favoriteHospitals 제거 중 오류:', error);
        }
        
        // 즉시 화면에서 제거
        const item = document.querySelector(`[data-id="${id}"]`);
        if (item) {
            item.remove();
        }
        
        // 목록이 비어있으면 빈 상태 메시지 표시
        if (favorites.length === 0) {
            const favoriteList = document.querySelector('.favorite-list');
            if (favoriteList) {
                favoriteList.innerHTML = `
                    <div class="empty-favorites">
                        <i class="fas fa-heart-broken"></i>
                        <h3>즐겨찾기한 병원이 없습니다</h3>
                        <p>병원을 검색하고 즐겨찾기에 추가해보세요!</p>
                        <button onclick="goToMain()" class="btn-go-main">메인으로 가기</button>
                    </div>
                `;
            }
        }
        
        console.log('즐겨찾기에서 제거 완료:', id);
    }
}

// 전화하기
function callHospital(phone) {
    window.location.href = `tel:${phone}`;
}

// 지도보기
function openMap(address) {
    const encodedAddress = encodeURIComponent(address);
    window.open(`https://map.kakao.com/link/search/${encodedAddress}`, '_blank');
}

// 메인 페이지로 이동
function goToMain() {
    window.location.href = '/main';
}

// 즐겨찾기 추가 (다른 페이지에서 호출)
function addToFavorites(hospitalData) {
    const existingIndex = favorites.findIndex(f => f.id === hospitalData.id);
    
    if (existingIndex !== -1) {
        alert('이미 즐겨찾기에 추가된 병원입니다.');
        return;
    }

    favorites.push(hospitalData);
    localStorage.setItem('favorites', JSON.stringify(favorites));
    alert('즐겨찾기에 추가되었습니다!');
}

// 즐겨찾기 확인
function isFavorite(id) {
    return favorites.some(f => f.id === id);
}

// 즐겨찾기 토글
function toggleFavorite(hospitalData) {
    const existingIndex = favorites.findIndex(f => f.id === hospitalData.id);
    
    if (existingIndex !== -1) {
        favorites.splice(existingIndex, 1);
        alert('즐겨찾기에서 제거되었습니다.');
    } else {
        favorites.push(hospitalData);
        alert('즐겨찾기에 추가되었습니다!');
    }
    
    localStorage.setItem('favorites', JSON.stringify(favorites));
    return existingIndex === -1; // 추가되면 true, 제거되면 false
}

// CSS 애니메이션 추가
const style = document.createElement('style');
style.textContent = `
    @keyframes fadeOut {
        from {
            opacity: 1;
            transform: translateY(0);
        }
        to {
            opacity: 0;
            transform: translateY(-20px);
        }
    }
    
    .favorite-list {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
        padding: 20px;
        max-width: 1200px;
        margin: 0 auto;
    }
    
    .favorite-list:has(.favorite-item:only-child) {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 400px;
    }
    
    .favorite-list:has(.favorite-item:only-child) .favorite-item {
        max-width: 500px;
        width: 100%;
    }
    
    .favorite-item {
        background: white;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        height: fit-content;
    }
    
    .favorite-item:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
    }
    
    .empty-favorites {
        text-align: center;
        padding: 60px 20px;
        color: #666;
        grid-column: 1 / -1;
    }
    
    .empty-favorites i {
        font-size: 48px;
        color: #ccc;
        margin-bottom: 20px;
    }
    
    .empty-favorites h3 {
        margin: 0 0 10px 0;
        color: #333;
    }
    
    .empty-favorites p {
        margin: 0 0 30px 0;
        color: #666;
    }
    
    .btn-go-main {
        background: #005a66;
        color: white;
        border: none;
        padding: 12px 24px;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 500;
        transition: background-color 0.3s ease;
    }
    
    .btn-go-main:hover {
        background: #004850;
    }
    
    .detail-content h2 {
        color: #333;
        margin-bottom: 20px;
    }
    
    .detail-info p {
        margin: 10px 0;
        color: #666;
    }
    
    .detail-actions {
        display: flex;
        gap: 10px;
        margin-top: 20px;
    }
    
    .btn-call, .btn-map {
        background: #005a66;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 500;
        transition: background-color 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .btn-call:hover, .btn-map:hover {
        background: #004850;
    }
    
    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .favorite-list {
            grid-template-columns: 1fr;
            padding: 15px;
        }
        
        .favorite-list:has(.favorite-item:only-child) .favorite-item {
            max-width: 100%;
        }
    }
`;
document.head.appendChild(style);
