package com.example.ApiRound.Controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.ApiRound.Service.ListService;
import com.example.ApiRound.Service.ClickLogService;
import com.example.ApiRound.dto.ListDto;

@Controller
@RequestMapping("/list") // URL 기본 prefix
public class ListController {

    private final ListService listService;
    private final ClickLogService clickLogService;

    @Autowired
    public ListController(ListService listService, ClickLogService clickLogService) {
        this.listService = listService;
        this.clickLogService = clickLogService;
    }

    // 번역된 파라미터를 한국어로 변환하는 메서드
    private String translateToKorean(String translatedText) {
        if (translatedText == null || translatedText.trim().isEmpty()) return translatedText;

        Map<String, String> regionTranslations = new HashMap<>();

        // 광역시/도 (영/소문자)
        regionTranslations.put("Seoul","서울");      regionTranslations.put("seoul","서울");
        regionTranslations.put("Busan","부산");      regionTranslations.put("busan","부산");
        regionTranslations.put("Daegu","대구");      regionTranslations.put("daegu","대구");
        regionTranslations.put("Incheon","인천");    regionTranslations.put("incheon","인천");
        regionTranslations.put("Gwangju","광주");    regionTranslations.put("gwangju","광주");
        regionTranslations.put("Daejeon","대전");    regionTranslations.put("daejeon","대전");
        regionTranslations.put("Ulsan","울산");      regionTranslations.put("ulsan","울산");
        regionTranslations.put("Sejong","세종");     regionTranslations.put("sejong","세종");
        regionTranslations.put("Gyeonggi","경기");   regionTranslations.put("gyeonggi","경기");
        regionTranslations.put("Gangwon","강원");    regionTranslations.put("gangwon","강원");
        regionTranslations.put("Chungbuk","충북");   regionTranslations.put("chungbuk","충북");
        regionTranslations.put("Chungnam","충남");   regionTranslations.put("chungnam","충남");
        regionTranslations.put("Jeonbuk","전북");    regionTranslations.put("jeonbuk","전북");
        regionTranslations.put("Jeonnam","전남");    regionTranslations.put("jeonnam","전남");
        regionTranslations.put("Gyeongbuk","경북");  regionTranslations.put("gyeongbuk","경북");
        regionTranslations.put("Gyeongnam","경남");  regionTranslations.put("gyeongnam","경남");
        regionTranslations.put("Jeju","제주");       regionTranslations.put("jeju","제주");
        regionTranslations.put("National","전국");   regionTranslations.put("national","전국");

        // 서울 구 (영/소문자)
        regionTranslations.put("Gangnam","강남구");      regionTranslations.put("gangnam","강남구");
        regionTranslations.put("Gangdong","강동구");     regionTranslations.put("gangdong","강동구");
        regionTranslations.put("Gangbuk","강북구");      regionTranslations.put("gangbuk","강북구");
        regionTranslations.put("Gangseo","강서구");      regionTranslations.put("gangseo","강서구");
        regionTranslations.put("Gwanak","관악구");       regionTranslations.put("gwanak","관악구");
        regionTranslations.put("Gwangjin","광진구");     regionTranslations.put("gwangjin","광진구");
        regionTranslations.put("Guro","구로구");         regionTranslations.put("guro","구로구");
        regionTranslations.put("Geumcheon","금천구");     regionTranslations.put("geumcheon","금천구");
        regionTranslations.put("Nowon","노원구");         regionTranslations.put("nowon","노원구");
        regionTranslations.put("Dobong","도봉구");        regionTranslations.put("dobong","도봉구");
        regionTranslations.put("Dongdaemun","동대문구");  regionTranslations.put("dongdaemun","동대문구");
        regionTranslations.put("Dongjak","동작구");       regionTranslations.put("dongjak","동작구");
        regionTranslations.put("Mapo","마포구");          regionTranslations.put("mapo","마포구");
        regionTranslations.put("Seodaemun","서대문구");   regionTranslations.put("seodaemun","서대문구");
        regionTranslations.put("Seocho","서초구");        regionTranslations.put("seocho","서초구");
        regionTranslations.put("Seongdong","성동구");     regionTranslations.put("seongdong","성동구");
        regionTranslations.put("Seongbuk","성북구");      regionTranslations.put("seongbuk","성북구");
        regionTranslations.put("Songpa","송파구");        regionTranslations.put("songpa","송파구");
        regionTranslations.put("Yangcheon","양천구");     regionTranslations.put("yangcheon","양천구");
        regionTranslations.put("Yeongdeungpo","영등포구");regionTranslations.put("yeongdeungpo","영등포구");
        regionTranslations.put("Yongsan","용산구");       regionTranslations.put("yongsan","용산구");
        regionTranslations.put("Eunpyeong","은평구");     regionTranslations.put("eunpyeong","은평구");
        regionTranslations.put("Jongno","종로구");        regionTranslations.put("jongno","종로구");
        regionTranslations.put("Jung","중구");            regionTranslations.put("jung","중구");
        regionTranslations.put("Jungnang","중랑구");      regionTranslations.put("jungnang","중랑구");

        // 경기도 시/군 (영/소문자)
        regionTranslations.put("Suwon","수원시");      regionTranslations.put("suwon","수원시");
        regionTranslations.put("Seongnam","성남시");    regionTranslations.put("seongnam","성남시");
        regionTranslations.put("Anyang","안양시");      regionTranslations.put("anyang","안양시");
        regionTranslations.put("Bucheon","부천시");     regionTranslations.put("bucheon","부천시");
        regionTranslations.put("Gwangmyeong","광명시"); regionTranslations.put("gwangmyeong","광명시");
        regionTranslations.put("Pyeongtaek","평택시");  regionTranslations.put("pyeongtaek","평택시");
        regionTranslations.put("Ansan","안산시");       regionTranslations.put("ansan","안산시");
        regionTranslations.put("Hwaseong","화성시");    regionTranslations.put("hwaseong","화성시");
        regionTranslations.put("Osan","오산시");        regionTranslations.put("osan","오산시");
        regionTranslations.put("Yongin","용인시");      regionTranslations.put("yongin","용인시");
        regionTranslations.put("Icheon","이천시");      regionTranslations.put("icheon","이천시");
        regionTranslations.put("Gunpo","군포시");       regionTranslations.put("gunpo","군포시");
        regionTranslations.put("Uijeongbu","의정부시"); regionTranslations.put("uijeongbu","의정부시");
        regionTranslations.put("Goyang","고양시");      regionTranslations.put("goyang","고양시");
        regionTranslations.put("Gimpo","김포시");       regionTranslations.put("gimpo","김포시");
        regionTranslations.put("Paju","파주시");        regionTranslations.put("paju","파주시");
        regionTranslations.put("Yangju","양주시");      regionTranslations.put("yangju","양주시");
        regionTranslations.put("Dongducheon","동두천시");regionTranslations.put("dongducheon","동두천시");
        regionTranslations.put("Gapyeong","가평군");    regionTranslations.put("gapyeong","가평군");
        regionTranslations.put("Yangpyeong","양평군");  regionTranslations.put("yangpyeong","양평군");
        regionTranslations.put("Yeoju","여주시");       regionTranslations.put("yeoju","여주시");
        regionTranslations.put("Anseong","안성시");     regionTranslations.put("anseong","안성시");
        regionTranslations.put("Pocheon","포천시");     regionTranslations.put("pocheon","포천시");
        regionTranslations.put("Yeoncheon","연천군");   regionTranslations.put("yeoncheon","연천군");

        // 대구시 구 (영/소문자)
        regionTranslations.put("Jung","중구");          regionTranslations.put("jung","중구");
        regionTranslations.put("Dong","동구");          regionTranslations.put("dong","동구");
        regionTranslations.put("Seo","서구");           regionTranslations.put("seo","서구");
        regionTranslations.put("Nam","남구");           regionTranslations.put("nam","남구");
        regionTranslations.put("Buk","북구");           regionTranslations.put("buk","북구");
        regionTranslations.put("Suseong","수성구");     regionTranslations.put("suseong","수성구");
        regionTranslations.put("Dalseo","달서구");      regionTranslations.put("dalseo","달서구");
        regionTranslations.put("Dalseong","달성군");    regionTranslations.put("dalseong","달성군");

        // 인천시 구 (영/소문자)
        regionTranslations.put("Michuhol","미추홀구");  regionTranslations.put("michuhol","미추홀구");
        regionTranslations.put("Yeonsu","연수구");      regionTranslations.put("yeonsu","연수구");
        regionTranslations.put("Namdong","남동구");     regionTranslations.put("namdong","남동구");
        regionTranslations.put("Bupyeong","부평구");    regionTranslations.put("bupyeong","부평구");
        regionTranslations.put("Gyeyang","계양구");     regionTranslations.put("gyeyang","계양구");
        regionTranslations.put("Ganghwa","강화군");     regionTranslations.put("ganghwa","강화군");
        regionTranslations.put("Ongjin","옹진군");      regionTranslations.put("ongjin","옹진군");

        // 부산시 구 (영/소문자)
        regionTranslations.put("Yeongdo","영도구");     regionTranslations.put("yeongdo","영도구");
        regionTranslations.put("Busanjin","부산진구");   regionTranslations.put("busanjin","부산진구");
        regionTranslations.put("Dongnae","동래구");     regionTranslations.put("dongnae","동래구");
        regionTranslations.put("Haeundae","해운대구");  regionTranslations.put("haeundae","해운대구");
        regionTranslations.put("Saha","사하구");        regionTranslations.put("saha","사하구");
        regionTranslations.put("Geumjeong","금정구");   regionTranslations.put("geumjeong","금정구");
        regionTranslations.put("Yeonje","연제구");      regionTranslations.put("yeonje","연제구");
        regionTranslations.put("Suyeong","수영구");     regionTranslations.put("suyeong","수영구");
        regionTranslations.put("Sasang","사상구");      regionTranslations.put("sasang","사상구");
        regionTranslations.put("Gijang","기장군");      regionTranslations.put("gijang","기장군");

        // 대전시 구 (영/소문자)
        regionTranslations.put("Yuseong","유성구");     regionTranslations.put("yuseong","유성구");
        regionTranslations.put("Daedeok","대덕구");     regionTranslations.put("daedeok","대덕구");

        // 광주시 구 (영/소문자)
        regionTranslations.put("Gwangsan","광산구");    regionTranslations.put("gwangsan","광산구");

        // 울산시 구 (영/소문자)
        regionTranslations.put("Ulju","울주군");        regionTranslations.put("ulju","울주군");

        // 일본어 번역
        regionTranslations.put("ソウル","서울"); regionTranslations.put("首尔","서울");
        regionTranslations.put("釜山","부산");   regionTranslations.put("大邱","대구");
        regionTranslations.put("仁川","인천");   regionTranslations.put("光州","광주");
        regionTranslations.put("大田","대전");   regionTranslations.put("蔚山","울산");
        regionTranslations.put("世宗","세종");   regionTranslations.put("京畿","경기");
        regionTranslations.put("江原","강원");   regionTranslations.put("忠北","충북");
        regionTranslations.put("忠南","충남");   regionTranslations.put("全北","전북");
        regionTranslations.put("全南","전남");   regionTranslations.put("慶北","경북"); regionTranslations.put("庆北","경북");
        regionTranslations.put("慶南","경남");   regionTranslations.put("庆南","경남");
        regionTranslations.put("済州","제주");   regionTranslations.put("济州","제주");
        regionTranslations.put("全国","전국");

        // 일본어 지역명 번역 (구/군)
        regionTranslations.put("江南区","강남구"); regionTranslations.put("江东区","강동구");
        regionTranslations.put("江北区","강북구"); regionTranslations.put("江西区","강서구");
        regionTranslations.put("冠岳区","관악구"); regionTranslations.put("广津区","광진구");
        regionTranslations.put("九老区","구로구"); regionTranslations.put("衿川区","금천구");
        regionTranslations.put("芦原区","노원구"); regionTranslations.put("道峰区","도봉구");
        regionTranslations.put("东大门区","동대문구"); regionTranslations.put("铜雀区","동작구");
        regionTranslations.put("麻浦区","마포구"); regionTranslations.put("西大门区","서대문구");
        regionTranslations.put("瑞草区","서초구"); regionTranslations.put("城东区","성동구");
        regionTranslations.put("城北区","성북구"); regionTranslations.put("松坡区","송파구");
        regionTranslations.put("阳川区","양천구"); regionTranslations.put("永登浦区","영등포구");
        regionTranslations.put("龙山区","용산구"); regionTranslations.put("恩平区","은평구");
        regionTranslations.put("钟路区","종로구"); regionTranslations.put("中区","중구");
        regionTranslations.put("中浪区","중랑구");

        // 경기도 시/군 일본어 번역
        regionTranslations.put("水原市","수원시"); regionTranslations.put("城南市","성남시");
        regionTranslations.put("安养市","안양시"); regionTranslations.put("富川市","부천시");
        regionTranslations.put("光明市","광명시"); regionTranslations.put("平泽市","평택시");
        regionTranslations.put("安山市","안산시"); regionTranslations.put("华城市","화성시");
        regionTranslations.put("乌山市","오산시"); regionTranslations.put("龙仁市","용인시");
        regionTranslations.put("利川市","이천시"); regionTranslations.put("军浦市","군포시");
        regionTranslations.put("议政府市","의정부시"); regionTranslations.put("高阳市","고양시");
        regionTranslations.put("金浦市","김포시"); regionTranslations.put("坡州市","파주시");
        regionTranslations.put("杨州市","양주시"); regionTranslations.put("东豆川市","동두천시");
        regionTranslations.put("加平郡","가평군"); regionTranslations.put("杨平郡","양평군");
        regionTranslations.put("骊州市","여주시"); regionTranslations.put("安城市","안성시");
        regionTranslations.put("抱川市","포천시"); regionTranslations.put("涟川郡","연천군");

        // 인천시 구 일본어 번역
        regionTranslations.put("弥邹忽区","미추홀구"); regionTranslations.put("延寿区","연수구");
        regionTranslations.put("南洞区","남동구"); regionTranslations.put("富平区","부평구");
        regionTranslations.put("桂阳区","계양구"); regionTranslations.put("江华郡","강화군");
        regionTranslations.put("瓮津郡","옹진군");

        // 부산시 구 일본어 번역
        regionTranslations.put("影岛区","영도구"); regionTranslations.put("釜山镇区","부산진구");
        regionTranslations.put("东莱区","동래구"); regionTranslations.put("海云台区","해운대구");
        regionTranslations.put("沙下区","사하구"); regionTranslations.put("金井区","금정구");
        regionTranslations.put("莲堤区","연제구"); regionTranslations.put("水营区","수영구");
        regionTranslations.put("沙上区","사상구"); regionTranslations.put("机张郡","기장군");

        // 대구시 구 일본어 번역
        regionTranslations.put("中区","중구"); regionTranslations.put("东区","동구");
        regionTranslations.put("西区","서구"); regionTranslations.put("南区","남구");
        regionTranslations.put("北区","북구"); regionTranslations.put("寿城区","수성구");
        regionTranslations.put("达西区","달서구"); regionTranslations.put("达城郡","달성군");

        // 대전시 구 일본어 번역
        regionTranslations.put("儒城区","유성구"); regionTranslations.put("大德区","대덕구");

        // 광주시 구 일본어 번역
        regionTranslations.put("光山区","광산구");

        // 울산시 구 일본어 번역
        regionTranslations.put("蔚州郡","울주군");

        // 중국어 지역명 번역 (구/군)
        regionTranslations.put("江南区","강남구"); regionTranslations.put("江东区","강동구");
        regionTranslations.put("江北区","강북구"); regionTranslations.put("江西区","강서구");
        regionTranslations.put("冠岳区","관악구"); regionTranslations.put("广津区","광진구");
        regionTranslations.put("九老区","구로구"); regionTranslations.put("衿川区","금천구");
        regionTranslations.put("芦原区","노원구"); regionTranslations.put("道峰区","도봉구");
        regionTranslations.put("东大门区","동대문구"); regionTranslations.put("铜雀区","동작구");
        regionTranslations.put("麻浦区","마포구"); regionTranslations.put("西大门区","서대문구");
        regionTranslations.put("瑞草区","서초구"); regionTranslations.put("城东区","성동구");
        regionTranslations.put("城北区","성북구"); regionTranslations.put("松坡区","송파구");
        regionTranslations.put("阳川区","양천구"); regionTranslations.put("永登浦区","영등포구");
        regionTranslations.put("龙山区","용산구"); regionTranslations.put("恩平区","은평구");
        regionTranslations.put("钟路区","종로구"); regionTranslations.put("中区","중구");
        regionTranslations.put("中浪区","중랑구");

        // 경기도 시/군 중국어 번역
        regionTranslations.put("水原市","수원시"); regionTranslations.put("城南市","성남시");
        regionTranslations.put("安养市","안양시"); regionTranslations.put("富川市","부천시");
        regionTranslations.put("光明市","광명시"); regionTranslations.put("平泽市","평택시");
        regionTranslations.put("安山市","안산시"); regionTranslations.put("华城市","화성시");
        regionTranslations.put("乌山市","오산시"); regionTranslations.put("龙仁市","용인시");
        regionTranslations.put("利川市","이천시"); regionTranslations.put("军浦市","군포시");
        regionTranslations.put("议政府市","의정부시"); regionTranslations.put("高阳市","고양시");
        regionTranslations.put("金浦市","김포시"); regionTranslations.put("坡州市","파주시");
        regionTranslations.put("杨州市","양주시"); regionTranslations.put("东豆川市","동두천시");
        regionTranslations.put("加平郡","가평군"); regionTranslations.put("杨平郡","양평군");
        regionTranslations.put("骊州市","여주시"); regionTranslations.put("安城市","안성시");
        regionTranslations.put("抱川市","포천시"); regionTranslations.put("涟川郡","연천군");

        // 인천시 구 중국어 번역
        regionTranslations.put("弥邹忽区","미추홀구"); regionTranslations.put("延寿区","연수구");
        regionTranslations.put("南洞区","남동구"); regionTranslations.put("富平区","부평구");
        regionTranslations.put("桂阳区","계양구"); regionTranslations.put("江华郡","강화군");
        regionTranslations.put("瓮津郡","옹진군");

        // 부산시 구 중국어 번역
        regionTranslations.put("影岛区","영도구"); regionTranslations.put("釜山镇区","부산진구");
        regionTranslations.put("东莱区","동래구"); regionTranslations.put("海云台区","해운대구");
        regionTranslations.put("沙下区","사하구"); regionTranslations.put("金井区","금정구");
        regionTranslations.put("莲堤区","연제구"); regionTranslations.put("水营区","수영구");
        regionTranslations.put("沙上区","사상구"); regionTranslations.put("机张郡","기장군");

        // 대구시 구 중국어 번역
        regionTranslations.put("中区","중구"); regionTranslations.put("东区","동구");
        regionTranslations.put("西区","서구"); regionTranslations.put("南区","남구");
        regionTranslations.put("北区","북구"); regionTranslations.put("寿城区","수성구");
        regionTranslations.put("达西区","달서구"); regionTranslations.put("达城郡","달성군");

        // 대전시 구 중국어 번역
        regionTranslations.put("儒城区","유성구"); regionTranslations.put("大德区","대덕구");

        // 광주시 구 중국어 번역
        regionTranslations.put("光山区","광산구");

        // 울산시 구 중국어 번역
        regionTranslations.put("蔚州郡","울주군");

        // 영어 지역명 번역 (구/군)
        regionTranslations.put("Gangnam-gu","강남구"); regionTranslations.put("Gangdong-gu","강동구");
        regionTranslations.put("Gangbuk-gu","강북구"); regionTranslations.put("Gangseo-gu","강서구");
        regionTranslations.put("Gwanak-gu","관악구"); regionTranslations.put("Gwangjin-gu","광진구");
        regionTranslations.put("Guro-gu","구로구"); regionTranslations.put("Geumcheon-gu","금천구");
        regionTranslations.put("Nowon-gu","노원구"); regionTranslations.put("Dobong-gu","도봉구");
        regionTranslations.put("Dongdaemun-gu","동대문구"); regionTranslations.put("Dongjak-gu","동작구");
        regionTranslations.put("Mapo-gu","마포구"); regionTranslations.put("Seodaemun-gu","서대문구");
        regionTranslations.put("Seocho-gu","서초구"); regionTranslations.put("Seongdong-gu","성동구");
        regionTranslations.put("Seongbuk-gu","성북구"); regionTranslations.put("Songpa-gu","송파구");
        regionTranslations.put("Yangcheon-gu","양천구"); regionTranslations.put("Yeongdeungpo-gu","영등포구");
        regionTranslations.put("Yongsan-gu","용산구"); regionTranslations.put("Eunpyeong-gu","은평구");
        regionTranslations.put("Jongno-gu","종로구"); regionTranslations.put("Jung-gu","중구");
        regionTranslations.put("Jungnang-gu","중랑구");

        // 경기도 시/군 영어 번역
        regionTranslations.put("Suwon-si","수원시"); regionTranslations.put("Seongnam-si","성남시");
        regionTranslations.put("Anyang-si","안양시"); regionTranslations.put("Bucheon-si","부천시");
        regionTranslations.put("Gwangmyeong-si","광명시"); regionTranslations.put("Pyeongtaek-si","평택시");
        regionTranslations.put("Ansan-si","안산시"); regionTranslations.put("Hwaseong-si","화성시");
        regionTranslations.put("Osan-si","오산시"); regionTranslations.put("Yongin-si","용인시");
        regionTranslations.put("Icheon-si","이천시"); regionTranslations.put("Gunpo-si","군포시");
        regionTranslations.put("Uijeongbu-si","의정부시"); regionTranslations.put("Goyang-si","고양시");
        regionTranslations.put("Gimpo-si","김포시"); regionTranslations.put("Paju-si","파주시");
        regionTranslations.put("Yangju-si","양주시"); regionTranslations.put("Dongducheon-si","동두천시");
        regionTranslations.put("Gapyeong-gun","가평군"); regionTranslations.put("Yangpyeong-gun","양평군");
        regionTranslations.put("Yeoju-si","여주시"); regionTranslations.put("Anseong-si","안성시");
        regionTranslations.put("Pocheon-si","포천시"); regionTranslations.put("Yeoncheon-gun","연천군");

        // 인천시 구 영어 번역
        regionTranslations.put("Michuhol-gu","미추홀구"); regionTranslations.put("Yeonsu-gu","연수구");
        regionTranslations.put("Namdong-gu","남동구"); regionTranslations.put("Bupyeong-gu","부평구");
        regionTranslations.put("Gyeyang-gu","계양구"); regionTranslations.put("Ganghwa-gun","강화군");
        regionTranslations.put("Ongjin-gun","옹진군");

        // 부산시 구 영어 번역
        regionTranslations.put("Yeongdo-gu","영도구"); regionTranslations.put("Busanjin-gu","부산진구");
        regionTranslations.put("Dongnae-gu","동래구"); regionTranslations.put("Haeundae-gu","해운대구");
        regionTranslations.put("Saha-gu","사하구"); regionTranslations.put("Geumjeong-gu","금정구");
        regionTranslations.put("Yeonje-gu","연제구"); regionTranslations.put("Suyeong-gu","수영구");
        regionTranslations.put("Sasang-gu","사상구"); regionTranslations.put("Gijang-gun","기장군");

        // 대구시 구 영어 번역
        regionTranslations.put("Jung-gu","중구"); regionTranslations.put("Dong-gu","동구");
        regionTranslations.put("Seo-gu","서구"); regionTranslations.put("Nam-gu","남구");
        regionTranslations.put("Buk-gu","북구"); regionTranslations.put("Suseong-gu","수성구");
        regionTranslations.put("Dalseo-gu","달서구"); regionTranslations.put("Dalseong-gun","달성군");

        // 대전시 구 영어 번역
        regionTranslations.put("Yuseong-gu","유성구"); regionTranslations.put("Daedeok-gu","대덕구");

        // 광주시 구 영어 번역
        regionTranslations.put("Gwangsan-gu","광산구");

        // 울산시 구 영어 번역
        regionTranslations.put("Ulju-gun","울주군");

        // 카테고리 번역 매핑
        Map<String, String> categoryTranslations = new HashMap<>();
        categoryTranslations.put("Plastic Surgery","성형");  categoryTranslations.put("plastic","성형");
        categoryTranslations.put("Skin Care","피부");         categoryTranslations.put("skin","피부");
        categoryTranslations.put("Dental","치과");            categoryTranslations.put("dental","치과");
        categoryTranslations.put("Pharmacy","약국");          categoryTranslations.put("pharmacy","약국");
        categoryTranslations.put("Korean Medicine","한의원"); categoryTranslations.put("korean.medicine","한의원");
        categoryTranslations.put("Massage","마사지");         categoryTranslations.put("massage","마사지");
        categoryTranslations.put("Waxing","왁싱");            categoryTranslations.put("waxing","왁싱");
        categoryTranslations.put("Tourism","관광");           categoryTranslations.put("tourism","관광");
        categoryTranslations.put("整形","성형"); categoryTranslations.put("皮膚","피부"); categoryTranslations.put("皮肤","피부");
        categoryTranslations.put("歯科","치과"); categoryTranslations.put("牙科","치과");
        categoryTranslations.put("薬局","약국"); categoryTranslations.put("药房","약국");
        categoryTranslations.put("韓方","한의원"); categoryTranslations.put("韩医","한의원");
        categoryTranslations.put("マッサージ","마사지"); categoryTranslations.put("按摩","마사지");
        categoryTranslations.put("ワックス","왁싱"); categoryTranslations.put("脱毛","왁싱");
        categoryTranslations.put("観光","관광"); categoryTranslations.put("旅游","관광");

        String korean = regionTranslations.get(translatedText);
        if (korean != null) {
            System.out.println("번역 매핑: " + translatedText + " → " + korean);
            return korean;
        }
        korean = categoryTranslations.get(translatedText);
        if (korean != null) {
            System.out.println("번역 매핑: " + translatedText + " → " + korean);
            return korean;
        }
        System.out.println("번역 매핑 없음: " + translatedText + " (원본 반환)");
        return translatedText;
    }

