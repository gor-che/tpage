scroll = {
  tableId: '',
  parentHeight: '',
  tHeigh: '',
  offsetAcc: 0,
  offset: 0
}

function update_table(scrll){
  t = qi('table');
  r = qi('table')['data-rid'];
  dt = qi('divTable');
  acc = qi('table')['data-scroll']
    
  //moving down
  if(acc !=0 && scrll > acc){

      t.childNodes.forEach(tr => {
        if(t.childNodes[0].getBoundingClientRect().y < scrll - dt.clientHeight * 1.5){
          console.log("delete bottom row");
          t.removeChild(t.childNodes[0])
        }
      });

      if(qi('divTable').clientHeight * 2 > qi('table').clientHeight){
      //   console.log("add_row_after");
         direct(tuple(atom('append_rows'), string('table'), string(r)))}
  }

  //moving up
  if(acc!=0 && scrll < acc){

    if(t.childNodes[t.childNodes.length-1].getBoundingClientRect().y > scrll + dt.clientHeight * 1.5){
        console.log(["del_after_in_append_before"]);
         t.removeChild(t.childNodes[t.childNodes.length-1])
    }

    if(qi('divTable').clientHeight * 2 < qi('table').clientHeight){
        firstId= qi('table').childNodes[0].id
        console.log(["move_up#",scrll  ,qi('table').offsetHeight - qi('divTable').offsetHeight]);
      direct(tuple(atom('append_row_before'), string('table'), string(r),string(firstId)))
    }
  }

  set_height(scrll);
  qi('table')['data-scroll'] = scrll;
}

function set_height(scrll){
  r = qi('table')['data-rid'];
  t = qi('table');
  div = qi('divTable').clientHeight;
  table = t.clientHeight;
  
  if(div >= table){
    console.log(["append#", div, table]);
    direct(tuple(atom('append_rows'), string('table'), string(r)))
  }
  
  qi('divTable').height = t.clientHeight - 10;
}