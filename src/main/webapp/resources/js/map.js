// 전역 변수
let map = null;
let currentMarker = null;
let globalInfoWindow = null; // 모든 마커에서 재사용

// 사진 갤러리 HTML 생성 유틸
function buildPhotoGallery(photos = [], max = 3, size = { maxWidth: 380, maxHeight: 260 }) {
  if (!photos || photos.length === 0) return '<div style="color:#888">사진 없음</div>';
  const imgs = photos
    .slice(0, max)
    .map((p) => {
      const url = p.getUrl(size);
      return `<img src="${url}" style="width:100%;height:auto;border-radius:8px;margin:6px 0" loading="lazy" />`;
    })
    .join("");

  // 저작권/출처 표기 (가능하면)
  const attributions = photos[0].html_attributions?.join(" • ") || "";
  const attrHtml = attributions
    ? `<div style="font-size:11px;color:#999;margin-top:4px">${attributions}</div>`
    : "";

  return `${imgs}${attrHtml}`;
}

// 패널(photo-gallery)에 사진 HTML 주입
function renderPhotoGalleryToPanel(html, root = document) {
  try {
    const box = (root && root.querySelector)
      ? root.querySelector('#photo-gallery')
      : document.querySelector('#photo-gallery');
    if (box) box.innerHTML = html;
  } catch (e) {
    console.warn('photo-gallery 주입 실패:', e);
  }
}

// ───────────────────────────────────────────
// 1) 기본 지도: 근처 검색 결과에 사진 붙이기 (예: 레스토랑)
// ───────────────────────────────────────────
function initMap() {
  const mapElement = document.getElementById("map");
  if (!mapElement) {
    console.log("지도 요소가 없습니다. 병원을 선택해주세요.");
    return;
  }

  map = new google.maps.Map(mapElement, {
    zoom: 15,
    center: { lat: 37.5665, lng: 126.9780 }, // 서울
  });

  globalInfoWindow = new google.maps.InfoWindow();
  const service = new google.maps.places.PlacesService(map);

  // 근처 장소 검색 (레스토랑 예시)
  service.nearbySearch(
    {
      location: { lat: 37.5665, lng: 126.9780 },
      radius: 1000,
      type: "restaurant",
    },
    (results, status) => {
      if (status !== google.maps.places.PlacesServiceStatus.OK || !results) {
        console.error("Places request failed:", status);
        return;
      }

      results.forEach((place) => {
        const marker = new google.maps.Marker({
          position: place.geometry.location,
          map: map,
          title: place.name,
        });

        // NearbySearch 결과에도 photos가 들어올 수 있음 → 바로 썸네일 사용
        const photoHtml = buildPhotoGallery(place.photos, 1);

        const content = `
          <div style="max-width:400px">
            <div style="font-weight:600;margin-bottom:4px">${place.name}</div>
            <div style="color:#666;font-size:12px;margin-bottom:8px">${place.vicinity ?? ""}</div>
            ${photoHtml}
          </div>
        `;

        marker.addListener("click", () => {
          globalInfoWindow.setContent(content);
          globalInfoWindow.open(map, marker);
        });
      });
    }
  );
}