    public String redirectList(String region, String category) {
        try {
            String decodedRegion = java.net.URLDecoder.decode(region, "UTF-8");
            String encodedRegion = java.net.URLEncoder.encode(decodedRegion, "UTF-8");

            return switch (category) {
                case "dental"          -> "redirect:/list/search?region=" + encodedRegion + "&category=dental";
                case "korean.medicine" -> "redirect:/list/search?region=" + encodedRegion + "&category=korean.medicine";
                case "massage"         -> "redirect:/list/search?region=" + encodedRegion + "&category=massage";
                case "pharmacy"        -> "redirect:/list/search?region=" + encodedRegion + "&category=pharmacy";
                case "skin"            -> "redirect:/list/search?region=" + encodedRegion + "&category=skin";
                case "waxing"          -> "redirect:/list/search?region=" + encodedRegion + "&category=waxing";
                case "plastic", "tourism" -> "redirect:/list/search?region=" + encodedRegion + "&category=plastic";
                default                -> "redirect:/list/search?region=" + encodedRegion + "&category=plastic";
            };
        } catch (Exception e) {
            return "redirect:/list/search?region=" + region + "&category=" + category;
        }
    }

    // 전체 병원 목록 조회 → list.jsp (페이징 적용)
    @GetMapping
    public String getAllList(Model model,
                             @RequestParam(required = false) String region,
                             @RequestParam(required = false, name = "subRegion") String subRegion,
                             @RequestParam(required = false) String category,
                             @RequestParam(defaultValue = "1") int pageNo,
                             @RequestParam(defaultValue = "15") int amount) {

        System.out.println("=== 요청 파라미터 ===");
        System.out.println("region: " + region);
        System.out.println("category: " + category);
        System.out.println("subRegion: " + subRegion);
        System.out.println("pageNo: " + pageNo);
        System.out.println("amount: " + amount);
        
        // 디버깅용: 모든 카테고리 값 출력
        List<String> allCategories = listService.getAllCategories();
        System.out.println("=== 데이터베이스의 모든 카테고리 ===");
        for (String cat : allCategories) {
            System.out.println("카테고리: " + cat);
        }

        // null 가드 + 트리밍
        region    = (region    == null) ? "" : region.trim();
        subRegion = (subRegion == null) ? "" : subRegion.trim();
        category  = (category  == null) ? "" : category.trim();

        System.out.println("=== 디버깅 정보 ===");
        System.out.println("현재 locale: " + locale);
        System.out.println("원본 파라미터 - region: " + region + ", subRegion: " + subRegion + ", category: " + category);
        System.out.println("번역 후 파라미터 - region: " + region + ", subRegion: " + subRegion + ", category: " + category);

        pageNo = Math.max(1, pageNo);
        amount = Math.max(1, amount);
        int offset = (pageNo - 1) * amount;

        // 총 개수 & 현재 페이지 데이터
        int totalCount;
        List<ListDto> lists;
        
        // region과 subRegion이 "전국"일 때는 카테고리만으로 검색
        if ("전국".equals(region) && "전국".equals(subRegion)) {
            System.out.println("=== 전국 카테고리 검색 ===");
            System.out.println("카테고리: " + category);
            System.out.println("amount: " + amount + ", offset: " + offset);
            totalCount = listService.countByCategory(category);
            lists = listService.getListByCategoryPaged(category, amount, offset);
            System.out.println("총 개수: " + totalCount);
            System.out.println("조회된 리스트 개수: " + (lists != null ? lists.size() : 0));
            model.addAttribute("mode", "category");

            // 조회된 데이터 확인
            if (lists != null && !lists.isEmpty()) {
                System.out.println("=== 조회된 데이터 샘플 ===");
                System.out.println("첫 번째 항목: " + lists.get(0));
            }
        } else {
            System.out.println("=== 지역별 검색 ===");
            System.out.println("지역: " + region + ", 구: " + subRegion + ", 카테고리: " + category);
            totalCount = listService.countByRegionAndCategory(region, subRegion, category);
            lists = listService.getListByRegionAndSubregionPaged(region, subRegion, category, amount, offset);
            model.addAttribute("mode", "search");
            System.out.println("총 개수: " + totalCount);
            System.out.println("조회된 리스트 개수: " + (lists != null ? lists.size() : 0));
        }

        System.out.println("총 데이터 개수: " + (lists != null ? lists.size() : 0));

        // 페이지 블록 계산 (blockSize = 5)
        int totalPages = (int) Math.ceil((double) totalCount / amount);
        int blockSize  = 5;
        int startPage  = ((pageNo - 1) / blockSize) * blockSize + 1;
        int endPage    = Math.min(startPage + blockSize - 1, Math.max(totalPages, 1));

        // 모델 바인딩
        model.addAttribute("lists", lists);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageNo", pageNo);
        model.addAttribute("amount", amount);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("region", region);
        model.addAttribute("subregion", subRegion);
        model.addAttribute("category", category);

        // 디버깅용: 모델에 바인딩된 데이터 확인
        System.out.println("=== 모델 바인딩 데이터 확인 ===");
        System.out.println("lists: " + (lists != null ? lists.size() : "null") + "개");
        System.out.println("totalCount: " + totalCount);
        System.out.println("region: " + region);
        System.out.println("subregion: " + subRegion);
        System.out.println("category: " + category);
        if (lists != null && !lists.isEmpty()) {
            System.out.println("첫 번째 항목: " + lists.get(0));
        }

        System.out.println("=== 모델 바인딩 완료 ===");
        System.out.println("lists size: " + (lists != null ? lists.size() : 0));
        System.out.println("totalCount: " + totalCount);
        System.out.println("totalPages: " + totalPages);
        System.out.println("startPage: " + startPage);
        System.out.println("endPage: " + endPage);

        return "list"; // /WEB-INF/views/list.jsp
    }

