$(function(){

 $('.t-datepicker').tDatePicker({

  // auto close after selection
  autoClose        : true,

  // animation speed in milliseconds
  durationArrowTop : 200,

  // the number of calendars
  numCalendar    : 2,

  // localization
  titleCheckIn   : 'Check In',
  titleCheckOut  : 'Check Out',
  titleToday     : 'Today',
  titleDateRange : 'night',
  titleDateRanges: 'nights',
  titleDays      : [ 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su' ],
  titleMonths    : ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'Septemper', 'October', 'November', "December"],

  // the max length of the title
  titleMonthsLimitShow : 3,

  // replace moth names
  replaceTitleMonths : null,

  // e.g. 'dd-mm-yy'
  showDateTheme   : null,

  // icon options
  iconArrowTop : true,
  iconDate     : '&#x279C;',
  arrowPrev    : '&#x276E;',
  arrowNext    : '&#x276F;',
  // https://fontawesome.com/v4.7.0/icons/
  // iconDate: '<i class="li-calendar-empty"></i><i class="li-arrow-right"></i>',
  // arrowPrev: '<i class="fa fa-chevron-left"></i>',
  // arrowNext: '<i class="fa fa-chevron-right"></i>',

  // shows today title
  toDayShowTitle       : true, 

  // showss dange range title
  dateRangesShowTitle  : true,

  // highlights today
  toDayHighlighted     : false,

  // highlights next day
  nextDayHighlighted   : false,

  // an array of days
  daysOfWeekHighlighted: [0,6],

  // custom date format
  formatDate      : 'yyyy-mm-dd',

  // dateCheckIn: '25/06/2018',  // DD/MM/YY
  // dateCheckOut: '26/06/2018', // DD/MM/YY
  dateCheckIn  : null,
  dateCheckOut : null,
  startDate    : null,
  endDate      : null,

  // limits the number of months
  limitPrevMonth : 0,
  limitNextMonth : 11,

  // limits the number of days
  limitDateRanges    : 31,

  // true -> full days || false - 1 day
  showFullDateRanges : false, 

  // DATA HOLIDAYS
  // Data holidays
  fnDataEvent   : null

});

});
// shows the date range picker
$('.t-datepicker').tDatePicker('show');

// hides the date range picker
$('.t-datepicker').tDatePicker('hide');

// updates the date range picker
$('.t-datepicker').tDatePicker('update', '2018-07-17');

// updates the check-in date
$('.t-datepicker').tDatePicker('updateCI', '2018-07-17');

// updates the check-out date
$('.t-datepicker').tDatePicker('updateCO', '2018-07-17');

// sets the start date
$('.t-datepicker').tDatePicker('setStartDate', '2018-07-17');

// sets the end date
$('.t-datepicker').tDatePicker('setEndDate', '2018-07-25');

// returns Date Object
// e.g: Wed Jul 18 2018 07:00:00 GMT+0700
$('.t-datepicker').tDatePicker('getDate');

// returns Date Object
$('.t-datepicker').tDatePicker('getDates');

// returns Date String
// e.g: '2018-07-17'
$('.t-datepicker').tDatePicker('getDateInput');

// returns [Date String, Date String]
// e.g: Return ['2018-07-17', '2018-07-18']
$('.t-datepicker').tDatePicker('getDateInput');

// returns [UTC CI, UTC CO]
// e.g: Return [1531785600000, 1531872000000]
$('.t-datepicker').tDatePicker('getDateUTCs');

// returns Date Object
// e.g: Wed Jul 18 2018 07:00:00 GMT+0700
$('.t-datepicker').tDatePicker('getStartDatet');

// returns Date Object
// e.g: 1531785600000
$('.t-datepicker').tDatePicker('getStartDateUTC');

// returns Date Object
// e.g: Wed Jul 18 2018 07:00:00 GMT+0700
$('.t-datepicker').tDatePicker('getEndDate');

// returns Date Object
// e.g: 1531785600000
$('.t-datepicker').tDatePicker('getDateUTC');

// returns Date Object
// e.g: Wed Jul 18 2018 07:00:00 GMT+0700
$('.t-datepicker').tDatePicker('getEndDate');

$('.t-datepicker').tDatePicker()

.on('clickDateCI',function(e, dateCI) {
  // after click check-in date
})

.on('clickDateCO',function(e, dateCO) {
  // after click check-out date
})

.on('beforeShowDay',function(e) {
  // before show
})

.on('afterShowDay',function(e) {
  // after show
})

.on('toggleAfterHideDay',function(e) {
  // after hide
})

.on('afterCheckOut',function(e, dataDate) {
  // console.log(new Date(dataDate[0])) // check-in
  // console.log(new Date(dataDate[1])) // check-out
})

.on('eventClickDay',function(e, dataDate) {
  // console.log(new Date(dataDate[0])) // check-in
  // console.log(new Date(dataDate[1])) // check-out
})

.on('selectedCI',function(e, slDateCI) {
  // after check-in date selected
})

.on('selectedCO',function(e, slDateCO) {
  // after check-out date selected
})

.on('onChangeCI',function(e, changeDateCI) {
  // after check-in date changed
})

.on('onChangeCO',function(e, changeDateCO) {
  // after check-out date changed
})