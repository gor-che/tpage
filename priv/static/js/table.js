scroll = {
  tableId: '',
  parentHeight: '',
  tHeigh: '',
  offsetAcc: 0,
  offset: 0
}

window.addEventListener('scroll', function(e){
console.log(e.target);
});

function update_table(scrll){
  t = qi('table');
  r = qi('table')['data-rid'];
  dt = qi('divTable');
  acc = qi('table')['data-scroll']
    
  //moving down
  if(acc !=0 && scrll > acc){
    set_height(scrll);
    t.childNodes.forEach(tr => {
      if(t.childNodes[0].getBoundingClientRect().y < scrll - dt.clientHeight * 1.5){
        console.log("delete top row");
        t.removeChild(t.childNodes[0])
      }
    });
  }

  //moving up
  if(acc!=0 && scrll < acc){

    set_height(scrll);
    if(t.childNodes[t.childNodes.length-1].getBoundingClientRect().y > scrll + dt.clientHeight * 1.5){
      console.log(["del_bottom_row"]);
        t.removeChild(t.childNodes[t.childNodes.length-1]);
      
    }
    // if(scrll !=0 && t.childNodes[0].getBoundingClientRect().y > -50){direct(tuple(atom('append_row_before'), string('table'), string(r),string("str")));update_table(scrll);}
  }

  
  qi('table')['data-scroll'] = scrll;
}

function set_height(scrll){
  r = qi('table')['data-rid'];
  t = qi('table');
  div = qi('divTable').clientHeight;
  table = t.clientHeight;

  if(div * 2 >= table){
    if(scroll.offset > scroll.offsetAcc){
      console.log(["append#", div, table]);
      direct(tuple(atom('append_rows'), string('table'), string(r)))}

    if(scroll.offset < scroll.offsetAcc){
       console.log(["append_before#", div, table]);
      
       direct(tuple(atom('append_row_before'), string('table'), string(r),string("str")));
    }
  }
  
  qi('divTable').height = t.clientHeight - 10;
}

function fill_table(){
  r = qi('table')['data-rid'];
  t = qi('table');
  div = qi('divTable').clientHeight;
  table = t.clientHeight;
  qi('divTable').height = t.clientHeight - 10;
  console.log(["%%%%", div, table]);
  if(div >= table){  
    
    direct(tuple(atom('fill_table'), string('table'), string("reader")));
  }
}