# 호텔 예약 웹사이트 (스마트 컨트랙트 이용)

호텔이 직접 방을 올리고, 게스트가 검색해 자신에게 맞는 방을 예약하는 웹사이트.  
www.hotelnara.kro.kr
#

__개발 기간 및 인원__

- 개발 기간: 2019-5-16 ~ 2019-7-3 (총 49일)
- 개발 인원: 3명
#

__프로젝트 내용__

- 호텔이 회원가입으로 사이트에 등록한다.
- 방을 등록한다. (1박 가격, 허용 인원 등을 명시)
- 방을 등록할 때 그 방에 대한 스마트 컨트랙트가 이더리움 네트워크에 배포된다.
- 게스트는 도시를 검색하여 호텔과 방 리스트를 볼 수 있다.
- 예약 시, 취소 수수료와 예약금 이더(암호화폐)량을 확인하고 컨트랙트에 입금한다.
- 체크아웃 날이 지나면, 호텔 측은 컨트랙트에서 보관하고 있는 예약금을 징수할 수 있다.
- 취소 수수료는 명시된 남은 날 기준으로 컨트랙트에서 알아서 처리해준다.
#

__사용 기술__

- OS : Window 10, 7
- DB : OracleDB 11g express, Amazon RDS
- WAS : Apache tomcat 9.0
- Cloud : Amazon EC2
- Tool : Eclipse, sqldeveloper, Remix
- API: Google map api, CryptoCompare api
- 언어 : JSP(html, css, javascript), Java, Solidity
