<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><spring:message code="location.title"/></title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 공통 스타일시트 -->
    <link rel="stylesheet" href="/resources/css/styles.css">
    <!-- Font Awesome 5 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        :root { 
            --border: #e5e7eb; 
            --muted: #6b7280; 
            --text: #111827; 
            --bg: #ffffff; 
            --bg2: #f9fafb; 
            --black: #000; 
        }
        
        * { box-sizing: border-box; }
        
        body {
            margin: 0;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, Helvetica, Arial, "Apple SD Gothic Neo", "Noto Sans KR", "맑은 고딕", sans-serif;
            color: var(--text);
            background: var(--bg2);
        }
        
        /* 헤더와의 간격 조정 */
        .location-content {
            margin-top: 80px; /* 헤더 높이만큼 여백 추가 */
        }
        
        .container {
            max-width: 1120px;
            margin: 0 auto;
            padding: 16px;
        }
        
        .row {
            display: grid;
            gap: 12px;
        }
        
        @media (min-width: 900px) {
            .row {
                grid-template-columns: 240px 1fr;
            }
        }
        
        .card {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 12px;
        }
        
        .left {
            padding: 8px;
        }
        
        .right {
            padding: 12px;
        }
        
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 12px;
        }
        
        .title {
            font-size: 20px;
            font-weight: 600;
        }
        
        /* left nav */
        .sido {
            list-style: none;
            margin: 0;
            padding: 4px;
            max-height: 70vh;
            overflow: auto;
        }
        
        .sido li {
            border-radius: 8px;
        }
        
        .sido button {
            width: 100%;
            text-align: left;
            background: transparent;
            border: 0;
            cursor: pointer;
            padding: 10px 12px;
            border-radius: 8px;
            font-size: 14px;
            color: #374151;
        }
        
        .sido button:hover {
            background: #f3f4f6;
        }
        
        .sido .active {
            background: #a4d6a4cc !important;
            color: #fff !important;
            font-weight: 600;
        }
        
        /* right panel */
        .list {
            max-height: 64vh;
            overflow: auto;
            padding-right: 4px;
        }
        
        .item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 12px;
            border-bottom: 1px solid var(--border);
            font-size: 14px;
            cursor: pointer;
        }
        
        .item:last-child {
            border-bottom: 0;
        }
        
        .item:hover {
            background: #f3f4f6;
        }
        
        .item .arrow {
            color: #9ca3af;
            font-size: 12px;
        }
        
        .back-btn {
            background: #a4d6a4cc;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
            transition: background 0.3s ease;
        }
        
        .back-btn:hover {
            background: #005A66;
            color: white;
        }
    </style>
</head>
<body>
<%@include file = "/common/header.jsp"%>

<div class="location-content">
    <div class="container">
    <a href="/main" class="back-btn">
        <i class="fas fa-arrow-left"></i> <spring:message code="location.back.home"/>
    </a>
    
    <div class="row">
        <!-- 왼쪽: 시도 선택 -->
        <div class="card left">
            <ul class="sido" id="sidoList">
                <!-- JavaScript로 동적 생성 -->
            </ul>
        </div>
        
        <!-- 오른쪽: 세부 지역 선택 -->
        <div class="card right">
            <div class="header">
                <div class="title"><spring:message code="location.select.region"/></div>
                <i class="fas fa-chevron-up" id="scrollTop"></i>
            </div>
            
            <div class="list" id="distList">
                <!-- JavaScript로 동적 생성 -->
            </div>
        </div>
    </div>
    </div>
</div>


<%@include file = "/common/footer.jsp"%>