// ───────────────────────────────────────────
// 2) 병원 상세 지도: 주소 → 좌표 + placeId → 사진 포함 InfoWindow & 패널
// ───────────────────────────────────────────
function initializeMap(mapElement, hospitalName, address) {
  if (!mapElement) {
    console.error('지도 요소를 찾을 수 없습니다.');
    return;
  }

  // 기존 마커 제거
  if (currentMarker) currentMarker.setMap(null);

  // 지도 새로 생성
  map = new google.maps.Map(mapElement, {
    zoom: 15,
    center: { lat: 37.5665, lng: 126.9780 },
  });

  if (!globalInfoWindow) globalInfoWindow = new google.maps.InfoWindow();
  const geocoder = new google.maps.Geocoder();
  const placesService = new google.maps.places.PlacesService(map);

  // 주소 유효성 확인
  if (!address || address === '주소 정보 없음' || address === '-') {
    console.error('유효하지 않은 주소입니다:', address);
    const defaultLocation = { lat: 37.5665, lng: 126.9780 };
    map.setCenter(defaultLocation);
    currentMarker = new google.maps.Marker({ position: defaultLocation, map, title: hospitalName });
    globalInfoWindow.setContent(`<div><strong>${hospitalName}</strong><br/><div style="color:#888">주소 정보 없음</div></div>`);
    globalInfoWindow.open(map, currentMarker);
    // 패널도 비워두기
    renderPhotoGalleryToPanel('<div style="color:#888">사진 없음</div>', mapElement.closest('.detail-content') || document);
    return;
  }

  // 2-1) 우선 지오코딩으로 위치 지정
  geocoder.geocode({ address }, (geoResults, geoStatus) => {
    if (geoStatus !== 'OK' || !geoResults?.length) {
      console.error('주소를 좌표로 변환할 수 없습니다:', geoStatus, '주소:', address);
      const defaultLocation = { lat: 37.5665, lng: 126.9780 };
      map.setCenter(defaultLocation);
      currentMarker = new google.maps.Marker({ position: defaultLocation, map, title: hospitalName });
      globalInfoWindow.setContent(`<div><strong>${hospitalName}</strong><br/><div style="color:#888">지오코딩 실패</div></div>`);
      globalInfoWindow.open(map, currentMarker);
      renderPhotoGalleryToPanel('<div style="color:#888">사진 없음</div>', mapElement.closest('.detail-content') || document);
      return;
    }

    const location = geoResults[0].geometry.location;
    map.setCenter(location);

    // 2-2) 마커 먼저 표시
    currentMarker = new google.maps.Marker({
      position: location,
      map,
      title: hospitalName,
      icon: {
        url: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png',
        scaledSize: new google.maps.Size(32, 32),
      },
    });

    // 2-3) 병원 이름 + 주소로 placeId 찾기 (정확도 향상을 위해 findPlaceFromQuery)
    const query = `${hospitalName} ${address}`;
    placesService.findPlaceFromQuery(
      {
        query,
        fields: ["place_id", "name", "formatted_address", "geometry", "photos"],
        locationBias: { radius: 2000, center: location }, // 근방에서 우선 검색
      },
      (findResults, findStatus) => {
        // 기본 InfoWindow(사진 없음) 준비
        let baseContent = `
          <div style="max-width:420px">
            <div style="font-weight:600;margin-bottom:6px">${hospitalName}</div>
            <div style="color:#666;font-size:12px;margin-bottom:6px">${address}</div>
          </div>
        `;

        // findPlace 실패 시 기본 정보만 열고 종료
        if (findStatus !== google.maps.places.PlacesServiceStatus.OK || !findResults?.length) {
          globalInfoWindow.setContent(baseContent + `<div style="color:#888">장소 검색 결과 없음</div>`);
          globalInfoWindow.open(map, currentMarker);
          renderPhotoGalleryToPanel('<div style="color:#888">사진 없음</div>', mapElement.closest('.detail-content') || document);
          return;
        }

        // findPlace 결과에 이미 photos가 있으면 바로 사용
        const found = findResults[0];
        let photoSection = "";
        if (found.photos?.length) {
          photoSection = buildPhotoGallery(found.photos, 3);
          globalInfoWindow.setContent(baseContent + photoSection);
          globalInfoWindow.open(map, currentMarker);
          // 패널에도 주입
          renderPhotoGalleryToPanel(photoSection, mapElement.closest('.detail-content') || document);
          return;
        }

        // 2-4) 더 풍부한 사진을 위해 getDetails 호출 (placeId 기반)
        if (!found.place_id) {
          globalInfoWindow.setContent(baseContent + `<div style="color:#888">placeId 없음</div>`);
          globalInfoWindow.open(map, currentMarker);
          renderPhotoGalleryToPanel('<div style="color:#888">사진 없음</div>', mapElement.closest('.detail-content') || document);
          return;
        }

        placesService.getDetails(
          {
            placeId: found.place_id,
            fields: ["name", "formatted_address", "photos", "url", "website"],
          },
          (place, detailsStatus) => {
            if (detailsStatus !== google.maps.places.PlacesServiceStatus.OK || !place) {
              globalInfoWindow.setContent(baseContent + `<div style="color:#888">상세정보 없음</div>`);
              globalInfoWindow.open(map, currentMarker);
              renderPhotoGalleryToPanel('<div style="color:#888">사진 없음</div>', mapElement.closest('.detail-content') || document);
              return;
            }

            const gallery = buildPhotoGallery(place.photos, 3);
            const links = `
              <div style="margin-top:6px;font-size:12px">
                ${place.website ? `<a href="${place.website}" target="_blank" rel="noopener">웹사이트</a> · ` : ""}
                ${place.url ? `<a href="${place.url}" target="_blank" rel="noopener">지도에서 열기</a>` : ""}
              </div>
            `;

            globalInfoWindow.setContent(`
              <div style="max-width:420px">
                <div style="font-weight:600;margin-bottom:6px">${place.name || hospitalName}</div>
                <div style="color:#666;font-size:12px;margin-bottom:8px">${place.formatted_address || address}</div>
                ${gallery}
                ${links}
              </div>
            `);
            globalInfoWindow.open(map, currentMarker);

            // 패널에도 동일 갤러리 주입
            renderPhotoGalleryToPanel(gallery, mapElement.closest('.detail-content') || document);
          }
        );
      }
    );

    // 마커 클릭 시 현재 정보창 다시 열기
    currentMarker.addListener('click', () => {
      globalInfoWindow.open(map, currentMarker);
    });

    console.log('지도 초기화 완료:', hospitalName, '실제 주소:', address);
  });
}

// ==============================
// (참고)
// HTML에선 Google Maps JS를 다음처럼 로드:
// <script async src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY&libraries=places&callback=initMap"></script>
// 상세 패널 HTML에는 고정 이미지 대신 다음 컨테이너가 있어야 합니다:
// <div id="photo-gallery" class="photo-gallery">사진 로딩 중…</div>
// ==============================