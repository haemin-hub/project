
// 값 공백/placeholder 검사
function isBlank(v) {
  return !v || /^\s*$/.test(v);
}

// 홈페이지를 안전하게 HTML로 렌더 (없으면 링크 없이 텍스트만)
function websiteToHtml(raw) {
  const text = (raw || '').trim();

  // 비어있거나 placeholder면 링크 만들지 않음
  if (isBlank(text) || text === '-' || text === '홈페이지 정보 없음') {
    return '홈페이지 정보 없음';
  }

  // 스킴 없으면 https 붙이기
  let url = text;
  if (!/^https?:\/\//i.test(url)) {
    url = 'https://' + url;
  }

  // URL 유효성 최종 체크 실패 시에도 링크 금지
  try {
    new URL(url);
  } catch {
    return '홈페이지 정보 없음';
  }

  // 정상일 때만 앵커로 렌더
  return `<a href="${url}" target="_blank" rel="noopener">${text}</a>`;
}


// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
   console.log('병원 목록 페이지 로드 완료');

   bindHospitalItemEvents();   // ✅ 여기서 호출
   bindPagination();           // ✅ AJAX 페이징 바인딩
   // updateTotalCount();
   restoreHeartStates();

   const detailContent = document.querySelector('.detail-content');
   const detailPlaceholder = document.querySelector('.detail-placeholder');
   if (detailContent) detailContent.style.display = 'none';
   if (detailPlaceholder) detailPlaceholder.style.display = 'block';
 });