    // 단일 병원 조회 → detail.jsp
    @GetMapping("/{id}")
    public String getListById(@PathVariable Long id, Model model) {
        // 업체 상세 페이지 진입 시 클릭 로그 기록
        clickLogService.logClick(id);

        ListDto hospital = listService.getListById(id);
        String locale = LocaleContextHolder.getLocale().getLanguage();
        if (locale == null || locale.isEmpty() || locale.equals("ko")) {
            locale = "ko"; // 기본값
        }
        ListDto hospital = listService.getListById(id, locale);
        model.addAttribute("list", hospital);
        return "detail";
    }

    // ✅ 지역 + 카테고리별 병원 조회 (페이징 적용) → list.jsp
    @GetMapping("/search")
    public String getListByRegionAndCategory(@RequestParam(required = false) String region,
                                             @RequestParam(required = false) String subregion,
                                             @RequestParam(required = false) String category,
                                             @RequestParam(defaultValue = "1") int pageNo,
                                             @RequestParam(defaultValue = "15") int amount,
                                             Model model) {

        // null 가드 + 트리밍
        region    = (region    == null) ? "" : region.trim();
        subregion = (subregion == null) ? "" : subregion.trim();
        category  = (category  == null) ? "" : category.trim();

        pageNo = Math.max(1, pageNo);
        amount = Math.max(1, amount);
        int offset = (pageNo - 1) * amount;

        // 총 개수 & 현재 페이지 데이터 (Service에 메서드 구현 필요)
        int totalCount = listService.countByRegionAndCategory(region, subregion, category);
        List<ListDto> lists = listService.getListByRegionAndSubregionPaged(region, subregion, category, amount, offset);

        // 페이지 블록 계산 (blockSize = 5)
        int totalPages = (int) Math.ceil((double) totalCount / amount);
        int blockSize  = 5;
        int startPage  = ((pageNo - 1) / blockSize) * blockSize + 1;
        int endPage    = Math.min(startPage + blockSize - 1, Math.max(totalPages, 1));
        Integer prevPage = (startPage > 1) ? startPage - 1 : null;
        Integer nextPage = (endPage < totalPages) ? endPage + 1 : null;

        // 모델 바인딩
        model.addAttribute("lists", lists);
        model.addAttribute("totalCount", totalCount);

        model.addAttribute("pageNo", pageNo);
        model.addAttribute("amount", amount);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("prevPage", prevPage);
        model.addAttribute("nextPage", nextPage);

        model.addAttribute("region", region);
        model.addAttribute("subregion", subregion);
        model.addAttribute("category", category);

        return "list";
    }

