// 글작성 토글
document.addEventListener('click', function (e) {
  const btn = e.target.closest('.write-btn');
  if (!btn) return;

  const row = btn.closest('.community-row');
  const insert = row?.nextElementSibling; // .community-insert

  if (insert && insert.classList.contains('community-insert')) {
    insert.classList.toggle('is-open');
    btn.setAttribute('aria-expanded', insert.classList.contains('is-open'));
  }
});

// 입력 버튼
document.addEventListener('click', function (e) {
  const insertBtn = e.target.closest('.insert-btn');
  if (!insertBtn) return;

  const titleValue = document.querySelector('.insert-title').value.trim();
  const contentValue = document.querySelector('.insert-content').value.trim();

  // 비었을 때 안내 모달
  if (!titleValue || !contentValue) {
    const modalHTML = `
      <div id="insertAlertModal" class="insert-confirm-modal">
        <div class="insert-confirm-content">
          <h3>제목과 내용을 입력하세요</h3>
          <div class="insert-confirm-buttons">
            <button class="insert-confirm-ok">확인</button>
          </div>
        </div>
      </div>`;
    document.querySelector('#insertAlertModal')?.remove();
    document.body.insertAdjacentHTML('beforeend', modalHTML);
    document.querySelector('.insert-confirm-ok')
      .addEventListener('click', () => document.querySelector('#insertAlertModal').remove());
    return;
  }

  // 입력완료 모달
  const modalHTML = `
    <div id="insertConfirmModal" class="insert-confirm-modal">
      <div class="insert-confirm-content">
        <h3>입력완료</h3>
        <div class="insert-confirm-buttons">
          <button class="insert-confirm-ok">확인</button>
        </div>
      </div>
    </div>`;
  document.querySelector('#insertConfirmModal')?.remove();
  document.body.insertAdjacentHTML('beforeend', modalHTML);

  document.querySelector('.insert-confirm-ok').addEventListener('click', () => {
    document.querySelector('#insertConfirmModal').remove();

    // 표시 영역 채우고 보이기
    const showBox = document.querySelector('.community-show');
    showBox.querySelector('.show-title').textContent = titleValue;
    showBox.querySelector('.show-content').textContent = contentValue;
    showBox.classList.add('is-open');     // CSS에서 .community-show.is-open { display:flex; }
  });
});

// 삭제 버튼 (이벤트 위임)
document.addEventListener('click', function (e) {
  const deleteBtn = e.target.closest('.show-delete');
  if (!deleteBtn) return; // show-delete가 아니면 무시

  // 모달 HTML
  const html = `
    <div id="deleteConfirmModal" class="delete-confirm-modal">
      <div class="delete-confirm-content">
        <h3>정말 삭제하시겠습니까?</h3>
        <div class="delete-confirm-buttons">
          <button class="delete-confirm-ok">확인</button>
          <button class="delete-confirm-cancel">취소</button>
        </div>
      </div>
    </div>
  `;

  // 기존 모달 제거 후 추가
  document.querySelector('#deleteConfirmModal')?.remove();
  document.body.insertAdjacentHTML('beforeend', html);

  // 요소 참조
  const modal = document.querySelector('#deleteConfirmModal');
  const okBtn = modal.querySelector('.delete-confirm-ok');
  const cancelBtn = modal.querySelector('.delete-confirm-cancel');

  // 확인: 실제 삭제 로직
  okBtn.addEventListener('click', () => {
    // 이 버튼이 속한 카드(박스) 기준으로 삭제할 경우:
    const showBox = deleteBtn.closest('.community-show');
    if (showBox) {
      showBox.querySelector('.show-title').textContent = '';
      showBox.querySelector('.show-content').textContent = '';
      showBox.classList.remove('is-open');   // CSS로 숨기는 방식
      // showBox.style.display = 'none';     // 인라인으로 숨기려면 이 방식
    }
    modal.remove();
  });

  // 취소: 모달 닫기
  cancelBtn.addEventListener('click', () => modal.remove());

  // (선택) 배경 클릭 시 닫기
  modal.addEventListener('click', (ev) => {
    if (ev.target === modal) modal.remove();
  });
});

document.addEventListener('click', function(e) {
  const insertBtn = e.target.closest('.insert-btn');
  if (!insertBtn) return;

  const title = document.querySelector('.insert-title').value.trim();
  const content = document.querySelector('.insert-content').value.trim();

  if (!title || !content) {
    alert("제목과 내용을 입력하세요.");
    return;
  }

  // ✅ DB 저장 (AJAX 요청)
  fetch('/community/insert', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({ title, content })
  })
  .then(res => res.text())
  .then(data => {
    if (data === 'success') {
      alert("입력 완료!");

      // 입력창 비우기
      document.querySelector('.insert-title').value = '';
      document.querySelector('.insert-content').value = '';

      // 새 글 목록 불러오기 (선택)
      location.reload();
    }
  });
});