function bindHospitalItemEvents() {
  const list = document.querySelector('.hospital-list');
  if (!list || list.dataset.bound === '1') return; // 중복 바인딩 방지
  list.dataset.bound = '1';

  list.addEventListener('click', function(e) {
    const item = e.target.closest('.hospital-item');
    if (!item) return;

    const heart = e.target.closest('.hospital-heart');
    if (heart) {
      e.preventDefault();
      e.stopPropagation();
      toggleHeart(item);
      return;
    }

    // 아이템 클릭 → 선택/상세 열기
    selectHospital(item);
    if (item.classList.contains('active')) {
      showHospitalDetail(item);

      // 클릭 로그 전송 코드 추가
      const companyId = item.dataset.companyId;  // dataset에 companyId가 있어야 함
      if (companyId) {
        fetch(`/api/clicks/${companyId}`, { method: "POST" })
          .then(response => {
            if (!response.ok) throw new Error("클릭 로그 저장 실패");
            console.log(`회사 ID ${companyId} 클릭 로그 저장 완료`);
          })
          .catch(error => {
            console.error("에러 발생:", error);
          });
      }
    }
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

    // 지도 초기화 (Google Maps API가 로드된 경우)
    const initializeMapWhenReady = () => {
        const mapElement = detailContent.querySelector('#map');
        if (mapElement) {
            const hospitalData = getHospitalData(hospitalName);
            console.log('지도 초기화 시작 - 병원:', hospitalName, '주소:', hospitalData.address);
            
            // Google Maps API가 로드되었는지 확인
            if (typeof google !== 'undefined' && google.maps) {
                // map.js의 initializeMap 함수 사용
                initializeMap(mapElement, hospitalName, hospitalData.address);
            } else {
                // API가 아직 로드되지 않았으면 다시 시도
                setTimeout(initializeMapWhenReady, 100);
            }
        } else {
            console.error('지도 요소를 찾을 수 없습니다.');
        }
    };
    
    // DOM 업데이트 후 지도 초기화 시작 (약간의 지연 추가)
    setTimeout(initializeMapWhenReady, 100);

    console.log('상세 정보 표시:', hospitalName);
}
function generateHospitalDetailHTML(hospitalName) {
  const data = getHospitalData(hospitalName);

  const websiteHtml = websiteToHtml(data.website);
  const phone   = (!isBlank(data.phone) && data.phone !== '전화번호 정보 없음')
                  ? data.phone : '연락처 정보 없음';
  const address = !isBlank(data.address) ? data.address : '주소 정보 없음';

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
            <td class="hospital_website">${websiteHtml}</td>
          </tr>
          <tr>
            <th>연락처</th>
            <td class="hospital_phonenumber">${phone}</td>
          </tr>
          <tr>
            <th>위치 및 교통정보</th>
            <td class="hospital_address">${address}</td>
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



// 병원 데이터 가져오기 (DB에서 실제 데이터 사용)
function getHospitalData(hospitalName) {
    // 현재 페이지의 병원 목록에서 해당 병원 찾기
    const hospitalItems = document.querySelectorAll('.hospital-item');
    
    for (let item of hospitalItems) {
        if (item.dataset.hospital === hospitalName) {
            // DB에서 가져온 실제 데이터 사용
            const address = item.dataset.address || '주소 정보 없음';
            const phone = item.dataset.phone || '전화번호 정보 없음';
            const homepage = item.dataset.homepage || '홈페이지 정보 없음';
            const region = item.dataset.region || '';
            const subregion = item.dataset.subregion || '';
            
            // 지하철 정보는 기본값 사용 (DB에 지하철 정보가 없으므로)
            const subway = '지하철 정보 없음';
            
            return {
                website: homepage,
                phone: phone,
                address: address,
                subway: subway,
                region: region,
                subregion: subregion
            };
        }
    }
    
    // 병원을 찾지 못한 경우 기본값 반환
    return {
        website: '-',
        phone: '-',
        address: '주소 정보 없음',
        subway: '지하철 정보 없음',
        region: '',
        subregion: ''
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

// ✅ 더 이상 클라이언트에서 총 건수 계산/덮어쓰기 하지 않음
function updateTotalCount(){}

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

// ---- AJAX Pagination ----

// 초기 바인딩 (DOMContentLoaded 끝에 호출)
function bindPagination() {
  const pager = document.querySelector('.pagination');
  if (!pager || pager.dataset.bound === '1') return;
  pager.dataset.bound = '1';

  pager.addEventListener('click', function (e) {
    const a = e.target.closest('a.page-link');
    if (!a) return;
    e.preventDefault();
    ajaxNavigate(a.href);
  });
}

// 히스토리 뒤로/앞으로도 AJAX로 복원
window.addEventListener('popstate', () => {
  ajaxNavigate(location.href, { push: false });
});

// 공통: 서버에서 받은 HTML에서 필요한 부분만 교체
function replaceSection(doc, selector) {
  const newEl = doc.querySelector(selector);
  const curEl = document.querySelector(selector);
  if (newEl && curEl) {
    curEl.innerHTML = newEl.innerHTML;
  }
}

// 핵심: 링크를 AJAX로 로드해서 부분 교체 + URL 갱신
async function ajaxNavigate(url, { push = true } = {}) {
  try {
    // 로딩 상태(선택): 리스트 살짝 투명하게
    const listWrap = document.querySelector('.hospital-list');
    if (listWrap) listWrap.style.opacity = '0.5';

    const res = await fetch(url, {
      headers: { 'X-Requested-With': 'XMLHttpRequest' }
    });
    if (!res.ok) throw new Error('HTTP ' + res.status);

    const html = await res.text();
    const doc = new DOMParser().parseFromString(html, 'text/html');

    // 필요한 영역만 갈아끼우기
    replaceSection(doc, '.hospital-list');
    replaceSection(doc, '.pagination');
    replaceSection(doc, '.total-count');

    // 교체 후 필요한 이벤트 다시 바인딩
    bindHospitalItemEvents();  // 병원 아이템/하트 클릭 등
    // pagination 컨테이너는 같은 노드이면 이벤트 위임 유지됨
    // 만약 .pagination 자체를 통으로 교체한다면 아래 한 줄을 다시 호출:
    bindPagination();

    // URL만 바꾸고 페이지는 그대로 유지
    if (push) history.pushState({ url }, '', url);

    // 부드럽게 리스트 상단으로 스크롤
    const leftPanel = document.querySelector('.left-panel');
    if (leftPanel) {
      leftPanel.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

  } catch (err) {
    console.error('AJAX 페이지 네비게이션 실패, 폴백으로 이동합니다.', err);
    // 문제가 생기면 그냥 원래 방식으로 이동
    window.location.href = url;
  } finally {
    const listWrap = document.querySelector('.hospital-list');
    if (listWrap) listWrap.style.opacity = '';
  }
}
