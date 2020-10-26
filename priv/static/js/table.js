scroll = {
  tableId: '',
  parentHeight: '',
  tHeigh: '',
  offsetAcc: 0,
  offset: 0
}

function update_table(scrll){
  r = qi('table')['data-rid'];
  dt = qi('divTable');
  acc = qi('table')['data-scroll']
  console.log([scrll, qi('divTable').offsetHeight, qi('table').offsetHeight ]);
  
  // move down
  if(scrll + qi('divTable').offsetHeight + 11 > qi('table').offsetHeight ){
    direct(tuple(atom('append_rows'), string('table'), string(r)))
  }

  // move up
  if(scrll < acc){
    direct(tuple(atom('append_row_before'), string('table'), string(r)))
    t.childNodes.forEach(tr => {
      if(tr.getBoundingClientRect().y > scrll + dt.clientHeight){
        t.removeChild(tr)
      }}
    );
    console.log('MOVE_BACK');
  }

  set_height();
  qi('table')['data-scroll'] = scrll;
}

function set_height(){
  r = qi('table')['data-rid'];
  t = qi('table');
  div = qi('divTable').clientHeight;
  table = t.clientHeight;
  console.log(["#", div, table]);
  if(div >= table){
    direct(tuple(atom('append_rows'), string('table'), string(r)))
  }
  
  qi('divTable').height = t.clientHeight - 10;
  //console.log([t.clientHeight, qi('divTable').clientHeight]);

  tH = t.clientHeight;
  tScrl = t.scrollTop;
  dt = t.clientHeight;

  // t.childNodes.forEach(tr => {
  //   if(tr.getBoundingClientRect().y < 0){
  //     t.removeChild(tr)
  //   }}
  // );
  
  console.log([tH, tScrl, dt]);
  // if(tH){

  // }
}