<!-- 부트스트랩 JS 및 의존성 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
(function() {
    // 지역 데이터
    const REGIONS = {
        'nation': {
            name: '<spring:message code="region.nation"/>',
            districts: ['<spring:message code="region.nation.nation"/>']
        },
        'seoul': {
            name: '<spring:message code="region.seoul"/>',
            districts: ['<spring:message code="region.seoul.gangnam"/>', '<spring:message code="region.seoul.gangbuk"/>', '<spring:message code="region.seoul.mapo"/>', '<spring:message code="region.seoul.yongsan"/>', '<spring:message code="region.seoul.seongdong"/>', '<spring:message code="region.seoul.dongdaemun"/>', '<spring:message code="region.seoul.jungnang"/>', '<spring:message code="region.seoul.seongbuk"/>', '<spring:message code="region.seoul.dobong"/>', '<spring:message code="region.seoul.nowon"/>', '<spring:message code="region.seoul.eunpyeong"/>', '<spring:message code="region.seoul.seodaemun"/>', '<spring:message code="region.seoul.seocho"/>', '<spring:message code="region.seoul.songpa"/>', '<spring:message code="region.seoul.gangdong"/>', '<spring:message code="region.seoul.gwangjin"/>', '<spring:message code="region.seoul.jung"/>', '<spring:message code="region.seoul.jongno"/>']
        },
        'gyeonggi': {
            name: '<spring:message code="region.gyeonggi"/>',
            districts: ['<spring:message code="region.gyeonggi.suwon"/>', '<spring:message code="region.gyeonggi.seongnam"/>', '<spring:message code="region.gyeonggi.anyang"/>', '<spring:message code="region.gyeonggi.bucheon"/>', '<spring:message code="region.gyeonggi.gwangmyeong"/>', '<spring:message code="region.gyeonggi.pyeongtaek"/>', '<spring:message code="region.gyeonggi.ansan"/>', '<spring:message code="region.gyeonggi.hwaseong"/>', '<spring:message code="region.gyeonggi.osan"/>', '<spring:message code="region.gyeonggi.yongin"/>', '<spring:message code="region.gyeonggi.ijeon"/>', '<spring:message code="region.gyeonggi.gunpo"/>', '<spring:message code="region.gyeonggi.uijeongbu"/>', '<spring:message code="region.gyeonggi.goyang"/>', '<spring:message code="region.gyeonggi.gimpo"/>', '<spring:message code="region.gyeonggi.paju"/>', '<spring:message code="region.gyeonggi.yangju"/>', '<spring:message code="region.gyeonggi.dongducheon"/>', '<spring:message code="region.gyeonggi.gapyeong"/>', '<spring:message code="region.gyeonggi.yangpyeong"/>', '<spring:message code="region.gyeonggi.yeoju"/>', '<spring:message code="region.gyeonggi.icheon"/>', '<spring:message code="region.gyeonggi.anseong"/>', '<spring:message code="region.gyeonggi.pocheon"/>', '<spring:message code="region.gyeonggi.yeoncheon"/>']
        },
        'incheon': {
            name: '<spring:message code="region.incheon"/>',
            districts: ['<spring:message code="region.incheon.jung"/>', '<spring:message code="region.incheon.dong"/>', '<spring:message code="region.incheon.michuhol"/>', '<spring:message code="region.incheon.yeonsu"/>', '<spring:message code="region.incheon.namdong"/>', '<spring:message code="region.incheon.bupyeong"/>', '<spring:message code="region.incheon.gyeyang"/>', '<spring:message code="region.incheon.seo"/>', '<spring:message code="region.incheon.ganghwa"/>', '<spring:message code="region.incheon.ongjin"/>']
        },
        'busan': {
            name: '<spring:message code="region.busan"/>',
            districts: ['<spring:message code="region.busan.jung"/>', '<spring:message code="region.busan.seo"/>', '<spring:message code="region.busan.dong"/>', '<spring:message code="region.busan.yeongdo"/>', '<spring:message code="region.busan.busanjin"/>', '<spring:message code="region.busan.dongnae"/>', '<spring:message code="region.busan.nam"/>', '<spring:message code="region.busan.buk"/>', '<spring:message code="region.busan.haeundae"/>', '<spring:message code="region.busan.saha"/>', '<spring:message code="region.busan.geumjeong"/>', '<spring:message code="region.busan.gangseo"/>', '<spring:message code="region.busan.yeonje"/>', '<spring:message code="region.busan.suyeong"/>', '<spring:message code="region.busan.sasang"/>', '<spring:message code="region.busan.gijang"/>']
        },
        'daegu': {
            name: '<spring:message code="region.daegu"/>',
            districts: ['<spring:message code="region.daegu.jung"/>', '<spring:message code="region.daegu.dong"/>', '<spring:message code="region.daegu.seo"/>', '<spring:message code="region.daegu.nam"/>', '<spring:message code="region.daegu.buk"/>', '<spring:message code="region.daegu.suseong"/>', '<spring:message code="region.daegu.dalseo"/>', '<spring:message code="region.daegu.dalseong"/>']
        },
        'daejeon': {
            name: '<spring:message code="region.daejeon"/>',
            districts: ['<spring:message code="region.daejeon.dong"/>', '<spring:message code="region.daejeon.jung"/>', '<spring:message code="region.daejeon.seo"/>', '<spring:message code="region.daejeon.yuseong"/>', '<spring:message code="region.daejeon.daedeok"/>']
        },
        'gwangju': {
            name: '<spring:message code="region.gwangju"/>',
            districts: ['<spring:message code="region.gwangju.dong"/>', '<spring:message code="region.gwangju.seo"/>', '<spring:message code="region.gwangju.nam"/>', '<spring:message code="region.gwangju.buk"/>', '<spring:message code="region.gwangju.gwangsan"/>']
        },
        'ulsan': {
            name: '<spring:message code="region.ulsan"/>',
            districts: ['<spring:message code="region.ulsan.jung"/>', '<spring:message code="region.ulsan.nam"/>', '<spring:message code="region.ulsan.dong"/>', '<spring:message code="region.ulsan.buk"/>', '<spring:message code="region.ulsan.ulju"/>']
        },
        'chungnam': {
            name: '<spring:message code="region.chungnam"/>',
            districts: ['<spring:message code="region.chungnam.cheonan"/>', '<spring:message code="region.chungnam.gongju"/>', '<spring:message code="region.chungnam.boryeong"/>', '<spring:message code="region.chungnam.asan"/>', '<spring:message code="region.chungnam.nonsan"/>', '<spring:message code="region.chungnam.gyeryong"/>', '<spring:message code="region.chungnam.dangjin"/>', '<spring:message code="region.chungnam.seosan"/>', '<spring:message code="region.chungnam.hongseong"/>', '<spring:message code="region.chungnam.cheongyang"/>', '<spring:message code="region.chungnam.boeun"/>', '<spring:message code="region.chungnam.okcheon"/>', '<spring:message code="region.chungnam.yeongdong"/>', '<spring:message code="region.chungnam.jincheon"/>', '<spring:message code="region.chungnam.goesan"/>', '<spring:message code="region.chungnam.eumseong"/>', '<spring:message code="region.chungnam.chungju"/>', '<spring:message code="region.chungnam.jecheon"/>', '<spring:message code="region.chungnam.taean"/>', '<spring:message code="region.chungnam.sejong"/>']
        },
        'chungbuk': {
            name: '<spring:message code="region.chungbuk"/>',
            districts: ['<spring:message code="region.chungbuk.cheongju"/>', '<spring:message code="region.chungbuk.chungju"/>', '<spring:message code="region.chungbuk.jecheon"/>', '<spring:message code="region.chungbuk.boeun"/>', '<spring:message code="region.chungbuk.okcheon"/>', '<spring:message code="region.chungbuk.yeongdong"/>', '<spring:message code="region.chungbuk.jincheon"/>', '<spring:message code="region.chungbuk.goesan"/>', '<spring:message code="region.chungbuk.eumseong"/>']
        },
        'jeonnam': {
            name: '<spring:message code="region.jeonnam"/>',
            districts: ['<spring:message code="region.jeonnam.mokpo"/>', '<spring:message code="region.jeonnam.yeosu"/>', '<spring:message code="region.jeonnam.suncheon"/>', '<spring:message code="region.jeonnam.naju"/>', '<spring:message code="region.jeonnam.gwangyang"/>', '<spring:message code="region.jeonnam.damyang"/>', '<spring:message code="region.jeonnam.gokseong"/>', '<spring:message code="region.jeonnam.gurye"/>', '<spring:message code="region.jeonnam.goheung"/>', '<spring:message code="region.jeonnam.boseong"/>', '<spring:message code="region.jeonnam.hwasun"/>', '<spring:message code="region.jeonnam.jangheung"/>', '<spring:message code="region.jeonnam.gangjin"/>', '<spring:message code="region.jeonnam.haenam"/>', '<spring:message code="region.jeonnam.yeongam"/>', '<spring:message code="region.jeonnam.muan"/>', '<spring:message code="region.jeonnam.shinan"/>', '<spring:message code="region.jeonnam.wando"/>', '<spring:message code="region.jeonnam.jindo"/>', '<spring:message code="region.jeonnam.jangseong"/>', '<spring:message code="region.jeonnam.hampyeong"/>', '<spring:message code="region.jeonnam.yeonggwang"/>']
        },
        'jeonbuk': {
            name: '<spring:message code="region.jeonbuk"/>',
            districts: ['<spring:message code="region.jeonbuk.jeonju"/>', '<spring:message code="region.jeonbuk.gunsan"/>', '<spring:message code="region.jeonbuk.iksan"/>', '<spring:message code="region.jeonbuk.jeongeup"/>', '<spring:message code="region.jeonbuk.namwon"/>', '<spring:message code="region.jeonbuk.gimje"/>', '<spring:message code="region.jeonbuk.wanju"/>', '<spring:message code="region.jeonbuk.jinan"/>', '<spring:message code="region.jeonbuk.muju"/>', '<spring:message code="region.jeonbuk.jangsu"/>', '<spring:message code="region.jeonbuk.imsil"/>', '<spring:message code="region.jeonbuk.sunchang"/>', '<spring:message code="region.jeonbuk.gochang"/>', '<spring:message code="region.jeonbuk.buan"/>']
        },
        'gyeongnam': {
            name: '<spring:message code="region.gyeongnam"/>',
            districts: ['<spring:message code="region.gyeongnam.changwon"/>', '<spring:message code="region.gyeongnam.gimhae"/>', '<spring:message code="region.gyeongnam.yangsan"/>', '<spring:message code="region.gyeongnam.geoje"/>', '<spring:message code="region.gyeongnam.tongyeong"/>', '<spring:message code="region.gyeongnam.sacheon"/>', '<spring:message code="region.gyeongnam.miryang"/>', '<spring:message code="region.gyeongnam.haman"/>', '<spring:message code="region.gyeongnam.geochang"/>', '<spring:message code="region.gyeongnam.changnyeong"/>', '<spring:message code="region.gyeongnam.goseong"/>', '<spring:message code="region.gyeongnam.namhae"/>', '<spring:message code="region.gyeongnam.hadong"/>', '<spring:message code="region.gyeongnam.sancheong"/>', '<spring:message code="region.gyeongnam.hamyang"/>', '<spring:message code="region.gyeongnam.georyeong"/>', '<spring:message code="region.gyeongnam.uiryeong"/>', '<spring:message code="region.gyeongnam.hapcheon"/>']
        },
        'gyeongbuk': {
            name: '<spring:message code="region.gyeongbuk"/>',
            districts: ['<spring:message code="region.gyeongbuk.pohang"/>', '<spring:message code="region.gyeongbuk.gyeongju"/>', '<spring:message code="region.gyeongbuk.gimcheon"/>', '<spring:message code="region.gyeongbuk.andong"/>', '<spring:message code="region.gyeongbuk.gumi"/>', '<spring:message code="region.gyeongbuk.yeongju"/>', '<spring:message code="region.gyeongbuk.yeongcheon"/>', '<spring:message code="region.gyeongbuk.sangju"/>', '<spring:message code="region.gyeongbuk.mungyeong"/>', '<spring:message code="region.gyeongbuk.cheongdo"/>', '<spring:message code="region.gyeongbuk.gyeongsan"/>', '<spring:message code="region.gyeongbuk.chilgok"/>', '<spring:message code="region.gyeongbuk.gunwi"/>', '<spring:message code="region.gyeongbuk.uiseong"/>', '<spring:message code="region.gyeongbuk.cheongsong"/>', '<spring:message code="region.gyeongbuk.yeongdeok"/>', '<spring:message code="region.gyeongbuk.uljin"/>', '<spring:message code="region.gyeongbuk.yeongyang"/>', '<spring:message code="region.gyeongbuk.bonghwa"/>']
        },
        'gangwon': {
            name: '<spring:message code="region.gangwon"/>',
            districts: ['<spring:message code="region.gangwon.chuncheon"/>', '<spring:message code="region.gangwon.wonju"/>', '<spring:message code="region.gangwon.gangneung"/>', '<spring:message code="region.gangwon.donghae"/>', '<spring:message code="region.gangwon.taebaek"/>', '<spring:message code="region.gangwon.sokcho"/>', '<spring:message code="region.gangwon.samcheok"/>', '<spring:message code="region.gangwon.hongcheon"/>', '<spring:message code="region.gangwon.cheorwon"/>', '<spring:message code="region.gangwon.hoengseong"/>', '<spring:message code="region.gangwon.pyeongchang"/>', '<spring:message code="region.gangwon.jeongseon"/>', '<spring:message code="region.gangwon.yeongwol"/>', '<spring:message code="region.gangwon.inje"/>', '<spring:message code="region.gangwon.goseong"/>', '<spring:message code="region.gangwon.yangyang"/>', '<spring:message code="region.gangwon.hwacheon"/>', '<spring:message code="region.gangwon.yanggu"/>']
        },
        'jeju': {
            name: '<spring:message code="region.jeju"/>',
            districts: ['<spring:message code="region.jeju.jeju"/>', '<spring:message code="region.jeju.seogwipo"/>']
        }
    };

    // DOM 요소들
    const sidoList = document.getElementById('sidoList');
    const distList = document.getElementById('distList');
    const scrollTop = document.getElementById('scrollTop');

    // 상태 변수들
    let current = 'nation'; // 현재 선택된 시도

    // 렌더링 함수들
    function renderSido() {
        sidoList.innerHTML = '';
        Object.keys(REGIONS).forEach(function(code) {
            var li = document.createElement('li');
            var btn = document.createElement('button');
            btn.type = 'button';
            btn.className = (code === current ? 'active ' : '') + 'sido-btn';
            btn.textContent = REGIONS[code].name;
            btn.onclick = function() {
                // 이전 active 버튼에서 active 클래스 제거
                var prevActive = sidoList.querySelector('.active');
                if (prevActive) {
                    prevActive.classList.remove('active');
                }
                
                // 현재 버튼에 active 클래스 추가
                this.classList.add('active');
                
                current = code;
                renderDists();
            };
            li.appendChild(btn);
            sidoList.appendChild(li);
        });
    }

    function renderDists() {
        var list = REGIONS[current].districts;
        distList.innerHTML = '';
        list.forEach(function(name) {
            var row = document.createElement('div');
            row.className = 'item';
            var left = document.createElement('div');
            left.textContent = name;
            var right = document.createElement('div');
            right.className = 'arrow';
            right.textContent = '>';
            row.onclick = function() {
                console.log('Selected:', REGIONS[current].name, name);
                // URL 파라미터에서 카테고리 가져오기
                const urlParams = new URLSearchParams(window.location.search);
                const category = urlParams.get('category') || 'plastic';
                const region = REGIONS[current].name;
                const subRegion = name;
                
                // 리스트 페이지로 이동
                window.location.href = '/list?category=' + encodeURIComponent(category) + '&region=' + encodeURIComponent(region) + '&subRegion=' + encodeURIComponent(subRegion);
            };
            row.appendChild(left);
            row.appendChild(right);
            distList.appendChild(row);
        });
    }

    // 이벤트 리스너들
    scrollTop.addEventListener('click', function() {
        distList.scrollTop = 0;
    });

    // 초기화
    (function init() {
        renderSido();
        renderDists();
    })();
})();
</script>
</body>
</html>
