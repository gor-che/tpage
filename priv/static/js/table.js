//object.addEventListener("scroll", myScript);
qi('divTable').addEventListener("scroll", function(e){
  console.log(["scrll",e]);
  let target = e.target;
  update_table(target.scrollTop);
  
});

function update_table(scrll){
  r = qi('table')['data-rid'];
  console.log([scrll, 10 + scrll + qi('divTable').offsetHeight, qi('table').offsetHeight ]);
  
  if(scrll + qi('divTable').offsetHeight + 11 > qi('table').offsetHeight ){
    direct(tuple(atom('append_rows'), string('table'), string(r)))
  }
  
}

function set_height(){
  r = qi('table')['data-rid'];
  div = qi('divTable').clientHeight;
  table = qi('table').clientHeight;
  if(div >= table){
    direct(tuple(atom('append_rows'), string('table'), string(r)))
  }
  
  qi('divTable').height = qi('table').clientHeight - 10;
  console.log([qi('table').clientHeight, qi('divTable').clientHeight])
}