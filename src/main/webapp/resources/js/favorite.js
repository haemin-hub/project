// 즐겨찾기 관리
let favorites = JSON.parse(localStorage.getItem('favorites')) || [];

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    console.log('즐겨찾기 페이지 로드 완료');
    loadFavorites();
    setupModal();
});

// 즐겨찾기 목록 로드
function loadFavorites() {
    const favoriteList = document.querySelector('.favorite-list');
    if (!favoriteList) return;

    // 기존 항목들 제거
    favoriteList.innerHTML = '';

    if (favorites.length === 0) {
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

    // 즐겨찾기 항목들 생성
    favorites.forEach((favorite, index) => {
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
            <button class="btn-detail" onclick="showDetail(${favorite.id})">상세보기</button>
            <button class="btn-remove" onclick="removeFavorite(${favorite.id})">
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

// 상세보기 표시
function showDetail(id) {
    const favorite = favorites.find(f => f.id === id);
    if (!favorite) return;

    const modal = document.getElementById('detailModal');
    const modalBody = document.getElementById('modalBody');

    modalBody.innerHTML = `
        <div class="detail-content">
            <h2>${favorite.name}</h2>
            <div class="detail-info">
                <p><strong>주소:</strong> ${favorite.address}</p>
                <p><strong>전화번호:</strong> ${favorite.phone}</p>
                <p><strong>운영시간:</strong> ${favorite.hours}</p>
                <p><strong>전문분야:</strong> ${favorite.tags.join(', ')}</p>
            </div>
            <div class="detail-actions">
                <button onclick="callHospital('${favorite.phone}')" class="btn-call">
                    <i class="fas fa-phone"></i> 전화하기
                </button>
                <button onclick="openMap('${favorite.address}')" class="btn-map">
                    <i class="fas fa-map-marker-alt"></i> 지도보기
                </button>
            </div>
        </div>
    `;

    modal.style.display = 'block';
}

// 즐겨찾기 제거
function removeFavorite(id) {
    if (confirm('정말로 즐겨찾기에서 제거하시겠습니까?')) {
        favorites = favorites.filter(f => f.id !== id);
        localStorage.setItem('favorites', JSON.stringify(favorites));
        loadFavorites();
        
        // 제거 애니메이션
        const item = document.querySelector(`[data-id="${id}"]`);
        if (item) {
            item.style.animation = 'fadeOut 0.3s ease';
            setTimeout(() => {
                item.remove();
            }, 300);
        }
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
    
    .empty-favorites {
        text-align: center;
        padding: 60px 20px;
        color: #666;
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
`;
document.head.appendChild(style);