    // 등록 폼 → form.jsp
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("listDto", new ListDto());
        return "form";
    }

    // 등록 처리
    @PostMapping
    public String addList(@ModelAttribute ListDto listDto) {
        listService.addList(listDto);
        return "redirect:/list"; // 등록 후 목록으로 이동
    }

    // 카테고리별(전국) 병원 목록: 페이징
    @GetMapping("/category/{category}")
    public String getListByCategoryPaged(@PathVariable String category,
                                         @RequestParam(defaultValue = "1") int pageNo,
                                         @RequestParam(defaultValue = "15") int amount,
                                         Model model) {

        category = (category == null) ? "" : category.trim();
        pageNo   = Math.max(1, pageNo);
        amount   = Math.max(1, amount);
        int offset = (pageNo - 1) * amount;

        int totalCount     = listService.countByCategory(category);
        List<ListDto> lists = listService.getListByCategoryPaged(category, amount, offset);

        int totalPages = (int) Math.ceil((double) totalCount / amount);
        int blockSize  = 5;
        int startPage  = ((pageNo - 1) / blockSize) * blockSize + 1;
        int endPage    = Math.min(startPage + blockSize - 1, Math.max(totalPages, 1));

        model.addAttribute("lists", lists);
        model.addAttribute("totalCount", totalCount);

        model.addAttribute("pageNo", pageNo);
        model.addAttribute("amount", amount);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        // 뷰에서 사용
        model.addAttribute("region", "전국");     // 상단 "선택된 지역" 표시용
        model.addAttribute("subregion", "전국");      // 비움
        model.addAttribute("category", category); // 현재 카테고리

        // 페이지네이션 링크 분기용 (JSP에서 사용)
        model.addAttribute("mode", "category");

        return "list";
    }

    // 디버깅용
    @GetMapping("/test")
    @ResponseBody
    public String testDatabase() {
        try {
            String locale = LocaleContextHolder.getLocale().getLanguage();
            if (locale == null || locale.isEmpty() || locale.equals("ko")) {
                locale = "ko"; // 기본값
            }
            List<String> categories = listService.getAllCategories();
            List<ListDto> allData   = listService.getAllList(locale);

            StringBuilder result = new StringBuilder();
            result.append("Database connection successful.\n");
            result.append("Current locale: ").append(locale).append("\n");
            result.append("Categories: ").append(categories).append("\n");
            result.append("Total records: ").append(allData != null ? allData.size() : 0).append("\n");

            if (allData != null && !allData.isEmpty()) {
                result.append("\n=== Sample Data ===\n");
                ListDto sample = allData.get(0);
                result.append("ID: ").append(sample.getId()).append("\n");
                result.append("Name: ").append(sample.getName()).append("\n");
                result.append("NameLabel: ").append(sample.getNameLabel()).append("\n");
                result.append("Address: ").append(sample.getAddress()).append("\n");
                result.append("AddressLabel: ").append(sample.getAddressLabel()).append("\n");
                result.append("Region: ").append(sample.getRegion()).append("\n");
                result.append("Category: ").append(sample.getCategory()).append("\n");
            }

            return result.toString();
        } catch (Exception e) {
            return "Database connection failed: " + e.getMessage() + "\n" + e.getStackTrace()[0];
        }
    }
}
